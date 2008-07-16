Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id EE72EDE941
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:28:28 +1000 (EST)
Message-ID: <487E6692.1090202@am.sony.com>
Date: Wed, 16 Jul 2008 14:22:26 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 2/2] powerpc/ps3: Update ps3_defconfig
References: <487E654C.9030001@am.sony.com>
In-Reply-To: <487E654C.9030001@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/configs/ps3_defconfig |  196 +++++++++++++++++++++++--------------
 1 file changed, 122 insertions(+), 74 deletions(-)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25
-# Mon Apr 28 12:39:10 2008
+# Linux kernel version: 2.6.26
+# Wed Jul 16 13:59:24 2008
 #
 CONFIG_PPC64=y
 
@@ -14,8 +14,9 @@ CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
+# CONFIG_VSX is not set
 CONFIG_PPC_STD_MMU=y
-# CONFIG_PPC_MM_SLICES is not set
+CONFIG_PPC_MM_SLICES=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
@@ -31,6 +32,7 @@ CONFIG_GENERIC_HARDIRQS=y
 CONFIG_HAVE_SETUP_PER_CPU_AREA=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -90,6 +92,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -117,12 +120,15 @@ CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_USE_GENERIC_SMP_HELPERS=y
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
@@ -132,6 +138,7 @@ CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_BLK_DEV_BSG=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
 CONFIG_BLOCK_COMPAT=y
 
 #
@@ -152,13 +159,8 @@ CONFIG_CLASSIC_RCU=y
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_86xx is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
-# CONFIG_PPC_MPC512x is not set
-# CONFIG_PPC_MPC5121 is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
@@ -187,6 +189,7 @@ CONFIG_PPC_CELL=y
 # Cell Broadband Engine options
 #
 CONFIG_SPU_FS=y
+CONFIG_SPU_FS_64K_LS=y
 CONFIG_SPU_BASE=y
 # CONFIG_PQ2ADS is not set
 # CONFIG_IPIC is not set
@@ -222,6 +225,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 CONFIG_COMPAT_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
+CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
 # CONFIG_IOMMU_VMERGE is not set
 CONFIG_IOMMU_HELPER=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
@@ -248,18 +252,22 @@ CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
 # CONFIG_SPARSEMEM_VMEMMAP is not set
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_ARCH_MEMORY_PROBE=y
-# CONFIG_PPC_HAS_HASH_64K is not set
+CONFIG_PPC_HAS_HASH_64K=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_FORCE_MAX_ZONEORDER=13
-# CONFIG_SCHED_SMT is not set
+CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
-# CONFIG_PM is not set
+CONFIG_EXTRA_TARGETS=""
+CONFIG_PM=y
+CONFIG_PM_DEBUG=y
+# CONFIG_PM_VERBOSE is not set
 # CONFIG_SECCOMP is not set
 CONFIG_ISA_DMA_API=y
 
@@ -273,6 +281,7 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCCARD is not set
+# CONFIG_HAS_RAPIDIO is not set
 CONFIG_PAGE_OFFSET=0xc000000000000000
 CONFIG_KERNEL_START=0xc000000000000000
 CONFIG_PHYSICAL_START=0x00000000
@@ -412,6 +421,8 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
@@ -478,6 +489,7 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_SAS_LIBSAS is not set
 # CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
@@ -533,8 +545,18 @@ CONFIG_USB_NET_MCS7830=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
 # CONFIG_WAN is not set
-# CONFIG_PPP is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+# CONFIG_PPP_SYNC_TTY is not set
+CONFIG_PPP_DEFLATE=m
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
+CONFIG_PPPOE=m
+# CONFIG_PPPOL2TP is not set
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -603,6 +625,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -618,23 +641,17 @@ CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_HANGCHECK_TIMER is not set
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 
 #
@@ -652,8 +669,17 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
 # CONFIG_DAB is not set
 
 #
@@ -671,8 +697,8 @@ CONFIG_FB=y
 CONFIG_FB_SYS_FILLRECT=y
 CONFIG_FB_SYS_COPYAREA=y
 CONFIG_FB_SYS_IMAGEBLIT=y
+# CONFIG_FB_FOREIGN_ENDIAN is not set
 CONFIG_FB_SYS_FOPS=y
-CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -712,18 +738,12 @@ CONFIG_FB_LOGO_EXTRA=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-
-#
-# Sound
-#
 CONFIG_SOUND=m
-
-#
-# Advanced Linux Sound Architecture
-#
 CONFIG_SND=m
 CONFIG_SND_TIMER=m
 CONFIG_SND_PCM=m
+CONFIG_SND_HWDEP=m
+CONFIG_SND_RAWMIDI=m
 # CONFIG_SND_SEQUENCER is not set
 # CONFIG_SND_MIXER_OSS is not set
 # CONFIG_SND_PCM_OSS is not set
@@ -732,53 +752,20 @@ CONFIG_SND_SUPPORT_OLD_API=y
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
-
-#
-# Generic devices
-#
-# CONFIG_SND_DUMMY is not set
-# CONFIG_SND_MTPAV is not set
-# CONFIG_SND_SERIAL_U16550 is not set
-# CONFIG_SND_MPU401 is not set
-
-#
-# ALSA PowerMac devices
-#
-
-#
-# ALSA PowerMac requires I2C
-#
-
-#
-# ALSA PowerPC devices
-#
+# CONFIG_SND_DRIVERS is not set
+CONFIG_SND_PPC=y
 CONFIG_SND_PS3=m
 CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
-
-#
-# USB devices
-#
-# CONFIG_SND_USB_AUDIO is not set
+CONFIG_SND_USB=y
+CONFIG_SND_USB_AUDIO=m
 # CONFIG_SND_USB_USX2Y is not set
 # CONFIG_SND_USB_CAIAQ is not set
-
-#
-# System on Chip audio support
-#
 # CONFIG_SND_SOC is not set
-
-#
-# ALSA SoC audio for Freescale SOCs
-#
-
-#
-# Open Sound System
-#
 # CONFIG_SOUND_PRIME is not set
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
-# CONFIG_HIDRAW is not set
+CONFIG_HIDRAW=y
 
 #
 # USB Input Devices
@@ -807,17 +794,20 @@ CONFIG_USB=m
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+CONFIG_USB_SUSPEND=y
 # CONFIG_USB_OTG is not set
 
 #
 # USB Host Controller Drivers
 #
+# CONFIG_USB_C67X00_HCD is not set
 CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_EHCI_HCD_PPC_OF is not set
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=m
 # CONFIG_USB_OHCI_HCD_PPC_OF is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
@@ -831,6 +821,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -890,12 +881,45 @@ CONFIG_USB_MON=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_EDAC is not set
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=m
+CONFIG_RTC_CLASS=m
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_PPC=m
 # CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
 
@@ -911,6 +935,7 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -959,8 +984,8 @@ CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
-# CONFIG_HUGETLBFS is not set
-# CONFIG_HUGETLB_PAGE is not set
+CONFIG_HUGETLBFS=y
+CONFIG_HUGETLB_PAGE=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1059,12 +1084,15 @@ CONFIG_NLS_ISO8859_1=y
 #
 CONFIG_BITREVERSE=y
 # CONFIG_GENERIC_FIND_FIRST_BIT is not set
-# CONFIG_CRC_CCITT is not set
+CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
 CONFIG_CRC_ITU_T=m
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=m
+CONFIG_ZLIB_DEFLATE=m
 CONFIG_LZO_COMPRESS=m
 CONFIG_LZO_DECOMPRESS=m
 CONFIG_PLIST=y
@@ -1082,7 +1110,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
@@ -1090,33 +1118,49 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_LOCK_ALLOC is not set
-# CONFIG_PROVE_LOCKING is not set
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_LOCKDEP=y
 # CONFIG_LOCK_STAT is not set
+CONFIG_DEBUG_LOCKDEP=y
+CONFIG_TRACE_IRQFLAGS=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+CONFIG_STACKTRACE=y
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
-# CONFIG_DEBUG_WRITECOUNT is not set
+CONFIG_DEBUG_WRITECOUNT=y
 CONFIG_DEBUG_LIST=y
 # CONFIG_DEBUG_SG is not set
+CONFIG_FRAME_POINTER=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_HAVE_FTRACE=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+# CONFIG_FTRACE is not set
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
 # CONFIG_SAMPLES is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
 CONFIG_IRQSTACKS=y
+# CONFIG_VIRQ_DEBUG is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
@@ -1172,6 +1216,10 @@ CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
