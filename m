Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E5C79B8124
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 05:01:23 +1000 (EST)
Date: Wed, 23 Sep 2009 23:01:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/83xx: Add power management support for
	MPC8315E-RDB boards
Message-ID: <20090923190122.GC19932@oksana.dev.rtsoft.ru>
References: <20090923190041.GA18944@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090923190041.GA18944@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add nodes for PMC and GTM controllers. GTM4 can be used as a wakeup
  source;

- Add fsl,magic-packet properties to eTSEC nodes, i.e. wake-on-lan
  support. Unlike MPC8313 processors, MPC8315 can resume from deep
  sleep upon magic packet reception;

- Add proper sleep = <> properties;

- DMA and PCI share a single clock soruce, so put them into "sleep
  nexus" node (the same we do for MPC8313E-RDB boards);

- I2C and Encryption core also share a single clock, so do the same:
  put i2c and crypto nodes into sleep-nexus.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts |  264 ++++++++++++++++++++-------------
 1 files changed, 161 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 32e10f5..406ebc3 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -109,26 +109,47 @@
 			reg = <0x200 0x100>;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x03000000>;
+			ranges;
+
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
+				interrupt-parent = <&ipic>;
+				dfsrr;
+				rtc@68 {
+					compatible = "dallas,ds1339";
+					reg = <0x68>;
+				};
+
+				mcu_pio: mcu@a {
+					#gpio-cells = <2>;
+					compatible = "fsl,mc9s08qg8-mpc8315erdb",
+						     "fsl,mcu-mpc8349emitx";
+					reg = <0x0a>;
+					gpio-controller;
+				};
 			};
 
-			mcu_pio: mcu@a {
-				#gpio-cells = <2>;
-				compatible = "fsl,mc9s08qg8-mpc8315erdb",
-					     "fsl,mcu-mpc8349emitx";
-				reg = <0x0a>;
-				gpio-controller;
+			crypto@30000 {
+				compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
+					     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+					     "fsl,sec2.0";
+				reg = <0x30000 0x10000>;
+				interrupts = <11 0x8>;
+				interrupt-parent = <&ipic>;
+				fsl,num-channels = <4>;
+				fsl,channel-fifo-len = <24>;
+				fsl,exec-units-mask = <0x97c>;
+				fsl,descriptor-types-mask = <0x3ab0abf>;
 			};
 		};
 
@@ -141,45 +162,6 @@
 			mode = "cpu";
 		};
 
