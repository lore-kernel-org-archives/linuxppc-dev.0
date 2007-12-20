Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59E50DDE39
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 04:45:26 +1100 (EST)
Date: Thu, 20 Dec 2007 11:45:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v3 2/2] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071220174524.GB21048@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This board is also resold by Freescale under the names
"QUICCStart MPC8248 Evaluation System" and "CWH-PPC-8248N-VE".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Resent with dts-v1 and aliases.

 arch/powerpc/boot/Makefile             |    3 +-
 arch/powerpc/boot/dts/ep8248e.dts      |  205 ++++++++
 arch/powerpc/boot/ep8248e.c            |   55 ++
 arch/powerpc/boot/wrapper              |    2 +-
 arch/powerpc/configs/ep8248e_defconfig |  864 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/82xx/Kconfig    |   13 +
 arch/powerpc/platforms/82xx/Makefile   |    1 +
 arch/powerpc/platforms/82xx/ep8248e.c  |  325 ++++++++++++
 include/asm-powerpc/mpc8260.h          |    1 +
 9 files changed, 1467 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ep8248e.dts
 create mode 100644 arch/powerpc/boot/ep8248e.c
 create mode 100644 arch/powerpc/configs/ep8248e_defconfig
 create mode 100644 arch/powerpc/platforms/82xx/ep8248e.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9dfadc0..57bee27 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -58,7 +58,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c redboot-8xx.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c redboot-8xx.c ep8248e.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -190,6 +190,7 @@ ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
 image-$(CONFIG_PPC_EP88XC)		+= zImage.ep88xc
 image-$(CONFIG_8260)			+= cuImage.pq2
+image-$(CONFIG_EP8248E)			+= zImage.ep8248e
 image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
