Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by bilbo.ozlabs.org (Postfix) with ESMTP id 76231B7BBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 04:09:28 +1000 (EST)
Message-ID: <4A94251F.7030705@am.sony.com>
Date: Tue, 25 Aug 2009 10:53:35 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch v2] powerpc/ps3: Update ps3_defconfig
References: <4A93347C.4060609@am.sony.com>
In-Reply-To: <4A93347C.4060609@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update ps3_defconfig.

 o Refresh for 2.6.31.
 o Remove MTD support.
 o Add more HID drivers.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/configs/ps3_defconfig |  211 +++++++++++++------------------------
 1 file changed, 75 insertions(+), 136 deletions(-)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,13 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30-rc5
-# Fri May 15 10:37:00 2009
+# Linux kernel version: 2.6.31-rc7
+# Mon Aug 24 17:38:50 2009
 #
 CONFIG_PPC64=y
 
 #
 # Processor support
 #
+CONFIG_PPC_BOOK3S_64=y
 CONFIG_PPC_BOOK3S=y
 # CONFIG_POWER4_ONLY is not set
 CONFIG_POWER3=y
@@ -20,6 +21,7 @@ CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_64=y
 CONFIG_PPC_MM_SLICES=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
+CONFIG_PPC_HAVE_PMU_SUPPORT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_64BIT=y
@@ -31,6 +33,7 @@ CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_TIME_VSYSCALL=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_HAVE_SETUP_PER_CPU_AREA=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_STACKTRACE_SUPPORT=y
@@ -41,7 +44,6 @@ CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_ARCH_NO_VIRT_TO_BUS=y
 CONFIG_PPC=y
@@ -62,6 +64,7 @@ CONFIG_DTC=y
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -113,7 +116,6 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -126,7 +128,14 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+CONFIG_HAVE_PERF_COUNTERS=y
+
+#
+# Performance Counters
+#
+# CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
@@ -145,6 +154,11 @@ CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
 CONFIG_USE_GENERIC_SMP_HELPERS=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
 # CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
@@ -210,7 +224,7 @@ CONFIG_PPC_CELL=y
 #
 # Cell Broadband Engine options
 #
-CONFIG_SPU_FS=y
+CONFIG_SPU_FS=m
 CONFIG_SPU_FS_64K_LS=y
 # CONFIG_SPU_TRACE is not set
 CONFIG_SPU_BASE=y
@@ -255,6 +269,7 @@ CONFIG_BINFMT_MISC=y
 CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
 # CONFIG_IOMMU_VMERGE is not set
 CONFIG_IOMMU_HELPER=y
+# CONFIG_SWIOTLB is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
@@ -285,9 +300,9 @@ CONFIG_MIGRATION=y
 CONFIG_PHYS_ADDR_T_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
-CONFIG_UNEVICTABLE_LRU=y
 CONFIG_HAVE_MLOCK=y
 CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_ARCH_MEMORY_PROBE=y
 CONFIG_PPC_HAS_HASH_64K=y
 CONFIG_PPC_4K_PAGES=y
@@ -399,6 +414,7 @@ CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -433,11 +449,14 @@ CONFIG_BT_HCIBTUSB=m
 CONFIG_WIRELESS=y
 CONFIG_CFG80211=m
 # CONFIG_CFG80211_REG_DEBUG is not set
+# CONFIG_CFG80211_DEBUGFS is not set
 # CONFIG_WIRELESS_OLD_REGULATORY is not set
 CONFIG_WIRELESS_EXT=y
 # CONFIG_WIRELESS_EXT_SYSFS is not set
 # CONFIG_LIB80211 is not set
 CONFIG_MAC80211=m
+CONFIG_MAC80211_DEFAULT_PS=y
+CONFIG_MAC80211_DEFAULT_PS_VALUE=1
 
 #
 # Rate control algorithm selection
@@ -447,7 +466,6 @@ CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
 # CONFIG_MAC80211_RC_DEFAULT_MINSTREL is not set
 CONFIG_MAC80211_RC_DEFAULT="pid"
-# CONFIG_MAC80211_MESH is not set
 # CONFIG_MAC80211_LEDS is not set
 # CONFIG_MAC80211_DEBUGFS is not set
 # CONFIG_MAC80211_DEBUG_MENU is not set
