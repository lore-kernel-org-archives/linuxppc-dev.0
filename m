Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7ED6BDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 11:45:54 +1100 (EST)
Date: Wed, 21 Nov 2007 11:45:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Update iseries_defconfig
Message-Id: <20071121114552.c3b4243b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The notable changes hare are the enabling of NO_HZ and HIGH_RES_TIMERS.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/iseries_defconfig |  123 +++++++++++++++++---------------
 1 files changed, 64 insertions(+), 59 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index d78e3a6..4a87745 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Thu Aug 30 16:37:16 2007
+# Linux kernel version: 2.6.24-rc3
+# Wed Nov 21 11:19:59 2007
 #
 CONFIG_PPC64=y
 
@@ -11,6 +11,7 @@ CONFIG_PPC64=y
 # CONFIG_POWER4_ONLY is not set
 CONFIG_POWER3=y
 CONFIG_POWER4=y
+# CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
@@ -19,8 +20,13 @@ CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_64BIT=y
+CONFIG_WORD_SIZE=64
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -63,12 +69,17 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
+CONFIG_AUDIT_TREE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_CPUSETS is not set
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -89,7 +100,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -110,6 +120,7 @@ CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_BLK_DEV_BSG=y
+CONFIG_BLOCK_COMPAT=y
 
 #
 # IO Schedulers
@@ -128,7 +139,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_EMBEDDED6xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_86xx is not set
@@ -172,6 +182,10 @@ CONFIG_GENERIC_IOMAP=y
 #
 # Kernel options
 #
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -201,6 +215,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
@@ -227,11 +242,8 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCI_DEBUG is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 CONFIG_KERNEL_START=0xc000000000000000
@@ -271,6 +283,7 @@ CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=m
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -338,6 +351,7 @@ CONFIG_NETFILTER_XT_MATCH_SCTP=m
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
 # CONFIG_NETFILTER_XT_MATCH_U32 is not set
 # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
 
@@ -403,10 +417,6 @@ CONFIG_LLC=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 CONFIG_NET_CLS_ROUTE=y
 
@@ -436,6 +446,7 @@ CONFIG_NET_CLS_ROUTE=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -508,6 +519,7 @@ CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_SAS_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
 CONFIG_SCSI_SAS_LIBSAS_DEBUG=y
+CONFIG_SCSI_SRP_ATTRS=m
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
@@ -559,14 +571,8 @@ CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 # CONFIG_DM_MULTIPATH is not set
 # CONFIG_DM_DELAY is not set
-
-#
-# Fusion MPT device support
-#
+# CONFIG_DM_UEVENT is not set
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -582,6 +588,8 @@ CONFIG_BONDING=m
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=m
+# CONFIG_VETH is not set
+# CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
@@ -592,6 +600,10 @@ CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
 CONFIG_PCNET32_NAPI=y
@@ -599,7 +611,6 @@ CONFIG_PCNET32_NAPI=y
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
 # CONFIG_FEALNX is not set
@@ -619,6 +630,7 @@ CONFIG_ACENIC=m
 CONFIG_E1000=m
 # CONFIG_E1000_NAPI is not set
 # CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
+# CONFIG_E1000E is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -626,6 +638,7 @@ CONFIG_E1000=m
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -634,12 +647,15 @@ CONFIG_E1000=m
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
 # CONFIG_PASEMI_MAC is not set
 # CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
 CONFIG_TR=y
 CONFIG_IBMOL=y
 # CONFIG_3C359 is not set
@@ -669,6 +685,7 @@ CONFIG_SLHC=m
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 CONFIG_NETCONSOLE=y
+# CONFIG_NETCONSOLE_DYNAMIC is not set
 CONFIG_NETPOLL=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_NET_POLL_CONTROLLER=y
@@ -690,7 +707,6 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -736,14 +752,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_HVC_DRIVER=y
 CONFIG_HVC_ISERIES=y
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=256
 # CONFIG_HANGCHECK_TIMER is not set
@@ -759,6 +772,13 @@ CONFIG_DEVPORT=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -775,16 +795,17 @@ CONFIG_DEVPORT=y
 #
 # Graphics support
 #
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-# CONFIG_FB_IBM_GXT4500 is not set
 
 #
 # Console display driver support
@@ -806,19 +827,6 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
 # Userspace I/O
 #
 # CONFIG_UIO is not set
@@ -902,7 +910,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 CONFIG_CONFIGFS_FS=m
 
 #
@@ -921,10 +928,7 @@ CONFIG_CRAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
@@ -963,10 +967,6 @@ CONFIG_CIFS_POSIX=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
@@ -1007,10 +1007,6 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
-
-#
-# Distributed Lock Manager
-#
 CONFIG_DLM=m
 # CONFIG_DLM_DEBUG is not set
 # CONFIG_UCC_SLOW is not set
@@ -1035,17 +1031,16 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-
-#
-# Instrumentation Support
-#
+CONFIG_INSTRUMENTATION=y
 # CONFIG_PROFILING is not set
 # CONFIG_KPROBES is not set
+# CONFIG_MARKERS is not set
 
 #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1069,14 +1064,18 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 # CONFIG_FORCED_INLINING is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
+# CONFIG_VIRQ_DEBUG is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
@@ -1085,8 +1084,10 @@ CONFIG_IRQSTACKS=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=m
 CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
@@ -1105,6 +1106,7 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
@@ -1119,9 +1121,12 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
 # CONFIG_CRYPTO_CAMELLIA is not set
 CONFIG_CRYPTO_TEST=m
+CONFIG_CRYPTO_AUTHENC=m
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_PPC_CLOCK is not set
-- 
1.5.3.6


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
