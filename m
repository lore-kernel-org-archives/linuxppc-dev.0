Return-Path: <mmadishetty@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5B2E0DE089
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:05:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: [PATCH 1/1 v2] AMCC PPC 460SX redwood SoC platform initial framework 
Date: Thu, 29 Jan 2009 13:05:08 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C06C31EE8@SDCEXCHANGE01.ad.amcc.com>
From: "Madhulika Madishetty" <mmadishetty@amcc.com>
To: <linuxppc-dev@ozlabs.org>
Cc: Loc Ho <lho@amcc.com>, Feng Kan <fkan@amcc.com>,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
Resubmitting patch without the confidentiality notice.

From: Madhulika Madishetty <mmadishetty@amcc.com>

This patch contains initial framework for the AMCC Redwood board.

Signed-off-by: Madhulika Madishetty <mmadishetty@amcc.com>
Signed-off-by: Tirumala Marri <tmarri@amcc.com>
Signed-off-by: Feng Kan <fkan@amcc.com>
Signed-off-by: Vidhyananth Venkatasamy <vvenkatasamy@amcc.com>
Signed-off-by: Preetesh Parekh <pparekh@amcc.com>
Acked-by: Loc Ho <lho@amcc.com>
Acked-by: Feng Kan <fkan@amcc.com>
---
 arch/powerpc/boot/dts/redwood.dts          |  245 ++++++
 arch/powerpc/configs/44x/redwood_defconfig | 1174
++++++++++++++++++++++++++++
 arch/powerpc/kernel/cpu_setup_44x.S        |    1 +
 arch/powerpc/kernel/cputable.c             |   13 +
 arch/powerpc/platforms/44x/Kconfig         |   19 +
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
 6 files changed, 1453 insertions(+), 0 deletions(-)  create mode 100644
arch/powerpc/boot/dts/redwood.dts  create mode 100644
arch/powerpc/configs/44x/redwood_defconfig

