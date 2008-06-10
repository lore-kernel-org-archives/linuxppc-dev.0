Return-Path: <david@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 933C6DDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 05:56:20 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id A1C0029EC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jun 2008 21:29:41 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15387-06 for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jun 2008 21:27:59 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id B68EA29EBB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jun 2008 21:27:57 +0200 (CEST)
Resent-Message-ID: <200806101842.36755.david@protonic.nl>
From: David Jander <david@protonic.nl>
Date: Tue, 10 Jun 2008 18:29:05 +0200
Subject: [PATCH] prtlvt board support (MPC5121e) added
To: Undisclosed.Recipients: ;
Message-Id: <200806101842.36755.david@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: David Jander <david@protonic.nl>
---
 arch/powerpc/boot/dts/prtlvt.dts     |  280 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/512x/Kconfig  |    9 +
 arch/powerpc/platforms/512x/Makefile |    1 +
 arch/powerpc/platforms/512x/prtlvt.c |  105 +++++++++++++
 4 files changed, 395 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/prtlvt.dts
 create mode 100644 arch/powerpc/platforms/512x/prtlvt.c

diff --git a/arch/powerpc/boot/dts/prtlvt.dts b/arch/powerpc/boot/dts/prtlvt.dts
new file mode 100644
index 0000000..238dc89
--- /dev/null
+++ b/arch/powerpc/boot/dts/prtlvt.dts
@@ -0,0 +1,280 @@
+/*
+ * MPC5121E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
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
+	compatible = "fsl,prtlvt";
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
+	localbus@80000020 {
+		compatible = "fsl,prtlvt-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x80000020 0x40>;
+
+		ranges = <0x0 0x0 0xfe000000 0x02000000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x4000000>;
+			bank-width = <4>;
+			device-width = <1>;
+		};
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
+		// PSC0 serial port A aka ttyPSC0
+		serial@11000 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <0>;
+			cell-index = <0>;
+			reg = <0x11000 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC1 serial port A aka ttyPSC1
+		serial@11100 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <1>;
+			cell-index = <1>;
+			reg = <0x11100 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC2 serial port A aka ttyPSC2
+		serial@11200 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <2>;
+			cell-index = <2>;
+			reg = <0x11200 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+		
+		// PSC3 serial port A aka ttyPSC3
+		serial@11300 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			// Logical port assignment needed until driver
+			// learns to use aliases
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
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x1700 0x20>;
+			interrupts = <0x9 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1720 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x1720 0x20>;
+			interrupts = <0xa 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1740 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x1740 0x20>;
+			interrupts = <0xb 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl-512x-i2c-ctrl";
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
+			compatible = "fsl-diu";
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
+		// 5121e has two dr usb modules
+		// mpc5121_ads only uses port0
+
+		// port1 using extern ULPI PHY
+		usb@3000 {
+			device_type = "usb";
+			compatible = "fsl-usb2-dr";
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
+			compatible = "fsl-usb2-dr";
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
+		// PSC4 in SPI mode (eg ADS touchscreen interface)
+		//spi@11400 {
+		//	device_type = "spi";
+		//	compatible = "mpc512x-psc-spi";
+		//	cell-index = <4>;
+		//	reg = <11400 100>;
+		//	interrupts = <20 8>;
+		//	interrupt-parent = < &ipic >;
+		//};
+
+		// PSC5 in ac97 mode
+		// ac97@11500 {
+		//	device_type = "sound";
+		//	compatible = "mpc512x-psc-ac97";
+		//	cell-index = <5>;
+		//	reg = <11500 100>;
+		//	interrupts = <21 8>;	// FIXME
+		//	interrupt-parent = < &ipic >;
+		//};
+
+		dma2@14000 {
+			compatible = "mpc512x-dma2";
+			reg = <0x14000 0x1800>;
+			interrupts = <0x41 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@20000 {
+			compatible = "mpc512x-sata";
+			reg = <0x20000 0x2000>;
+			interrupts = <0x2d 0x8 0x56 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4c0da0c..d8c72d6 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -17,3 +17,12 @@ config MPC5121_ADS
 	help
 	  This option enables support for the MPC5121E ADS board.
 	default n
+
+config PRTLVT
+	bool "Protonic LVT family of MPC5121 based boards"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select DEFAULT_UIMAGE
+	select PPC_MPC5121
+	help
+	  This option enables support for the Protonic LVT family (ZANMCU and VICVT2).
+	default n
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 232c89f..d0fe46e 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -2,3 +2,4 @@
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o
+obj-$(CONFIG_PRTLVT)		+= prtlvt.o
diff --git a/arch/powerpc/platforms/512x/prtlvt.c b/arch/powerpc/platforms/512x/prtlvt.c
new file mode 100644
index 0000000..225636b
--- /dev/null
+++ b/arch/powerpc/platforms/512x/prtlvt.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (c) 2008 Protonic Holland
+ *
+ * Author: David Jander <david@protonic.nl>, June 2008
+ * based on mpc5121_ads.c by John Rigby.
+ *
+ * Description:
+ * PRTLVT board support
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
+unsigned long mpc512x_find_ips_freq(struct device_node *node)
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
+ { .name = "soc", },
+ { .name = "localbus", },
+ {},
+};
+
+static void __init mpc5121_prtlvt_declare_of_platform_devices(void)
+{
+	/* Find every child of the SOC node and add it to of_platform */
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
+		printk(KERN_ERR __FILE__ ": "
+				"Error while probing of_platform bus\n");
+}
+
+static void __init mpc5121_prtlvt_init_IRQ(void)
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
+	* Initialize the default interrupt mapping priorities,
+	* in case the boot rom changed something on us.
+	*/
+	ipic_set_default_priority();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc5121_prtlvt_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,prtlvt");
+}
+
+define_machine(mpc5121_ads) {
+ .name			= "Protonic LVT",
+ .probe			= mpc5121_prtlvt_probe,
+ .init			= mpc5121_prtlvt_declare_of_platform_devices,
+ .init_IRQ		= mpc5121_prtlvt_init_IRQ,
+ .get_irq		= ipic_get_irq,
+ .calibrate_decr		= generic_calibrate_decr,
+};
-- 
1.5.4.3
