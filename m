Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:23 +1100
Subject: [PATCH 24/25] powerpc: Base support for 440SPe "Katmai" eval board
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080134.7DB7CDE155@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds base support for the Katmai board, including PCI-X and
PCI-Express (but no RTC, nvram, etc... yet).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

As for Taishan, the bootwrapper code can be simplified. In fact,
we probably don't need to probe clocks & memsize off the chip and
just trust what uboot tells us.

 arch/powerpc/boot/Makefile          |    5 
 arch/powerpc/boot/cuboot-katmai.c   |   56 +++++
 arch/powerpc/boot/dts/katmai.dts    |  393 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig  |   13 +
 arch/powerpc/platforms/44x/Makefile |    3 
 arch/powerpc/platforms/44x/katmai.c |   63 +++++
 6 files changed, 531 insertions(+), 2 deletions(-)

Index: linux-work/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2007-12-05 11:58:28.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/Kconfig	2007-12-05 11:58:32.000000000 +1100
@@ -30,6 +30,15 @@ config TAISHAN
 	help
 	  This option enables support for the IBM PPC440GX "Taishan" evaluation board.
 
+config KATMAI
+	bool "Katmai"
+	depends on 44x
+	default n
+	select 440SPe
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC440SPe evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -74,6 +83,10 @@ config 440GX
 config 440SP
 	bool
 
+config 440SPe
+        select IBM_NEW_EMAC_EMAC4
+	bool
+
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
Index: linux-work/arch/powerpc/platforms/44x/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Makefile	2007-12-05 11:58:28.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/Makefile	2007-12-05 11:58:32.000000000 +1100
@@ -1,5 +1,6 @@
 obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
