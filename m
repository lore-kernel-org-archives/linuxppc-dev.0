Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 45161DDF65
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:42:08 +1000 (EST)
Message-ID: <4644AAEB.1090904@am.sony.com>
Date: Fri, 11 May 2007 10:42:03 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: update ps3_defconfig
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/configs/ps3_defconfig |  167 ++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 103 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/configs/ps3_defconfig
+++ ps3-linux-dev/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.21
-# Mon Apr 30 12:03:35 2007
+# Fri May 11 10:16:27 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -40,6 +40,7 @@ CONFIG_PPC_FPU=y
 # CONFIG_PPC_OF_PLATFORM_PCI is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
+# CONFIG_PPC_MM_SLICES is not set
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
@@ -67,6 +68,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CPUSETS is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
@@ -87,12 +89,13 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -213,6 +216,7 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_ARCH_MEMORY_PROBE=y
+# CONFIG_PPC_HAS_HASH_64K is not set
 # CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
@@ -229,15 +233,12 @@ CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 CONFIG_KERNEL_START=0xc000000000000000
 
 #
@@ -363,7 +364,9 @@ CONFIG_BT_HCIUSB_SCO=y
 #
 # CONFIG_CFG80211 is not set
 CONFIG_WIRELESS_EXT=y
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -414,6 +417,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # Misc devices
 #
+# CONFIG_BLINK is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -447,6 +451,7 @@ CONFIG_CHR_DEV_SG=m
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -473,25 +478,7 @@ CONFIG_CHR_DEV_SG=m
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Macintosh device drivers
-#
-# CONFIG_MAC_EMUMOUSEBTN is not set
-# CONFIG_WINDFARM is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 
 #
 # Network device support
@@ -519,6 +506,7 @@ CONFIG_MII=m
 #
 # Ethernet (10000 Mbit)
 #
+CONFIG_MLX4_DEBUG=y
 
 #
 # Token Ring devices
@@ -531,6 +519,25 @@ CONFIG_MII=m
 # CONFIG_WLAN_80211 is not set
 
 #
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+CONFIG_USB_PEGASUS=m
+# CONFIG_USB_RTL8150 is not set
+CONFIG_USB_USBNET_MII=m
+CONFIG_USB_USBNET=m
+# CONFIG_USB_NET_CDCETHER is not set
+# CONFIG_USB_NET_DM9601 is not set
+# CONFIG_USB_NET_GL620A is not set
+# CONFIG_USB_NET_NET1080 is not set
+# CONFIG_USB_NET_PLUSB is not set
+CONFIG_USB_NET_MCS7830=m
+# CONFIG_USB_NET_RNDIS_HOST is not set
+# CONFIG_USB_NET_CDC_SUBSET is not set
+# CONFIG_USB_NET_ZAURUS is not set
+
+#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -575,6 +582,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -609,15 +617,10 @@ CONFIG_LEGACY_PTY_COUNT=16
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_HANGCHECK_TIMER is not set
@@ -626,10 +629,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
 # CONFIG_I2C is not set
 
 #
@@ -642,12 +641,7 @@ CONFIG_GEN_RTC=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
 
 #
 # Multifunction device drivers
@@ -669,12 +663,23 @@ CONFIG_GEN_RTC=y
 # Graphics support
 #
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -702,10 +707,6 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
@@ -768,6 +769,20 @@ CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 
 #
+# USB Input Devices
+#
+CONFIG_USB_HID=m
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -827,56 +842,10 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_LIBUSUAL is not set
 
 #
-# USB Input Devices
-#
-CONFIG_USB_HID=m
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-
-#
-# USB HID Boot Protocol drivers
-#
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
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-CONFIG_USB_PEGASUS=m
-# CONFIG_USB_RTL8150 is not set
-CONFIG_USB_USBNET_MII=m
-CONFIG_USB_USBNET=m
-# CONFIG_USB_NET_CDCETHER is not set
-# CONFIG_USB_NET_DM9601 is not set
-# CONFIG_USB_NET_GL620A is not set
-# CONFIG_USB_NET_NET1080 is not set
-# CONFIG_USB_NET_PLUSB is not set
-CONFIG_USB_NET_MCS7830=m
-# CONFIG_USB_NET_RNDIS_HOST is not set
-# CONFIG_USB_NET_CDC_SUBSET is not set
-# CONFIG_USB_NET_ZAURUS is not set
 CONFIG_USB_MON=y
 
 #
@@ -920,10 +889,6 @@ CONFIG_USB_MON=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -966,14 +931,6 @@ CONFIG_USB_MON=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=m
@@ -1071,6 +1028,7 @@ CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1148,11 +1106,13 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
 
 #
 # Instrumentation Support
@@ -1171,7 +1131,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
@@ -1205,6 +1164,7 @@ CONFIG_PPC_EARLY_DEBUG=y
 # CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
 # CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
 # CONFIG_PPC_EARLY_DEBUG_BEAT is not set
+# CONFIG_PPC_EARLY_DEBUG_44x is not set
 
 #
 # Security options
@@ -1234,6 +1194,7 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
