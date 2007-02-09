Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 39645DDED2
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:02:01 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Updated mpc834x_itx_defconfig
Date: Fri,  9 Feb 2007 10:01:50 -0600
Message-Id: <11710369101980-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates the defconfig for the MPC8349E-mITX.  In addition to picking
up changes from recent kernels, it turns off math emulation, disables support
for e100 (which doesn't ship with the system), turns off input devices, 
turns on some I2C support, turns off HW monitoring (HW not yet supported), 
turns off OHCI USB (not used), turns off USB gadget support (HW not yet 
supported), turns on DOS FS support, and turns off kernel debugging.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/mpc834x_itx_defconfig |  232 +++++++--------------------
 1 files changed, 60 insertions(+), 172 deletions(-)

diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index 7902806..23d8964 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Fri Jan 26 00:19:02 2007
+# Linux kernel version: 2.6.20
+# Wed Feb  7 13:12:18 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -34,9 +34,9 @@ CONFIG_DEFAULT_UIMAGE=y
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_85xx is not set
 # CONFIG_PPC_86xx is not set
+# CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
-# CONFIG_8xx is not set
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_83xx=y
@@ -178,7 +178,6 @@ CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
-# CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -303,7 +302,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
-# CONFIG_DEBUG_DRIVER is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -523,6 +521,7 @@ CONFIG_SCSI_SPI_ATTRS=y
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
 #
 CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
 # CONFIG_SATA_SVW is not set
 # CONFIG_ATA_PIIX is not set
@@ -647,37 +646,7 @@ CONFIG_CICADA_PHY=y
 #
 # Ethernet (10 or 100Mbit)
 #
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-# CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNGEM is not set
-# CONFIG_CASSINI is not set
-# CONFIG_NET_VENDOR_3COM is not set
-
-#
-# Tulip family network device support
-#
-# CONFIG_NET_TULIP is not set
-# CONFIG_HP100 is not set
-CONFIG_NET_PCI=y
-# CONFIG_PCNET32 is not set
-# CONFIG_AMD8111_ETH is not set
-# CONFIG_ADAPTEC_STARFIRE is not set
-# CONFIG_B44 is not set
-# CONFIG_FORCEDETH is not set
-# CONFIG_DGRS is not set
-# CONFIG_EEPRO100 is not set
-CONFIG_E100=y
-# CONFIG_FEALNX is not set
-# CONFIG_NATSEMI is not set
-# CONFIG_NE2K_PCI is not set
-# CONFIG_8139CP is not set
-# CONFIG_8139TOO is not set
-# CONFIG_SIS900 is not set
-# CONFIG_EPIC100 is not set
-# CONFIG_SUNDANCE is not set
-# CONFIG_TLAN is not set
-# CONFIG_VIA_RHINE is not set
+# CONFIG_NET_ETHERNET is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -693,7 +662,6 @@ CONFIG_E100=y
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
@@ -746,26 +714,7 @@ CONFIG_GFAR_NAPI=y
 #
 # Input device support
 #
-CONFIG_INPUT=y
-# CONFIG_INPUT_FF_MEMLESS is not set
-
-#
-# Userland interfaces
-#
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input Device Drivers
-#
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+# CONFIG_INPUT is not set
 
 #
 # Hardware I/O ports
@@ -784,7 +733,7 @@ CONFIG_INPUT=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -887,7 +836,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_PCF8574 is not set
+CONFIG_SENSORS_PCF8574=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_M41T00 is not set
@@ -901,7 +850,6 @@ CONFIG_I2C_MPC=y
 # SPI support
 #
 CONFIG_SPI=y
-# CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
 
 #
@@ -922,52 +870,8 @@ CONFIG_SPI_MPC83xx=y
 #
 # Hardware Monitoring support
 #
-CONFIG_HWMON=y
+# CONFIG_HWMON is not set
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_ADM1025 is not set
-# CONFIG_SENSORS_ADM1026 is not set
-# CONFIG_SENSORS_ADM1031 is not set
-# CONFIG_SENSORS_ADM9240 is not set
-# CONFIG_SENSORS_ASB100 is not set
-# CONFIG_SENSORS_ATXP1 is not set
-# CONFIG_SENSORS_DS1621 is not set
-# CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_FSCHER is not set
-# CONFIG_SENSORS_FSCPOS is not set
-# CONFIG_SENSORS_GL518SM is not set
-# CONFIG_SENSORS_GL520SM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM63 is not set
-# CONFIG_SENSORS_LM70 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM77 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM80 is not set
-# CONFIG_SENSORS_LM83 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_LM87 is not set
-# CONFIG_SENSORS_LM90 is not set
-# CONFIG_SENSORS_LM92 is not set
-# CONFIG_SENSORS_MAX1619 is not set
-# CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_PC87427 is not set
-# CONFIG_SENSORS_SIS5595 is not set
-# CONFIG_SENSORS_SMSC47M1 is not set
-# CONFIG_SENSORS_SMSC47M192 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
-# CONFIG_SENSORS_VIA686A is not set
-# CONFIG_SENSORS_VT1211 is not set
-# CONFIG_SENSORS_VT8231 is not set
-# CONFIG_SENSORS_W83781D is not set
-# CONFIG_SENSORS_W83791D is not set
-# CONFIG_SENSORS_W83792D is not set
-# CONFIG_SENSORS_W83793 is not set
-# CONFIG_SENSORS_W83L785TS is not set
-# CONFIG_SENSORS_W83627HF is not set
-# CONFIG_SENSORS_W83627EHF is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Multimedia devices
@@ -983,7 +887,7 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
@@ -994,11 +898,6 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
-# HID Devices
-#
-CONFIG_HID=y
-
-#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1023,10 +922,8 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
-CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_OHCI_BIG_ENDIAN is not set
-CONFIG_USB_OHCI_LITTLE_ENDIAN=y
-CONFIG_USB_UHCI_HCD=y
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 
 #
@@ -1058,25 +955,10 @@ CONFIG_USB_STORAGE=y
 #
 # USB Input Devices
 #
-# CONFIG_USB_HID is not set
 
 #
 # USB HID Boot Protocol drivers
 #
-# CONFIG_USB_KBD is not set
-# CONFIG_USB_MOUSE is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_YEALINK is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
 
 #
 # USB Imaging devices
@@ -1133,25 +1015,7 @@ CONFIG_USB_MON=y
 #
 # USB Gadget Support
 #
-CONFIG_USB_GADGET=y
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-CONFIG_USB_GADGET_SELECTED=y
-CONFIG_USB_GADGET_NET2280=y
-CONFIG_USB_NET2280=y
-# CONFIG_USB_GADGET_PXA2XX is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-CONFIG_USB_GADGET_DUALSPEED=y
-# CONFIG_USB_ZERO is not set
-CONFIG_USB_ETH=y
-CONFIG_USB_ETH_RNDIS=y
-# CONFIG_USB_GADGETFS is not set
-# CONFIG_USB_FILE_STORAGE is not set
-# CONFIG_USB_G_SERIAL is not set
-# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_USB_GADGET is not set
 
 #
 # MMC/SD Card support
@@ -1273,8 +1137,11 @@ CONFIG_DNOTIFY=y
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1340,7 +1207,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_OSF_PARTITION is not set
 # CONFIG_AMIGA_PARTITION is not set
 # CONFIG_ATARI_PARTITION is not set
-# CONFIG_MAC_PARTITION is not set
+CONFIG_MAC_PARTITION=y
 CONFIG_MSDOS_PARTITION=y
 # CONFIG_BSD_DISKLABEL is not set
 # CONFIG_MINIX_SUBPARTITION is not set
@@ -1356,7 +1223,46 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Native Language Support
 #
-# CONFIG_NLS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
 
 #
 # Distributed Lock Manager
@@ -1388,27 +1294,9 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_DETECT_SOFTLOCKUP=y
-# CONFIG_SCHEDSTATS is not set
-# CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_RT_MUTEXES is not set
-# CONFIG_RT_MUTEX_TESTER is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
-# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
-# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_DEBUG_INFO is not set
-# CONFIG_DEBUG_VM is not set
-# CONFIG_DEBUG_LIST is not set
-CONFIG_FORCED_INLINING=y
-# CONFIG_RCU_TORTURE_TEST is not set
-# CONFIG_DEBUGGER is not set
-# CONFIG_BDI_SWITCH is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
-- 
1.4.4