diff --git a/arch/powerpc/boot/dts/redwood.dts
b/arch/powerpc/boot/dts/redwood.dts
new file mode 100644
index 0000000..1c525ee
--- /dev/null
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -0,0 +1,245 @@
+/*
+ * Device Tree Source for AMCC Redwood(460SX)
+ *
+ * Copyright 2008 AMCC <tmarri@amcc.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+	model =3D "amcc,redwood";
+	compatible =3D "amcc,redwood";
+	dcr-parent =3D <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 =3D &EMAC0;
+		serial0 =3D &UART0;
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu@0 {
+			device_type =3D "cpu";
+			model =3D "PowerPC,460SX";
+			reg =3D <0x00000000>;
+			clock-frequency =3D <0>; /* Filled in by U-Boot */
+			timebase-frequency =3D <0>; /* Filled in by U-Boot
*/
+			i-cache-line-size =3D <32>;
+			d-cache-line-size =3D <32>;
+			i-cache-size =3D <32768>;
+			d-cache-size =3D <32768>;
+			dcr-controller;
+			dcr-access-method =3D "native";
+		};
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x00000000 0x00000000>; /* Filled in
by U-Boot */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible =3D "ibm,uic-460sx","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <0>;
+		dcr-reg =3D <0x0c0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible =3D "ibm,uic-460sx","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <1>;
+		dcr-reg =3D <0x0d0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+		interrupts =3D <0x1e 0x4 0x1f 0x4>; /* cascade */
+		interrupt-parent =3D <&UIC0>;
+	};
+
+	UIC2: interrupt-controller2 {
+		compatible =3D "ibm,uic-460sx","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <2>;
+		dcr-reg =3D <0x0e0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+		interrupts =3D <0xa 0x4 0xb 0x4>; /* cascade */
+		interrupt-parent =3D <&UIC0>;
+	};
+
+	UIC3: interrupt-controller3 {
+		compatible =3D "ibm,uic-460sx","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <3>;
+		dcr-reg =3D <0x0f0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+		interrupts =3D <0x10 0x4 0x11 0x4>; /* cascade */
+		interrupt-parent =3D <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible =3D "ibm,sdr-460sx";
+		dcr-reg =3D <0x00e 0x002>;
+	};
+
+	CPR0: cpr {
+		compatible =3D "ibm,cpr-460sx";
+		dcr-reg =3D <0x00c 0x002>;
+	};
+
+	plb {
+		compatible =3D "ibm,plb-460sx", "ibm,plb4";
+		#address-cells =3D <2>;
+		#size-cells =3D <1>;
+		ranges;
+		clock-frequency =3D <0>; /* Filled in by U-Boot */
+
+		SDRAM0: sdram {
+			compatible =3D "ibm,sdram-460sx",
"ibm,sdram-405gp";
+			dcr-reg =3D <0x010 0x002>;
+		};
+
+		MAL0: mcmal {
+			compatible =3D "ibm,mcmal-460sx", "ibm,mcmal2";
+			dcr-reg =3D <0x180 0x62>;
+			num-tx-chans =3D <4>;
+			num-rx-chans =3D <32>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			interrupt-parent =3D <&UIC1>;
+			interrupts =3D <	/*TXEOB*/ 0x6 0x4
+					/*RXEOB*/ 0x7 0x4
+					/*SERR*/  0x1 0x4
+					/*TXDE*/  0x2 0x4
+					/*RXDE*/  0x3 0x4
+					/*COAL TX0*/ 0x18 0x2
+					/*COAL TX1*/ 0x19 0x2
+					/*COAL TX2*/ 0x1a 0x2
+					/*COAL TX3*/ 0x1b 0x2
+					/*COAL RX0*/ 0x1c 0x2
+					/*COAL RX1*/ 0x1d 0x2
+					/*COAL RX2*/ 0x1e 0x2
+					/*COAL RX3*/ 0x1f 0x2>;
+		};
+
+		POB0: opb {
+			compatible =3D "ibm,opb-460sx", "ibm,opb";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0xb0000000 0x00000004 0xb0000000
0x50000000>;
+			clock-frequency =3D <0>; /* Filled in by U-Boot */
+
+			EBC0: ebc {
+				compatible =3D "ibm,ebc-460sx", "ibm,ebc";
+				dcr-reg =3D <0x012 0x002>;
+				#address-cells =3D <2>;
+				#size-cells =3D <1>;
+				clock-frequency =3D <0>; /* Filled in by
U-Boot */
+				/* ranges property is supplied by U-Boot
*/
+				interrupts =3D <0x6 0x4>;
+				interrupt-parent =3D <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible =3D "amd,s29gl512n",
"cfi-flash";
+					bank-width =3D <2>;
+					reg =3D <0x0000000 0x00000000
0x04000000>;
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+					partition@0 {
+						label =3D "kernel";
+						reg =3D <0x00000000
0x001e0000>;
+					};
+					partition@1e0000 {
+						label =3D "dtb";
+						reg =3D <0x001e0000
0x00020000>;
+					};
+					partition@200000 {
+						label =3D "ramdisk";
+						reg =3D <0x00200000
0x01400000>;
+					};
+					partition@1600000 {
+						label =3D "jffs2";
+						reg =3D <0x01600000
0x00400000>;
+					};
+					partition@1a00000 {
+						label =3D "user";
+						reg =3D <0x01a00000
0x02560000>;
+					};
+					partition@3f60000 {
+						label =3D "env";
+						reg =3D <0x03f60000
0x00040000>;
+					};
+					partition@3fa0000 {
+						label =3D "u-boot";
+						reg =3D <0x03fa0000
0x00060000>;
+					};
+				};
+			};
+
+			UART0: serial@ef600200 {
+				device_type =3D "serial";
+				compatible =3D "ns16550";
+				reg =3D <0xef600200 0x00000008>;
+				virtual-reg =3D <0xef600200>;
+				clock-frequency =3D <0>; /* Filled in by
U-Boot */
+				current-speed =3D <0>; /* Filled in by
U-Boot */
+				interrupt-parent =3D <&UIC0>;
+				interrupts =3D <0x0 0x4>;
+			};
+
+			RGMII0: emac-rgmii@ef600900 {
+				compatible =3D "ibm,rgmii-460sx",
"ibm,rgmii";
+				reg =3D <0xef600900 0x00000008>;
+			};
+
+			EMAC0: ethernet@ef600a00 {
+				device_type =3D "network";
+				compatible =3D "ibm,emac-460sx",
"ibm,emac4";
+				interrupt-parent =3D <&EMAC0>;
+				interrupts =3D <0x0 0x1>;
+				#interrupt-cells =3D <1>;
+				#address-cells =3D <0>;
+				#size-cells =3D <0>;
+				interrupt-map =3D </*Status*/ 0x0 &UIC0
0x13 0x4
+						 /*Wake*/   0x1 &UIC2
0x1d 0x4>;
+				reg =3D <0xef600a00 0x00000070>;
+				local-mac-address =3D [000000000000]; /*
Filled in by U-Boot */
+				mal-device =3D <&MAL0>;
+				mal-tx-channel =3D <0>;
+				mal-rx-channel =3D <0>;
+				cell-index =3D <0>;
+				max-frame-size =3D <9000>;
+				rx-fifo-size =3D <4096>;
+				tx-fifo-size =3D <2048>;
+				phy-mode =3D "rgmii";
+				phy-map =3D <0x00000000>;
+				rgmii-device =3D <&RGMII0>;
+				rgmii-channel =3D <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+
+		};
+
+	};
+	chosen {
+		linux,stdout-path =3D "/plb/opb/serial@ef600200";
+	};
+
+};
diff --git a/arch/powerpc/configs/44x/redwood_defconfig
b/arch/powerpc/configs/44x/redwood_defconfig
new file mode 100644
index 0000000..1a3f8c9
--- /dev/null
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -0,0 +1,1174 @@
+#
+# Automatically generated make config: don't edit # Linux kernel=20
+version: 2.6.29-rc1 # Fri Jan 16 17:41:30 2009 # # CONFIG_PPC64 is not=20
+set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=3Dy
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=3Dy
+CONFIG_4xx=3Dy
+CONFIG_BOOKE=3Dy
+CONFIG_PTE_64BIT=3Dy
+CONFIG_PHYS_64BIT=3Dy
+CONFIG_PPC_MMU_NOHASH=3Dy
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=3Dy
+CONFIG_PPC32=3Dy
+CONFIG_WORD_SIZE=3D32
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
+CONFIG_MMU=3Dy
+CONFIG_GENERIC_CMOS_UPDATE=3Dy
+CONFIG_GENERIC_TIME=3Dy
+CONFIG_GENERIC_TIME_VSYSCALL=3Dy
+CONFIG_GENERIC_CLOCKEVENTS=3Dy
+CONFIG_GENERIC_HARDIRQS=3Dy
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set CONFIG_IRQ_PER_CPU=3Dy=20
+CONFIG_STACKTRACE_SUPPORT=3Dy CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy=20
+CONFIG_LOCKDEP_SUPPORT=3Dy CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=20
+CONFIG_ARCH_HAS_ILOG2_U32=3Dy CONFIG_GENERIC_HWEIGHT=3Dy=20
+CONFIG_GENERIC_CALIBRATE_DELAY=3Dy CONFIG_GENERIC_FIND_NEXT_BIT=3Dy #=20
+CONFIG_ARCH_NO_VIRT_TO_BUS is not set CONFIG_PPC=3Dy=20
+CONFIG_EARLY_PRINTK=3Dy CONFIG_GENERIC_NVRAM=3Dy=20
+CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
+CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
+CONFIG_PPC_OF=3Dy
+CONFIG_OF=3Dy
+CONFIG_PPC_UDBG_16550=3Dy
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=3Dy
+CONFIG_GENERIC_BUG=3Dy
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_PPC_DCR_NATIVE=3Dy
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_DCR=3Dy
+CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=3Dy
+CONFIG_BROKEN_ON_SMP=3Dy
+CONFIG_INIT_ENV_ARG_LIMIT=3D32
+CONFIG_LOCALVERSION=3D""
+CONFIG_LOCALVERSION_AUTO=3Dy
+CONFIG_SWAP=3Dy
+CONFIG_SYSVIPC=3Dy
+CONFIG_SYSVIPC_SYSCTL=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=3D14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+CONFIG_SYSFS_DEPRECATED=3Dy
+CONFIG_SYSFS_DEPRECATED_V2=3Dy
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_INITRAMFS_SOURCE=3D""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set CONFIG_SYSCTL=3Dy=20
+CONFIG_EMBEDDED=3Dy CONFIG_SYSCTL_SYSCALL=3Dy CONFIG_KALLSYMS=3Dy #=20
+CONFIG_KALLSYMS_ALL is not set # CONFIG_KALLSYMS_EXTRA_PASS is not set=20
+CONFIG_HOTPLUG=3Dy CONFIG_PRINTK=3Dy CONFIG_BUG=3Dy CONFIG_ELF_CORE=3Dy =