diff --git a/arch/powerpc/boot/dts/ep8248e.dts b/arch/powerpc/boot/dts/ep8248e.dts
new file mode 100644
index 0000000..f5b058c
--- /dev/null
+++ b/arch/powerpc/boot/dts/ep8248e.dts
@@ -0,0 +1,205 @@
+/*
+ * Device Tree for the Embedded Planet EP8248E board running PlanetCore.
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "EP8248E";
+	compatible = "fsl,ep8248e";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		planetcore-SMC1 = &smc1;
+		planetcore-SCC1 = &scc1;
+		enet0 = &eth0;
+		enet1 = &eth1;
+		serial0 = &smc1;
+		serial1 = &scc1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8248@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <16384>;
+			i-cache-size = <16384>;
+			timebase-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	localbus {
+		compatible = "fsl,mpc8248-localbus",
+		             "fsl,pq2-localbus",
+		             "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xf0010100 0x40>;
+
+		ranges = <0 0 0xfc000000 0x04000000
+		          1 0 0xfa000000 0x00008000>;
+
+		flash@0,3800000 {
+			compatible = "cfi-flash";
+			reg = <0 0x3800000 0x800000>;
+			bank-width = <4>;
+			device-width = <2>;
+		};
+
+		bcsr@1,0 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			reg = <1 0 0x10>;
+			compatible = "fsl,ep8248e-bcsr";
+			ranges;
+
+			mdio {
+				device_type = "mdio";
+				compatible = "fsl,ep8248e-mdio-bitbang";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1 8 1>;
+
+				PHY0: ethernet-phy@0 {
+					interrupt-parent = <&PIC>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+
+				PHY1: ethernet-phy@1 {
+					interrupt-parent = <&PIC>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+			};
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
+	soc@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8248", "fsl,pq2-soc", "simple-bus";
+		ranges = <0x00000000 0xf0000000 0x00053000>;
+
+		// Temporary -- will go away once kernel uses ranges for get_immrbase().
+		reg = <0xf0000000 0x00053000>;
+
+		cpm@119c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			compatible = "fsl,mpc8248-cpm", "fsl,cpm2",
+			             "simple-bus";
+			reg = <0x119c0 0x30>;
+			ranges;
+
+			muram {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x1100 0x1140
+					       0xec0 0x9800 0x800>;
+				};
+			};
+
+			brg@119f0 {
+				compatible = "fsl,mpc8248-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <0x119f0 0x10 0x115f0 0x10>;
+			};
+
+			/* Monitor port/SMC1 */
+			smc1: serial@11a80 {
+				device_type = "serial";
+				compatible = "fsl,mpc8248-smc-uart",
+				             "fsl,cpm2-smc-uart";
+				reg = <0x11a80 0x20 0x1100 0x40>;
+				interrupts = <4 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <7>;
+				fsl,cpm-command = <0x1d000000>;
+				linux,planetcore-label = "SMC1";
+			};
+
+			/* "Serial" port/SCC1 */
+			scc1: serial@11a00 {
+				device_type = "serial";
+				compatible = "fsl,mpc8248-scc-uart",
+				             "fsl,cpm2-scc-uart";
+				reg = <0x11a00 0x20 0x8000 0x100>;
+				interrupts = <40 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0x00800000>;
+				linux,planetcore-label = "SCC1";
+			};
+
+			eth0: ethernet@11300 {
+				device_type = "network";
+				compatible = "fsl,mpc8248-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <0x11300 0x20 0x8400 0x100 0x11390 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <32 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY0>;
+				linux,network-index = <0>;
+				fsl,cpm-command = <0x12000300>;
+			};
+
+			eth1: ethernet@11320 {
+				device_type = "network";
+				compatible = "fsl,mpc8248-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <0x11320 0x20 0x8500 0x100 0x113b0 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <33 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY1>;
+				linux,network-index = <1>;
+				fsl,cpm-command = <0x16200300>;
+			};
+
+			usb@11b60 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,mpc8248-usb",
+				             "fsl,cpm2-usb";
+				reg = <0x11b60 0x18 0x8b00 0x100>;
+				interrupt-parent = <&PIC>;
+				interrupts = <11 8>;
+				fsl,cpm-command = <0x2e600000>;
+			};
+		};
+
+		PIC: interrupt-controller@10c00 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0x10c00 0x80>;
+			compatible = "fsl,mpc8248-pic", "fsl,pq2-pic";
+		};
+	};
+};
diff --git a/arch/powerpc/boot/ep8248e.c b/arch/powerpc/boot/ep8248e.c
new file mode 100644
index 0000000..f57d14d
--- /dev/null
+++ b/arch/powerpc/boot/ep8248e.c
@@ -0,0 +1,55 @@
+/*
+ * Embedded Planet EP8248E with PlanetCore firmware
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "planetcore.h"
+#include "pq2.h"
+
+static char *table;
+static u64 mem_size;
+
+#include <io.h>
+
+static void platform_fixups(void)
+{
+	u64 val;
+
+	dt_fixup_memory(0, mem_size);
+	planetcore_set_mac_addrs(table);
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_CRYSTAL_HZ, &val)) {
+		printf("No PlanetCore crystal frequency key.\r\n");
+		return;
+	}
+
+	pq2_fixup_clocks(val);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	table = (char *)r3;
+	planetcore_prepare_table(table);
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_MB_RAM, &mem_size))
+		return;
+
+	mem_size *= 1024 * 1024;
+	simple_alloc_init(_end, mem_size - (unsigned long)_end, 32, 64);
+
+	fdt_init(_dtb_start);
+
+	planetcore_set_stdout_path(table);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index a7261b5..904001b 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -168,7 +168,7 @@ ps3)
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
     ;;
-ep88xc|redboot*)
+ep88xc|ep8248e|redboot*)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
new file mode 100644
index 0000000..704ffcc
--- /dev/null
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -0,0 +1,864 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24-rc3
+# Mon Dec 10 13:01:33 2007
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
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
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_DEFAULT_UIMAGE is not set
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_MODULES is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_DEADLINE=y
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="deadline"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+CONFIG_PPC_82xx=y
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_MPC8272_ADS is not set
+# CONFIG_PQ2FADS is not set
+CONFIG_EP8248E=y
+# CONFIG_PQ2ADS is not set
+CONFIG_8260=y
+CONFIG_8272=y
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
+CONFIG_CPM2=y
+CONFIG_PPC_CPM_NEW_BINDING=y
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_CPM=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
+# CONFIG_SECCOMP is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="ep8248e.dts"
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0xc0000000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
+# CONFIG_NETFILTER_XTABLES is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
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
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
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
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+# CONFIG_MTD_CFI_I1 is not set
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MISC_DEVICES is not set
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
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
+CONFIG_MDIO_BITBANG=y
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+# CONFIG_FS_ENET_MDIO_FCC is not set
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+CONFIG_MOUSE_PS2_ALPS=y
+CONFIG_MOUSE_PS2_LOGIPS2PP=y
+CONFIG_MOUSE_PS2_SYNAPTICS=y
+CONFIG_MOUSE_PS2_LIFEBOOK=y
+CONFIG_MOUSE_PS2_TRACKPOINT=y
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+CONFIG_SERIAL_CPM_SCC1=y
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+CONFIG_SERIAL_CPM_SCC4=y
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
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
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
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
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_RTC_CLASS is not set
+
+#
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_JBD=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
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
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_JFFS2_FS is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+# CONFIG_CRC32 is not set
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_KGDB_CONSOLE is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 541fbb8..4fad6c7 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -26,6 +26,19 @@ config PQ2FADS
 	help
 	  This option enables support for the PQ2FADS board
 
+config EP8248E
+	bool "Embedded Planet EP8248E (a.k.a. CWH-PPC-8248N-VE)"
+	select 8272
+	select 8260
+	select FSL_SOC
+	select PPC_CPM_NEW_BINDING
+	select MDIO_BITBANG
+	help
+	  This enables support for the Embedded Planet EP8248E board.
+
+	  This board is also resold by Freescale as the QUICCStart
+	  MPC8248 Evaluation System and/or the CWH-PPC-8248N-VE.
+
 endchoice
 
 config PQ2ADS
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 68c8b0c..6cd5cd5 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_MPC8272_ADS) += mpc8272_ads.o
 obj-$(CONFIG_CPM2) += pq2.o
 obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
 obj-$(CONFIG_PQ2FADS) += pq2fads.o
+obj-$(CONFIG_EP8248E) += ep8248e.o
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
new file mode 100644
index 0000000..9753ae5
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -0,0 +1,325 @@
+/*
+ * Embedded Planet EP8248E support
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+#include <linux/mdio-bitbang.h>
+#include <linux/of_platform.h>
+
+#include <asm/io.h>
+#include <asm/cpm2.h>
+#include <asm/udbg.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/mpc8260.h>
+#include <asm/prom.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/cpm2_pic.h>
+
+#include "pq2.h"
+
+static u8 __iomem *ep8248e_bcsr;
+static struct device_node *ep8248e_bcsr_node;
+
+#define BCSR7_SCC2_ENABLE 0x10
+
+#define BCSR8_PHY1_ENABLE 0x80
+#define BCSR8_PHY1_POWER  0x40
+#define BCSR8_PHY2_ENABLE 0x20
+#define BCSR8_PHY2_POWER  0x10
+#define BCSR8_MDIO_READ   0x04
+#define BCSR8_MDIO_CLOCK  0x02
+#define BCSR8_MDIO_DATA   0x01
+
+#define BCSR9_USB_ENABLE  0x80
+#define BCSR9_USB_POWER   0x40
+#define BCSR9_USB_HOST    0x20
+#define BCSR9_USB_FULL_SPEED_TARGET 0x10
+
+static void __init ep8248_pic_init(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,pq2-pic");
+	if (!np) {
+		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+		return;
+	}
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+}
+
+static void ep8248e_set_mdc(struct mdiobb_ctrl *ctrl, int level)
+{
+	if (level)
+		setbits8(&ep8248e_bcsr[8], BCSR8_MDIO_CLOCK);
+	else
+		clrbits8(&ep8248e_bcsr[8], BCSR8_MDIO_CLOCK);
+
+	/* Read back to flush the write. */
+	in_8(&ep8248e_bcsr[8]);
+}
+
+static void ep8248e_set_mdio_dir(struct mdiobb_ctrl *ctrl, int output)
+{
+	if (output)
+		clrbits8(&ep8248e_bcsr[8], BCSR8_MDIO_READ);
+	else
+		setbits8(&ep8248e_bcsr[8], BCSR8_MDIO_READ);
+
+	/* Read back to flush the write. */
+	in_8(&ep8248e_bcsr[8]);
+}
+
+static void ep8248e_set_mdio_data(struct mdiobb_ctrl *ctrl, int data)
+{
+	if (data)
+		setbits8(&ep8248e_bcsr[8], BCSR8_MDIO_DATA);
+	else
+		clrbits8(&ep8248e_bcsr[8], BCSR8_MDIO_DATA);
+
+	/* Read back to flush the write. */
+	in_8(&ep8248e_bcsr[8]);
+}
+
+static int ep8248e_get_mdio_data(struct mdiobb_ctrl *ctrl)
+{
+	return in_8(&ep8248e_bcsr[8]) & BCSR8_MDIO_DATA;
+}
+
+static struct mdiobb_ops ep8248e_mdio_ops = {
+	.set_mdc = ep8248e_set_mdc,
+	.set_mdio_dir = ep8248e_set_mdio_dir,
+	.set_mdio_data = ep8248e_set_mdio_data,
+	.get_mdio_data = ep8248e_get_mdio_data,
+	.owner = THIS_MODULE,
+};
+
+static struct mdiobb_ctrl ep8248e_mdio_ctrl = {
+	.ops = &ep8248e_mdio_ops,
+};
+
+static int __devinit ep8248e_mdio_probe(struct of_device *ofdev,
+                                        const struct of_device_id *match)
+{
+	struct mii_bus *bus;
+	struct resource res;
+	struct device_node *node;
+	int ret, i;
+
+	node = of_get_parent(ofdev->node);
+	of_node_put(node);
+	if (node != ep8248e_bcsr_node)
+		return -ENODEV;
+
+	ret = of_address_to_resource(ofdev->node, 0, &res);
+	if (ret)
+		return ret;
+
+	bus = alloc_mdio_bitbang(&ep8248e_mdio_ctrl);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->phy_mask = 0;
+	bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
+
+	for (i = 0; i < PHY_MAX_ADDR; i++)
+		bus->irq[i] = -1;
+
+	bus->name = "ep8248e-mdio-bitbang";
+	bus->dev = &ofdev->dev;
+	bus->id = res.start;
+
+	return mdiobus_register(bus);
+}
+
+static int ep8248e_mdio_remove(struct of_device *ofdev)
+{
+	BUG();
+	return 0;
+}
+
+static const struct of_device_id ep8248e_mdio_match[] = {
+	{
+		.compatible = "fsl,ep8248e-mdio-bitbang",
+	},
+	{},
+};
+
+static struct of_platform_driver ep8248e_mdio_driver = {
+	.name = "ep8248e-mdio-bitbang",
+	.match_table = ep8248e_mdio_match,
+	.probe = ep8248e_mdio_probe,
+	.remove = ep8248e_mdio_remove,
+};
+
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static const struct cpm_pin ep8248_pins[] = {
+	/* SMC1 */
+	{2, 4, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+
+	/* SCC1 */
+	{2, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC1 */
+	{0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 18, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 19, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 26, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 28, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 30, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 31, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{2, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* I2C */
+	{4, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{4, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+
+	/* USB */
+	{2, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ep8248_pins); i++) {
+		const struct cpm_pin *pin = &ep8248_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm2_smc_clk_setup(CPM_CLK_SMC1, CPM_BRG7);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC3, CPM_CLK8, CPM_CLK_TX); /* USB */
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
+}
+
+static void __init ep8248_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("ep8248_setup_arch()", 0);
+
+	cpm2_reset();
+
+	/* When this is set, snooping CPM DMA from RAM causes
+	 * machine checks.  See erratum SIU18.
+	 */
+	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
+
+	ep8248e_bcsr_node =
+		of_find_compatible_node(NULL, NULL, "fsl,ep8248e-bcsr");
+	if (!ep8248e_bcsr_node) {
+		printk(KERN_ERR "No bcsr in device tree\n");
+		return;
+	}
+
+	ep8248e_bcsr = of_iomap(ep8248e_bcsr_node, 0);
+	if (!ep8248e_bcsr) {
+		printk(KERN_ERR "Cannot map BCSR registers\n");
+		return;
+	}
+
+	setbits8(&ep8248e_bcsr[7], BCSR7_SCC2_ENABLE);
+	setbits8(&ep8248e_bcsr[8], BCSR8_PHY1_ENABLE | BCSR8_PHY1_POWER |
+	                           BCSR8_PHY2_ENABLE | BCSR8_PHY2_POWER);
+
+	init_ioports();
+
+	if (ppc_md.progress)
+		ppc_md.progress("ep8248_setup_arch(), finish", 0);
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{ .compatible = "fsl,ep8248e-bcsr", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	if (!machine_is(ep8248))
+		return 0;
+
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	of_register_platform_driver(&ep8248e_mdio_driver);
+
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init ep8248_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,ep8248e");
+}
+
+define_machine(ep8248)
+{
+	.name = "Embedded Planet EP8248E",
+	.probe = ep8248_probe,
+	.setup_arch = ep8248_setup_arch,
+	.init_IRQ = ep8248_pic_init,
+	.get_irq = cpm2_get_irq,
+	.calibrate_decr = generic_calibrate_decr,
+	.restart = pq2_restart,
+	.progress = udbg_progress,
+};
diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/mpc8260.h
index e0d4807..03317e1 100644
--- a/include/asm-powerpc/mpc8260.h
+++ b/include/asm-powerpc/mpc8260.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_POWERPC_MPC8260_H__
 #define __ASM_POWERPC_MPC8260_H__
 
+#define MPC82XX_BCR_PLDP 0x00800000 /* Pipeline Maximum Depth */
 
 #ifdef CONFIG_8260
 
-- 
1.5.3.7
