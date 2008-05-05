Return-Path: <gicoviello@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id A4910DE3B8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:23:33 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1887415ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 11:23:30 -0700 (PDT)
Message-ID: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
Date: Mon, 5 May 2008 20:23:29 +0200
From: "Giuseppe Coviello" <cjg@cruxppc.org>
Sender: gicoviello@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Sam440ep support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the support for the sam440ep board.

 arch/powerpc/boot/Makefile                  |    5 +-
 arch/powerpc/boot/cuboot-sam440ep.c         |   35 +
 arch/powerpc/boot/dts/sam440ep.dts          |  292 ++++++
 arch/powerpc/boot/sam440ep.c                |   53 +
 arch/powerpc/configs/44x/sam440ep_defconfig | 1429 +++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig          |    9 +
 arch/powerpc/platforms/44x/Makefile         |    1 +
 arch/powerpc/platforms/44x/sam440ep.c       |   66 ++
 arch/powerpc/sysdev/Makefile                |    1 +
 arch/powerpc/sysdev/sam440ep.c              |  112 +++
 include/asm-powerpc/dma-mapping.h           |   30 +
 sound/core/memalloc.c                       |   31 +-
 12 files changed, 2061 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7822d25..0d49e47 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -57,7 +57,7 @@ src-wlib := string.S crt0.S stdio.c main.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c
+		fsl-soc.c mpc8xx.c pq2.c sam440ep.c
 src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c
cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
@@ -66,7 +66,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c
cuboot-83xx.c cuboot-85xx.c holly.c
 		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