+CONFIG_COMPAT_BRK=3Dy CONFIG_BASE_FULL=3Dy CONFIG_FUTEX=3Dy=20
+CONFIG_ANON_INODES=3Dy CONFIG_EPOLL=3Dy CONFIG_SIGNALFD=3Dy =
CONFIG_TIMERFD=3Dy=20
+CONFIG_EVENTFD=3Dy CONFIG_SHMEM=3Dy CONFIG_AIO=3Dy =
CONFIG_VM_EVENT_COUNTERS=3Dy

+CONFIG_PCI_QUIRKS=3Dy CONFIG_SLUB_DEBUG=3Dy # CONFIG_SLAB is not set=20
+CONFIG_SLUB=3Dy # CONFIG_SLOB is not set # CONFIG_PROFILING is not set=20
+CONFIG_HAVE_OPROFILE=3Dy # CONFIG_KPROBES is not set=20
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
+CONFIG_HAVE_IOREMAP_PROT=3Dy
+CONFIG_HAVE_KPROBES=3Dy
+CONFIG_HAVE_KRETPROBES=3Dy
+CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set CONFIG_SLABINFO=3Dy=20
+CONFIG_RT_MUTEXES=3Dy CONFIG_BASE_SMALL=3D0 CONFIG_MODULES=3Dy #=20
+CONFIG_MODULE_FORCE_LOAD is not set CONFIG_MODULE_UNLOAD=3Dy #=20
+CONFIG_MODULE_FORCE_UNLOAD is not set # CONFIG_MODVERSIONS is not set #

