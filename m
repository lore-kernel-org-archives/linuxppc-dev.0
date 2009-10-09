Return-Path: <niklaus@ngiger.dyndns.org>
Received: from viefep21-int.chello.at (viefep21-int.chello.at [62.179.121.41])
	by ozlabs.org (Postfix) with ESMTP id 5752CB7B92
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 19:28:53 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/1] powerpc/40x: Add new PPC440EPx based board HCU5 of
	Netstal Maschinen
Date: Fri,  9 Oct 2009 10:11:05 +0200
Message-Id: <1255075865-4025-2-git-send-email-niklaus.giger@member.fsf.org>
In-Reply-To: <1255075865-4025-1-git-send-email-niklaus.giger@member.fsf.org>
References: <1255075865-4025-1-git-send-email-niklaus.giger@member.fsf.org>
Cc: niklaus.giger@netstal.com, Niklaus Giger <niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for a HCU5 PPC405EPx based board from Netstal Maschinen AG.

Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 arch/powerpc/boot/dts/hcu5.dts          |  254 +++++++
 arch/powerpc/configs/44x/hcu5_defconfig | 1166 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig      |    9 +
 arch/powerpc/platforms/44x/Makefile     |    1 +
 arch/powerpc/platforms/44x/hcu5.c       |  153 ++++
 5 files changed, 1583 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/hcu5.dts
 create mode 100644 arch/powerpc/configs/44x/hcu5_defconfig
 create mode 100644 arch/powerpc/platforms/44x/hcu5.c

