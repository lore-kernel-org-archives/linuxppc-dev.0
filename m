Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 03 Oct 2008 10:07:19 +1000
Subject: [PATCH] powerpc: Simple platform for the ISS 4xx simulator
Message-Id: <20081003000737.85CFEDDE17@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a trivial 4xx plaform that uses the new simple bsp from
Josh and is handy to use in simulators such as ISS or even Mambo
who don't properly implement most of the actual devices in the
SoC but really only the core.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/Makefile                 |    7 
 arch/powerpc/boot/dts/iss4xx.dts           |  107 +++
 arch/powerpc/boot/treeboot-iss4xx.c        |   54 +
 arch/powerpc/configs/44x/iss4xx_defconfig  |  827 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig         |   11 
 arch/powerpc/platforms/44x/ppc44x_simple.c |    3 
 6 files changed, 1006 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/boot/Makefile	2008-10-02 15:45:47.000000000 +1000
+++ linux-work/arch/powerpc/boot/Makefile	2008-10-02 15:46:11.000000000 +1000
@@ -42,6 +42,7 @@ $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-iss4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
 
@@ -68,7 +69,8 @@ src-plat := of.c cuboot-52xx.c cuboot-82
 		fixed-head.S ep88xc.c ep405.c cuboot-c2k.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
-		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c
+		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
+		treeboot-iss4xx.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -221,7 +223,8 @@ image-$(CONFIG_RAINIER)			+= cuImage.rai
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
 image-$(CONFIG_WARP)			+= cuImage.warp
-image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
+image-$(CONFIG_YOSEMITE)		+= cuImage.yosemit
+image-$(CONFIG_ISS4xx)			+= treeImage.iss4xx
 
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_MPC86XADS)		+= cuImage.mpc866ads
Index: linux-work/arch/powerpc/boot/dts/iss4xx.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/dts/iss4xx.dts	2008-10-02 15:46:11.000000000 +1000
@@ -0,0 +1,107 @@
+/*
+ * Device Tree Source for IBM Ebony
+ *
+ * Copyright (c) 2006, 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * FIXME: Draft only!
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,iss-4xx";
+	compatible = "ibm,iss-4xx";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <0x00000000>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>; // may need fixup in sim
+			d-cache-line-size = <32>; // may need fixup in sim
+			i-cache-size = <32768>; /* may need fixup in sim */
+			d-cache-size = <32768>; /* may need fixup in sim */
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-4xx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-4xx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0x0d0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	plb {
+		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; // Filled in by zImage
+
+		POB0: opb {
+			compatible = "ibm,opb-4xx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full 32-bit
+			   range */
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			clock-frequency = <0>; // Filled in by zImage
+
+			UART0: serial@40000200 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0x40000200 0x00000008>;
+				virtual-reg = <0xe0000200>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x0 0x4>;
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@40000200";
+	};
+};
Index: linux-work/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2008-10-02 15:45:47.000000000 +1000
+++ linux-work/arch/powerpc/platforms/44x/Kconfig	2008-10-02 15:47:48.000000000 +1000
@@ -113,6 +113,17 @@ config YOSEMITE
 	help
 	  This option enables support for the AMCC PPC440EP evaluation board.
 