+CONFIG_MODULE_SRCVERSION_ALL is not set CONFIG_BLOCK=3Dy CONFIG_LBD=3Dy =
#=20
+CONFIG_BLK_DEV_IO_TRACE is not set # CONFIG_BLK_DEV_BSG is not set #=20
+CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=3Dy
+CONFIG_IOSCHED_AS=3Dy
+CONFIG_IOSCHED_DEADLINE=3Dy
+CONFIG_IOSCHED_CFQ=3Dy
+CONFIG_DEFAULT_AS=3Dy
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
+CONFIG_CLASSIC_RCU=3Dy
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
+# CONFIG_FREEZER is not set
+CONFIG_PPC4xx_PCI_EXPRESS=3Dy
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
+# CONFIG_ARCHES is not set
+# CONFIG_CANYONLANDS is not set
+# CONFIG_GLACIER is not set
+CONFIG_REDWOOD=3Dy
+# CONFIG_YOSEMITE is not set
+# CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set=20
+CONFIG_PPC44x_SIMPLE=3Dy # CONFIG_PPC4xx_GPIO is not set =
CONFIG_460SX=3Dy #

+CONFIG_IPIC is not set # CONFIG_MPIC is not set # CONFIG_MPIC_WEIRD is=20
+not set # CONFIG_PPC_I8259 is not set # CONFIG_PPC_RTAS is not set #=20
+CONFIG_MMIO_NVRAM is not set # CONFIG_PPC_MPC106 is not set #=20
+CONFIG_PPC_970_NAP is not set # CONFIG_PPC_INDIRECT_IO is not set #=20
+CONFIG_GENERIC_IOMAP is not set # CONFIG_CPU_FREQ is not set #=20
+CONFIG_FSL_ULI1575 is not set # CONFIG_SIMPLE_GPIO is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_TICK_ONESHOT=3Dy
+CONFIG_NO_HZ=3Dy
+CONFIG_HIGH_RES_TIMERS=3Dy
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=3Dy
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=3D250
+CONFIG_SCHED_HRTICK=3Dy
+CONFIG_PREEMPT_NONE=3Dy
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=3Dy
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set # CONFIG_HAVE_AOUT is

