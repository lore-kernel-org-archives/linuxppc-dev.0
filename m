Return-Path: <super.firetwister@googlemail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id B2345DDFC8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 17:58:58 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so699881wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 00:58:57 -0700 (PDT)
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add a simple 405EP based board
Date: Thu, 21 Aug 2008 10:07:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808211007.59965.super.firetwister@gmail.com>
From: Markus Brunner <super.firetwister@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for a simple ppc405ep board. 
At the moment, there are no 405ep boards in arch/powerpc, so this can be used as a template
for new boards, or migrating them from arch/ppc.
I2c, UART and EMAC are working. PCI could not be tested, so it was not included in the dts.

Signed-off-by: Markus Brunner <super.firetwister@googlemail.com>
---
 boot/dts/ppc405ep.dts    |  218 +++++++++++++++++++++++++++++++++++++++++++++++
 platforms/40x/Kconfig    |    8 +
 platforms/40x/Makefile   |    1
 platforms/40x/ppc405ep.c |   58 ++++++++++++
 4 files changed, 285 insertions(+)

diff -upNr linux-2.6.27-rc4-orig/arch/powerpc/boot/dts/ppc405ep.dts 
linux-2.6.27-rc4/arch/powerpc/boot/dts/ppc405ep.dts
--- linux-2.6.27-rc4-orig/arch/powerpc/boot/dts/ppc405ep.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.27-rc4/arch/powerpc/boot/dts/ppc405ep.dts	2008-08-21 09:35:45.722031912 +0200
@@ -0,0 +1,218 @@
+/*
+ * Device Tree Source for ppc405ep
+ *
+ * (c) 2008 Markus Brunner <super.firetwister@googlemail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "company,ppc405ep";
+	compatible = "company,ppc405ep";
+	dcr-parent = <&/cpus/cpu@0>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,405EP";
+			reg = <0>;
+			clock-frequency = <0>; /* Filled in by u-boot */
+			timebase-frequency = <0>; /* Filled in by u-boot */
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <4000>;
+			d-cache-size = <4000>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <00000000 00000000>;	/* Filled in by u-boot */
+	};
+
+	UIC0: interrupt-controller {
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 9>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	plb {
+		compatible = "ibm,plb3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by u-boot */
+
+		SDRAM0: memory-controller {
+			compatible = "ibm,sdram-405ep";
+			dcr-reg = <010 2>;
+		};
+
+		MAL: mcmal {
+			compatible = "ibm,mcmal-405ep", "ibm,mcmal";
+			dcr-reg = <180 62>;
+			num-tx-chans = <4>;
+			num-rx-chans = <4>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <
+				b 4 /* TXEOB */
+				c 4 /* RXEOB */
+				a 4 /* SERR */
+				d 4 /* TXDE */
+				e 4 /* RXDE */>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb-405ep", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <ef600000 ef600000 a00000>;
+			dcr-reg = <0a0 5>;
+			clock-frequency = <0>; /* Filled in by u-boot */
+
+			UART0: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <ef600300 8>;
+				virtual-reg = <ef600300>;
+				clock-frequency = <0>; /* Filled in by u-boot */
+				current-speed = <1c200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0 4>;
+			};
+
+			UART1: serial@ef600400 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <ef600400 8>;
+				virtual-reg = <ef600400>;
+				clock-frequency = <0>; /* Filled in by u-boot */
+				current-speed = <1c200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <1 4>;
+			};
+
+			IIC: i2c@ef600500 {
+				compatible = "ibm,iic-405ep", "ibm,iic";
+				reg = <ef600500 11>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+
+			GPIO: gpio@ef600700 {
+				compatible = "ibm,gpio-405ep";
+				reg = <ef600700 38>;
+			};
+
+			EMAC0: ethernet@ef600800 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-405ep", "ibm,emac";
+				interrupt-parent = <&UIC0>;
+				interrupts = <
+					f 4 /* Ethernet */
+					9 4 /* Ethernet Wake Up */>;
+				local-mac-address = [000000000000]; /* Filled in by u-boot */
+				reg = <ef600800 70>;
+				mal-device = <&MAL>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "mii";
+				phy-map = <00000000>;
+			};
+
+			EMAC1: ethernet@ef600900 {
+				linux,network-index = <1>;
+				device_type = "network";
+				compatible = "ibm,emac-405ep", "ibm,emac";
+				interrupt-parent = <&UIC0>;
+				interrupts = <
+					11 4 /* Ethernet */
+					9 4 /* Ethernet Wake Up */>;
+				local-mac-address = [000000000000]; /* Filled in by u-boot */
+				reg = <ef600900 70>;
+				mal-device = <&MAL>;
+				mal-tx-channel = <2>;
+				mal-rx-channel = <1>;
+				cell-index = <1>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				mdio-device = <&EMAC0>;
+				phy-mode = "mii";
+				phy-map = <00000020>;
+			};
+
+
+		};
+
+		EBC0: ebc {
+			compatible = "ibm,ebc-405ep", "ibm,ebc";
+			dcr-reg = <012 2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 f8000000 8000000
+				  1 0 0c000000  100000
+				  2 0 0C100000  100000
+				  3 0 0C200000  100000
+				  4 0 80000000  100000>;
+
+			clock-frequency = <0>; /* Filled in by u-boot */
+
+			nor_flash@0,0 {
+				compatible = "amd,s29gl01gp", "cfi-flash";
+				bank-width = <2>;
+				reg = <0 000000 8000000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				partition@0 {
+					label = "jffs2";
+					reg = <0 a00000>;
+				};
+				partition@a00000 {
+					label = "foo";
+					reg = <a00000 400000>;
+				};
+				partition@e00000 {
+					label = "bar";
+					reg = <e00000 7180000>;
+				};
+				partition@7f80000 {
+					label = "u-boot";
+					reg = <7f80000 80000>;
+				};
+			};
+		};
+		/* PCI0: pci@ec000000 { PCI was not tested } */
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+	};
+};
diff -upNr linux-2.6.27-rc4-orig/arch/powerpc/platforms/40x/Kconfig 
linux-2.6.27-rc4/arch/powerpc/platforms/40x/Kconfig
--- linux-2.6.27-rc4-orig/arch/powerpc/platforms/40x/Kconfig	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.27-rc4/arch/powerpc/platforms/40x/Kconfig	2008-08-21 09:35:45.722031912 +0200
@@ -42,6 +42,14 @@ config MAKALU
 	help
 	  This option enables support for the AMCC PPC405EX board.
 