-		dma@82a8 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8315-dma", "fsl,elo-dma";
-			reg = <0x82a8 4>;
-			ranges = <0 0x8100 0x1a8>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
-				reg = <0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x180 0x28>;
-				cell-index = <3>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-		};
-
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -188,6 +170,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "utmi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		enet0: ethernet@24000 {
@@ -204,6 +187,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = < &phy0 >;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 
 			mdio@520 {
 				#address-cells = <1>;
@@ -246,6 +231,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = < &phy1 >;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 
 			mdio@520 {
 				#address-cells = <1>;
@@ -280,25 +267,13 @@
 			interrupt-parent = <&ipic>;
 		};
 
-		crypto@30000 {
-			compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
-				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
-				     "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <11 0x8>;
-			interrupt-parent = <&ipic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x97c>;
-			fsl,descriptor-types-mask = <0x3ab0abf>;
-		};
-
 		sata@18000 {
 			compatible = "fsl,mpc8315-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
 			cell-index = <1>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00003000>;
 		};
 
 		sata@19000 {
@@ -307,6 +282,23 @@
 			cell-index = <2>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000c00>;
+		};
+
+		gtm1: timer@500 {
+			compatible = "fsl,mpc8315-gtm", "fsl,gtm";
+			reg = <0x500 0x100>;
+			interrupts = <90 8 78 8 84 8 72 8>;
+			interrupt-parent = <&ipic>;
+			clock-frequency = <133333333>;
+		};
+
+		timer@600 {
+			compatible = "fsl,mpc8315-gtm", "fsl,gtm";
+			reg = <0x600 0x100>;
+			interrupts = <91 8 79 8 85 8 73 8>;
+			interrupt-parent = <&ipic>;
+			clock-frequency = <133333333>;
 		};
 
 		/* IPIC
@@ -337,42 +329,106 @@
 				      0x59 0x8>;
 			interrupt-parent = < &ipic >;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8315-pmc", "fsl,mpc8313-pmc",
+				     "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 8>;
+			interrupt-parent = <&ipic>;
+			fsl,mpc8313-wakeup-timer = <&gtm1>;
+		};
 	};
 
-	pci0: pci@e0008500 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-				/* IDSEL 0x0E -mini PCI */
-				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
-
-				/* IDSEL 0x0F -mini PCI */
-				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x2 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x4 &ipic 17 0x8
-
-				/* IDSEL 0x10 - PCI slot */
-				 0x8000 0x0 0x0 0x1 &ipic 48 0x8
-				 0x8000 0x0 0x0 0x2 &ipic 17 0x8
-				 0x8000 0x0 0x0 0x3 &ipic 48 0x8
-				 0x8000 0x0 0x0 0x4 &ipic 17 0x8>;
-		interrupt-parent = <&ipic>;
-		interrupts = <66 0x8>;
-		bus-range = <0x0 0x0>;
-		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
-			  0x42000000 0 0x80000000 0x80000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xe0300000 0 0x00100000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008500 0x100		/* internal registers */
-		       0xe0008300 0x8>;		/* config space access registers */
-		compatible = "fsl,mpc8349-pci";
-		device_type = "pci";
+	sleep-nexus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		sleep = <&pmc 0x00010000>;
+		ranges;
+
+		pci0: pci@e0008500 {
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+			interrupt-map = <
+					/* IDSEL 0x0E -mini PCI */
+					 0x7000 0x0 0x0 0x1 &ipic 18 0x8
+					 0x7000 0x0 0x0 0x2 &ipic 18 0x8
+					 0x7000 0x0 0x0 0x3 &ipic 18 0x8
+					 0x7000 0x0 0x0 0x4 &ipic 18 0x8
+
+					/* IDSEL 0x0F -mini PCI */
+					 0x7800 0x0 0x0 0x1 &ipic 17 0x8
+					 0x7800 0x0 0x0 0x2 &ipic 17 0x8
+					 0x7800 0x0 0x0 0x3 &ipic 17 0x8
+					 0x7800 0x0 0x0 0x4 &ipic 17 0x8
+
+					/* IDSEL 0x10 - PCI slot */
+					 0x8000 0x0 0x0 0x1 &ipic 48 0x8
+					 0x8000 0x0 0x0 0x2 &ipic 17 0x8
+					 0x8000 0x0 0x0 0x3 &ipic 48 0x8
+					 0x8000 0x0 0x0 0x4 &ipic 17 0x8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <66 0x8>;
+			bus-range = <0x0 0x0>;
+			ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
+				  0x42000000 0 0x80000000 0x80000000 0 0x10000000
+				  0x01000000 0 0x00000000 0xe0300000 0 0x00100000>;
+			clock-frequency = <66666666>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <0xe0008500 0x100	/* internal registers */
+			       0xe0008300 0x8>;	/* config space access registers */
+			compatible = "fsl,mpc8349-pci";
+			device_type = "pci";
+		};
+
+		dma@e00082a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8315-dma", "fsl,elo-dma";
+			reg = <0xe00082a8 4>;
+			ranges = <0 0xe0008100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+
+			dma-channel@0 {
+				compatible = "fsl,mpc8315-dma-channel",
+					     "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+
+			dma-channel@80 {
+				compatible = "fsl,mpc8315-dma-channel",
+					     "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+
+			dma-channel@100 {
+				compatible = "fsl,mpc8315-dma-channel",
+					     "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+
+			dma-channel@180 {
+				compatible = "fsl,mpc8315-dma-channel",
+					     "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				cell-index = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
 	};
 
 	pci1: pcie@e0009000 {
@@ -390,6 +446,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -421,6 +478,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
-- 
1.6.3.3