+not set # CONFIG_BINFMT_MISC is not set # CONFIG_MATH_EMULATION is not=20
+set # CONFIG_IOMMU_HELPER is not set CONFIG_PPC_NEED_DMA_SYNC_OPS=3Dy=20
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
+CONFIG_ARCH_HAS_WALK_MEMORY=3Dy
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
+CONFIG_ARCH_FLATMEM_ENABLE=3Dy
+CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
+CONFIG_SELECT_MEMORY_MODEL=3Dy
+CONFIG_FLATMEM_MANUAL=3Dy
+# CONFIG_DISCONTIGMEM_MANUAL is not set # CONFIG_SPARSEMEM_MANUAL is=20
+not set CONFIG_FLATMEM=3Dy CONFIG_FLAT_NODE_MEM_MAP=3Dy=20
+CONFIG_PAGEFLAGS_EXTENDED=3Dy
+CONFIG_SPLIT_PTLOCK_CPUS=3D4
+CONFIG_MIGRATION=3Dy
+CONFIG_PHYS_ADDR_T_64BIT=3Dy
+CONFIG_ZONE_DMA_FLAG=3D1
+CONFIG_BOUNCE=3Dy
+CONFIG_VIRT_TO_BUS=3Dy
+CONFIG_UNEVICTABLE_LRU=3Dy
+CONFIG_PPC_4K_PAGES=3Dy
+# CONFIG_PPC_16K_PAGES is not set
+# CONFIG_PPC_64K_PAGES is not set
+CONFIG_FORCE_MAX_ZONEORDER=3D11
+CONFIG_PROC_DEVICETREE=3Dy
+CONFIG_CMDLINE_BOOL=3Dy
+CONFIG_CMDLINE=3D""
+CONFIG_EXTRA_TARGETS=3D""
+CONFIG_SECCOMP=3Dy
+CONFIG_ISA_DMA_API=3Dy
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=3Dy
+CONFIG_PPC_INDIRECT_PCI=3Dy
+CONFIG_4xx_SOC=3Dy
+CONFIG_PPC_PCI_CHOICE=3Dy
+CONFIG_PCI=3Dy
+CONFIG_PCI_DOMAINS=3Dy
+CONFIG_PCI_SYSCALL=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCIEAER=3Dy
+# CONFIG_PCIEASPM is not set
+CONFIG_ARCH_SUPPORTS_MSI=3Dy
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=3Dy
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
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
+# Default settings for advanced configuration options are used #=20
+CONFIG_LOWMEM_SIZE=3D0x30000000 CONFIG_PAGE_OFFSET=3D0xc0000000=20
+CONFIG_KERNEL_START=3D0xc0000000 CONFIG_PHYSICAL_START=3D0x00000000=20
+CONFIG_TASK_SIZE=3D0xc0000000 CONFIG_CONSISTENT_START=3D0xff100000
+CONFIG_CONSISTENT_SIZE=3D0x00200000
+CONFIG_NET=3Dy
+
+#
+# Networking options
+#
+CONFIG_COMPAT_NET_DEV_OPS=3Dy
+CONFIG_PACKET=3Dy
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=3Dy
+# CONFIG_NET_KEY is not set
+CONFIG_INET=3Dy
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=3Dy
+CONFIG_IP_PNP=3Dy
+CONFIG_IP_PNP_DHCP=3Dy
+CONFIG_IP_PNP_BOOTP=3Dy
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
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set #=20
+CONFIG_INET_XFRM_MODE_TUNNEL is not set # CONFIG_INET_XFRM_MODE_BEET is

+not set # CONFIG_INET_LRO is not set CONFIG_INET_DIAG=3Dy=20
+CONFIG_INET_TCP_DIAG=3Dy # CONFIG_TCP_CONG_ADVANCED is not set=20
+CONFIG_TCP_CONG_CUBIC=3Dy CONFIG_DEFAULT_TCP_CONG=3D"cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
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
+# CONFIG_PHONET is not set
+CONFIG_WIRELESS=3Dy
+# CONFIG_CFG80211 is not set
+CONFIG_WIRELESS_OLD_REGULATORY=3Dy
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_LIB80211 is not set
+# CONFIG_MAC80211 is not set
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
+CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
+CONFIG_STANDALONE=3Dy
+CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
+CONFIG_FW_LOADER=3Dy
+CONFIG_FIRMWARE_IN_KERNEL=3Dy
+CONFIG_EXTRA_FIRMWARE=3D""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=3Dy
+CONFIG_PROC_EVENTS=3Dy
+CONFIG_MTD=3Dy
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=3Dy
+CONFIG_MTD_PARTITIONS=3Dy
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=3Dy
+CONFIG_MTD_OF_PARTS=3Dy
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=3Dy
+CONFIG_MTD_BLKDEVS=3Dy
+CONFIG_MTD_BLOCK=3Dy
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
+CONFIG_MTD_CFI=3Dy
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=3Dy
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy =

+CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy #=20
+CONFIG_MTD_MAP_BANK_WIDTH_8 is not set # CONFIG_MTD_MAP_BANK_WIDTH_16=20
+is not set # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set=20
+CONFIG_MTD_CFI_I1=3Dy CONFIG_MTD_CFI_I2=3Dy # CONFIG_MTD_CFI_I4 is not =
set=20
+# CONFIG_MTD_CFI_I8 is not set # CONFIG_MTD_CFI_INTELEXT is not set=20
+CONFIG_MTD_CFI_AMDSTD=3Dy # CONFIG_MTD_CFI_STAA is not set=20
+CONFIG_MTD_CFI_UTIL=3Dy # CONFIG_MTD_RAM is not set # CONFIG_MTD_ROM is =

