Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B8139DE822
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:09:06 +1100 (EST)
Message-ID: <45BAC22D.7060800@am.sony.com>
Date: Fri, 26 Jan 2007 19:08:29 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 16/16] ps3: ps3_defconfig updates
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates for ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Enabled some USB_NET options as requested by Arnd.

 arch/powerpc/configs/ps3_defconfig |  225 ++++++++++++++++++++++++++++++++-----
 1 files changed, 200 insertions(+), 25 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/configs/ps3_defconfig
+++ ps3-linux-dev/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:29:11 2007
+# Linux kernel version: 2.6.20-rc6
+# Thu Jan 25 13:35:34 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -70,10 +70,10 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
-CONFIG_EMBEDDED=y
-# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -160,7 +160,7 @@ CONFIG_SPU_BASE=y
 # PS3 Platform Options
 #
 CONFIG_PS3_HTAB_SIZE=20
-CONFIG_PS3_DYNAMIC_DMA=y
+# CONFIG_PS3_DYNAMIC_DMA is not set
 CONFIG_PS3_USE_LPAR_ADDR=y
 CONFIG_PS3_VUART=y
 
@@ -207,7 +207,7 @@ CONFIG_PPC_64K_PAGES=y
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="root=/dev/nfs rw ip=dhcp"
+CONFIG_CMDLINE="root=/dev/sda1 ip=dhcp"
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
 CONFIG_ISA_DMA_API=y
@@ -240,7 +240,8 @@ CONFIG_NET=y
 # Networking options
 #
 # CONFIG_NETDEBUG is not set
-# CONFIG_PACKET is not set
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -353,6 +354,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
@@ -380,10 +382,11 @@ CONFIG_SCSI_PROC_FS=y
 #
 # SCSI support type (disk, tape, CD-ROM)
 #
-# CONFIG_BLK_DEV_SD is not set
+CONFIG_BLK_DEV_SD=y
 # CONFIG_CHR_DEV_ST is not set
 # CONFIG_CHR_DEV_OSST is not set
-# CONFIG_BLK_DEV_SR is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
 # CONFIG_CHR_DEV_SG is not set
 # CONFIG_CHR_DEV_SCH is not set
 
@@ -456,6 +459,7 @@ CONFIG_NETDEVICES=y
 # Ethernet (10 or 100Mbit)
 #
 # CONFIG_NET_ETHERNET is not set
+CONFIG_MII=y
 
 #
 # Ethernet (1000 Mbit)
@@ -504,10 +508,13 @@ CONFIG_INPUT=y
 #
 # Userland interfaces
 #
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
-CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
 #
@@ -598,6 +605,7 @@ CONFIG_GEN_RTC=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -626,15 +634,132 @@ CONFIG_HID=y
 #
 # USB support
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_HCD_PPC_OF is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
+# may also be needed; see USB_STORAGE Help for more information
+#
+# CONFIG_USB_STORAGE is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_TOUCHSCREEN is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+CONFIG_USB_USBNET_MII=y
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_CDCETHER=y
+# CONFIG_USB_NET_GL620A is not set
+# CONFIG_USB_NET_NET1080 is not set
+# CONFIG_USB_NET_PLUSB is not set
+CONFIG_USB_NET_MCS7830=y
+# CONFIG_USB_NET_RNDIS_HOST is not set
+# CONFIG_USB_NET_CDC_SUBSET is not set
+# CONFIG_USB_NET_ZAURUS is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+
+#
+# USB DSL modem support
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -691,8 +816,14 @@ CONFIG_HID=y
 # File systems
 #
 # CONFIG_EXT2_FS is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
@@ -712,8 +843,11 @@ CONFIG_DNOTIFY=y
 #
 # CD-ROM/DVD Filesystems
 #
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
@@ -785,7 +919,46 @@ CONFIG_MSDOS_PARTITION=y
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
@@ -795,9 +968,10 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_IOMAP_COPY=y
@@ -821,22 +995,23 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
-# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_SLAB=y
+# CONFIG_DEBUG_SLAB_LEAK is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_RWSEMS=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 CONFIG_DEBUG_LIST=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
-# CONFIG_DEBUG_STACKOVERFLOW is not set
+CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
