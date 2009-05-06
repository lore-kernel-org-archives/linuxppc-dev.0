Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 693C8DF87A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:21:06 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/04] ARIA: add device tree source file
Date: Wed,  6 May 2009 22:20:59 +0200
Message-Id: <1241641262-5202-3-git-send-email-wd@denx.de>
In-Reply-To: <1241641262-5202-1-git-send-email-wd@denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
Cc: Andrea Scian <andrea.scian@dave.eu>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ARIA is a MPC5121 based COM Express module by Dave/DENX.

Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/boot/dts/aria.dts |  410 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 410 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/aria.dts

diff --git a/arch/powerpc/boot/dts/aria.dts b/arch/powerpc/boot/dts/aria.dts
new file mode 100644
index 0000000..6c6b5e4
--- /dev/null
+++ b/arch/powerpc/boot/dts/aria.dts
@@ -0,0 +1,407 @@
+/*
+ * Aria Device Tree Source
+ *
+ * Copyright 2009 Dave Srl www.dave.eu
+ * Copyright 2009 Wolfgang Denk <wd@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "aria";
+	compatible = "davedenx,aria";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+
+		pci = &pci;
+	};
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
+			timebase-frequency = <49500000>;// 49.5 MHz (csb/4)
+			//bus-frequency = <198000000>;	// 198 MHz csb bus
+			//clock-frequency = <396000000>;	// 396 MHz ppc core
+			bus-frequency = <158000000>;
+			clock-frequency = <316000000>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	mbx@20000000 {
+		device_type = "mbx";
+		compatible = "fsl,mpc5121-mbx";
+		reg = <0x20000000 0x4000>;
+		interrupts = <66 0x8>;
+		interrupt-parent = < &ipic >;
+	};
+
+	sram@30000000 {
+		compatible = "fsl,mpc5121-sram";
+		reg = <0x30000000 0x20000>;		// 128K at 0x30000000
+	};
+
+	nfc@40000000 {
+		//compatible = "fsl,mpc5121rev2-nfc";
+		compatible = "fsl,mpc5121-nfc";
+		reg = <0x40000000 0x100000>;	// 1M at 0x40000000
+		interrupts = <6 8>;
+		interrupt-parent = < &ipic >;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		write-size = <2048>;
+		spare-size = <64>;
+		chips = <1>;
+		nand@0 {
+			label = "nand";
+			reg = <0x00000000 0x08000000>; 	// 128 MB
+		};
+	};
+
+	localbus@80000020 {
+		compatible = "fsl,mpc5121-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x80000020 0x40>;
+
+		ranges = <0x0 0x0 0xF8000000 0x08000000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x8000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <2>;
+			device-width = <2>;
+			partition@0 {
+				label = "user";
+				reg = <0x00000000 0x07000000>;  // 112 MiB for user data
+			};
+			partition@07000000 {
+				label = "rootfs";
+				reg = <0x07000000 0x00c00000>;	// 12 MiB for root file system
+			};
+			partition@07c00000 {
+				label = "kernel";
+				reg = <0x07c00000 0x00300000>;  // 3 MiB for kernel
+			};
+			partition@07f00000 {
+				label = "u-boot";
+				reg = <0x07f00000 0x000c0000>;  // 768 KiB for u-boot w/ env
+				read-only;
+			};
+			partition@07fc0000 {
+				label = "device-tree";
+				reg = <0x07fc0000 0x00040000>;  // 256 KiB for device tree
+			};
+		};
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		device_type = "soc";
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
+		rtc@a00 {	// Real time clock
+			compatible = "fsl,mpc5121-rtc";
+			reg = <0xa00 0x100>;
+			interrupts = <79 0x8 80 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		reset@e00 {	// Reset module
+			compatible = "fsl,mpc5121-reset";
+			reg = <0xe00 0x100>;
+		};
+
+		clock@f00 {	// Clock control
+			compatible = "fsl,mpc5121rev2-clock", "fsl,mpc5121-clock";
+			reg = <0xf00 0x100>;
+		};
+
+		pmc@1000{  //Power Management Controller
+			compatible = "fsl,mpc5121-pmc";
+			reg = <0x1000 0x100>;
+			interrupts = <83 0x2>;
+			interrupt-parent = < &ipic >;
+		};
+
+		gpio@1100 {
+			compatible = "fsl,mpc5121-gpio";
+			reg = <0x1100 0x100>;
+			interrupts = <78 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		mscan@1300 {
+			compatible = "fsl,mpc5121-mscan";
+			cell-index = <0>;
+			interrupts = <12 0x8>;
+			interrupt-parent = < &ipic >;
+			reg = <0x1300 0x80>;
+		};
+
+		mscan@1380 {
+			compatible = "fsl,mpc5121-mscan";
+			cell-index = <1>;
+			interrupts = <13 0x8>;
+			interrupt-parent = < &ipic >;
+			reg = <0x1380 0x80>;
+		};
+
+		// this is here for reference only
+//		sdhc@1500 {
+//			compatible = "fsl,mpc5121-sdhc";
+//			interrupts = <8 0x8>;
+//			interrupt-parent = < &ipic >;
+//			reg = <0x1500 0x100>;
+//		};
+
+		i2c@1700 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			cell-index = <0>;
+			reg = <0x1700 0x20>;
+			interrupts = <9 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+
+			rtc@68 {
+				compatible = "stm,m41t80";
+				reg = <0x68>;
+			};
+		};
+
+		i2c@1720 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			cell-index = <1>;
+			reg = <0x1720 0x20>;
+			interrupts = <10 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1740 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			cell-index = <2>;
+			reg = <0x1740 0x20>;
+			interrupts = <11 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl,mpc5121-i2c-ctrl";
+			reg = <0x1760 0x8>;
+		};
+
+		axe@2000 {
+			compatible = "fsl,mpc5121-axe";
+			reg = <0x2000 0x100>;
+			interrupts = <42 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		diu@2100 {
+			device_type = "display";
+			compatible = "fsl-diu";
+			reg = <0x2100 0x100>;
+			interrupts = <64 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		mdio@2800 {
+			device_type = "mdio";
+			compatible = "fsl,mpc5121-fec-mdio";
+			reg = <0x2800 0x800>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy: ethernet-phy@0 {
+				reg = <23>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet: ethernet@2800 {
+			device_type = "network";
+			compatible = "fsl,mpc5121-fec";
+			reg = <0x2800 0x800>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <4 0x8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy >;
+			fsl,align-tx-packets = <4>;
+		};
+
+		// 5121e has two dr usb modules
+		// We use only USB0
+
+		// USB1 using external ULPI PHY
+		//usb@3000 {
+		//	device_type = "usb";
+		//	compatible = "fsl-usb2-dr";
+		//	reg = <0x3000 0x1000>;
+		//	#address-cells = <1>;
+		//	#size-cells = <0>;
+		//	interrupt-parent = < &ipic >;
+		//	interrupts = <43 0x8>;
+		//	dr_mode = "otg";
+		//	phy_type = "ulpi";
+		//};
+
+		// USB0 using internal UTMI PHY
+		usb@4000 {
+			device_type = "usb";
+			compatible = "fsl-usb2-dr";
+			reg = <0x4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			dr_mode = "host";
+			phy_type = "utmi_wide";
+			//port0;
+		};
+
+		// IO control
+		ioctl@a000 {
+			compatible = "fsl,mpc5121-ioctl";
+			reg = <0xA000 0x1000>;
+		};
+
+		pata@10200 {
+			compatible = "fsl,mpc5121-pata";
+			reg = <0x10200 0x100>;
+			interrupts = <5 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		// 512x PSCs are not 52xx PSCs compatible
+		// PSC3 serial port A aka ttyPSC0
+		serial0: serial@11300 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <0>;
+			cell-index = <3>;
+			reg = <0x11300 0x100>;
+			interrupts = <40 0x8 71 0x8>;
+			interrupt-parent = < &ipic >;
+			rx-fifo-size = <16>;
+			tx-fifo-size = <16>;
+			nodcd;
+		};
+
+		// PSC4 serial port B aka ttyPSC1
+		serial1: serial@11400 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <1>;
+			cell-index = <4>;
+			reg = <0x11400 0x100>;
+			interrupts = <40 0x8 32 0x8>;
+			interrupt-parent = < &ipic >;
+			rx-fifo-size = <16>;
+			tx-fifo-size = <16>;
+			nodcd;
+		};
+
+		// PSC5 in ac97 mode
+		ac97@11500 {
+			device_type = "sound";
+			compatible = "fsl,mpc5121-psc-ac97", "fsl,mpc5121-psc";
+			cell-index = <5>;
+			reg = <0x11500 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl,mode = "ac97-slave";
+			rx-fifo-size = <384>;
+			tx-fifo-size = <384>;
+		};
+
+		pscfifo@11f00 {
+			compatible = "fsl,mpc5121-psc-fifo";
+			reg = <0x11f00 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		dma@14000 {
+			compatible = "mpc512x-dma";
+			reg = <0x14000 0x1800>;
+			interrupts = <65 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+	};
+
+	pci: pci@80008500 {
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				>;
+		interrupt-parent = < &ipic >;
+		interrupts = <1 0x8>;
+		bus-range = <0 0>;
+		ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0x84000000 0x0 0x01000000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x80008500 0x100>;
+		compatible = "fsl,mpc5121-pci";
+		device_type = "pci";
+	};
+};
-- 
1.6.0.6
