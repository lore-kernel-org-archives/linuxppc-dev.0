Return-Path: <niklaus@ngiger.dyndns.org>
Received: from viefep11-int.chello.at (viefep11-int.chello.at [62.179.121.31])
	by ozlabs.org (Postfix) with ESMTP id 73EC7B7B7B
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Oct 2009 06:48:04 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/40x: Cleanups for HCU4 board
Date: Fri,  9 Oct 2009 21:47:38 +0200
Message-Id: <1255117658-3889-1-git-send-email-niklaus.giger@member.fsf.org>
Cc: niklaus.giger@netstal.com, Niklaus Giger <niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- hcu4.dts: Added definitions for 2 CAN (Intel 82527)
- hcu4.c: Some code for CPLD (special HW clock) and 2 CAN (Intel 82527)

Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 arch/powerpc/boot/dts/hcu4.dts    |  193 ++++++++++++++++++++++---------------
 arch/powerpc/platforms/40x/hcu4.c |   87 +++++++++++++++++
 2 files changed, 200 insertions(+), 80 deletions(-)

diff --git a/arch/powerpc/boot/dts/hcu4.dts b/arch/powerpc/boot/dts/hcu4.dts
index 7988598..64ad122 100644
--- a/arch/powerpc/boot/dts/hcu4.dts
+++ b/arch/powerpc/boot/dts/hcu4.dts
@@ -1,164 +1,197 @@
 /*
-* Device Tree Source for Netstal Maschinen HCU4
-* based on the IBM Walnut
-*
-* Copyright 2008
-* Niklaus Giger <niklaus.giger@member.fsf.org>
-*
-* Copyright 2007 IBM Corp.
-* Josh Boyer <jwboyer@linux.vnet.ibm.com>
-*
-* This file is licensed under the terms of the GNU General Public
-* License version 2.  This program is licensed "as is" without
-* any warranty of any kind, whether express or implied.
-*/
+ * Device Tree Source for Netstal Maschinen HCU4
+ * based on the IBM Walnut
+ *
+ * Copyright 2008-2009
+ * Niklaus Giger <niklaus.giger@member.fsf.org>
+ *
+ * Copyright 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
 
 /dts-v1/;
 
 / {
-	#address-cells = <0x1>;
-	#size-cells = <0x1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "netstal,hcu4";
 	compatible = "netstal,hcu4";
-	dcr-parent = <0x1>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
-		ethernet0 = "/plb/opb/ethernet@ef600800";
-		serial0 = "/plb/opb/serial@ef600300";
+		ethernet0 = &EMAC;
+		serial0 = &UART0;
 	};
 
 	cpus {
-		#address-cells = <0x1>;
-		#size-cells = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,405GPr";
-			reg = <0x0>;
-			clock-frequency = <0>;		/* Filled in by U-Boot */
-			timebase-frequency = <0x0>;	/* Filled in by U-Boot */
-			i-cache-line-size = <0x20>;
-			d-cache-line-size = <0x20>;
-			i-cache-size = <0x4000>;
-			d-cache-size = <0x4000>;
+			reg = <0x00000000>;
+			clock-frequency = <0>;	  /* Filled in by U-Boot */
+			timebase-frequency = <0>; /* Filled in by U-Boot */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>;
+			d-cache-size = <16384>;
 			dcr-controller;
 			dcr-access-method = "native";
-			linux,phandle = <0x1>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <0x0 0x0>;	/* Filled in by U-Boot */
+		reg = <0x00000000 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller {
 		compatible = "ibm,uic";
 		interrupt-controller;
-		cell-index = <0x0>;
-		dcr-reg = <0xc0 0x9>;
-		#address-cells = <0x0>;
-		#size-cells = <0x0>;
-		#interrupt-cells = <0x2>;
-		linux,phandle = <0x2>;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
 	};
 
 	plb {
 		compatible = "ibm,plb3";
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		ranges;
-		clock-frequency = <0x0>;	/* Filled in by U-Boot */
+		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-405gp";
-			dcr-reg = <0x10 0x2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL: mcmal {
 			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
-			dcr-reg = <0x180 0x62>;
-			num-tx-chans = <0x1>;
-			num-rx-chans = <0x1>;
-			interrupt-parent = <0x2>;
-			interrupts = <0xb 0x4 0xc 0x4 0xa 0x4 0xd 0x4 0xe 0x4>;
-			linux,phandle = <0x3>;
+			dcr-reg = <0x180 0x062>;
+			num-tx-chans = <1>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <
+				0xb 0x4 /* TXEOB */
+				0xc 0x4 /* RXEOB */
+				0xa 0x4 /* SERR */
+				0xd 0x4 /* TXDE */
+				0xe 0x4 /* RXDE */>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-405gp", "ibm,opb";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			ranges = <0xef600000 0xef600000 0xa00000>;
-			dcr-reg = <0xa0 0x5>;
-			clock-frequency = <0x0>;	/* Filled in by U-Boot */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xef600000 0xef600000 0x00a00000>;
+			dcr-reg = <0x0a0 0x005>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			UART0: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <0xef600300 0x8>;
+				reg = <0xef600300 0x00000008>;
 				virtual-reg = <0xef600300>;
-				clock-frequency = <0x0>;/* Filled in by U-Boot */
-				current-speed = <0>;	/* Filled in by U-Boot */
-				interrupt-parent = <0x2>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				current-speed = <0>;   /* Filled in by U-Boot */
+				interrupt-parent = <&UIC0>;
 				interrupts = <0x0 0x4>;
 			};
 
 			IIC: i2c@ef600500 {
 				compatible = "ibm,iic-405gp", "ibm,iic";
-				reg = <0xef600500 0x11>;
-				interrupt-parent = <0x2>;
+				reg = <0xef600500 0x00000011>;
+				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
 			};
 
 			GPIO: gpio@ef600700 {
 				compatible = "ibm,gpio-405gp";
-				reg = <0xef600700 0x20>;
+				reg = <0xef600700 0x00000020>;
 			};
 
 			EMAC: ethernet@ef600800 {
 				device_type = "network";
 				compatible = "ibm,emac-405gp", "ibm,emac";
-				interrupt-parent = <0x2>;
-				interrupts = <0xf 0x4 0x9 0x4>;
-				local-mac-address = [00 00 00 00 00 00];
-				reg = <0xef600800 0x70>;
-				mal-device = <0x3>;
-				mal-tx-channel = <0x0>;
-				mal-rx-channel = <0x0>;
-				cell-index = <0x0>;
-				max-frame-size = <0x5dc>;
-				rx-fifo-size = <0x1000>;
-				tx-fifo-size = <0x800>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <
+					0xf 0x4 /* Ethernet */
+					0x9 0x4 /* Ethernet Wake Up */>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				reg = <0xef600800 0x00000070>;
+				mal-device = <&MAL>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <0x1>;
+				phy-map = <0x00000001>;
 			};
+
+			CPLD: cpld@0x7d000000 {
+				reg = <0x7c000000 0x00000004>;
+				interval = "1000";
+				device_type = "cpld";
+				interrupts = <25 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
+				interrupt-parent = <&UIC0>;
+			};
+
+			CAN1: can@0x0x78000000 {
+				reg = <0x78000000 0x00000100>;
+				device_type = "can1";
+				interrupts = <19 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
+				compatible = "intel,82527";
+				interrupt-parent = <&UIC0>;
+			};
+
+			CAN2: can@0x0x78000004 {
+				reg = <0x78000100 0x00000100>;
+				device_type = "can2";
+				compatible = "intel,82527";
+				interrupts = <20 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
+				interrupt-parent = <&UIC0>;
+			};
+
 		};
 
 		EBC0: ebc {
 			compatible = "ibm,ebc-405gp", "ibm,ebc";
-			dcr-reg = <0x12 0x2>;
-			#address-cells = <0x2>;
-			#size-cells = <0x1>;
-			clock-frequency = <0x0>;	/* Filled in by U-Boot */
+			dcr-reg = <0x012 0x002>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			/* The ranges property is supplied by the bootwrapper
+			 * and is based on the firmware's configuration of the
+			 * EBC bridge
+			 */
+			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			sram@0,0 {
-				reg = <0x0 0x0 0x80000>;
+				reg = <0x00000000 0x00000000 0x00080000>;
 			};
 
 			flash@0,80000 {
 				compatible = "jedec-flash";
-				bank-width = <0x1>;
-				reg = <0x0 0x80000 0x80000>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-
+				bank-width = <1>;
+				reg = <0x00000000 0x00080000 0x00080000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
 				partition@0 {
 					label = "OpenBIOS";
-					reg = <0x0 0x80000>;
+					reg = <0x00000000 0x00080000>;
 					read-only;
 				};
 			};
+
 		};
 	};
 