@@ -472,77 +490,7 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=0
-# CONFIG_MTD_CONCAT is not set
-# CONFIG_MTD_PARTITIONS is not set
-# CONFIG_MTD_TESTS is not set
-
-#
-# User Modules And Translation Layers
-#
-# CONFIG_MTD_CHAR is not set
-CONFIG_MTD_BLKDEVS=y
-CONFIG_MTD_BLOCK=y
-# CONFIG_FTL is not set
-# CONFIG_NFTL is not set
-# CONFIG_INFTL is not set
-# CONFIG_RFD_FTL is not set
-# CONFIG_SSFDC is not set
-# CONFIG_MTD_OOPS is not set
-
-#
-# RAM/ROM/Flash chip drivers
-#
-# CONFIG_MTD_CFI is not set
-# CONFIG_MTD_JEDECPROBE is not set
-CONFIG_MTD_MAP_BANK_WIDTH_1=y
-CONFIG_MTD_MAP_BANK_WIDTH_2=y
-CONFIG_MTD_MAP_BANK_WIDTH_4=y
-# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
-CONFIG_MTD_CFI_I1=y
-CONFIG_MTD_CFI_I2=y
-# CONFIG_MTD_CFI_I4 is not set
-# CONFIG_MTD_CFI_I8 is not set
-# CONFIG_MTD_RAM is not set
-# CONFIG_MTD_ROM is not set
-# CONFIG_MTD_ABSENT is not set
-
-#
-# Mapping drivers for chip access
-#
-# CONFIG_MTD_COMPLEX_MAPPINGS is not set
-# CONFIG_MTD_PLATRAM is not set
-
-#
-# Self-contained MTD device drivers
-#
-# CONFIG_MTD_SLRAM is not set
-# CONFIG_MTD_PHRAM is not set
-# CONFIG_MTD_MTDRAM is not set
-# CONFIG_MTD_BLOCK2MTD is not set
-
-#
-# Disk-On-Chip Device Drivers
-#
-# CONFIG_MTD_DOC2000 is not set
-# CONFIG_MTD_DOC2001 is not set
-# CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
-# CONFIG_MTD_ONENAND is not set
-
-#
-# LPDDR flash memory drivers
-#
-# CONFIG_MTD_LPDDR is not set
-
-#
-# UBI - Unsorted block images
-#
-# CONFIG_MTD_UBI is not set
+# CONFIG_MTD is not set
 CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -590,10 +538,6 @@ CONFIG_BLK_DEV_SR=y
 # CONFIG_BLK_DEV_SR_VENDOR is not set
 CONFIG_CHR_DEV_SG=m
 # CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
 CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
@@ -626,7 +570,6 @@ CONFIG_BLK_DEV_DM=m
 # CONFIG_DM_UEVENT is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
-CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -646,10 +589,11 @@ CONFIG_MII=m
 # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_GELIC_NET=y
 CONFIG_GELIC_WIRELESS=y
-CONFIG_GELIC_WIRELESS_OLD_PSK_INTERFACE=y
+# CONFIG_GELIC_WIRELESS_OLD_PSK_INTERFACE is not set
 # CONFIG_NETDEV_10000 is not set
 
 #
@@ -669,8 +613,7 @@ CONFIG_WLAN_80211=y
 # CONFIG_HOSTAP is not set
 # CONFIG_B43 is not set
 # CONFIG_B43LEGACY is not set
-CONFIG_ZD1211RW=m
-# CONFIG_ZD1211RW_DEBUG is not set
+# CONFIG_ZD1211RW is not set
 # CONFIG_RT2X00 is not set
 
 #
@@ -682,7 +625,7 @@ CONFIG_ZD1211RW=m
 #
 # CONFIG_USB_CATC is not set
 # CONFIG_USB_KAWETH is not set
-CONFIG_USB_PEGASUS=m
+# CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_AX8817X=m
@@ -693,10 +636,11 @@ CONFIG_USB_NET_AX8817X=m
 # CONFIG_USB_NET_GL620A is not set
 # CONFIG_USB_NET_NET1080 is not set
 # CONFIG_USB_NET_PLUSB is not set
