Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90A01B7D55
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 02:05:34 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0QEwusH031211
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 09:58:56 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0QF5VP0152770
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 10:05:31 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0QF5UVF024438
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 13:05:31 -0200
Date: Tue, 26 Jan 2010 10:05:26 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] powerpc/44x: Add MTD support to katmai defconfig
Message-ID: <20100126150526.GR7484@zod.rchland.ibm.com>
References: <1264513820-16354-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1264513820-16354-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2010 at 02:50:20PM +0100, Stefan Roese wrote:
>Signed-off-by: Stefan Roese <sr@denx.de>
>Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>

I have an updated defconfig sitting in my 'merge' branch that Ben was supposed
to pull about 3 weeks ago.  This will conflict with that.  Do you think you
could regen the MTD adds off of that branch instead?

Ben, please pull those defconfig updates...

josh

>---
> arch/powerpc/configs/44x/katmai_defconfig |  339 +++++++++++++++++++++++------
> 1 files changed, 274 insertions(+), 65 deletions(-)
>
>diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/configs/44x/katmai_defconfig
>index c23a4ef..af244e1 100644
>--- a/arch/powerpc/configs/44x/katmai_defconfig
>+++ b/arch/powerpc/configs/44x/katmai_defconfig
>@@ -1,14 +1,14 @@
> #
> # Automatically generated make config: don't edit
>-# Linux kernel version: 2.6.29-rc2
>-# Tue Jan 20 08:22:38 2009
>+# Linux kernel version: 2.6.33-rc5
>+# Tue Jan 26 14:40:58 2010
> #
> # CONFIG_PPC64 is not set
>
> #
> # Processor support
> #
>-# CONFIG_6xx is not set
>+# CONFIG_PPC_BOOK3S_32 is not set
> # CONFIG_PPC_85xx is not set
> # CONFIG_PPC_8xx is not set
> # CONFIG_40x is not set
>@@ -19,6 +19,7 @@ CONFIG_BOOKE=y
> CONFIG_PTE_64BIT=y
> CONFIG_PHYS_64BIT=y
> CONFIG_PPC_MMU_NOHASH=y
>+CONFIG_PPC_MMU_NOHASH_32=y
> # CONFIG_PPC_MM_SLICES is not set
> CONFIG_NOT_COHERENT_CACHE=y
> CONFIG_PPC32=y
>@@ -30,15 +31,18 @@ CONFIG_GENERIC_TIME=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_HARDIRQS=y
>+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
> # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
>+# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
> CONFIG_IRQ_PER_CPU=y
>+CONFIG_NR_IRQS=512
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_LATENCYTOP_SUPPORT=y
>+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_ARCH_HAS_ILOG2_U32=y
> CONFIG_GENERIC_HWEIGHT=y
>-CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_GENERIC_FIND_NEXT_BIT=y
> # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
> CONFIG_PPC=y
>@@ -52,11 +56,15 @@ CONFIG_PPC_UDBG_16550=y
> # CONFIG_GENERIC_TBSYNC is not set
> CONFIG_AUDIT_ARCH=y
> CONFIG_GENERIC_BUG=y
>+CONFIG_DTC=y
> # CONFIG_DEFAULT_UIMAGE is not set
>+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_PPC_DCR_NATIVE=y
> # CONFIG_PPC_DCR_MMIO is not set
> CONFIG_PPC_DCR=y
>+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>+CONFIG_CONSTRUCTORS=y
>
> #
> # General setup
>@@ -70,9 +78,21 @@ CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
>+CONFIG_POSIX_MQUEUE_SYSCTL=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_AUDIT is not set
>+
>+#
>+# RCU Subsystem
>+#
>+CONFIG_TREE_RCU=y
>+# CONFIG_TREE_PREEMPT_RCU is not set
>+# CONFIG_TINY_RCU is not set
>+# CONFIG_RCU_TRACE is not set
>+CONFIG_RCU_FANOUT=32
>+# CONFIG_RCU_FANOUT_EXACT is not set
>+# CONFIG_TREE_RCU_TRACE is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_LOG_BUF_SHIFT=14
> # CONFIG_GROUP_SCHED is not set
>@@ -83,8 +103,13 @@ CONFIG_SYSFS_DEPRECATED_V2=y
> # CONFIG_NAMESPACES is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
>+CONFIG_RD_GZIP=y
>+# CONFIG_RD_BZIP2 is not set
>+# CONFIG_RD_LZMA is not set
>+# CONFIG_RD_LZO is not set
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
>+CONFIG_ANON_INODES=y
> CONFIG_EMBEDDED=y
> CONFIG_SYSCTL_SYSCALL=y
> CONFIG_KALLSYMS=y
>@@ -94,19 +119,25 @@ CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
>-CONFIG_COMPAT_BRK=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
>-CONFIG_ANON_INODES=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
>+CONFIG_HAVE_PERF_EVENTS=y
>+
>+#
>+# Kernel Performance Events And Counters
>+#
>+# CONFIG_PERF_EVENTS is not set
>+# CONFIG_PERF_COUNTERS is not set
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_PCI_QUIRKS=y
> CONFIG_SLUB_DEBUG=y
>+CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
>@@ -118,6 +149,13 @@ CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
>+CONFIG_HAVE_DMA_ATTRS=y
>+CONFIG_HAVE_DMA_API_DEBUG=y
>+
>+#
>+# GCOV-based kernel profiling
>+#
>+# CONFIG_SLOW_WORK is not set
> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> CONFIG_SLABINFO=y
> CONFIG_RT_MUTEXES=y
>@@ -129,8 +167,7 @@ CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_BLOCK=y
>-CONFIG_LBD=y
>-# CONFIG_BLK_DEV_IO_TRACE is not set
>+CONFIG_LBDAF=y
> # CONFIG_BLK_DEV_BSG is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
>
>@@ -138,19 +175,41 @@ CONFIG_LBD=y
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
>-CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
>-CONFIG_DEFAULT_AS=y
> # CONFIG_DEFAULT_DEADLINE is not set
>-# CONFIG_DEFAULT_CFQ is not set
>+CONFIG_DEFAULT_CFQ=y
> # CONFIG_DEFAULT_NOOP is not set
>-CONFIG_DEFAULT_IOSCHED="anticipatory"
>-CONFIG_CLASSIC_RCU=y
>-# CONFIG_TREE_RCU is not set
>-# CONFIG_PREEMPT_RCU is not set
>-# CONFIG_TREE_RCU_TRACE is not set
>-# CONFIG_PREEMPT_RCU_TRACE is not set
>+CONFIG_DEFAULT_IOSCHED="cfq"
>+# CONFIG_INLINE_SPIN_TRYLOCK is not set
>+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
>+# CONFIG_INLINE_SPIN_LOCK is not set
>+# CONFIG_INLINE_SPIN_LOCK_BH is not set
>+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
>+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
>+CONFIG_INLINE_SPIN_UNLOCK=y
>+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
>+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
>+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
>+# CONFIG_INLINE_READ_TRYLOCK is not set
>+# CONFIG_INLINE_READ_LOCK is not set
>+# CONFIG_INLINE_READ_LOCK_BH is not set
>+# CONFIG_INLINE_READ_LOCK_IRQ is not set
>+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
>+CONFIG_INLINE_READ_UNLOCK=y
>+# CONFIG_INLINE_READ_UNLOCK_BH is not set
>+CONFIG_INLINE_READ_UNLOCK_IRQ=y
>+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
>+# CONFIG_INLINE_WRITE_TRYLOCK is not set
>+# CONFIG_INLINE_WRITE_LOCK is not set
>+# CONFIG_INLINE_WRITE_LOCK_BH is not set
>+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
>+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
>+CONFIG_INLINE_WRITE_UNLOCK=y
>+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
>+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
>+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
>+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
> # CONFIG_FREEZER is not set
> CONFIG_PPC4xx_PCI_EXPRESS=y
>
>@@ -171,6 +230,8 @@ CONFIG_KATMAI=y
> # CONFIG_ARCHES is not set
> # CONFIG_CANYONLANDS is not set
> # CONFIG_GLACIER is not set
>+# CONFIG_REDWOOD is not set
>+# CONFIG_EIGER is not set
> # CONFIG_YOSEMITE is not set
> # CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
> CONFIG_PPC44x_SIMPLE=y
>@@ -212,10 +273,12 @@ CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_MATH_EMULATION is not set
> # CONFIG_IOMMU_HELPER is not set
>-CONFIG_PPC_NEED_DMA_SYNC_OPS=y
>+# CONFIG_SWIOTLB is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_HAS_WALK_MEMORY=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
>+CONFIG_SPARSE_IRQ=y
>+CONFIG_MAX_ACTIVE_REGIONS=32
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_SELECT_MEMORY_MODEL=y
>@@ -231,10 +294,13 @@ CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_ZONE_DMA_FLAG=1
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
>-CONFIG_UNEVICTABLE_LRU=y
>+# CONFIG_KSM is not set
>+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>+CONFIG_STDBINUTILS=y
> CONFIG_PPC_4K_PAGES=y
> # CONFIG_PPC_16K_PAGES is not set
> # CONFIG_PPC_64K_PAGES is not set
>+# CONFIG_PPC_256K_PAGES is not set
> CONFIG_FORCE_MAX_ZONEORDER=11
> CONFIG_PROC_DEVICETREE=y
> CONFIG_CMDLINE_BOOL=y
>@@ -259,6 +325,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
> # CONFIG_PCI_LEGACY is not set
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
>+# CONFIG_PCI_IOV is not set
> # CONFIG_PCCARD is not set
> # CONFIG_HOTPLUG_PCI is not set
> # CONFIG_HAS_RAPIDIO is not set
>@@ -276,14 +343,12 @@ CONFIG_PAGE_OFFSET=0xc0000000
> CONFIG_KERNEL_START=0xc0000000
> CONFIG_PHYSICAL_START=0x00000000
> CONFIG_TASK_SIZE=0xc0000000
>-CONFIG_CONSISTENT_START=0xff100000
> CONFIG_CONSISTENT_SIZE=0x00200000
> CONFIG_NET=y
>
> #
> # Networking options
> #
>-CONFIG_COMPAT_NET_DEV_OPS=y
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=y
>@@ -320,6 +385,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_NETFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
>+# CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
>@@ -333,6 +399,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
>+# CONFIG_PHONET is not set
>+# CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
>
>@@ -345,8 +413,13 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
>-# CONFIG_PHONET is not set
>-# CONFIG_WIRELESS is not set
>+CONFIG_WIRELESS=y
>+# CONFIG_CFG80211 is not set
>+# CONFIG_LIB80211 is not set
>+
>+#
>+# CFG80211 needs to be enabled for MAC80211
>+#
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
>@@ -359,6 +432,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>+# CONFIG_DEVTMPFS is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
>@@ -369,7 +443,90 @@ CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_SYS_HYPERVISOR is not set
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
>-# CONFIG_MTD is not set
>+CONFIG_MTD=y
>+# CONFIG_MTD_DEBUG is not set
>+# CONFIG_MTD_TESTS is not set
>+# CONFIG_MTD_CONCAT is not set
>+CONFIG_MTD_PARTITIONS=y
>+# CONFIG_MTD_REDBOOT_PARTS is not set
>+CONFIG_MTD_CMDLINE_PARTS=y
>+CONFIG_MTD_OF_PARTS=y
>+# CONFIG_MTD_AR7_PARTS is not set
>+
>+#
>+# User Modules And Translation Layers
>+#
>+CONFIG_MTD_CHAR=y
>+CONFIG_MTD_BLKDEVS=y
>+CONFIG_MTD_BLOCK=y
>+# CONFIG_FTL is not set
>+# CONFIG_NFTL is not set
>+# CONFIG_INFTL is not set
>+# CONFIG_RFD_FTL is not set
>+# CONFIG_SSFDC is not set
>+# CONFIG_MTD_OOPS is not set
>+
>+#
>+# RAM/ROM/Flash chip drivers
>+#
>+CONFIG_MTD_CFI=y
>+# CONFIG_MTD_JEDECPROBE is not set
>+CONFIG_MTD_GEN_PROBE=y
>+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
>+CONFIG_MTD_MAP_BANK_WIDTH_1=y
>+CONFIG_MTD_MAP_BANK_WIDTH_2=y
>+CONFIG_MTD_MAP_BANK_WIDTH_4=y
>+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
>+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
>+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
>+CONFIG_MTD_CFI_I1=y
>+CONFIG_MTD_CFI_I2=y
>+# CONFIG_MTD_CFI_I4 is not set
>+# CONFIG_MTD_CFI_I8 is not set
>+# CONFIG_MTD_CFI_INTELEXT is not set
>+CONFIG_MTD_CFI_AMDSTD=y
>+# CONFIG_MTD_CFI_STAA is not set
>+CONFIG_MTD_CFI_UTIL=y
>+# CONFIG_MTD_RAM is not set
>+# CONFIG_MTD_ROM is not set
>+# CONFIG_MTD_ABSENT is not set
>+
>+#
>+# Mapping drivers for chip access
>+#
>+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
>+# CONFIG_MTD_PHYSMAP is not set
>+CONFIG_MTD_PHYSMAP_OF=y
>+# CONFIG_MTD_INTEL_VR_NOR is not set
>+# CONFIG_MTD_PLATRAM is not set
>+
>+#
>+# Self-contained MTD device drivers
>+#
>+# CONFIG_MTD_PMC551 is not set
>+# CONFIG_MTD_SLRAM is not set
>+# CONFIG_MTD_PHRAM is not set
>+# CONFIG_MTD_MTDRAM is not set
>+# CONFIG_MTD_BLOCK2MTD is not set
>+
>+#
>+# Disk-On-Chip Device Drivers
>+#
>+# CONFIG_MTD_DOC2000 is not set
>+# CONFIG_MTD_DOC2001 is not set
>+# CONFIG_MTD_DOC2001PLUS is not set
>+# CONFIG_MTD_NAND is not set
>+# CONFIG_MTD_ONENAND is not set
>+
>+#
>+# LPDDR flash memory drivers
>+#
>+# CONFIG_MTD_LPDDR is not set
>+
>+#
>+# UBI - Unsorted block images
>+#
>+# CONFIG_MTD_UBI is not set
> CONFIG_OF_DEVICE=y
> # CONFIG_PARPORT is not set
> CONFIG_BLK_DEV=y
>@@ -380,6 +537,7 @@ CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> # CONFIG_BLK_DEV_LOOP is not set
>+# CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y
>@@ -392,12 +550,17 @@ CONFIG_BLK_DEV_RAM_SIZE=35000
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_MISC_DEVICES=y
> # CONFIG_PHANTOM is not set
>-# CONFIG_EEPROM_93CX6 is not set
> # CONFIG_SGI_IOC4 is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_C2PORT is not set
>+
>+#
>+# EEPROM support
>+#
>+# CONFIG_EEPROM_93CX6 is not set
>+# CONFIG_CB710_CORE is not set
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
>
>@@ -417,7 +580,11 @@ CONFIG_HAVE_IDE=y
> #
>
> #
>-# Enable only one of the two stacks, unless you know what you are doing
>+# You can enable one or both FireWire driver stacks.
>+#
>+
>+#
>+# The newer stack is recommended.
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_IEEE1394 is not set
>@@ -440,6 +607,8 @@ CONFIG_NET_ETHERNET=y
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
>+# CONFIG_ETHOC is not set
>+# CONFIG_DNET is not set
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_IBM_NEW_EMAC=y
>@@ -458,7 +627,10 @@ CONFIG_IBM_NEW_EMAC_EMAC4=y
> # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
> # CONFIG_NET_PCI is not set
> # CONFIG_B44 is not set
>+# CONFIG_KS8842 is not set
>+# CONFIG_KS8851_MLL is not set
> # CONFIG_ATL2 is not set
>+# CONFIG_XILINX_EMACLITE is not set
> CONFIG_NETDEV_1000=y
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
>@@ -466,6 +638,7 @@ CONFIG_NETDEV_1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IP1000 is not set
> # CONFIG_IGB is not set
>+# CONFIG_IGBVF is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
>@@ -476,9 +649,13 @@ CONFIG_NETDEV_1000=y
> # CONFIG_VIA_VELOCITY is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2 is not set
>+# CONFIG_CNIC is not set
>+# CONFIG_MV643XX_ETH is not set
>+# CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_QLA3XXX is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
>+# CONFIG_ATL1C is not set
> # CONFIG_JME is not set
> CONFIG_NETDEV_10000=y
> # CONFIG_CHELSIO_T1 is not set
>@@ -488,6 +665,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
> # CONFIG_IXGBE is not set
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
>+# CONFIG_VXGE is not set
> # CONFIG_MYRI10GE is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_NIU is not set
>@@ -497,14 +675,13 @@ CONFIG_CHELSIO_T3_DEPENDS=y
> # CONFIG_BNX2X is not set
> # CONFIG_QLGE is not set
> # CONFIG_SFC is not set
>+# CONFIG_BE2NET is not set
> # CONFIG_TR is not set
>-
>-#
>-# Wireless LAN
>-#
>-# CONFIG_WLAN_PRE80211 is not set
>-# CONFIG_WLAN_80211 is not set
>-# CONFIG_IWLWIFI_LEDS is not set
>+CONFIG_WLAN=y
>+# CONFIG_AIRO is not set
>+# CONFIG_ATMEL is not set
>+# CONFIG_PRISM54 is not set
>+# CONFIG_HOSTAP is not set
>
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
>@@ -517,6 +694,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
>+# CONFIG_VMXNET3 is not set
> # CONFIG_ISDN is not set
> # CONFIG_PHONE is not set
>
>@@ -562,6 +740,7 @@ CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_SERIAL_OF_PLATFORM=y
> # CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL is not set
>+# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> CONFIG_LEGACY_PTYS=y
>@@ -578,13 +757,17 @@ CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_DEVPORT=y
> # CONFIG_I2C is not set
> # CONFIG_SPI is not set
>+
>+#
>+# PPS support
>+#
>+# CONFIG_PPS is not set
> CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
> # CONFIG_GPIOLIB is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> # CONFIG_THERMAL is not set
>-# CONFIG_THERMAL_HWMON is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
>
>@@ -601,27 +784,13 @@ CONFIG_SSB_POSSIBLE=y
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_REGULATOR is not set
>-
>-#
>-# Multimedia devices
>-#
>-
>-#
>-# Multimedia core support
>-#
>-# CONFIG_VIDEO_DEV is not set
>-# CONFIG_DVB_CORE is not set
>-# CONFIG_VIDEO_MEDIA is not set
>-
>-#
>-# Multimedia drivers
>-#
>-CONFIG_DAB=y
>+# CONFIG_MEDIA_SUPPORT is not set
>
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
>+CONFIG_VGA_ARB=y
> # CONFIG_DRM is not set
> # CONFIG_VGASTATE is not set
> CONFIG_VIDEO_OUTPUT_CONTROL=m
>@@ -646,7 +815,7 @@ CONFIG_USB_ARCH_HAS_EHCI=y
> #
>
> #
>-# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
>+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> # CONFIG_USB_GADGET is not set
>
>@@ -662,7 +831,12 @@ CONFIG_USB_ARCH_HAS_EHCI=y
> # CONFIG_EDAC is not set
> # CONFIG_RTC_CLASS is not set
> # CONFIG_DMADEVICES is not set
>+# CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
>+
>+#
>+# TI VLYNQ
>+#
> # CONFIG_STAGING is not set
>
> #
>@@ -676,11 +850,13 @@ CONFIG_EXT2_FS=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
>-CONFIG_FILE_LOCKING=y
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
>+# CONFIG_NILFS2_FS is not set
>+CONFIG_FILE_LOCKING=y
>+CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY=y
> CONFIG_INOTIFY_USER=y
>@@ -690,6 +866,11 @@ CONFIG_INOTIFY_USER=y
> # CONFIG_FUSE_FS is not set
>
> #
>+# Caches
>+#
>+# CONFIG_FSCACHE is not set
>+
>+#
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
>@@ -722,6 +903,7 @@ CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
>+# CONFIG_JFFS2_FS is not set
> CONFIG_CRAMFS=y
> # CONFIG_SQUASHFS is not set
> # CONFIG_VXFS_FS is not set
>@@ -743,7 +925,6 @@ CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
>-# CONFIG_SUNRPC_REGISTER_V4 is not set
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
>@@ -759,6 +940,7 @@ CONFIG_SUNRPC=y
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_NLS is not set
> # CONFIG_DLM is not set
>+# CONFIG_BINARY_PRINTF is not set
>
> #
> # Library routines
>@@ -773,11 +955,13 @@ CONFIG_CRC32=y
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=y
>-CONFIG_PLIST=y
>+CONFIG_DECOMPRESS_GZIP=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_DMA=y
> CONFIG_HAVE_LMB=y
>+CONFIG_NLATTR=y
>+CONFIG_GENERIC_ATOMIC64=y
>
> #
> # Kernel hacking
>@@ -787,6 +971,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=1024
> CONFIG_MAGIC_SYSRQ=y
>+# CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_HEADERS_CHECK is not set
>@@ -795,16 +980,23 @@ CONFIG_DEBUG_KERNEL=y
> CONFIG_DETECT_SOFTLOCKUP=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
>+CONFIG_DETECT_HUNG_TASK=y
>+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> CONFIG_SCHED_DEBUG=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_TIMER_STATS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
>+# CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
>+# CONFIG_DEBUG_LOCK_ALLOC is not set
>+# CONFIG_PROVE_LOCKING is not set
>+# CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_DEBUG_KOBJECT is not set
>@@ -816,35 +1008,43 @@ CONFIG_SCHED_DEBUG=y
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
>-# CONFIG_BOOT_PRINTK_DELAY is not set
>+# CONFIG_DEBUG_CREDENTIALS is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_SYSCTL_SYSCALL_CHECK=y
>+# CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_HAVE_FUNCTION_TRACER=y
>+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>-
>-#
>-# Tracers
>-#
>+CONFIG_TRACING_SUPPORT=y
>+CONFIG_FTRACE=y
> # CONFIG_FUNCTION_TRACER is not set
>+# CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
>-# CONFIG_CONTEXT_SWITCH_TRACER is not set
>+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
> # CONFIG_BOOT_TRACER is not set
>-# CONFIG_TRACE_BRANCH_PROFILING is not set
>+CONFIG_BRANCH_PROFILE_NONE=y
>+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>+# CONFIG_PROFILE_ALL_BRANCHES is not set
> # CONFIG_STACK_TRACER is not set
>-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
>+# CONFIG_KMEMTRACE is not set
>+# CONFIG_WORKQUEUE_TRACER is not set
>+# CONFIG_BLK_DEV_IO_TRACE is not set
>+# CONFIG_DMA_API_DEBUG is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
>+# CONFIG_PPC_DISABLE_WERROR is not set
>+CONFIG_PPC_WERROR=y
> CONFIG_PRINT_STACK_DEPTH=64
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
>-# CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_CODE_PATCHING_SELFTEST is not set
> # CONFIG_FTR_FIXUP_SELFTEST is not set
> # CONFIG_MSI_BITMAP_SELFTEST is not set
>@@ -859,13 +1059,16 @@ CONFIG_PRINT_STACK_DEPTH=64
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
>-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
>+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
>+# CONFIG_DEFAULT_SECURITY_SMACK is not set
>+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
>+CONFIG_DEFAULT_SECURITY_DAC=y
>+CONFIG_DEFAULT_SECURITY=""
> CONFIG_CRYPTO=y
>
> #
> # Crypto core or helper
> #
>-# CONFIG_CRYPTO_FIPS is not set
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD2=y
>@@ -874,10 +1077,12 @@ CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG2=y
>+CONFIG_CRYPTO_PCOMP=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_GF128MUL is not set
> # CONFIG_CRYPTO_NULL is not set
>+CONFIG_CRYPTO_WORKQUEUE=y
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
>@@ -905,11 +1110,13 @@ CONFIG_CRYPTO_PCBC=y
> #
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_XCBC is not set
>+# CONFIG_CRYPTO_VMAC is not set
>
> #
> # Digest
> #
> # CONFIG_CRYPTO_CRC32C is not set
>+# CONFIG_CRYPTO_GHASH is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
>@@ -946,6 +1153,7 @@ CONFIG_CRYPTO_DES=y
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
>+# CONFIG_CRYPTO_ZLIB is not set
> # CONFIG_CRYPTO_LZO is not set
>
> #
>@@ -954,5 +1162,6 @@ CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_HIFN_795X is not set
>+# CONFIG_CRYPTO_DEV_PPC4XX is not set
> # CONFIG_PPC_CLOCK is not set
> # CONFIG_VIRTUALIZATION is not set
>-- 
>1.6.6.1
>
