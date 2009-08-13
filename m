Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4143B7BE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 00:31:19 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10D38DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 00:31:17 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/44x: Update Arches defconfig
Date: Thu, 13 Aug 2009 16:30:56 +0200
Message-Id: <1250173856-20781-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds NOR MTD support and I2C HWMON support for the AD7414
to the AMCC Arches defconfig.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/configs/44x/arches_defconfig |  382 +++++++++++++++++++++++++----
 1 files changed, 332 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/configs/44x/arches_defconfig b/arch/powerpc/configs/44x/arches_defconfig
index f7fd32c..6f976b5 100644
--- a/arch/powerpc/configs/44x/arches_defconfig
+++ b/arch/powerpc/configs/44x/arches_defconfig
@@ -1,14 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc2
-# Tue Jan 20 08:22:31 2009
+# Linux kernel version: 2.6.31-rc5
+# Thu Aug 13 14:14:07 2009
 #
 # CONFIG_PPC64 is not set
 
 #
 # Processor support
 #
-# CONFIG_6xx is not set
+# CONFIG_PPC_BOOK3S_32 is not set
 # CONFIG_PPC_85xx is not set
 # CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
@@ -31,15 +31,16 @@ CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_TIME_VSYSCALL=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
 CONFIG_IRQ_PER_CPU=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
@@ -53,11 +54,14 @@ CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
 # CONFIG_DEFAULT_UIMAGE is not set
 CONFIG_PPC_DCR_NATIVE=y
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_DCR=y
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -71,9 +75,19 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
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
 # CONFIG_GROUP_SCHED is not set
@@ -84,8 +98,12 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
@@ -95,23 +113,30 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
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
 CONFIG_PCI_QUIRKS=y
 CONFIG_SLUB_DEBUG=y
+# CONFIG_STRIP_ASM_SYMS is not set
+CONFIG_COMPAT_BRK=y
 # CONFIG_SLAB is not set
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
@@ -119,6 +144,12 @@ CONFIG_HAVE_IOREMAP_PROT=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+# CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -130,8 +161,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
-CONFIG_LBD=y
-# CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -147,11 +177,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
-# CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_FREEZER is not set
 CONFIG_PPC4xx_PCI_EXPRESS=y
 
@@ -172,6 +197,7 @@ CONFIG_PPC4xx_PCI_EXPRESS=y
 CONFIG_ARCHES=y
 # CONFIG_CANYONLANDS is not set
 # CONFIG_GLACIER is not set
+# CONFIG_REDWOOD is not set
 # CONFIG_YOSEMITE is not set
 # CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
 CONFIG_PPC44x_SIMPLE=y
@@ -214,6 +240,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_MATH_EMULATION is not set
 # CONFIG_IOMMU_HELPER is not set
+# CONFIG_SWIOTLB is not set
 CONFIG_PPC_NEED_DMA_SYNC_OPS=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
@@ -233,10 +260,14 @@ CONFIG_PHYS_ADDR_T_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_STDBINUTILS=y
 CONFIG_PPC_4K_PAGES=y
 # CONFIG_PPC_16K_PAGES is not set
 # CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
 CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_PROC_DEVICETREE=y
 CONFIG_CMDLINE_BOOL=y
@@ -261,6 +292,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 # CONFIG_HAS_RAPIDIO is not set
@@ -278,14 +310,12 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
 CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
 # Networking options
 #
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -335,6 +365,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -347,7 +379,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 # CONFIG_WIRELESS is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
@@ -371,8 +402,92 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
+CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
@@ -412,7 +527,11 @@ CONFIG_HAVE_IDE=y
 #
 
 #
-# Enable only one of the two stacks, unless you know what you are doing
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# See the help texts for more information.
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
@@ -433,6 +552,8 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_IBM_NEW_EMAC=y
@@ -451,6 +572,7 @@ CONFIG_IBM_NEW_EMAC_EMAC4=y
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
 # CONFIG_ATL2 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
@@ -461,7 +583,6 @@ CONFIG_IBM_NEW_EMAC_EMAC4=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -533,13 +654,143 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_IBM_IIC=y
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Graphics adapter I2C/DDC channel drivers
+#
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 # CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+CONFIG_SENSORS_AD7414=y
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
@@ -556,24 +807,15 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
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
-CONFIG_DAB=y
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
@@ -600,7 +842,12 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -614,11 +861,12 @@ CONFIG_EXT2_FS=y
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
@@ -628,6 +876,11 @@ CONFIG_INOTIFY_USER=y
 # CONFIG_FUSE_FS is not set
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -660,6 +913,17 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
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
 CONFIG_CRAMFS=y
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -670,6 +934,7 @@ CONFIG_CRAMFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -681,7 +946,6 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_REGISTER_V4 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -697,6 +961,7 @@ CONFIG_SUNRPC=y
 CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 # CONFIG_DLM is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
@@ -711,11 +976,14 @@ CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
-CONFIG_PLIST=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_HAVE_LMB=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
 
 #
 # Kernel hacking
@@ -733,6 +1001,9 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
@@ -743,6 +1014,9 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -754,7 +1028,6 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
@@ -762,27 +1035,36 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_DEBUG_PAGEALLOC is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
-
-#
-# Tracers
-#
+CONFIG_TRACING_SUPPORT=y
+CONFIG_FTRACE=y
 # CONFIG_FUNCTION_TRACER is not set
+# CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
 # CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
 # CONFIG_STACK_TRACER is not set
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
+# CONFIG_KMEMCHECK is not set
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
 CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_PPC_EMULATED_STATS is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
-- 
1.6.3.4