diff --git a/arch/powerpc/boot/dts/hcu5.dts b/arch/powerpc/boot/dts/hcu5.dts
new file mode 100644
index 0000000..abb15f0
--- /dev/null
+++ b/arch/powerpc/boot/dts/hcu5.dts
@@ -0,0 +1,254 @@
+/*
+ * Device Tree Source for the Nestal Maschinen HCU5 board
+ *
+ * Copyright (c) 2008 Niklaus Giger <niklaus.giger@member.fsf.org>
+ *
+ * Based on Sequoia code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright (c) 2006, 2007 IBM Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "netstal,hcu5";
+	compatible = "netstal,hcu5";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,440EPx";
+			reg = <0x00000000>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+			timebase-frequency = <0>; /* Filled in by U-Boot */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-440epx","ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-440epx","ibm,uic";
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
+	UIC2: interrupt-controller2 {
+		compatible = "ibm,uic-440epx","ibm,uic";
+		interrupt-controller;
+		cell-index = <2>;
+		dcr-reg = <0x0e0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible = "ibm,sdr-440epx", "ibm,sdr-440ep";
+		dcr-reg = <0x00e 0x002>;
+	};
+
+	CPR0: cpr {
+		compatible = "ibm,cpr-440epx", "ibm,cpr-440ep";
+		dcr-reg = <0x00c 0x002>; /* ngngng ??? */
+	};
+
+	plb {
+		compatible = "ibm,plb-440epx", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by U-Boot */
+
+		SDRAM0: sdram {
+			compatible = "ibm,sdram-440epx", "ibm,sdram-44x-ddr2denali";
+			dcr-reg = <0x010 0x002>;
+		};
+
+		DMA0: dma {
+			compatible = "ibm,dma-440epx", "ibm,dma-4xx";
+			dcr-reg = <0x100 0x027>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-440epx", "ibm,mcmal2";
+			dcr-reg = <0x180 0x062>;
+			num-tx-chans = <2>;
+			num-rx-chans = <2>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
+		};
+
+		POB0: opb {
+		  	compatible = "ibm,opb-440epx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		  	ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+			          0x80000000 0x00000001 0x80000000 0x80000000>;
+		  	interrupt-parent = <&UIC1>;
+		  	interrupts = <0x7 0x4>;
+		  	clock-frequency = <0>; /* Filled in by U-Boot */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-440epx", "ibm,ebc";
+				dcr-reg = <0x012 0x002>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				interrupts = <0x5 0x1>;
+				interrupt-parent = <&UIC1>;
+
+			};
+
+			UART0: serial@ef600300 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <0xef600300 0x00000008>;
+		   		virtual-reg = <0xef600300>;
+		   		clock-frequency = <0>; /* Filled in by U-Boot */
+		   		current-speed = <0>; /* Filled in by U-Boot */
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <0x0 0x4>;
+	   		};
+
+			IIC0: i2c@ef600700 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "ibm,iic-440epx", "ibm,iic";
+				reg = <0xef600700 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x2 0x4>;
+			};
+
+			IIC1: i2c@ef600800 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "ibm,iic-440epx", "ibm,iic";
+				reg = <0xef600800 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x7 0x4>;
+			};
+
+
+			ZMII0: emac-zmii@ef600d00 {
+				compatible = "ibm,zmii-440epx", "ibm,zmii";
+				reg = <0xef600d00 0x0000000c>;
+			};
+
+			SMII0: emac-smii@ef601000 {
+					compatible = "ibm,smii-440epx", "ibm,smmii";
+					reg = <0xef601000 0x00000008>;
+					has-mdio;
+				};
+
+			EMAC0: ethernet@ef600e00 {
+				device_type = "network";
+				compatible = "ibm,emac-440epx", "ibm,emac4";
+				interrupt-parent = <&EMAC0>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+				/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600e00 0x00000074>;
+				local-mac-address = [000000000000];
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				phy-mode = "smii";
+				phy-map = <1>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+
+			CPLD: cpld@0xcd000000 {
+				reg = <0xcd000000 0x00000100>;
+				interval = "1000";
+				device_type = "cpld";
+				interrupt-parent = <&UIC1>;
+				interrupts = <28 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
+			};
+
+			/* The HCU5 has two Intel CAN SCC82527 controllers */
+			CAN1: can0@0xc8000000 {
+				device_type = "can1";
+				compatible = "intel,82527";
+				reg = <0xc800000 0x00000100>;
+				interrupt-parent = <&UIC2>;
+				interrupts = <3 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
+			};
+
+			CAN2: can1@0xc8000100 {
+				device_type = "can2";
+				compatible = "intel,82527";
+				reg = <0xc8000100 0x00000100>;
+				interrupt-parent = <&UIC2>;
+				interrupts = <4 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
+			};
+
+		};
+
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+		bootargs = "console=ttyS0,115200";
+	};
+};
diff --git a/arch/powerpc/configs/44x/hcu5_defconfig b/arch/powerpc/configs/44x/hcu5_defconfig
new file mode 100644
index 0000000..a44f57c
--- /dev/null
+++ b/arch/powerpc/configs/44x/hcu5_defconfig
@@ -0,0 +1,1166 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.31
+# Thu Oct  8 18:38:31 2009
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_PPC_BOOK3S_32 is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=y
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
+CONFIG_4xx=y
+CONFIG_BOOKE=y
+CONFIG_PTE_64BIT=y
+CONFIG_PHYS_64BIT=y
+CONFIG_PPC_MMU_NOHASH=y
+CONFIG_PPC_MMU_NOHASH_32=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
+CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_PPC_DCR_NATIVE=y
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_DCR=y
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
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
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_TREE_RCU_TRACE is not set
+CONFIG_IKCONFIG=m
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_GROUP_SCHED=y
+# CONFIG_FAIR_GROUP_SCHED is not set
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_HAVE_PERF_EVENTS=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+# CONFIG_PERF_COUNTERS is not set
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_COMPAT_BRK=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+# CONFIG_SLOW_WORK is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
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
+# CONFIG_FREEZER is not set
+# CONFIG_PPC4xx_PCI_EXPRESS is not set
+
+#
+# Platform support
+#
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+CONFIG_BAMBOO=y
+# CONFIG_EBONY is not set
+CONFIG_HCU5=y
+# CONFIG_SAM440EP is not set
+# CONFIG_SEQUOIA is not set
+# CONFIG_TAISHAN is not set
+# CONFIG_KATMAI is not set
+# CONFIG_RAINIER is not set
+# CONFIG_WARP is not set
+# CONFIG_ARCHES is not set
+# CONFIG_CANYONLANDS is not set
+# CONFIG_GLACIER is not set
+# CONFIG_REDWOOD is not set
+# CONFIG_EIGER is not set
+# CONFIG_YOSEMITE is not set
+# CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
+CONFIG_PPC44x_SIMPLE=y
+# CONFIG_PPC4xx_GPIO is not set
+CONFIG_440EP=y
+CONFIG_440EPX=y
+CONFIG_IBM440EP_ERR42=y
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
+# CONFIG_SIMPLE_GPIO is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_SCHED_HRTICK=y
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_IOMMU_HELPER is not set
+# CONFIG_SWIOTLB is not set
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
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_STDBINUTILS=y
+CONFIG_PPC_4K_PAGES=y
+# CONFIG_PPC_16K_PAGES is not set
+# CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_PROC_DEVICETREE=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+CONFIG_EXTRA_TARGETS=""
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_4xx_SOC=y
+CONFIG_PPC_PCI_CHOICE=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
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
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
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
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+CONFIG_CFG80211_DEFAULT_PS_VALUE=0
+CONFIG_WIRELESS_OLD_REGULATORY=y
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+# CONFIG_WIMAX is not set
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
+# CONFIG_DEVTMPFS is not set
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
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLKDEVS is not set
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
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
+CONFIG_MTD_CFI_INTELEXT=y
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
+CONFIG_OF_DEVICE=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=35000
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+# CONFIG_BLK_DEV_HD is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HP_ILO is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_CB710_CORE is not set
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
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# See the help texts for more information.
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=128
+CONFIG_IBM_NEW_EMAC_TXB=64
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
+# CONFIG_IBM_NEW_EMAC_DEBUG is not set
+CONFIG_IBM_NEW_EMAC_ZMII=y
+CONFIG_IBM_NEW_EMAC_RGMII=y
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+CONFIG_IBM_NEW_EMAC_EMAC4=y
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_ATL2 is not set
+# CONFIG_XILINX_EMACLITE is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
+# CONFIG_MV643XX_ETH is not set
+# CONFIG_XILINX_LL_TEMAC is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_JME is not set
+CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+CONFIG_CHELSIO_T3_DEPENDS=y
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_ENIC is not set
+# CONFIG_IXGBE is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_VXGE is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_EN is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
+# CONFIG_QLGE is not set
+# CONFIG_SFC is not set
+# CONFIG_BE2NET is not set
+# CONFIG_TR is not set
+CONFIG_WLAN=y
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
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
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_PCI is not set
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
+# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_HVC_UDBG is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_I2C is not set
+# CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+CONFIG_VGA_ARB=y
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_SOUND is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+
+#
+# Enable Host or Gadget support to see Inventra options
+#
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_UWB is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
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
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
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
+CONFIG_CRAMFS=y
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+
+#
+# Kernel hacking
+#
+CONFIG_PRINTK_TIME=y
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_DEBUG_PAGEALLOC is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+CONFIG_FTRACE=y
+# CONFIG_FUNCTION_TRACER is not set
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
+# CONFIG_BOOT_TRACER is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
+# CONFIG_STACK_TRACER is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
+CONFIG_PRINT_STACK_DEPTH=64
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_PPC_EMULATED_STATS is not set
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
+# CONFIG_XMON is not set
+# CONFIG_IRQSTACKS is not set
+# CONFIG_VIRQ_DEBUG is not set
+CONFIG_BDI_SWITCH=y
+CONFIG_PPC_EARLY_DEBUG=y
+# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
+# CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
+# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
+# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
+# CONFIG_PPC_EARLY_DEBUG_BEAT is not set
+CONFIG_PPC_EARLY_DEBUG_44x=y
+# CONFIG_PPC_EARLY_DEBUG_40x is not set
+# CONFIG_PPC_EARLY_DEBUG_CPM is not set
+CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW=0xef600300
+CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH=0x1
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
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
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
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
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_CRYPTO_DEV_PPC4XX is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 7486bff..cbf3601 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -18,6 +18,15 @@ config EBONY
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
+config HCU5
+	bool "Hcu5"
+	depends on 44x
+	default n
+	select PPC44x_SIMPLE
+	select 440EPX
+	help
+	  This option enables support for the Netstal Maschinen HCU5 board.
+
 config SAM440EP
         bool "Sam440ep"
 	depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index ee6185a..5263595 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_44x)	:= misc_44x.o idle.o
 obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
