Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:34 +1100
Subject: [PATCH 17/21] [POWERPC] Base support for 440SPe "Katmai" eval board
Message-Id: <20071221043938.9C15EDDFBF@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
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
Acked-by: Stefan Roese <sr@denx.de>
---

As for Taishan, the bootwrapper code can be simplified. In fact,
we probably don't need to probe clocks & memsize off the chip and
just trust what uboot tells us.

 arch/powerpc/boot/Makefile            |    5 
 arch/powerpc/boot/cuboot-katmai.c     |   56 ++
 arch/powerpc/boot/dts/katmai.dts      |  392 ++++++++++++++++
 arch/powerpc/configs/katmai_defconfig |  789 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig    |   14 
 arch/powerpc/platforms/44x/Makefile   |    3 
 arch/powerpc/platforms/44x/katmai.c   |   63 ++
 7 files changed, 1320 insertions(+), 2 deletions(-)

--- linux-merge.orig/arch/powerpc/platforms/44x/Kconfig	2007-12-21 14:20:11.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/44x/Kconfig	2007-12-21 14:21:23.000000000 +1100
@@ -34,6 +34,16 @@ config TAISHAN
 	  This option enables support for the AMCC PPC440GX "Taishan"
 	  evaluation board.
 
+config KATMAI
+	bool "Katmai"
+	depends on 44x
+	default n
+	select 440SPe
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC440SPe evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -78,6 +88,10 @@ config 440GX
 config 440SP
 	bool
 
+config 440SPe
+        select IBM_NEW_EMAC_EMAC4
+	bool
+
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
Index: linux-merge/arch/powerpc/platforms/44x/Makefile
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/44x/Makefile	2007-12-21 14:20:04.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/44x/Makefile	2007-12-21 14:21:23.000000000 +1100
@@ -1,5 +1,6 @@
 obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
-obj-$(CONFIG_BAMBOO) += bamboo.o
+obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
+obj-$(CONFIG_KATMAI)	+= katmai.o
Index: linux-merge/arch/powerpc/boot/dts/katmai.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-merge/arch/powerpc/boot/dts/katmai.dts	2007-12-21 14:34:45.000000000 +1100
@@ -0,0 +1,392 @@
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
Index: linux-merge/arch/powerpc/platforms/44x/katmai.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-merge/arch/powerpc/platforms/44x/katmai.c	2007-12-21 14:34:33.000000000 +1100
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
Index: linux-merge/arch/powerpc/boot/cuboot-katmai.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-merge/arch/powerpc/boot/cuboot-katmai.c	2007-12-21 14:21:23.000000000 +1100
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
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
Index: linux-merge/arch/powerpc/boot/Makefile
===================================================================
--- linux-merge.orig/arch/powerpc/boot/Makefile	2007-12-21 14:20:04.000000000 +1100
+++ linux-merge/arch/powerpc/boot/Makefile	2007-12-21 14:21:23.000000000 +1100
@@ -38,6 +38,7 @@ BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(ob
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=440
+$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=440
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 
 
@@ -60,7 +61,8 @@ src-plat := of.c cuboot-52xx.c cuboot-83
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
+		cuboot-katmai.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -202,6 +204,7 @@ image-$(CONFIG_BAMBOO)			+= treeImage.ba
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
+image-$(CONFIG_KATMAI)			+= cuImage.katmai
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
Index: linux-merge/arch/powerpc/configs/katmai_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-merge/arch/powerpc/configs/katmai_defconfig	2007-12-21 14:21:23.000000000 +1100
@@ -0,0 +1,789 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24-rc4
+# Tue Dec 11 17:07:18 2007
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
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
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
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
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
+CONFIG_LBD=y
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
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
+CONFIG_PPC4xx_PCI_EXPRESS=y
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_BAMBOO is not set
+# CONFIG_EBONY is not set
+# CONFIG_SEQUOIA is not set
+# CONFIG_TAISHAN is not set
+CONFIG_KATMAI=y
+CONFIG_440SPe=y
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
+# CONFIG_CPM2 is not set
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
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
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
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_RESOURCES_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+CONFIG_SECCOMP=y
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="katmai.dts"
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
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
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x01000000
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
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
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
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
+# CONFIG_MTD is not set
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
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
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
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+CONFIG_MACINTOSH_DRIVERS=y
+# CONFIG_MAC_EMUMOUSEBTN is not set
+# CONFIG_WINDFARM is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_IP1000 is not set
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
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+CONFIG_IBM_NEW_EMAC_EMAC4=y
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
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
+# CONFIG_SERIAL_NONSTANDARD is not set
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
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
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
+# CONFIG_AGP is not set
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
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
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
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
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
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
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
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_KPROBES is not set
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
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
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
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+CONFIG_DEBUGGER=y
+# CONFIG_KGDB is not set
+# CONFIG_XMON is not set
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
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
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
+# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set