diff --git a/arch/powerpc/platforms/40x/hcu4.c b/arch/powerpc/platforms/40x/hcu4.c
index 60b2afe..cd31c53 100644
--- a/arch/powerpc/platforms/40x/hcu4.c
+++ b/arch/powerpc/platforms/40x/hcu4.c
@@ -4,6 +4,10 @@
  * code by Gary Thomas, Cort Dougan <cort@fsmlabs.com>, and Dan Malek
  * <dan@net4x.com>.
  *
+ * HCU4 board specific routines
+ *
+ * Copyright (c) 2009 Niklaus Giger <niklaus.giger@member.fsf.org>
+ *
  * Copyright(c) 1999-2000 Grant Erickson <grant@lcse.umn.edu>
  *
  * Rewritten and ported to the merged powerpc tree:
@@ -17,6 +21,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/of_platform.h>
 
 #include <asm/machdep.h>
@@ -26,6 +31,24 @@
 #include <asm/uic.h>
 #include <asm/ppc4xx.h>
 
+#define MACH_CHIP_SELECT_BASE			0x7C000000
+#define HCU_TICK_CONTROL_REGISTER_ADDRESS (MACH_CHIP_SELECT_BASE + 0x1000000)
+
+/* Bits fuer HCU3/4 Tick-Status- und Control-Register */
+#define TICK_INT_ENABLE		0x01
+#define TICK_INT_RESET		0x02
+#define TICK_INT_PENDING	0x04
+#define TICK_START		0x08
+
+#define TICK_INTERVAL_250_US	0x00
+#define TICK_INTERVAL_500_US	0x10
+#define TICK_INTERVAL_1000_US	0x20
+#define TICK_INTERVAL_2000_US	0x30
+
+#define debug(...)
+
+static u16 __iomem *tickAddr;
+
 static __initdata struct of_device_id hcu4_of_bus[] = {
 	{ .compatible = "ibm,plb3", },
 	{ .compatible = "ibm,opb", },
@@ -33,11 +56,75 @@ static __initdata struct of_device_id hcu4_of_bus[] = {
 	{},
 };
 
+static irqreturn_t cpld_interrupt(int irq, void *dev_id)
+{
+	/*
+	out_be16(tickAddr,
+		TICK_INT_ENABLE | TICK_INT_RESET | TICK_START |
+		TICK_INTERVAL_1000_US);
+		*/
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
+
 static int __init hcu4_device_probe(void)
 {
 	of_platform_bus_probe(NULL, hcu4_of_bus, NULL);
 	return 0;
 }
+
+static int __init hcu4_map_irq(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(root, "netstal,hcu4"))
+		return 0;
+
+	tickAddr = ioremap(HCU_TICK_CONTROL_REGISTER_ADDRESS, 0x100);
+	printk(KERN_INFO "%s: tickAddr is at %p from 0x%x\n", __func__,
+		tickAddr, HCU_TICK_CONTROL_REGISTER_ADDRESS);
+	map_one_irq("cpld", cpld_interrupt);
+	map_one_irq("can1", can1_interrupt);
+	map_one_irq("can2", can2_interrupt);
+	return 1;
+}
+machine_device_initcall(hcu4, hcu4_map_irq);
 machine_device_initcall(hcu4, hcu4_device_probe);
 
 static int __init hcu4_probe(void)
-- 
1.6.3.3