-		virtex405-head.S
+		virtex405-head.S cuboot-sam440ep.c
 src-boot := $(src-wlib) $(src-plat) empty.c

 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -213,6 +213,7 @@ image-$(CONFIG_WALNUT)			+= treeImage.walnut
 # Board ports in arch/powerpc/platform/44x/Kconfig
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
+image-$(CONFIG_SAM440EP)		+= cuImage.sam440ep
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_RAINIER)			+= cuImage.rainier
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
diff --git a/arch/powerpc/boot/cuboot-sam440ep.c
b/arch/powerpc/boot/cuboot-sam440ep.c
new file mode 100644
index 0000000..200b35b
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-sam440ep.c
@@ -0,0 +1,35 @@
+/*
+ * Old U-boot compatibility for Sam440ep based off bamboo.c code
+ * original copyrights below
+ *
+ * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Copyright 2007 IBM Corporation
+ *
+ * Based on cuboot-ebony.c
+ *
+ * Modified from cuboot-bamboo.c for sam440ep:
+ * Copyright 2008 Giuseppe Coviello <cjg@cruxppc.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_4xx
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	sam440ep_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
diff --git a/arch/powerpc/boot/dts/sam440ep.dts
b/arch/powerpc/boot/dts/sam440ep.dts
new file mode 100644
index 0000000..764cab0
--- /dev/null
+++ b/arch/powerpc/boot/dts/sam440ep.dts
@@ -0,0 +1,292 @@
+/*
+ * Device Tree Source for ACube Sam440ep  based off bamboo.dts code
+ * original copyrights below
+ *
+ * Copyright (c) 2006, 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Modified from bamboo.dts for sam440ep:
+ * Copyright 2008 Giuseppe Coviello <cjg@cruxppc.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "acube,sam440ep";
+	compatible = "acube,sam440ep";
+	dcr-parent = <&/cpus/cpu@0>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+		serial2 = &UART2;
+		serial3 = &UART3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,440EP";
+			reg = <0>;
+			clock-frequency = <0>; /* Filled in by zImage */
+			timebase-frequency = <0>; /* Filled in by zImage */
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <8000>;
+			d-cache-size = <8000>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0>; /* Filled in by zImage */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-440ep","ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-440ep","ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0d0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible = "ibm,sdr-440ep";
+		dcr-reg = <00e 002>;
+	};
+
+	CPR0: cpr {
+		compatible = "ibm,cpr-440ep";
+		dcr-reg = <00c 002>;
+	};
+
+	plb {
+		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: sdram {
+			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
+			dcr-reg = <010 2>;
+		};
+
+		DMA0: dma {
+			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
+			dcr-reg = <100 027>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
+			dcr-reg = <180 62>;
+			num-tx-chans = <4>;
+			num-rx-chans = <2>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0 1 2 3 4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
+					/*RXEOB*/ 1 &UIC0 b 4
+					/*SERR*/  2 &UIC1 0 4
+					/*TXDE*/  3 &UIC1 1 4
+					/*RXDE*/  4 &UIC1 2 4>;
+		};
+
+		POB0: opb {
+		  	compatible = "ibm,opb-440ep", "ibm,opb-440gp", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
+			 * bits.
+			 */
+		  	ranges = <00000000 0 00000000 80000000
+			          80000000 0 80000000 80000000>;
+		  	interrupt-parent = <&UIC1>;
+		  	interrupts = <7 4>;
+		  	clock-frequency = <0>; /* Filled in by zImage */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
+				dcr-reg = <012 2>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				interrupts = <5 1>;
+				interrupt-parent = <&UIC1>;
+			};
+
+			UART0: serial@ef600300 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600300 8>;
+		   		virtual-reg = <ef600300>;
+		   		clock-frequency = <0>; /* Filled in by zImage */
+		   		current-speed = <1c200>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <0 4>;
+	   		};
+
+			UART1: serial@ef600400 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600400 8>;
+		   		virtual-reg = <ef600400>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <1 4>;
+	   		};
+
+			UART2: serial@ef600500 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600500 8>;
+		   		virtual-reg = <ef600500>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <3 4>;
+	   		};
+
+			UART3: serial@ef600600 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600600 8>;
+		   		virtual-reg = <ef600600>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <4 4>;
+	   		};
+
+			IIC0: i2c@ef600700 {
+                                #address-cells = <1>;
+                                #size-cells = <0>;
+				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
+				index = <0>;
+				reg = <ef600700 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+				rtc@68 {
+					compatible = "stm,m41t80";
+					reg = <68>;
+				};
+			};
+
+			IIC1: i2c@ef600800 {
+				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
+				index = <5>;
+				reg = <ef600800 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <7 4>;
+			};
+
+			ZMII0: emac-zmii@ef600d00 {
+				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
+				reg = <ef600d00 c>;
+			};
+
+			EMAC0: ethernet@ef600e00 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1c 4 1d 4>;
+				reg = <ef600e00 70>;
+				local-mac-address = [000000000000];
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0 1>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000000>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <0>;
+			};
+
+			EMAC1: ethernet@ef600f00 {
+				linux,network-index = <1>;
+				device_type = "network";
+				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1e 4 1f 4>;
+				reg = <ef600f00 70>;
+				local-mac-address = [000000000000];
+				mal-device = <&MAL0>;
+				mal-tx-channel = <2 3>;
+				mal-rx-channel = <1>;
+				cell-index = <1>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000000>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <1>;
+			};
+			usb@ef601000 {
+				compatible = "ohci-be";
+				reg = <ef601000 80>;
+				interrupts = <8 4 9 4>;
+				interrupt-parent = < &UIC1 >;
+			};	
+		};
+
+		PCI0: pci@ec000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
+			primary;
+			reg = <0 eec00000 8	/* Config space access */
+			       0 eed00000 4	/* IACK */
+			       0 eed00000 4	/* Special cycle */
+			       0 ef400000 40>;	/* Internal registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed. Chip supports a second
+			 * IO range but we don't use it for now
+			 */
+			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
+				  01000000 0 00000000 0 e8000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+	};
+};
diff --git a/arch/powerpc/boot/sam440ep.c b/arch/powerpc/boot/sam440ep.c
new file mode 100644
index 0000000..2f3c8f6
--- /dev/null
+++ b/arch/powerpc/boot/sam440ep.c
@@ -0,0 +1,53 @@
+/*
+ * Sam440ep wrapper based off bamboo.c code
+ * original copyrights below
+ *
+ * Copyright IBM Corporation, 2007
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Based on ebony wrapper:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Clocking code based on code by:
+ * Stefan Roese <sr@denx.de>
+ *
+ * Modified from bamboo.c for sam440ep:
+ * Copyright 2008 Giuseppe Coviello <cjg@cruxppc.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the License
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+
+static u8 *sam440ep_mac0, *sam440ep_mac1;
+
+static void sam440ep_fixups(void)
+{
+	unsigned long sysclk = 66666666; 	
+
+	ibm440ep_fixup_clocks(sysclk, 11059200, 25000000);
+	ibm4xx_sdram_fixup_memsize();
+	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
+	dt_fixup_mac_addresses(sam440ep_mac0, sam440ep_mac1);
+}
+
+void sam440ep_init(void *mac0, void *mac1)
+{
+	platform_ops.fixups = sam440ep_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	sam440ep_mac0 = mac0;
+	sam440ep_mac1 = mac1;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig
b/arch/powerpc/configs/44x/sam440ep_defconfig
new file mode 100644
index 0000000..4db89d2
--- /dev/null
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -0,0 +1,1429 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.25
+# Fri May  2 17:10:54 2008
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
+CONFIG_PPC_FPU=y
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
+CONFIG_IKCONFIG=y
+# CONFIG_IKCONFIG_PROC is not set
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
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
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
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
+# CONFIG_PPC4xx_PCI_EXPRESS is not set
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC512x is not set
+# CONFIG_PPC_MPC5121 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_BAMBOO is not set
+# CONFIG_EBONY is not set
+CONFIG_SAM440EP=y
+# CONFIG_SEQUOIA is not set
+# CONFIG_TAISHAN is not set
+# CONFIG_KATMAI is not set
+# CONFIG_RAINIER is not set
+# CONFIG_WARP is not set
+# CONFIG_CANYONLANDS is not set
+# CONFIG_YOSEMITE is not set
+CONFIG_440EP=y
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
+# CONFIG_SCHED_HRTICK is not set
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
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
+CONFIG_RESOURCES_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_PROC_DEVICETREE=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_4xx_SOC=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
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
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
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
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
+# CONFIG_MTD is not set
+CONFIG_OF_DEVICE=y
+CONFIG_OF_I2C=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=35000
+# CONFIG_BLK_DEV_XIP is not set
+CONFIG_CDROM_PKTCDVD=y
+CONFIG_CDROM_PKTCDVD_BUFFERS=8
+# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+# CONFIG_SATA_PMP is not set
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_SATA_SIL=y
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
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
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI is not set
+# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
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
+# CONFIG_INPUT_EVDEV is not set
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
+# CONFIG_MOUSE_APPLETOUCH is not set
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
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
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
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_ALGOBIT=y
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+CONFIG_I2C_IBM_IIC=y
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
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
+# CONFIG_HTC_PASIC3 is not set
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
+
+#
+# Multimedia drivers
+#
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+CONFIG_FB_DDC=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
+CONFIG_FB_MACMODES=y
+CONFIG_FB_BACKLIGHT=y
+CONFIG_FB_MODE_HELPERS=y
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_OF is not set
+# CONFIG_FB_CT65550 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_UVESA is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+CONFIG_FB_RADEON=y
+CONFIG_FB_RADEON_I2C=y
+CONFIG_FB_RADEON_BACKLIGHT=y
+# CONFIG_FB_RADEON_DEBUG is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_FB_VIRTUAL is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_CORGI is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
+
+#
+# Sound
+#
+CONFIG_SOUND=m
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=m
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
+CONFIG_SND_HWDEP=m
+CONFIG_SND_RAWMIDI=m
+# CONFIG_SND_SEQUENCER is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=m
+CONFIG_SND_PCM_OSS=m
+CONFIG_SND_PCM_OSS_PLUGINS=y
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+CONFIG_SND_OPL3_LIB=m
+CONFIG_SND_AC97_CODEC=m
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# PCI devices
+#
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS300 is not set
+# CONFIG_SND_ALS4000 is not set
+# CONFIG_SND_ALI5451 is not set
+# CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
+# CONFIG_SND_AU8810 is not set
+# CONFIG_SND_AU8820 is not set
+# CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AW2 is not set
+# CONFIG_SND_AZT3328 is not set
+# CONFIG_SND_BT87X is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_OXYGEN is not set
+CONFIG_SND_CS4281=m
+# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS5530 is not set
+# CONFIG_SND_DARLA20 is not set
+# CONFIG_SND_GINA20 is not set
+# CONFIG_SND_LAYLA20 is not set
+# CONFIG_SND_DARLA24 is not set
+# CONFIG_SND_GINA24 is not set
+# CONFIG_SND_LAYLA24 is not set
+# CONFIG_SND_MONA is not set
+# CONFIG_SND_MIA is not set
+# CONFIG_SND_ECHO3G is not set
+# CONFIG_SND_INDIGO is not set
+# CONFIG_SND_INDIGOIO is not set
+# CONFIG_SND_INDIGODJ is not set
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_ENS1370 is not set
+# CONFIG_SND_ENS1371 is not set
+# CONFIG_SND_ES1938 is not set
+# CONFIG_SND_ES1968 is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_HDA_INTEL is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
+# CONFIG_SND_HIFIER is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+# CONFIG_SND_INTEL8X0 is not set
+# CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_PCXHR is not set
+# CONFIG_SND_RIPTIDE is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_TRIDENT is not set
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VIRTUOSO is not set
+# CONFIG_SND_VX222 is not set
+# CONFIG_SND_YMFPCI is not set
+# CONFIG_SND_AC97_POWER_SAVE is not set
+
+#
+# ALSA PowerMac devices
+#
+
+#
+# ALSA PowerPC devices
+#
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_USX2Y is not set
+# CONFIG_SND_USB_CAIAQ is not set
+
+#
+# System on Chip audio support
+#
+# CONFIG_SND_SOC is not set
+
+#
+# ALSA SoC audio for Freescale SOCs
+#
+
+#
+# SoC Audio for the Texas Instruments OMAP
+#
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=m
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=m
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PPC_OF=y
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PPC_OF=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
+CONFIG_USB_OHCI_HCD_PCI=y
+CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_MON is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
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
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_RTC_DRV_M41T80_WDT=y
+# CONFIG_RTC_DRV_S35390A is not set
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
+# CONFIG_DMADEVICES is not set
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+# CONFIG_EXT2_FS_SECURITY is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=m
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=y
+# CONFIG_REISERFS_CHECK is not set
+CONFIG_REISERFS_PROC_INFO=y
+CONFIG_REISERFS_FS_XATTR=y
+CONFIG_REISERFS_FS_POSIX_ACL=y
+# CONFIG_REISERFS_FS_SECURITY is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+CONFIG_XFS_FS=m
+CONFIG_XFS_QUOTA=y
+CONFIG_XFS_POSIX_ACL=y
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_DEBUG is not set
+# CONFIG_OCFS2_FS is not set
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+CONFIG_QUOTACTL=y
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
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
+CONFIG_AFFS_FS=m
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+CONFIG_NFSD_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
+CONFIG_RPCSEC_GSS_KRB5=y
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
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+CONFIG_AMIGA_PARTITION=y
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
+# CONFIG_NLS_CODEPAGE_437 is not set
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
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
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
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC_ITU_T=y
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
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_IRQSTACKS is not set
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
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
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
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/platforms/44x/Kconfig
b/arch/powerpc/platforms/44x/Kconfig
index 6abe913..3e0a58f 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -17,6 +17,15 @@ config EBONY
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.

+config SAM440EP
+	bool "Sam440ep"
+	depends on 44x
+	default n
+	select 440EP
+	select PCI
+	help
+	  This option enables support for the ACube Sam440ep board.
+
 config SEQUOIA
 	bool "Sequoia"
 	depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile
b/arch/powerpc/platforms/44x/Makefile
index 774165f..ec8c275 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_YOSEMITE)	+= bamboo.o
+obj-$(CONFIG_SAM440EP)	+= sam440ep.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
 obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
diff --git a/arch/powerpc/platforms/44x/sam440ep.c
b/arch/powerpc/platforms/44x/sam440ep.c
new file mode 100644
index 0000000..a95eb80
--- /dev/null
+++ b/arch/powerpc/platforms/44x/sam440ep.c
@@ -0,0 +1,66 @@
+/*
+ * Sam440ep board specific routines based off bamboo.c code
+ * original copyrights below
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * Rewritten and ported to the merged powerpc tree:
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright 2007 IBM Corporation
+ *
+ * Modified from bamboo.c for sam440ep:
+ * Copyright 2008 Giuseppe Coviello <cjg@cruxppc.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
+
+static __initdata struct of_device_id sam440ep_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init sam440ep_device_probe(void)
+{
+	of_platform_bus_probe(NULL, sam440ep_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(sam440ep, sam440ep_device_probe);
+
+static int __init sam440ep_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "acube,sam440ep"))
+		return 0;
+
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
+	return 1;
+}
+
+define_machine(sam440ep) {
+	.name 			= "Sam440ep",
+	.probe 			= sam440ep_probe,
+	.progress 		= udbg_progress,
+	.init_IRQ 		= uic_init_tree,
+	.get_irq 		= uic_get_irq,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr 	= generic_calibrate_decr,
+};
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 6d386d0..43556a0 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+obj-$(CONFIG_SAM440EP)		+= sam440ep.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
diff --git a/arch/powerpc/sysdev/sam440ep.c b/arch/powerpc/sysdev/sam440ep.c
new file mode 100644
index 0000000..c249591
--- /dev/null
+++ b/arch/powerpc/sysdev/sam440ep.c
@@ -0,0 +1,112 @@
+/*
+ * Sam440ep setup code based off fsl_soc.c code
+ * original copyrights below
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Modified from fsl_soc.c for sam440ep:
+ * Copyright 2008 Giuseppe Coviello <cjg@cruxppc.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+
+struct i2c_driver_device {
+	char	*of_device;
+	char	*i2c_driver;
+	char	*i2c_type;
+};
+
+static struct i2c_driver_device i2c_devices[] __initdata = {
+	{"stm,m41t80",     "rtc-m41t80",  "m41st85"},
+};
+
+static int __init of_find_i2c_driver(struct device_node *node,
+				     struct i2c_board_info *info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
+		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
+			continue;
+		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
+			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
+		    strlcpy(info->type, i2c_devices[i].i2c_type,
+			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+			return -ENOMEM;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static void __init of_register_i2c_devices(struct device_node *adap_node,
+					   int bus_num)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info = {};
+		const u32 *addr;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
+			printk(KERN_WARNING "sam440ep.c: invalid i2c device entry\n");
+			continue;
+		}
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		if (of_find_i2c_driver(node, &info) < 0)
+			continue;
+
+		info.addr = *addr;
+
+		i2c_register_board_info(bus_num, &info, 1);
+	}
+}
+
+static int __init sam440ep_i2c_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i = 0;
+	struct platform_device *i2c_dev;
+	int ret;
+
+	for_each_compatible_node(np, NULL, "ibm,iic") {
+		struct resource r[2];
+
+		memset(&r, 0, sizeof(r));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		of_irq_to_resource(np, 0, &r[1]);
+
+		i2c_dev = platform_device_register_simple("ibm,iic", i, r, 2);
+		if (IS_ERR(i2c_dev)) {
+			ret = PTR_ERR(i2c_dev);
+			goto err;
+		}
+
+		of_register_i2c_devices(np, i++);
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+
+arch_initcall(sam440ep_i2c_of_init);
diff --git a/include/asm-powerpc/dma-mapping.h
b/include/asm-powerpc/dma-mapping.h
index bbefb69..3a6235a 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -244,6 +244,36 @@ dma_free_coherent(struct device *dev, size_t
size, void *vaddr,
 #endif
 }

+#ifdef CONFIG_SAM440EP
+static inline void *dma_std_alloc_coherent(struct device *dev, size_t size,
+				       dma_addr_t * dma_handle,
+				       gfp_t gfp)
+{
+	void *ret;
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+	if (dev == NULL || dev->coherent_dma_mask < 0xffffffff)
+		gfp |= GFP_DMA;
+
+	ret = (void *)__get_free_pages(gfp, get_order(size));
+
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_bus(ret);
+	}
+
+	return ret;
+}
+
+static inline void
+dma_std_free_coherent(struct device *dev, size_t size, void *vaddr,
+		  dma_addr_t dma_handle)
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+#endif
+
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
 	       enum dma_data_direction direction)
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 23b7bc0..e7c64ac 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -108,20 +108,33 @@ static void *snd_dma_hack_alloc_coherent(struct
device *dev, size_t size,
 	u64 dma_mask, coherent_dma_mask;

 	if (dev == NULL || !dev->dma_mask)
+#ifdef CONFIG_SAM440EP
+		return dma_std_alloc_coherent(dev, size, dma_handle, flags);
+#else
 		return dma_alloc_coherent(dev, size, dma_handle, flags);
+#endif
 	dma_mask = *dev->dma_mask;
 	coherent_dma_mask = dev->coherent_dma_mask;
 	*dev->dma_mask = 0xffffffff; 	/* do without masking */
 	dev->coherent_dma_mask = 0xffffffff; 	/* do without masking */
