Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: P1020 DTS : re-organize dts files
Date: Thu, 7 Apr 2011 11:55:34 +0530
Message-ID: <1302157534-16746-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, B11780@freescale.com,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Creates P1020si.dtsi, containing information for the P1020 SoC. Modifies dts
files for P1020 based systems to use dtsi file.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Acked-by: Kumar Gala <kumar.gala@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)

 Please see mpc5200b.dtsi for reference.
 
 Tested on P1020RDB

 arch/powerpc/boot/dts/p1020rdb.dts |  315 +-----------------------------
 arch/powerpc/boot/dts/p1020si.dtsi |  378 ++++++++++++++++++++++++++++++++++++
 2 files changed, 380 insertions(+), 313 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020si.dtsi

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index e0668f8..8ae5ddf 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -9,12 +9,10 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "p1020si.dtsi"
+
 / {
-	model = "fsl,P1020";
 	compatible = "fsl,P1020RDB";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
 		serial0 = &serial0;
@@ -26,34 +24,11 @@
 		pci1 = &pci1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P1020@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,P1020@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
-		};
-	};
-
 	memory {
 		device_type = "memory";
 	};
 
 	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
-		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
@@ -165,88 +140,14 @@
 	};
 
 	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p1020-immr", "simple-bus";
-		ranges = <0x0  0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p1020-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <16 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p1020-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
-
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
 		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
 		spi@7000 {
-			cell-index = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			mode = "cpu";
 
 			fsl_m25p80@0 {
 				#address-cells = <1>;
@@ -294,66 +195,7 @@
 			};
 		};
 
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p1020-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x40000>; // L2,256K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
 		mdio@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-mdio";
-			reg = <0x24000 0x1000 0xb0030 0x4>;
 
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
@@ -369,10 +211,6 @@
 		};
 
 		mdio@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,etsec2-tbi";
-			reg = <0x25000 0x1000 0xb1030 0x4>;
 
 			tbi0: tbi-phy@11 {
 				reg = <0x11>;
@@ -381,97 +219,25 @@
 		};
 
 		enet0: ethernet@b0000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
 			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
 
-			queue-group@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb0000 0x1000>;
-				interrupts = <29 2 30 2 34 2>;
-			};
-
-			queue-group@1 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb4000 0x1000>;
-				interrupts = <17 2 18 2 24 2>;
-			};
 		};
 
 		enet1: ethernet@b1000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 			tbi-handle = <&tbi0>;
 			phy-connection-type = "sgmii";
 
-			queue-group@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb1000 0x1000>;
-				interrupts = <35 2 36 2 40 2>;
-			};
-
-			queue-group@1 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb5000 0x1000>;
-				interrupts = <51 2 52 2 67 2>;
-			};
 		};
 
 		enet2: ethernet@b2000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
 
-			queue-group@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb2000 0x1000>;
-				interrupts = <31 2 32 2 33 2>;
-			};
-
-			queue-group@1 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xb6000 0x1000>;
-				interrupts = <25 2 26 2 27 2>;
-			};
 		};
 
 		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
 			phy_type = "ulpi";
 		};
 
@@ -481,82 +247,15 @@
 		   it enables USB2. OTOH, U-Boot does create a new node
 		   when there isn't any. So, just comment it out.
 		usb@23000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x23000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <46 0x2>;
 			phy_type = "ulpi";
 		};
 		*/
 
-		sdhci@2e000 {
-			compatible = "fsl,p1020-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xbfe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,p1020-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p1020-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
 	};
 
 	pci0: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
@@ -573,18 +272,8 @@
 	};
 
 	pci1: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
new file mode 100644
index 0000000..7b87d00
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -0,0 +1,378 @@
+/*
+ * P1020si Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "fsl,P1020";
+	compatible = "fsl,P1020";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1020@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1020@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	localbus@ffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xffe05000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+	};
+
+	soc@ffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,p1020-immr", "simple-bus";
+		ranges = <0x0  0x0 0xffe00000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,p1020-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <16 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,p1020-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		spi@7000 {
+			cell-index = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+			mode = "cpu";
+		};
+
+		gpio: gpio-controller@f000 {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8572-gpio";
+			reg = <0xf000 0x100>;
+			interrupts = <47 0x2>;
+			interrupt-parent = <&mpic>;
+			gpio-controller;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,p1020-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x40000>; // L2,256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		mdio@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-mdio";
+			reg = <0x24000 0x1000 0xb0030 0x4>;
+
+		};
+
+		mdio@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-tbi";
+			reg = <0x25000 0x1000 0xb1030 0x4>;
+
+		};
+
+		enet0: ethernet@b0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb0000 0x1000>;
+				interrupts = <29 2 30 2 34 2>;
+			};
+
+			queue-group@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb4000 0x1000>;
+				interrupts = <17 2 18 2 24 2>;
+			};
+		};
+
+		enet1: ethernet@b1000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb1000 0x1000>;
+				interrupts = <35 2 36 2 40 2>;
+			};
+
+			queue-group@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb5000 0x1000>;
+				interrupts = <51 2 52 2 67 2>;
+			};
+		};
+
+		enet2: ethernet@b2000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb2000 0x1000>;
+				interrupts = <31 2 32 2 33 2>;
+			};
+
+			queue-group@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb6000 0x1000>;
+				interrupts = <25 2 26 2 27 2>;
+			};
+		};
+
+		usb@22000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-usb2-dr";
+			reg = <0x22000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <28 0x2>;
+		};
+
+		/* USB2 is shared with localbus, so it must be disabled
+		   by default. We can't put 'status = "disabled";' here
+		   since U-Boot doesn't clear the status property when
+		   it enables USB2. OTOH, U-Boot does create a new node
+		   when there isn't any. So, just comment it out.
+		usb@23000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-usb2-dr";
+			reg = <0x23000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <46 0x2>;
+			phy_type = "ulpi";
+		};
+		*/
+
+		sdhci@2e000 {
+			compatible = "fsl,p1020-esdhc", "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x2>;
+			interrupt-parent = <&mpic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
+				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xbfe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		msi@41600 {
+			compatible = "fsl,p1020-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,p1020-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe09000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+	};
+
+	pci1: pcie@ffe0a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe0a000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+	};
+};
-- 
1.7.3