+config ISS4xx
+	bool "ISS 4xx Simulator"
+	depends on (44x || 40x)
+	default n
+	select PPC44x_SIMPLE
+	select 405GP if 40x
+	select 440GP if 44x
+	select PPC_FPU
+	help
+	  This option enables support for the IBM ISS simulation environment
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
Index: linux-work/arch/powerpc/configs/44x/iss4xx_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/configs/44x/iss4xx_defconfig	2008-10-02 15:46:11.000000000 +1000
@@ -0,0 +1,827 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.27-rc3
+# Mon Aug 25 13:20:28 2008
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=y
+# CONFIG_E200 is not set
+CONFIG_4xx=y
+CONFIG_BOOKE=y
+CONFIG_PTE_64BIT=y
+CONFIG_PHYS_64BIT=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_PPC_DCR_NATIVE=y
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_DCR=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+# CONFIG_HAVE_DMA_ATTRS is not set
+# CONFIG_USE_GENERIC_SMP_HELPERS is not set
+# CONFIG_HAVE_CLK is not set
+CONFIG_PROC_PAGE_MONITOR=y
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+CONFIG_LBD=y
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
+
+#
+# Platform support
+#
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_BAMBOO is not set
+# CONFIG_EBONY is not set
+# CONFIG_SAM440EP is not set
+# CONFIG_SEQUOIA is not set
+# CONFIG_TAISHAN is not set
+# CONFIG_KATMAI is not set
+# CONFIG_RAINIER is not set
+# CONFIG_WARP is not set
+# CONFIG_CANYONLANDS is not set
+# CONFIG_YOSEMITE is not set
+CONFIG_ISS4xx=y
+# CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
+CONFIG_440GP=y
+# CONFIG_IPIC is not set
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_FSL_ULI1575 is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+# CONFIG_SCHED_HRTICK is not set
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_MATH_EMULATION=y
+# CONFIG_IOMMU_HELPER is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
+CONFIG_RESOURCES_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_EXTRA_TARGETS=""
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_4xx_SOC=y
+CONFIG_PPC_PCI_CHOICE=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+# CONFIG_HAS_RAPIDIO is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_PAGE_OFFSET=0xc0000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_TASK_SIZE=0xc0000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
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
+# CONFIG_MTD_CFI is not set
+CONFIG_MTD_JEDECPROBE=y
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
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
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
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=35000
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+# CONFIG_BLK_DEV_HD is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+# CONFIG_NETDEVICES is not set
+CONFIG_IBM_NEW_EMAC_ZMII=y
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
+# CONFIG_SPI is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+
+#
+# Multimedia devices
+#
+
+#
+# Multimedia core support
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_SOUND is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_HAVE_FTRACE=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+# CONFIG_FTRACE is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_XMON is not set
+# CONFIG_IRQSTACKS is not set
+# CONFIG_VIRQ_DEBUG is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=y
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_LZO is not set
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
Index: linux-work/arch/powerpc/boot/treeboot-iss4xx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/treeboot-iss4xx.c	2008-10-02 15:46:11.000000000 +1000
@@ -0,0 +1,54 @@
+/*
+ * Copyright 2008 Ben. Herrenschmidt, IBM Corporation.
+ *
+ * Based on earlier code:
+ *   Copyright (C) Paul Mackerras 1997.
+ *
+ *   Matt Porter <mporter@kernel.crashing.org>
+ *   Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *   Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ *    Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "reg.h"
+#include "io.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+
+BSS_STACK(4096);
+
+static void iss_4xx_fixups(void)
+{
+	ibm4xx_sdram_fixup_memsize();
+
+	/* Need to fixup icache/dcache info base on core type */
+}
+
+void platform_init(void)
+{
+	/* Sim has at least 128M of RAM ok ? */
+	unsigned long end_of_ram = 0x08000000;
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+
+	simple_alloc_init(_end, avail_ram, 128, 64);
+	platform_ops.fixups = iss_4xx_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
Index: linux-work/arch/powerpc/platforms/44x/ppc44x_simple.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/ppc44x_simple.c	2008-10-02 15:48:25.000000000 +1000
+++ linux-work/arch/powerpc/platforms/44x/ppc44x_simple.c	2008-10-02 15:48:38.000000000 +1000
@@ -58,7 +58,8 @@ static char *board[] __initdata = {
 	"amcc,rainier",
 	"amcc,sequoia",
 	"amcc,taishan",
-	"amcc,yosemite"
+	"amcc,yosemite",
+	"ibm,iss-4xx",
 };
 
 static int __init ppc44x_probe(void)
