Return-Path: <david.jander@protonic.nl>
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Subject: [PATCH] Added support for PRTLVT based boards (MPC5121)
Date: Fri, 13 Jun 2008 10:49:03 +0200
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806131049.03765.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Made MPC5121_ADS board support generic:
 Renamed arch/powerpc/platforms/512x/mpc5121_ads.c and added list of supported
 boards.
 For both MPC5121 ADS or PRTLVT support, just select "MPC5121_GENERIC" and use
 the corresponding device-tree.

Signed-off-by: David Jander <david@protonic.nl>
---
 arch/powerpc/boot/dts/prtlvt.dts                   |  255 ++++++++++++++++++++
 arch/powerpc/platforms/512x/Kconfig                |   14 +-
 arch/powerpc/platforms/512x/Makefile               |    2 +-
 .../512x/{mpc5121_ads.c => mpc5121_generic.c}      |   38 ++-
 4 files changed, 290 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/prtlvt.dts
 rename arch/powerpc/platforms/512x/{mpc5121_ads.c => mpc5121_generic.c} (73%)

diff --git a/arch/powerpc/boot/dts/prtlvt.dts b/arch/powerpc/boot/dts/prtlvt.dts
new file mode 100644
index 0000000..aeb663b
--- /dev/null
+++ b/arch/powerpc/boot/dts/prtlvt.dts
@@ -0,0 +1,255 @@
+/*
+ * Device tree source for PRTLVT based boards, based on:
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
+	localbus@80000020 {
+		compatible = "prt,prtlvt-localbus", "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x80000020 0x40>;
+		ranges = <0x0 0x0 0xfe000000 0x02000000>;
+		flash@0,0 {
+			compatible = "amd,s29gl256n", "cfi-flash";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0 0x0 0x02000000>;
+			bank-width = <2>;
+		};
+	};
+	
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr", "simple-bus";
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
+		display@2100 {
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
+			compatible = "fsl,mpc5121-usb2-dr", "fsl-usb2-dr";
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
+			compatible = "fsl,mpc5121-usb2-dr", "fsl-usb2-dr";
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
+			compatible = "fsl,mpc5121-psc-i2s";
+			cell-index = <4>;
+			reg = <0x11400 0x100>;
+			interrupts = <0x20 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC5 in SPI mode for touchscreen
+		spi@11500 {
+			compatible = "fsl,mpc5121-psc-spi";
+			cell-index = <5>;
+			reg = <0x11500 0x100>;
+			interrupts = <0x21 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		// This dma controller is not compatible with fsldma
+		dma@14000 {
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
index 4c0da0c..57b3912 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -2,18 +2,20 @@ config PPC_MPC512x
 	bool
 	select FSL_SOC
 	select IPIC
-	default n
 
 config PPC_MPC5121
 	bool
 	select PPC_MPC512x
-	default n
 
-config MPC5121_ADS
-	bool "Freescale MPC5121E ADS"
+config MPC5121_GENERIC
+	bool "Generic support for simple MPC5121 based boards"
 	depends on PPC_MULTIPLATFORM && PPC32
 	select DEFAULT_UIMAGE
 	select PPC_MPC5121
 	help
-	  This option enables support for the MPC5121E ADS board.
-	default n
+	  This option enables support for a simple MPC5121 based boards which
+	  do not need a custom platform specific setup.
+
+	  Boards that are compatible with this generic platform support
+	  are: Freescale MPC5121 ADS and Protonic LVT based boards (ZANMCU
+	  and VICVT2).
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
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
similarity index 73%
rename from arch/powerpc/platforms/512x/mpc5121_ads.c
rename to arch/powerpc/platforms/512x/mpc5121_generic.c
index 50bd3a3..824ddbb 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -4,7 +4,7 @@
  * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
  *
  * Description:
- * MPC5121 ADS board setup
+ * MPC5121 SoC setup
  *
  * This is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{},
 };
 
-static void __init mpc5121_ads_declare_of_platform_devices(void)
+static void __init mpc5121_generic_declare_of_platform_devices(void)
 {
 	/* Find every child of the SOC node and add it to of_platform */
 	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
@@ -66,7 +66,7 @@ static void __init mpc5121_ads_declare_of_platform_devices(void)
 			"Error while probing of_platform bus\n");
 }
 
-static void __init mpc5121_ads_init_IRQ(void)
+static void __init mpc5121_generic_init_IRQ(void)
 {
 	struct device_node *np;
 
@@ -84,21 +84,35 @@ static void __init mpc5121_ads_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+/* list of the supported boards */
+static char *board[] __initdata = {
+	"fsl,mpc5121ads",
+	"prt,prtlvt",
+	NULL
+};
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-static int __init mpc5121_ads_probe(void)
+static int __init mpc5121_generic_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
+	unsigned long node = of_get_flat_dt_root();
+	int i = 0;
 
-	return of_flat_dt_is_compatible(root, "fsl,mpc5121ads");
+	while (board[i]) {
+		if (of_flat_dt_is_compatible(node, board[i]))
+			break;
+		i++;
+	}
+	
+	return (board[i] != NULL);
 }
 
-define_machine(mpc5121_ads) {
-	.name			= "MPC5121 ADS",
-	.probe			= mpc5121_ads_probe,
-	.init			= mpc5121_ads_declare_of_platform_devices,
-	.init_IRQ		= mpc5121_ads_init_IRQ,
+define_machine(mpc5121_generic) {
+	.name			= "MPC5121 generic",
+	.probe			= mpc5121_generic_probe,
+	.init			= mpc5121_generic_declare_of_platform_devices,
+	.init_IRQ		= mpc5121_generic_init_IRQ,
 	.get_irq		= ipic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
+	.calibrate_decr	= generic_calibrate_decr,
 };
-- 
1.5.4.3