+obj-$(CONFIG_HCU5)	+= hcu5.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
diff --git a/arch/powerpc/platforms/44x/hcu5.c b/arch/powerpc/platforms/44x/hcu5.c
new file mode 100644
index 0000000..1248a84
--- /dev/null
+++ b/arch/powerpc/platforms/44x/hcu5.c
@@ -0,0 +1,153 @@
+/*
+ * arch/ppc/platforms/4xx/hcu5.c
+ *
+ * HCU5 board specific routines
+ *
+ * Copyright (c) 2009 Niklaus Giger <niklaus.giger@member.fsf.org>
+ *
+ * Copyright 2006-2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on bamboo.c from Wade Farnsworth <wfarnsworth@mvista.com>
+ *	Copyright 2004 MontaVista Software Inc.
+ *	Copyright 2006 AMCC
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+#include <asm/uic.h>
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <asm/irq.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <asm/device.h>
+
+static int __init hcu5_probe(void);
+#define debug printk
+
+/* HCU5 tick-status und tick-ontrol-register definitions */
+#define CFG_CS_2  0xCC000000
+#define CFG_CPLD  CFG_CS_2
+#define HCU_TICK_CONTROL_REGISTER_ADDRESS	(CFG_CPLD + 0x1000000)
+
+#define TICK_INTERRUPT_ON_HCU5 60	/* UIC1, 28, GPIO40, IRQ0 */
+#define CAN1_INTERRUPT_ON_HCU5 67	/* UIC2,  3  GPIO42  IRQ2 */
+#define CAN2_INTERRUPT_ON_HCU5 68	/* UIC3,  4  GPIO43  IRQ3 */
+
+#define TICK_INT_ENABLE       0x01
+#define TICK_INT_RESET        0x02
+#define TICK_INT_PENDING      0x04
+#define TICK_START            0x08
+
+#define TICK_INTERVAL_250_US  0x00
+#define TICK_INTERVAL_500_US  0x10
+#define TICK_INTERVAL_1000_US 0x20
+#define TICK_INTERVAL_2000_US 0x30
+
+static u16 __iomem *tickAddr;
+
+static irqreturn_t cpld_interrupt(int irq, void *dev_id)
+{
+	/*
+	out_be16(HCU_TICK_CONTROL_REGISTER_ADDRESS,
+	TICK_INT_ENABLE | TICK_INT_RESET | TICK_START |
+	TICK_INTERVAL_1000_US);
+	*/
+	return 0;
+}
+
+static irqreturn_t can1_interrupt(int irq, void *dev_id)
+{
+	return 0;
+}
+
+static irqreturn_t can2_interrupt(int irq, void *dev_id)
+{
+	return 0;
+}
+
+static int map_one_irq(const char *typeName, void *proc)
+{
+	struct device_node *np;
+	int irq = 0;
+	int rc;
+
+	np = of_find_node_by_type(NULL, typeName);
+	debug(KERN_INFO "%s: %s np %p\n", __func__, typeName, np);
+	if (!np) {
+		printk(KERN_INFO "\n\nNo %s found in device tree\n", typeName);
+		return -1;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	debug(KERN_INFO "%s: %s with irq %d\n",  __func__, typeName, irq);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR "%s: irq_of_parse_and_map failed\n", typeName);
+		of_node_put(np);
+		return -ENODEV;
+	}
+	rc = request_irq(irq, proc, IRQF_TRIGGER_LOW,
+			  typeName, NULL);
+	debug(KERN_INFO"%s: %s %d rc %d\n",
+		__func__, typeName, irq, rc);
+	return 0;
+}
+
+static __initdata struct of_device_id hcu5_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init hcu5_device_probe(void)
+{
+	of_platform_bus_probe(NULL, hcu5_of_bus, NULL);
+	tickAddr = ioremap(HCU_TICK_CONTROL_REGISTER_ADDRESS, 0x100);
+	printk(KERN_INFO "%s: tickAddr is at %p from 0x%x\n", __func__,
+		tickAddr, HCU_TICK_CONTROL_REGISTER_ADDRESS);
+	map_one_irq("cpld", cpld_interrupt);
+	map_one_irq("can1", can1_interrupt);
+	map_one_irq("can2", can2_interrupt);
+
+	return 0;
+}
+
+machine_device_initcall(hcu5, hcu5_device_probe);
+
+/*
+* Called very early, MMU is off, device-tree isn't unflattened
+*/
+static int __init hcu5_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "netstal,hcu5"))
+		return 0;
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
+	return 1;
+}
+
+define_machine(hcu5) {
+	.name = "hcu5",
+	.probe = hcu5_probe,
+	.progress = udbg_progress,
+	.init_IRQ = uic_init_tree,
+	.get_irq = uic_get_irq,
+	.restart = ppc4xx_reset_system,
+	.calibrate_decr = generic_calibrate_decr,
+};
-- 
1.6.3.3