-obj-$(CONFIG_BAMBOO) += bamboo.o
+obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
+obj-$(CONFIG_KATMAI)	+= katmai.o
Index: linux-work/arch/powerpc/boot/dts/katmai.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/dts/katmai.dts	2007-12-05 12:00:37.000000000 +1100
@@ -0,0 +1,393 @@
+/*
+ * Device Tree Source for AMCC Katmai eval board
+ *
+ * Copyright (c) 2006, 2007 IBM Corp.
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * Copyright (c) 2006, 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "amcc,katmai";
+	compatible = "amcc,katmai";
+	dcr-parent = <&/cpus/PowerPC,440SPe@0>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,440SPe@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <0>; /* Filled in by zImage */
+			timebase-frequency = <0>; /* Filled in by zImage */
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <20000>;
+			d-cache-size = <20000>;
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
+		compatible = "ibm,uic-440spe","ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-440spe","ibm,uic";
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
+	UIC2: interrupt-controller2 {
+		compatible = "ibm,uic-440spe","ibm,uic";
+		interrupt-controller;
+		cell-index = <2>;
+		dcr-reg = <0e0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <a 4 b 4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	UIC3: interrupt-controller3 {
+		compatible = "ibm,uic-440spe","ibm,uic";
+		interrupt-controller;
+		cell-index = <3>;
+		dcr-reg = <0f0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <10 4 11 4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible = "ibm,sdr-440spe";
+		dcr-reg = <00e 002>;
+	};
+
+	CPR0: cpr {
+		compatible = "ibm,cpr-440spe";
+		dcr-reg = <00c 002>;
+	};
+
+	plb {
+		compatible = "ibm,plb-440spe", "ibm,plb-440gp", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: sdram {
+			compatible = "ibm,sdram-440spe", "ibm,sdram-405gp";
+			dcr-reg = <010 2>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-440spe", "ibm,mcmal2";
+			dcr-reg = <180 62>;
+			num-tx-chans = <2>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0 1 2 3 4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0 &UIC1 6 4
+					 /*RXEOB*/ 1 &UIC1 7 4
+					 /*SERR*/  2 &UIC1 1 4
+					 /*TXDE*/  3 &UIC1 2 4
+					 /*RXDE*/  4 &UIC1 3 4>;
+		};
+
+		POB0: opb {
+		  	compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		  	ranges = <00000000 4 e0000000 20000000>;
+		  	clock-frequency = <0>; /* Filled in by zImage */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-440spe", "ibm,ebc-440gp", "ibm,ebc";
+				dcr-reg = <012 2>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				ranges;
+				interrupts = <5 1>;
+				interrupt-parent = <&UIC1>;
+			};
+
+			UART0: serial@10000200 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <10000200 8>;
+				virtual-reg = <a0000200>;
+		   		clock-frequency = <0>; /* Filled in by zImage */
+		   		current-speed = <1c200>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <0 4>;
+	   		};
+
+			UART1: serial@10000300 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <10000300 8>;
+				virtual-reg = <a0000300>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <1 4>;
+	   		};
+
+
+			UART2: serial@10000600 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <10000600 8>;
+				virtual-reg = <a0000600>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC1>;
+		   		interrupts = <5 4>;
+	   		};
+
+			IIC0: i2c@10000400 {
+				device_type = "i2c";
+				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
+				reg = <10000400 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+
+			IIC1: i2c@10000500 {
+				device_type = "i2c";
+				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
+				reg = <10000500 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <3 4>;
+			};
+
+			EMAC0: ethernet@10000800 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-440spe", "ibm,emac4";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1c 4 1d 4>;
+				reg = <10000800 70>;
+				local-mac-address = [000000000000];
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "gmii";
+				phy-map = <00000000>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+		};
+
+		PCIX0: pci@c0ec00000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pcix-440spe", "ibm,plb-pcix";
+			primary;
+			large-inbound-windows;
+			enable-msi-hole;
+			reg = <c 0ec00000   8	/* Config space access */
+			       0 0 0		/* no IACK cycles */
+			       c 0ed00000   4   /* Special cycles */
+			       c 0ec80000 100	/* Internal registers */
+			       c 0ec80100  fc>;	/* Internal messaging registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 0000000d 80000000 0 80000000
+				  01000000 0 00000000 0000000c 08000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* This drives busses 0 to 0xf */
+			bus-range = <0 f>;
+
+			/*
+			 * On Katmai, the following PCI-X interrupts signals
+			 * have to be enabled via jumpers (only INTA is
+			 * enabled per default):
+			 *
+			 * INTB: J3: 1-2
+			 * INTC: J2: 1-2
+			 * INTD: J1: 1-2
+			 */
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 1 */
+				0800 0 0 1 &UIC1 14 8
+				0800 0 0 2 &UIC1 13 8
+				0800 0 0 3 &UIC1 12 8
+				0800 0 0 4 &UIC1 11 8
+			>;
+		};
+
+		PCIE0: pciex@d00000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			primary;
+			port = <0>; /* port number */
+			reg = <d 00000000 20000000	/* Config space access */
+			       c 10000000 00001000>;	/* Registers */
+			dcr-reg = <100 020>;
+			sdr-base = <300>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 0000000e 00000000 0 80000000
+				  01000000 0 00000000 0000000f 80000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* This drives busses 10 to 0x1f */
+			bus-range = <10 1f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map = <
+				0000 0 0 1 &UIC3 0 4 /* swizzled int A */
+				0000 0 0 2 &UIC3 1 4 /* swizzled int B */
+				0000 0 0 3 &UIC3 2 4 /* swizzled int C */
+				0000 0 0 4 &UIC3 3 4 /* swizzled int D */>;
+		};
+
+		PCIE1: pciex@d20000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			primary;
+			port = <1>; /* port number */
+			reg = <d 20000000 20000000	/* Config space access */
+			       c 10001000 00001000>;	/* Registers */
+			dcr-reg = <120 020>;
+			sdr-base = <340>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 0000000e 80000000 0 80000000
+				  01000000 0 00000000 0000000f 80010000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* This drives busses 10 to 0x1f */
+			bus-range = <20 2f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map = <
+				0000 0 0 1 &UIC3 4 4 /* swizzled int A */
+				0000 0 0 2 &UIC3 5 4 /* swizzled int B */
+				0000 0 0 3 &UIC3 6 4 /* swizzled int C */
+				0000 0 0 4 &UIC3 7 4 /* swizzled int D */>;
+		};
+
+		PCIE2: pciex@d40000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			primary;
+			port = <2>; /* port number */
+			reg = <d 40000000 20000000	/* Config space access */
+			       c 10002000 00001000>;	/* Registers */
+			dcr-reg = <140 020>;
+			sdr-base = <370>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 0000000f 00000000 0 80000000
+				  01000000 0 00000000 0000000f 80020000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* This drives busses 10 to 0x1f */
+			bus-range = <30 3f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map = <
+				0000 0 0 1 &UIC3 8 4 /* swizzled int A */
+				0000 0 0 2 &UIC3 9 4 /* swizzled int B */
+				0000 0 0 3 &UIC3 a 4 /* swizzled int C */
+				0000 0 0 4 &UIC3 b 4 /* swizzled int D */>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@10000200";
+	};
+};
Index: linux-work/arch/powerpc/platforms/44x/katmai.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/platforms/44x/katmai.c	2007-12-05 11:58:32.000000000 +1100
@@ -0,0 +1,63 @@
+/*
+ * Katmai board specific routines
+ *
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * Copyright 2007 IBM Corp.
+ *
+ * Based on the Bamboo code by
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright 2007 IBM Corporation
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
+
+#include "44x.h"
+
+static struct of_device_id katmai_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init katmai_device_probe(void)
+{
+	if (!machine_is(katmai))
+		return 0;
+
+	of_platform_bus_probe(NULL, katmai_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(katmai_device_probe);
+
+static int __init katmai_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,katmai"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(katmai) {
+	.name 				= "Katmai",
+	.probe 				= katmai_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc44x_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
Index: linux-work/arch/powerpc/boot/cuboot-katmai.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/boot/cuboot-katmai.c	2007-12-05 11:58:32.000000000 +1100
@@ -0,0 +1,56 @@
+/*
+ * Old U-boot compatibility for Katmai
+ *
+ * Author: Hugh Blemings <hugh@au.ibm.com>
+ *
+ * Copyright 2007 Hugh Blemings, IBM Corporation.
+ *   Based on cuboot-ebony.c which is:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *   Based on cuboot-83xx.c, which is:
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "reg.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+BSS_STACK(4096);
+
+static void katmai_fixups(void)
+{
+	unsigned long sysclk = 33333000;
+
+	/* 440SP Clock logic is all but identical to 440GX
+	 * so we just use that code for now at least
+	 */
+	ibm440spe_fixup_clocks(sysclk, 6 * 1843200, 0);
+
+	ibm440spe_fixup_memsize();
+
+	dt_fixup_mac_address(0, bd.bi_enetaddr);
+
+	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+
+	platform_ops.fixups = katmai_fixups;
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+}
Index: linux-work/arch/powerpc/boot/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/boot/Makefile	2007-12-05 11:58:28.000000000 +1100
+++ linux-work/arch/powerpc/boot/Makefile	2007-12-05 11:58:32.000000000 +1100
@@ -38,6 +38,7 @@ BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(ob
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=440
+$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=440
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 
 
@@ -58,7 +59,8 @@ src-plat := of.c cuboot-52xx.c cuboot-83
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
+		cuboot-katmai.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -163,6 +165,7 @@ image-$(CONFIG_BAMBOO)			+= treeImage.ba
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
+image-$(CONFIG_KATMAI)			+= cuImage.katmai
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
