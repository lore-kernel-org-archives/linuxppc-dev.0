Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 42C3BDDF20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 19:44:47 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 1FA7829EC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:43:08 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07022-01 for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:41:29 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id A3C9129EBB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:41:29 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
Date: Wed, 11 Jun 2008 11:43:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806111143.08905.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Made MPC5121_ADS board support generic

Signed-off-by: David Jander <david@protonic.nl>
---
 arch/powerpc/boot/dts/prtlvt.dts              |  267 +++++++++++++++++++++++++
 arch/powerpc/platforms/512x/Kconfig           |   15 ++
 arch/powerpc/platforms/512x/Makefile          |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c     |  104 ----------
 arch/powerpc/platforms/512x/mpc5121_generic.c |  105 ++++++++++
 5 files changed, 388 insertions(+), 105 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/prtlvt.dts
 delete mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.c
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_generic.c

diff --git a/arch/powerpc/boot/dts/prtlvt.dts b/arch/powerpc/boot/dts/prtlvt.dts
new file mode 100644
index 0000000..93d2fa2
--- /dev/null
+++ b/arch/powerpc/boot/dts/prtlvt.dts
@@ -0,0 +1,267 @@
+/*
+ * Device tree source for PRTLVT based boards, base on:
+ * MPC5121E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ * Copyright 2008 Protonic Holland
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+ /* compile with: ./dtc -p 10240 -R 20 -I dts -o prtlvt.dtb -O dtb -b 0 dts/prtlvt.dts */
+
+/dts-v1/;
+
+/ {
+	model = "prtlvt";
+	compatible = "prt,prtlvt";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5121@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <50000000>;// 50 MHz (csb/4)
+			bus-frequency = <200000000>;	// 200 MHz csb bus
+			clock-frequency = <400000000>;	// 400 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	flash@fe000000 {
+		device_type = "rom";
+		compatible = "direct-mapped";
+		probe-type = "CFI";
+		reg = <0xfe000000 0x02000000>;
+		bank-width = <2>;
+		partitions = <0x00000000 0x01800000   // filesystem
+		              0x01800000 0x00200000   // config0
+		              0x01a00000 0x00200000   // config1
+		              0x01c00000 0x002e0000   // kernel
+		              0x01ee0000 0x00020000   // one sector for device tree
+		              0x01f00000 0x00100000>; // u-boot
+		partition-names = "filesystem", "config0", "config1","kernel", "device-tree", "u-boot";
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0x0 0x80000000 0x400000>;
+		reg = <0x80000000 0x400000>;
+		bus-frequency = <66000000>;	// 66 MHz ips bus
+
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0xc00 0x100>;
+		};
+
+		// 512x PSCs are not 52xx PSCs compatible
+		// PSC0 serial port aka ttyPSC0
+		serial@11000 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			port-number = <0>;
+			cell-index = <0>;
+			reg = <0x11000 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC1 serial port aka ttyPSC1
+		serial@11100 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			port-number = <1>;
+			cell-index = <1>;
+			reg = <0x11100 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC2 serial port aka ttyPSC2
+		serial@11200 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			port-number = <2>;
+			cell-index = <2>;
+			reg = <0x11200 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+		
+		// PSC3 serial port aka ttyPSC3
+		serial@11300 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			port-number = <3>;
+			cell-index = <3>;
+			reg = <0x11300 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		pscsfifo@11f00 {
+			compatible = "fsl,mpc5121-psc-fifo";
+			reg = <0x11f00 0x100>;
+			interrupts = <0x28 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		i2c@1700 {
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1700 0x20>;
+			interrupts = <0x9 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1720 {
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1720 0x20>;
+			interrupts = <0xa 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1740 {
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1740 0x20>;
+			interrupts = <0xb 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl,mpc5121-i2c-ctrl";
+			reg = <0x1760 0x8>;
+		};
+
+		//axe@2000 {
+		//	compatible = "mpc512x-axe";
+		//	reg = <2000 100>;
+		//	interrupts = <2a 8>;
+		//	interrupt-parent = < &ipic >;
+		//};
+
+		diu@2100 {
+			compatible = "fsl,mpc5121-diu", "fsl-diu";
+			reg = <0x2100 0x100>;
+			interrupts = <0x40 0x8>;
+			interrupt-parent = < &ipic >;
+			clk-name = "diu_clk";
+			clk-parent = "ips_clk";
+			clk-ctrl = <0x1 0x1f>; // sccr2 bit 31
+		};
+
+		mdio@2800 {
+			device_type = "mdio";
+			compatible = "fsl,mpc5121-fec-mdio";
+			reg = <0x2800 0x800>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy: ethernet-phy@0 {
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@2800 {
+			device_type = "network";
+			compatible = "fsl,mpc5121-fec";
+			reg = <0x2800 0x800>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x4 0x8 >;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy >;
+		};
+
+		// port1 using extern ULPI PHY
+		usb@3000 {
+			device_type = "usb";
+			compatible = "fsl,fsl-usb2-dr";
+			reg = <0x3000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <0x2c 0x8>;
+			dr_mode = "otg";
+			phy_type = "ulpi";
+			port1;
+		};
+
+		// port0 using internal UTMI PHY
+		usb@4000 {
+			device_type = "usb";
+			compatible = "fsl,fsl-usb2-dr";
+			reg = <0x4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <0x2b 0x8>;
+			dr_mode = "otg";
+			phy_type = "utmi";
+			port0;
+		};
+
+		// PSC4 in i2s mode
+		i2s@11500 {
+			device_type = "i2s";
+			compatible = "fsl,mpc5121-psc-i2s";
+			cell-index = <4>;
+			reg = <0x11400 0x100>;
+			interrupts = <0x20 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC5 in SPI mode for touchscreen
+		spi@11500 {
+			device_type = "spi";
+			compatible = "fsl,mpc5121-psc-spi";
+			cell-index = <5>;
+			reg = <0x11500 0x100>;
+			interrupts = <0x21 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		dma2@14000 {
+			compatible = "fsl,mpc5121-dma2";
+			reg = <0x14000 0x1800>;
+			interrupts = <0x41 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@20000 {
+			compatible = "fsl,mpc5121-sata";
+			reg = <0x20000 0x2000>;
+			interrupts = <0x2d 0x8 0x56 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4c0da0c..67707f2 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -9,11 +9,26 @@ config PPC_MPC5121
 	select PPC_MPC512x
 	default n
 
+config MPC5121_GENERIC
+	bool
+	default n
+
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
 	depends on PPC_MULTIPLATFORM && PPC32
 	select DEFAULT_UIMAGE
 	select PPC_MPC5121
+	select MPC5121_GENERIC
 	help
 	  This option enables support for the MPC5121E ADS board.
 	default n
+
+config PRTLVT
+	bool "Protonic LVT family of MPC5121 based boards"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select DEFAULT_UIMAGE
+	select PPC_MPC5121
+	select MPC5121_GENERIC
+	help
+	  This option enables support for the Protonic LVT family (ZANMCU and VICVT2).
+	default n
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 232c89f..9d40a2e 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
-obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o
+obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
deleted file mode 100644
index 50bd3a3..0000000
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
- *
- * Description:
- * MPC5121 ADS board setup
- *
- * This is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/of_platform.h>
-
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/prom.h>
-#include <asm/time.h>
-
-/**
- * 	mpc512x_find_ips_freq - Find the IPS bus frequency for a device
- * 	@node:	device node
- *
- * 	Returns IPS bus frequency, or 0 if the bus frequency cannot be found.
- */
-unsigned long
-mpc512x_find_ips_freq(struct device_node *node)
-{
-	struct device_node *np;
-	const unsigned int *p_ips_freq = NULL;
-
-	of_node_get(node);
-	while (node) {
-		p_ips_freq = of_get_property(node, "bus-frequency", NULL);
-		if (p_ips_freq)
-			break;
-
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
-	}
-	if (node)
-		of_node_put(node);
-
-	return p_ips_freq ? *p_ips_freq : 0;
-}
-EXPORT_SYMBOL(mpc512x_find_ips_freq);
-
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .name = "localbus", },
-	{},
-};
-
-static void __init mpc5121_ads_declare_of_platform_devices(void)
-{
-	/* Find every child of the SOC node and add it to of_platform */
-	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
-		printk(KERN_ERR __FILE__ ": "
-			"Error while probing of_platform bus\n");
-}
-
-static void __init mpc5121_ads_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-	of_node_put(np);
-
-	/*
-	 * Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init mpc5121_ads_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,mpc5121ads");
-}
-
-define_machine(mpc5121_ads) {
-	.name			= "MPC5121 ADS",
-	.probe			= mpc5121_ads_probe,
-	.init			= mpc5121_ads_declare_of_platform_devices,
-	.init_IRQ		= mpc5121_ads_init_IRQ,
-	.get_irq		= ipic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-};
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
new file mode 100644
index 0000000..602580b
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
+ *
+ * Description:
+ * MPC5121 SoC setup
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+/**
+ * 	mpc512x_find_ips_freq - Find the IPS bus frequency for a device
+ * 	@node:	device node
+ *
+ * 	Returns IPS bus frequency, or 0 if the bus frequency cannot be found.
+ */
+unsigned long
+mpc512x_find_ips_freq(struct device_node *node)
+{
+	struct device_node *np;
+	const unsigned int *p_ips_freq = NULL;
+
+	of_node_get(node);
+	while (node) {
+		p_ips_freq = of_get_property(node, "bus-frequency", NULL);
+		if (p_ips_freq)
+			break;
+
+		np = of_get_parent(node);
+		of_node_put(node);
+		node = np;
+	}
+	if (node)
+		of_node_put(node);
+
+	return p_ips_freq ? *p_ips_freq : 0;
+}
+EXPORT_SYMBOL(mpc512x_find_ips_freq);
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "localbus", },
+	{},
+};
+
+static void __init mpc5121_generic_declare_of_platform_devices(void)
+{
+	/* Find every child of the SOC node and add it to of_platform */
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
+		printk(KERN_ERR __FILE__ ": "
+			"Error while probing of_platform bus\n");
+}
+
+static void __init mpc5121_generic_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+	of_node_put(np);
+
+	/*
+	 * Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc5121_generic_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,mpc5121ads") ||
+			of_flat_dt_is_compatible(root, "prt,prtlvt");
+}
+
+define_machine(mpc5121_generic) {
+	.name			= "MPC5121 generic",
+	.probe			= mpc5121_generic_probe,
+	.init			= mpc5121_generic_declare_of_platform_devices,
+	.init_IRQ		= mpc5121_generic_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.calibrate_decr	= generic_calibrate_decr,
+};
-- 
1.5.4.3