+not set # CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set # CONFIG_MTD_PHYSMAP is not=20
+set CONFIG_MTD_PHYSMAP_OF=3Dy # CONFIG_MTD_INTEL_VR_NOR is not set #=20
+CONFIG_MTD_PLATRAM is not set
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
+# CONFIG_MTD_QINFO_PROBE is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=3Dy
+CONFIG_OF_I2C=3Dy
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=3Dy
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=3Dy
+CONFIG_BLK_DEV_RAM_COUNT=3D16
+CONFIG_BLK_DEV_RAM_SIZE=3D35000
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=3Dy
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=3Dy
+CONFIG_SCSI_DMA=3Dy
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=3Dy
+
+#
+# SCSI support type (disk, tape, CD-ROM) # CONFIG_BLK_DEV_SD=3Dy #=20
+CONFIG_CHR_DEV_ST is not set # CONFIG_CHR_DEV_OSST is not set #=20
+CONFIG_BLK_DEV_SR is not set CONFIG_CHR_DEV_SG=3Dy # CONFIG_CHR_DEV_SCH =

+is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs # #=20
+CONFIG_SCSI_MULTI_LUN is not set # CONFIG_SCSI_CONSTANTS is not set #=20
+CONFIG_SCSI_LOGGING is not set # CONFIG_SCSI_SCAN_ASYNC is not set=20
+CONFIG_SCSI_WAIT_SCAN=3Dm
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+CONFIG_SCSI_SAS_ATTRS=3Dy
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=3Dy
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set # CONFIG_SCSI_3W_9XXX is not=20
+set # CONFIG_SCSI_ACARD is not set # CONFIG_SCSI_AACRAID is not set #=20
+CONFIG_SCSI_AIC7XXX is not set # CONFIG_SCSI_AIC7XXX_OLD is not set #=20
+CONFIG_SCSI_AIC79XX is not set # CONFIG_SCSI_AIC94XX is not set #=20
+CONFIG_SCSI_DPT_I2O is not set # CONFIG_SCSI_ADVANSYS is not set #=20
+CONFIG_SCSI_ARCMSR is not set # CONFIG_MEGARAID_NEWGEN is not set #=20
+CONFIG_MEGARAID_LEGACY is not set # CONFIG_MEGARAID_SAS is not set #=20
+CONFIG_SCSI_HPTIOP is not set # CONFIG_SCSI_BUSLOGIC is not set #=20
+CONFIG_LIBFC is not set # CONFIG_FCOE is not set # CONFIG_SCSI_DMX3191D

+is not set # CONFIG_SCSI_EATA is not set # CONFIG_SCSI_FUTURE_DOMAIN is

+not set # CONFIG_SCSI_GDTH is not set # CONFIG_SCSI_IPS is not set #=20
+CONFIG_SCSI_INITIO is not set # CONFIG_SCSI_INIA100 is not set #=20
+CONFIG_SCSI_MVSAS is not set # CONFIG_SCSI_STEX is not set #=20
+CONFIG_SCSI_SYM53C8XX_2 is not set # CONFIG_SCSI_QLOGIC_1280 is not set

+# CONFIG_SCSI_QLA_FC is not set # CONFIG_SCSI_QLA_ISCSI is not set #=20
+CONFIG_SCSI_LPFC is not set # CONFIG_SCSI_DC395x is not set #=20
+CONFIG_SCSI_DC390T is not set # CONFIG_SCSI_NSP32 is not set #=20
+CONFIG_SCSI_DEBUG is not set # CONFIG_SCSI_SRP is not set #=20
+CONFIG_SCSI_DH is not set # CONFIG_ATA is not set # CONFIG_MD is not=20
+set CONFIG_FUSION=3Dy # CONFIG_FUSION_SPI is not set # CONFIG_FUSION_FC =