+#ifdef CONFIG_SAM440EP
+	ret = dma_std_alloc_coherent(dev, size, dma_handle, flags);
+#else
 	ret = dma_alloc_coherent(dev, size, dma_handle, flags);
+#endif
 	*dev->dma_mask = dma_mask;	/* restore */
 	dev->coherent_dma_mask = coherent_dma_mask;	/* restore */
 	if (ret) {
 		/* obtained address is out of range? */
 		if (((unsigned long)*dma_handle + size - 1) & ~dma_mask) {
 			/* reallocate with the proper mask */
+#ifdef CONFIG_SAM440EP
+			dma_std_free_coherent(dev, size, ret, *dma_handle);
+			ret = dma_std_alloc_coherent(dev, size, dma_handle, flags);
+#else
 			dma_free_coherent(dev, size, ret, *dma_handle);
 			ret = dma_alloc_coherent(dev, size, dma_handle, flags);
+#endif
 		}
 	} else {
 		/* wish to success now with the proper mask... */
@@ -129,16 +142,24 @@ static void *snd_dma_hack_alloc_coherent(struct
device *dev, size_t size,
 			/* allocation with GFP_ATOMIC to avoid the long stall */
 			flags &= ~GFP_KERNEL;
 			flags |= GFP_ATOMIC;
+#ifdef CONFIG_SAM440EP
+			ret = dma_std_alloc_coherent(dev, size, dma_handle, flags);
+#else
 			ret = dma_alloc_coherent(dev, size, dma_handle, flags);
+#endif
 		}
 	}
 	return ret;
 }

 /* redefine dma_alloc_coherent for some architectures */
+#ifdef CONFIG_SAM440EP
+#undef dma_std_alloc_coherent
+#define dma_std_alloc_coherent snd_dma_hack_alloc_coherent
+#else
 #undef dma_alloc_coherent
 #define dma_alloc_coherent snd_dma_hack_alloc_coherent
-
+#endif
 #endif /* arch */

 /*
@@ -221,7 +242,11 @@ static void *snd_malloc_dev_pages(struct device
*dev, size_t size, dma_addr_t *d
 		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
+#ifdef CONFIG_SAM440EP
+	res = dma_std_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
+#else
 	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
+#endif
 	if (res != NULL)
 		inc_snd_pages(pg);

@@ -238,7 +263,11 @@ static void snd_free_dev_pages(struct device
*dev, size_t size, void *ptr,
 		return;
 	pg = get_order(size);
 	dec_snd_pages(pg);
+#ifdef CONFIG_SAM440EP
+	dma_std_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
+#else
 	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
+#endif
 }
 #endif /* CONFIG_HAS_DMA */