-CONFIG_USB_NET_MCS7830=m
+# CONFIG_USB_NET_MCS7830 is not set
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
+# CONFIG_USB_NET_INT51X1 is not set
 # CONFIG_WAN is not set
 CONFIG_PPP=m
 CONFIG_PPP_MULTILINK=y
@@ -771,8 +715,7 @@ CONFIG_DEVKMEM=y
 #
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=16
+# CONFIG_LEGACY_PTYS is not set
 # CONFIG_HVC_UDBG is not set
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
@@ -782,6 +725,11 @@ CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 # CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
@@ -805,22 +753,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_REGULATOR is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-# CONFIG_DAB is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
@@ -898,6 +831,11 @@ CONFIG_SND_SUPPORT_OLD_API=y
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_PPC=y
 CONFIG_SND_PS3=m
@@ -930,29 +868,34 @@ CONFIG_USB_HIDDEV=y
 # Special HID drivers
 #
 # CONFIG_HID_A4TECH is not set
-# CONFIG_HID_APPLE is not set
-# CONFIG_HID_BELKIN is not set
-# CONFIG_HID_CHERRY is not set
+CONFIG_HID_APPLE=m
+CONFIG_HID_BELKIN=m
+CONFIG_HID_CHERRY=m
 # CONFIG_HID_CHICONY is not set
 # CONFIG_HID_CYPRESS is not set
-# CONFIG_DRAGONRISE_FF is not set
-# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_DRAGONRISE is not set
+CONFIG_HID_EZKEY=m
 # CONFIG_HID_KYE is not set
 # CONFIG_HID_GYRATION is not set
 # CONFIG_HID_KENSINGTON is not set
-# CONFIG_HID_LOGITECH is not set
-# CONFIG_HID_MICROSOFT is not set
+CONFIG_HID_LOGITECH=m
+# CONFIG_LOGITECH_FF is not set
+# CONFIG_LOGIRUMBLEPAD2_FF is not set
+CONFIG_HID_MICROSOFT=m
 # CONFIG_HID_MONTEREY is not set
 # CONFIG_HID_NTRIG is not set
 # CONFIG_HID_PANTHERLORD is not set
 # CONFIG_HID_PETALYNX is not set
 # CONFIG_HID_SAMSUNG is not set
 CONFIG_HID_SONY=m
-# CONFIG_HID_SUNPLUS is not set
-# CONFIG_GREENASIA_FF is not set
+CONFIG_HID_SUNPLUS=m
+# CONFIG_HID_GREENASIA is not set
+CONFIG_HID_SMARTJOYPLUS=m
+# CONFIG_SMARTJOYPLUS_FF is not set
 # CONFIG_HID_TOPSEED is not set
-# CONFIG_THRUSTMASTER_FF is not set
-# CONFIG_ZEROPLUS_FF is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_WACOM is not set
+# CONFIG_HID_ZEROPLUS is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -988,6 +931,8 @@ CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_HCD_PPC_OF_BE is not set
+# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
 # CONFIG_USB_OHCI_HCD_PPC_OF is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
@@ -1115,6 +1060,10 @@ CONFIG_RTC_DRV_PS3=m
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -1141,11 +1090,12 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -1205,7 +1155,6 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1222,6 +1171,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
+# CONFIG_NFS_V4_1 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
@@ -1359,7 +1309,6 @@ CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_LIST=y
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
@@ -1374,31 +1323,21 @@ CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_RING_BUFFER=y
+CONFIG_EVENT_TRACING=y
+CONFIG_CONTEXT_SWITCH_TRACER=y
 CONFIG_TRACING=y
 CONFIG_TRACING_SUPPORT=y
-
-#
-# Tracers
-#
-# CONFIG_FUNCTION_TRACER is not set
-# CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
-# CONFIG_EVENT_TRACER is not set
-# CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
-# CONFIG_STACK_TRACER is not set
-# CONFIG_KMEMTRACE is not set
-# CONFIG_WORKQUEUE_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_FTRACE_STARTUP_TEST is not set
+# CONFIG_FTRACE is not set
 # CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
 CONFIG_PRINT_STACK_DEPTH=64
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_PPC_EMULATED_STATS is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
