Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 14B74DE1FB
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 20:04:26 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 315A41C15277
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:59:48 +0100 (CET)
Received: from lancy.denx.de (p4FE63FB4.dip.t-dialin.net [79.230.63.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id C99289022B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:57:59 +0100 (CET)
Message-ID: <49BE1497.6070004@grandegger.com>
Date: Mon, 16 Mar 2009 09:57:59 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] PowerPC: MPC85xx: TQM8548: update defconfig
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable highmem support for the TQM8548-AG modules and NAND support for
the TQM8548-BE modules. Furthermore disable USB, Wireless and IDE support
because it's not available on the STK85xx starter kit.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/configs/85xx/tqm8548_defconfig |  164 ++++++++-------------------
 1 files changed, 48 insertions(+), 116 deletions(-)

diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 0bc4597..43030fe 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc2
-# Mon Jan 26 15:36:20 2009
+# Linux kernel version: 2.6.29-rc7
+# Mon Mar 16 09:03:28 2009
 #
 # CONFIG_PPC64 is not set
 
@@ -22,6 +22,7 @@ CONFIG_FSL_EMB_PERFMON=y
 # CONFIG_PHYS_64BIT is not set
 CONFIG_SPE=y
 CONFIG_PPC_MMU_NOHASH=y
+CONFIG_PPC_BOOK3E_MMU=y
 # CONFIG_PPC_MM_SLICES is not set
 # CONFIG_SMP is not set
 CONFIG_PPC32=y
@@ -75,6 +76,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_GROUP_SCHED=y
@@ -152,11 +162,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
-# CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -202,7 +207,7 @@ CONFIG_MPIC=y
 #
 # Kernel options
 #
-# CONFIG_HIGHMEM is not set
+CONFIG_HIGHMEM=y
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -244,6 +249,7 @@ CONFIG_UNEVICTABLE_LRU=y
 CONFIG_PPC_4K_PAGES=y
 # CONFIG_PPC_16K_PAGES is not set
 # CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
 CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
@@ -259,6 +265,7 @@ CONFIG_ZONE_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_FSL_SOC=y
 CONFIG_FSL_PCI=y
+CONFIG_FSL_LBC=y
 CONFIG_PPC_PCI_CHOICE=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
@@ -284,10 +291,11 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 # Default settings for advanced configuration options are used
 #
 CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_LOWMEM_CAM_NUM=3
 CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
-CONFIG_PHYSICAL_ALIGN=0x10000000
+CONFIG_PHYSICAL_ALIGN=0x04000000
 CONFIG_TASK_SIZE=0xc0000000
 CONFIG_NET=y
 
@@ -363,12 +371,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 # CONFIG_PHONET is not set
-CONFIG_WIRELESS=y
-# CONFIG_CFG80211 is not set
-CONFIG_WIRELESS_OLD_REGULATORY=y
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_LIB80211 is not set
-# CONFIG_MAC80211 is not set
+# CONFIG_WIRELESS is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
@@ -471,27 +474,18 @@ CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_NANDSIM is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_NAND_FSL_ELBC is not set
-# CONFIG_MTD_NAND_FSL_UPM is not set
+CONFIG_MTD_NAND_FSL_UPM=y
 # CONFIG_MTD_ONENAND is not set
 
 #
 # LPDDR flash memory drivers
 #
 # CONFIG_MTD_LPDDR is not set
-# CONFIG_MTD_QINFO_PROBE is not set
 
 #
 # UBI - Unsorted block images
 #
-CONFIG_MTD_UBI=m
-CONFIG_MTD_UBI_WL_THRESHOLD=4096
-CONFIG_MTD_UBI_BEB_RESERVE=1
-# CONFIG_MTD_UBI_GLUEBI is not set
-
-#
-# UBI debugging options
-#
-# CONFIG_MTD_UBI_DEBUG is not set
+# CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
 CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
@@ -515,69 +509,21 @@ CONFIG_BLK_DEV_RAM_SIZE=32768
 # CONFIG_BLK_DEV_HD is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_PHANTOM is not set
-# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
 # CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_HP_ILO is not set
 # CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=y
-CONFIG_IDE=y
-
-#
-# Please see Documentation/ide/ide.txt for help/info on IDE drives
-#
-CONFIG_IDE_TIMINGS=y
-# CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_IDE_GD=y
-CONFIG_IDE_GD_ATA=y
-# CONFIG_IDE_GD_ATAPI is not set
-# CONFIG_BLK_DEV_IDECD is not set
-# CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_IDE_TASK_IOCTL is not set
-CONFIG_IDE_PROC_FS=y
-
-#
-# IDE chipset support/bugfixes
-#
-# CONFIG_BLK_DEV_PLATFORM is not set
-CONFIG_BLK_DEV_IDEDMA_SFF=y
-
-#
-# PCI IDE chipsets support
-#
-CONFIG_BLK_DEV_IDEPCI=y
-CONFIG_IDEPCI_PCIBUS_ORDER=y
-# CONFIG_BLK_DEV_OFFBOARD is not set
-CONFIG_BLK_DEV_GENERIC=y
-# CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_BLK_DEV_ALI15X3 is not set
-# CONFIG_BLK_DEV_AMD74XX is not set
-# CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_BLK_DEV_TRIFLEX is not set
-# CONFIG_BLK_DEV_CS5520 is not set
-# CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT366 is not set
-# CONFIG_BLK_DEV_JMICRON is not set
-# CONFIG_BLK_DEV_SC1200 is not set
-# CONFIG_BLK_DEV_PIIX is not set
-# CONFIG_BLK_DEV_IT8172 is not set
-# CONFIG_BLK_DEV_IT8213 is not set
-# CONFIG_BLK_DEV_IT821X is not set
-# CONFIG_BLK_DEV_NS87415 is not set
-# CONFIG_BLK_DEV_PDC202XX_OLD is not set
-# CONFIG_BLK_DEV_PDC202XX_NEW is not set
-# CONFIG_BLK_DEV_SVWKS is not set
-# CONFIG_BLK_DEV_SIIMAGE is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
-# CONFIG_BLK_DEV_SLC90E66 is not set
-# CONFIG_BLK_DEV_TRM290 is not set
-CONFIG_BLK_DEV_VIA82CXXX=y
-# CONFIG_BLK_DEV_TC86C001 is not set
-CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
@@ -650,7 +596,7 @@ CONFIG_MII=y
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
-CONFIG_E1000=y
+# CONFIG_E1000 is not set
 # CONFIG_E1000E is not set
 # CONFIG_IP1000 is not set
 # CONFIG_IGB is not set
@@ -668,6 +614,7 @@ CONFIG_GIANFAR=y
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 # CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
 # CONFIG_JME is not set
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
@@ -835,8 +782,6 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_EEPROM_AT24 is not set
-# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -975,26 +920,7 @@ CONFIG_HID=y
 # Special HID drivers
 #
 CONFIG_HID_COMPAT=y
-CONFIG_USB_SUPPORT=y
-CONFIG_USB_ARCH_HAS_HCD=y
-CONFIG_USB_ARCH_HAS_OHCI=y
-CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
-# CONFIG_USB_OTG_WHITELIST is not set
-# CONFIG_USB_OTG_BLACKLIST_HUB is not set
-
-#
-# Enable Host or Gadget support to see Inventra options
-#
-
-#
-# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# OTG and related infrastructure
-#
+# CONFIG_USB_SUPPORT is not set
 # CONFIG_UWB is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
@@ -1064,16 +990,9 @@ CONFIG_RTC_DRV_DS1307=y
 #
 # File systems
 #
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
 # CONFIG_EXT4_FS is not set
-CONFIG_JBD=y
-CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
@@ -1122,8 +1041,17 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-# CONFIG_UBIFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1184,6 +1112,8 @@ CONFIG_GENERIC_FIND_LAST_BIT=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
@@ -1219,6 +1149,7 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_HIGHMEM is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
@@ -1236,6 +1167,7 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 
-- 
1.6.0.6