+is not set CONFIG_FUSION_SAS=3Dy
+CONFIG_FUSION_MAX_SGE=3D128
+# CONFIG_FUSION_CTL is not set
+# CONFIG_FUSION_LOGGING is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# Enable only one of the two stacks, unless you know what you are doing
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+CONFIG_I2O=3Dy
+CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=3Dy
+CONFIG_I2O_EXT_ADAPTEC=3Dy
+# CONFIG_I2O_CONFIG is not set
+# CONFIG_I2O_BUS is not set
+# CONFIG_I2O_BLOCK is not set
+# CONFIG_I2O_SCSI is not set
+# CONFIG_I2O_PROC is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=3Dy
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=3Dy
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_NEW_EMAC=3Dy
+CONFIG_IBM_NEW_EMAC_RXB=3D256
+CONFIG_IBM_NEW_EMAC_TXB=3D256
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=3D32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=3D256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=3D0
+CONFIG_IBM_NEW_EMAC_DEBUG=3Dy
+CONFIG_IBM_NEW_EMAC_ZMII=3Dy
+CONFIG_IBM_NEW_EMAC_RGMII=3Dy
+CONFIG_IBM_NEW_EMAC_TAH=3Dy
+CONFIG_IBM_NEW_EMAC_EMAC4=3Dy
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+# CONFIG_ATL2 is not set
+CONFIG_NETDEV_1000=3Dy
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+CONFIG_E1000E=3Dy
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
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
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_JME is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
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
+CONFIG_DEVKMEM=3Dy
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=3Dy
+CONFIG_SERIAL_8250_CONSOLE=3Dy
+# CONFIG_SERIAL_8250_PCI is not set
+CONFIG_SERIAL_8250_NR_UARTS=3D1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3D1
+CONFIG_SERIAL_8250_EXTENDED=3Dy
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=3Dy
+CONFIG_SERIAL_CORE_CONSOLE=3Dy
+# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_OF_PLATFORM=3Dy
+# CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL is not set
+CONFIG_UNIX98_PTYS=3Dy
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=3Dy
+CONFIG_LEGACY_PTY_COUNT=3D256
+# CONFIG_HVC_UDBG is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=3Dy
+CONFIG_I2C=3Dy
+CONFIG_I2C_BOARDINFO=3Dy
+CONFIG_I2C_CHARDEV=3Dy
+CONFIG_I2C_HELPER_AUTO=3Dy
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
+CONFIG_I2C_IBM_IIC=3Dy
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
+# CONFIG_AT24 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_I2C_DEBUG_CORE=3Dy
+CONFIG_I2C_DEBUG_ALGO=3Dy
+CONFIG_I2C_DEBUG_BUS=3Dy
+CONFIG_I2C_DEBUG_CHIP=3Dy
+# CONFIG_SPI is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=3Dy
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
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_REGULATOR is not set
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
+CONFIG_DAB=3Dy
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_SOUND is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_UWB is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+CONFIG_DMADEVICES=3Dy
+
+#
+# DMA Devices
+#
+# CONFIG_UIO is not set
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=3Dy
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=3Dy
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+CONFIG_DNOTIFY=3Dy
+CONFIG_INOTIFY=3Dy
+CONFIG_INOTIFY_USER=3Dy
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
+CONFIG_PROC_FS=3Dy
+CONFIG_PROC_KCORE=3Dy
+CONFIG_PROC_SYSCTL=3Dy
+CONFIG_PROC_PAGE_MONITOR=3Dy
+CONFIG_SYSFS=3Dy
+CONFIG_TMPFS=3Dy
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=3Dy
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+CONFIG_CRAMFS=3Dy
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=3Dy
+CONFIG_NFS_FS=3Dy
+CONFIG_NFS_V3=3Dy
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=3Dy
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=3Dy
+CONFIG_LOCKD_V4=3Dy
+CONFIG_NFS_COMMON=3Dy
+CONFIG_SUNRPC=3Dy
+# CONFIG_SUNRPC_REGISTER_V4 is not set
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
+CONFIG_MSDOS_PARTITION=3Dy
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=3Dy
+CONFIG_GENERIC_FIND_LAST_BIT=3Dy
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=3Dy
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=3Dy
+CONFIG_PLIST=3Dy
+CONFIG_HAS_IOMEM=3Dy
+CONFIG_HAS_IOPORT=3Dy
+CONFIG_HAS_DMA=3Dy
+CONFIG_HAVE_LMB=3Dy
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=3Dy
+CONFIG_ENABLE_MUST_CHECK=3Dy
+CONFIG_FRAME_WARN=3D1024
+CONFIG_MAGIC_SYSRQ=3Dy
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=3Dy
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=3Dy
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=3Dy
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
+CONFIG_SCHED_DEBUG=3Dy
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
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
+CONFIG_HAVE_FUNCTION_TRACER=3Dy
+CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
+
+#
+# Tracers
+#
+# CONFIG_FUNCTION_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_TRACE_BRANCH_PROFILING is not set
+# CONFIG_STACK_TRACER is not set
+# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=3Dy
+# CONFIG_KGDB is not set
+CONFIG_PRINT_STACK_DEPTH=3D64
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
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
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=3Dy
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=3Dy
+CONFIG_CRYPTO_ALGAPI2=3Dy
+CONFIG_CRYPTO_AEAD=3Dy
+CONFIG_CRYPTO_AEAD2=3Dy
+CONFIG_CRYPTO_BLKCIPHER=3Dy
+CONFIG_CRYPTO_BLKCIPHER2=3Dy
+CONFIG_CRYPTO_HASH=3Dy
+CONFIG_CRYPTO_HASH2=3Dy
+CONFIG_CRYPTO_RNG=3Dy
+CONFIG_CRYPTO_RNG2=3Dy
+CONFIG_CRYPTO_MANAGER=3Dy
+CONFIG_CRYPTO_MANAGER2=3Dy
+CONFIG_CRYPTO_GF128MUL=3Dy
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_CRYPTD=3Dy
+CONFIG_CRYPTO_AUTHENC=3Dy
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+CONFIG_CRYPTO_CCM=3Dy
+CONFIG_CRYPTO_GCM=3Dy
+CONFIG_CRYPTO_SEQIV=3Dy
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=3Dy
+CONFIG_CRYPTO_CTR=3Dy
+CONFIG_CRYPTO_CTS=3Dy
+CONFIG_CRYPTO_ECB=3Dy
+CONFIG_CRYPTO_LRW=3Dy
+CONFIG_CRYPTO_PCBC=3Dy
+CONFIG_CRYPTO_XTS=3Dy
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_HMAC=3Dy
+CONFIG_CRYPTO_XCBC=3Dy
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+CONFIG_CRYPTO_MD4=3Dy
+CONFIG_CRYPTO_MD5=3Dy
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+CONFIG_CRYPTO_SHA1=3Dy
+CONFIG_CRYPTO_SHA256=3Dy
+CONFIG_CRYPTO_SHA512=3Dy
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=3Dy
+# CONFIG_CRYPTO_ANUBIS is not set
+CONFIG_CRYPTO_ARC4=3Dy
+CONFIG_CRYPTO_BLOWFISH=3Dy
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=3Dy
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
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_HW=3Dy
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/kernel/cpu_setup_44x.S
b/arch/powerpc/kernel/cpu_setup_44x.S
index 10b4ab1..7d606f8 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -34,6 +34,7 @@ _GLOBAL(__setup_cpu_440grx)
 	blr
 _GLOBAL(__setup_cpu_460ex)
 _GLOBAL(__setup_cpu_460gt)
