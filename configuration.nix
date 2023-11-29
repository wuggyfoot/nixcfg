{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Boot
  boot = { 
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 5;
      enable = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };
  
  # Network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Time zone.
  time.timeZone = "America/New_York";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # X11
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;
  };

  # programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Print
  services.printing = {
    enable = true;
    drivers = [ pkgs.cups-brother-hll2350dw ];
  };


  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User account
  users.users.wuggy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "adbusers" "vboxusers" ];
    packages = with pkgs; [
      
    ];
  };

  # Virtualization
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    package = pkgs.virtualbox;
    
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.flatpak.enable = true;
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    firefox
    android-tools
    # android-udev-rules
    nerdfonts
    home-manager
    google-chrome
    # virtualbox
    youtube-music
    signal-desktop
    libreoffice
    github-desktop

  ];

  # Services
  services = {
    openssh.enable = true;
    # autofs = {
    #   enable = true;
    #   autoMaster = "";
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # State Version
  system.stateVersion = "24.05"; 

}

