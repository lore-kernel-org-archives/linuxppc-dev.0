Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2468FDE8AF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 07:52:04 +1000 (EST)
Date: Wed, 25 Jun 2008 16:51:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/3] mpc8313erdb: Add power management to the device tree.
Message-ID: <20080625215139.GC11784@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts |  247 +++++++++++++++++++++++----------
 1 files changed, 174 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index e1f0dca..291aa82 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -109,18 +109,41 @@
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
+			};
+
+			crypto@30000 {
+				device_type = "crypto";
+				model = "SEC2";
+				compatible = "fsl,sec2.2", "fsl,sec2.1",
+				             "fsl,sec2.0";
+				reg = <0x30000 0x7000>;
+				interrupts = <11 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Rev. 2.2 */
+				num-channels = <1>;
+				channel-fifo-len = <24>;
+				exec-units-mask = <0x0000004c>;
+				descriptor-types-mask = <0x0122003f>;
 			};
 		};
 
@@ -153,37 +176,44 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "utmi_wide";
+			sleep = <&pmc 0x00300000>;
 		};
 
-		mdio@24520 {
+		enet0: ethernet@24000 {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&ipic>;
-				interrupts = <19 0x8>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy4: ethernet-phy@4 {
-				interrupt-parent = <&ipic>;
-				interrupts = <20 0x8>;
-				reg = <0x4>;
-				device_type = "ethernet-phy";
-			};
-		};
+			#size-cells = <1>;
+			sleep = <&pmc 0x20000000>;
+			ranges;
 
-		enet0: ethernet@24000 {
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 0x8 36 0x8 35 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = < &phy1 >;
+			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&ipic>;
+					interrupts = <19 0x8>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+				phy4: ethernet-phy@4 {
+					interrupt-parent = <&ipic>;
+					interrupts = <20 0x8>;
+					reg = <0x4>;
+					device_type = "ethernet-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
@@ -196,6 +226,8 @@
 			interrupts = <34 0x8 33 0x8 32 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = < &phy4 >;
+			sleep = <&pmc 0x10000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -218,20 +250,6 @@
 			interrupt-parent = <&ipic>;
 		};
 
-		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
-			reg = <0x30000 0x7000>;
-			interrupts = <11 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Rev. 2.2 */
-			num-channels = <1>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000004c>;
-			descriptor-types-mask = <0x0122003f>;
-		};
-
 		/* IPIC
 		 * interrupts cell = <intr #, sense>
 		 * sense values match linux IORESOURCE_IRQ_* defines:
@@ -245,36 +263,119 @@
 			reg = <0x700 0x100>;
 			device_type = "ipic";
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 8>;
+			interrupt-parent = <&ipic>;
+			fsl,mpc8313-wakeup-timer = <&gtm1>;
+
+			/* Remove this (or change to "okay") if you have
+			 * a REVA3 or later board, if you apply one of the
+			 * workarounds listed in section 8.5 of the board
+			 * manual, or if you are adapting this device tree
+			 * to a different board.
+			 */
+			status = "fail";
+		};
+
+		gtm1: timer@500 {
+			compatible = "fsl,mpc8313-gtm", "fsl,gtm";
+			reg = <0x500 0x100>;
+			interrupts = <90 8 78 8 84 8 72 8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		timer@600 {
+			compatible = "fsl,mpc8313-gtm", "fsl,gtm";
+			reg = <0x600 0x100>;
+			interrupts = <91 8 79 8 85 8 73 8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
-	pci0: pci@e0008500 {
-		cell-index = <1>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-
-				/* IDSEL 0x0E -mini PCI */
-				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
-
-				/* IDSEL 0x0F - PCI slot */
-				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
-		interrupt-parent = <&ipic>;
-		interrupts = <66 0x8>;
-		bus-range = <0x0 0x0>;
-		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
-			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
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
+			cell-index = <1>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+			interrupt-map = <
+					/* IDSEL 0x0E -mini PCI */
+					 0x7000 0x0 0x0 0x1 &ipic 18 0x8
+					 0x7000 0x0 0x0 0x2 &ipic 18 0x8
+					 0x7000 0x0 0x0 0x3 &ipic 18 0x8
+					 0x7000 0x0 0x0 0x4 &ipic 18 0x8
+
+					/* IDSEL 0x0F - PCI slot */
+					 0x7800 0x0 0x0 0x1 &ipic 17 0x8
+					 0x7800 0x0 0x0 0x2 &ipic 18 0x8
+					 0x7800 0x0 0x0 0x3 &ipic 17 0x8
+					 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <66 0x8>;
+			bus-range = <0x0 0x0>;
+			ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+				  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+				  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+			clock-frequency = <66666666>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <0xe0008500 0x100>;
+			compatible = "fsl,mpc8349-pci";
+			device_type = "pci";
+		};
+
+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8313-dma", "fsl,elo-dma";
+			reg = <0xe00082a8 4>;
+			ranges = <0 0xe0008100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+
+			dma-channel@0 {
+				compatible = "fsl,mpc8313-dma-channel",
+				             "fsl,elo-dma-channel";
+				reg = <0 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+				cell-index = <0>;
+			};
+
+			dma-channel@80 {
+				compatible = "fsl,mpc8313-dma-channel",
+				             "fsl,elo-dma-channel";
+				reg = <0x80 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+				cell-index = <1>;
+			};
+
+			dma-channel@100 {
+				compatible = "fsl,mpc8313-dma-channel",
+				             "fsl,elo-dma-channel";
+				reg = <0x100 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+				cell-index = <2>;
+			};
+
+			dma-channel@180 {
+				compatible = "fsl,mpc8313-dma-channel",
+				             "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+				cell-index = <3>;
+			};
+		};
 	};
 };
-- 
1.5.5.4