+config PPC405EP
+	bool "ppc405ep"
+	depends on 40x
+	default n
+	select 405EP
+	help
+	  This option enables support for a simple ppc 405ep board.
+
 #config REDWOOD_5
 #	bool "Redwood-5"
 #	depends on 40x
diff -upNr linux-2.6.27-rc4-orig/arch/powerpc/platforms/40x/Makefile 
linux-2.6.27-rc4/arch/powerpc/platforms/40x/Makefile
--- linux-2.6.27-rc4-orig/arch/powerpc/platforms/40x/Makefile	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.27-rc4/arch/powerpc/platforms/40x/Makefile	2008-08-21 10:03:54.718530907 +0200
@@ -3,3 +3,4 @@ obj-$(CONFIG_MAKALU)				+= makalu.o
 obj-$(CONFIG_WALNUT)				+= walnut.o
 obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)	+= virtex.o
 obj-$(CONFIG_EP405)				+= ep405.o
+obj-$(CONFIG_PPC405EP)				+= ppc405ep.o
diff -upNr linux-2.6.27-rc4-orig/arch/powerpc/platforms/40x/ppc405ep.c 
linux-2.6.27-rc4/arch/powerpc/platforms/40x/ppc405ep.c
--- linux-2.6.27-rc4-orig/arch/powerpc/platforms/40x/ppc405ep.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.27-rc4/arch/powerpc/platforms/40x/ppc405ep.c	2008-08-21 09:35:45.728701197 +0200
@@ -0,0 +1,58 @@
+/*
+ * Powerpc 405EP board setup. Not aimed at any particular board.
+ *
+ * Copyright(c) 2008 Markus Brunner <super.firetwister@googlemail.com>
+ *
+ * Based on the Walnut code by
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright 2007 IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ppc4xx.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+#include <asm/uic.h>
+
+
+static __initdata struct of_device_id ppc405ep_of_bus[] = {
+	{ .compatible = "ibm,plb3", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init ppc405ep_device_probe(void)
+{
+	of_platform_bus_probe(NULL, ppc405ep_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(ppc405ep, ppc405ep_device_probe);
+
+static int __init ppc405ep_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(root, "company,ppc405ep"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(ppc405ep) {
+	.name 				= "ppc405ep",
+	.probe 				= ppc405ep_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc4xx_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
