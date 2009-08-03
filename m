Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 305F6B7E06
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 17:29:56 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id D8B1EDDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 17:29:54 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	71F2531A1EF
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 09:29:48 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.202.159])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KNS00EM1I5NJ780@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 03 Aug 2009 09:29:48 +0200 (CEST)
Date: Mon, 03 Aug 2009 09:35:02 +0200
From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 2/2] 82xx, mgcoge: update defconfig for 2.6.32
To: linuxppc-dev@ozlabs.org
Message-id: <4A769326.9090302@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: david@gibson.dropbear.id.au
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- add I2C support
- add FCC1 and FCC2 support

Signed-off-by: Heiko Schocher <hs@denx.de>
---
- against git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
  next branch
- checked with checkpatch.pl:
$ ./scripts/checkpatch.pl 0002-82xx-mgcoge-update-defconfig-for-2.6.32.patch
total: 0 errors, 0 warnings, 381 lines checked

0002-82xx-mgcoge-update-defconfig-for-2.6.32.patch has no obvious style problems and is ready for submission.
$
- changes since v1
  - Add comments from David Gibson
    removed 2 "device_type" entries
  - Add comment from Kumar Gala
    splittet into 2 patches (seperated defconfig patch)

 arch/powerpc/configs/mgcoge_defconfig |  178 +++++++++++++++++++++++++-------
 1 files changed, 139 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 31e1df6..a6fe6b0 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -1,25 +1,27 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30-rc3
-# Wed May 13 17:21:55 2009
+# Linux kernel version: 2.6.31-rc4
+# Wed Jul 29 08:57:10 2009
 #
 # CONFIG_PPC64 is not set

 #
 # Processor support
 #
-CONFIG_6xx=y
+CONFIG_PPC_BOOK3S_32=y
 # CONFIG_PPC_85xx is not set
 # CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
 # CONFIG_E200 is not set
 CONFIG_PPC_BOOK3S=y
+CONFIG_6xx=y
 CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
+CONFIG_PPC_HAVE_PMU_SUPPORT=y
 # CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_WORD_SIZE=32
@@ -30,15 +32,16 @@ CONFIG_GENERIC_TIME=y
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
 CONFIG_GENERIC_GPIO=y
 # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
@@ -53,6 +56,7 @@ CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
 # CONFIG_DEFAULT_UIMAGE is not set
 CONFIG_HIBERNATE_32=y
 CONFIG_ARCH_HIBERNATION_POSSIBLE=y
@@ -60,6 +64,7 @@ CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y

 #
 # General setup
@@ -105,7 +110,6 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -119,8 +123,15 @@ CONFIG_TIMERFD=y
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
+# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
@@ -134,6 +145,11 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_CLK=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
 # CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
@@ -141,7 +157,7 @@ CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
 # CONFIG_MODULES is not set
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_INTEGRITY is not set

 #
@@ -225,6 +241,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_HAVE_AOUT is not set
 CONFIG_BINFMT_MISC=y
 # CONFIG_IOMMU_HELPER is not set
+# CONFIG_SWIOTLB is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
@@ -240,9 +257,9 @@ CONFIG_MIGRATION=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
 CONFIG_HAVE_MLOCK=y
 CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_PPC_4K_PAGES=y
 # CONFIG_PPC_16K_PAGES is not set
 # CONFIG_PPC_64K_PAGES is not set
@@ -313,6 +330,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -374,7 +392,11 @@ CONFIG_WIRELESS=y
 CONFIG_WIRELESS_OLD_REGULATORY=y
 # CONFIG_WIRELESS_EXT is not set
 # CONFIG_LIB80211 is not set
-# CONFIG_MAC80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+CONFIG_MAC80211_DEFAULT_PS_VALUE=0
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set

@@ -484,6 +506,8 @@ CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
 CONFIG_OF_GPIO=y
+CONFIG_OF_I2C=y
+CONFIG_OF_MDIO=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
@@ -523,13 +547,17 @@ CONFIG_HAVE_IDE=y
 #

 #
-# A new alternative FireWire stack is available with EXPERIMENTAL=y
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# See the help texts for more information.
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
-CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
@@ -555,7 +583,8 @@ CONFIG_PHYLIB=y
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
 CONFIG_FIXED_PHY=y
-# CONFIG_MDIO_BITBANG is not set
+CONFIG_MDIO_BITBANG=y
+# CONFIG_MDIO_GPIO is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_MACE is not set
@@ -577,11 +606,12 @@ CONFIG_MII=y
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
 # CONFIG_ATL2 is not set
 CONFIG_FS_ENET=y
 CONFIG_FS_ENET_HAS_SCC=y
-# CONFIG_FS_ENET_HAS_FCC is not set
-# CONFIG_FS_ENET_MDIO_FCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_FS_ENET_MDIO_FCC=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
@@ -652,8 +682,73 @@ CONFIG_HW_RANDOM=y
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
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
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# Mac SMBus host controller drivers
+#
+CONFIG_I2C_POWERMAC=y
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_CPM=y
+# CONFIG_I2C_DESIGNWARE is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
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
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_PCF8575 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
@@ -667,6 +762,9 @@ CONFIG_GPIOLIB=y
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set

 #
 # PCI GPIO expanders:
@@ -695,24 +793,16 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
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
-# CONFIG_DAB is not set
+# CONFIG_MEDIA_SUPPORT is not set

 #
 # Graphics support
@@ -740,6 +830,10 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set

 #
@@ -757,9 +851,10 @@ CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -916,6 +1011,7 @@ CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_HAVE_LMB=y
 CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y

 #
 # Kernel hacking
@@ -941,6 +1037,9 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -952,7 +1051,6 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
@@ -966,16 +1064,15 @@ CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
-
-#
-# Tracers
-#
+CONFIG_FTRACE=y
 # CONFIG_FUNCTION_TRACER is not set
+# CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
-# CONFIG_EVENT_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
 # CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
 # CONFIG_STACK_TRACER is not set
 # CONFIG_KMEMTRACE is not set
 # CONFIG_WORKQUEUE_TRACER is not set
@@ -983,9 +1080,12 @@ CONFIG_TRACING_SUPPORT=y
 # CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
 CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_PPC_EMULATED_STATS is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