+_GLOBAL(__setup_cpu_460sx)
 	mflr	r4
 	bl	__init_fpu_44x
 	bl	__fixup_440A_mcheck
diff --git a/arch/powerpc/kernel/cputable.c
b/arch/powerpc/kernel/cputable.c
index 923f87a..5c40da4 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -43,6 +43,7 @@ extern void __setup_cpu_440spe(unsigned long offset,
struct cpu_spec* spec);
 extern void __setup_cpu_440x5(unsigned long offset, struct cpu_spec*
spec);
 extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec*
spec);
 extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec*
spec);
+extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec
*spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec*
spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec*
spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec*
spec);
@@ -1634,6 +1635,18 @@ static struct cpu_spec __initdata cpu_specs[] =3D =
{
 		.machine_check		=3D machine_check_440A,
 		.platform		=3D "ppc440",
 	},
+	{ /* 460SX */
+		.pvr_mask		=3D 0xffffff00,
+		.pvr_value		=3D 0x13541800,
+		.cpu_name		=3D "460SX",
+		.cpu_features		=3D CPU_FTRS_44X,
+		.cpu_user_features	=3D COMMON_USER_BOOKE,
+		.icache_bsize		=3D 32,
+		.dcache_bsize		=3D 32,
+		.cpu_setup		=3D __setup_cpu_460sx,
+		.machine_check		=3D machine_check_440A,
+		.platform		=3D "ppc440",
+	},
 	{	/* default match */
 		.pvr_mask		=3D 0x00000000,
 		.pvr_value		=3D 0x00000000,
diff --git a/arch/powerpc/platforms/44x/Kconfig
b/arch/powerpc/platforms/44x/Kconfig
index 3496bc0..bf5c7ff 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -118,6 +118,17 @@ config GLACIER
 	help
 	  This option enables support for the AMCC PPC460GT evaluation
board.
=20
+config REDWOOD
+	bool "Redwood"
+	depends on 44x
+	default n
+	select PPC44x_SIMPLE
+	select 460SX
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC460SX Redwood
board.
+
 config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
@@ -220,6 +231,14 @@ config 460EX
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_TAH
=20
+config 460SX
+	bool
+	select PPC_FPU
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_TAH
+
 # 44x errata/workaround config symbols, selected by the CPU models
above
 config IBM440EP_ERR42
 	bool
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c
b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 76fdc51..5bcd441 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -57,6 +57,7 @@ static char *board[] __initdata =3D {
 	"ibm,ebony",
 	"amcc,katmai",
 	"amcc,rainier",
+	"amcc,redwood",
 	"amcc,sequoia",
 	"amcc,taishan",
 	"amcc,yosemite"
--=20
1.5.5
