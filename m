Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 187211A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 21:50:58 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [RFC PATCH v2 2/3] powerpc/86xx: Update device tree
Date: Wed,  2 Mar 2016 11:50:47 +0100
Message-Id: <1456915848-18868-2-git-send-email-alessio.bogani@elettra.eu>
In-Reply-To: <1456915848-18868-1-git-send-email-alessio.bogani@elettra.eu>
References: <1456915848-18868-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid duplication of the interrupt-parent, migrate to 4 interrupt-cells
and set the right clock-frequency for pcie (100 Mhz).

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        | 73 ++++++++------------
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 79 ++++++++-------------
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts       | 73 ++++++++------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 95 ++++++++++----------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 78 ++++++++-------------
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 59 ++++++----------
 6 files changed, 169 insertions(+), 288 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
index 83eb0fd..7e4487b 100644
--- a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
@@ -25,6 +25,7 @@
 	compatible = "gef,ppc9a";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -72,8 +73,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
 		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe8000000 0x08000000	// Paged Flash 0
@@ -150,9 +150,7 @@
 			interrupt-controller;
 			compatible = "gef,ppc9a-fpga-pic", "gef,fpga-pic-1.00";
 			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x8 0x9 0 0>;
 
 		};
 		gef_gpio: gpio@7,14000 {
@@ -166,7 +164,6 @@
 	soc@fef00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "fsl,mpc8641-soc", "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
@@ -181,17 +178,15 @@
 		mcm@1000 {
 			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
-		i2c1: i2c@3000 {
+		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2b 0x2 0 0>;
 			dfsrr;
 
 			hwmon@48 {
@@ -215,13 +210,12 @@
 			};
 		};
 
-		i2c2: i2c@3100 {
+		i2c@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2b 0x2 0 0>;
 			dfsrr;
 		};
 
@@ -237,32 +231,28 @@
 					   "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -276,8 +266,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
@@ -315,8 +304,7 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
@@ -340,8 +328,7 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2a 0x2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -350,17 +337,16 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x1c 0x2 0 0>;
 		};
 
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
@@ -369,15 +355,14 @@
 			reg = <0x41600 0x80>;
 			msi-available-ranges = <0 0x100>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
 		};
 
 		global-utilities@e0000 {
@@ -390,16 +375,14 @@
 	pci0: pcie@fef08000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
+		clock-frequency = <100000000>;
+		interrupts = <0x18 0x2 0 0>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
index d426dd3..1299011 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
@@ -25,6 +25,7 @@
 	compatible = "gef,sbc310";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -73,8 +74,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
 		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe0000000 0x08000000	// Paged Flash 0
@@ -148,9 +148,7 @@
 			interrupt-controller;
 			compatible = "gef,sbc310-fpga-pic", "gef,fpga-pic";
 			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x8 0x9 0 0>;
 
 		};
 		gef_gpio: gpio@4,8000 {
@@ -164,7 +162,6 @@
 	soc@fef00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "fsl,mpc8641-soc", "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
@@ -179,17 +176,15 @@
 		mcm@1000 {
 			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
-		i2c1: i2c@3000 {
+		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2b 0x2 0 0>;
 			dfsrr;
 
 			rtc@51 {
@@ -198,13 +193,12 @@
 			};
 		};
 
-		i2c2: i2c@3100 {
+		i2c@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2b 0x2 0 0>;
 			dfsrr;
 
 			hwmon@48 {
@@ -235,32 +229,28 @@
 					   "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -274,8 +264,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
@@ -313,8 +302,7 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
@@ -338,8 +326,7 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2a 0x2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -348,17 +335,16 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x1c 0x2 0 0>;
 		};
 
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
@@ -367,15 +353,14 @@
 			reg = <0x41600 0x80>;
 			msi-available-ranges = <0 0x100>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
 		};
 
 		global-utilities@e0000 {
@@ -388,16 +373,14 @@
 	pci0: pcie@fef08000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
+		clock-frequency = <100000000>;
+		interrupts = <0x18 0x2 0 0>;
 		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
@@ -424,16 +407,14 @@
 	pci1: pcie@fef09000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xfef09000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xfe400000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x19 0x2>;
+		clock-frequency = <100000000>;
+		interrupts = <0x19 0x2 0 0>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x4 0x2
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
index 5db3399..3a1f438 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
@@ -25,6 +25,7 @@
 	compatible = "gef,sbc610";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -72,8 +73,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
 		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe8000000 0x08000000	// Paged Flash 0
@@ -148,9 +148,7 @@
 			interrupt-controller;
 			compatible = "gef,fpga-pic";
 			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x8 0x9 0 0>;
 
 		};
 		gef_gpio: gpio@7,14000 {
@@ -164,7 +162,6 @@
 	soc@fef00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
@@ -179,17 +176,15 @@
 		mcm@1000 {
 			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
-		i2c1: i2c@3000 {
+		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2b 0x2 0 0>;
 			dfsrr;
 
 			hwmon@48 {
@@ -213,13 +208,12 @@
 			};
 		};
 
-		i2c2: i2c@3100 {
+		i2c@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2b 0x2 0 0>;
 			dfsrr;
 		};
 
@@ -235,32 +229,28 @@
 					   "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8641-dma-channel",
 					   "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -274,8 +264,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
@@ -313,8 +302,7 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
@@ -338,8 +326,7 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x2a 0x2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -348,17 +335,16 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <0x1c 0x2 0 0>;
 		};
 
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
@@ -367,15 +353,14 @@
 			reg = <0x41600 0x80>;
 			msi-available-ranges = <0 0x100>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
 		};
 
 		global-utilities@e0000 {
@@ -388,16 +373,14 @@
 	pci0: pcie@fef08000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
+		clock-frequency = <100000000>;
+		interrupts = <0x18 0x2 0 0>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 662169e..70ed3dc 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -16,6 +16,7 @@
 	compatible = "fsl,mpc8641hpcn";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -66,8 +67,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
 		reg = <0xffe05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xef800000 0x00800000
 			  2 0 0xffdf8000 0x00008000
@@ -118,8 +118,7 @@
 		mcm@1000 {
 			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
 		i2c@3000 {
@@ -128,8 +127,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -139,8 +137,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -156,32 +153,28 @@
 						"fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -195,8 +188,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
@@ -208,23 +200,19 @@
 				reg = <0x520 0x20>;
 
 				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <0>;
 				};
 				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <1>;
 				};
 				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <2>;
 				};
 				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <3>;
 				};
 				tbi0: tbi-phy@11 {
@@ -244,8 +232,7 @@
 			reg = <0x25000 0x1000>;
 			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
@@ -273,8 +260,7 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
@@ -302,8 +288,7 @@
 			reg = <0x27000 0x1000>;
 			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
@@ -327,8 +312,7 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -337,16 +321,15 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <28 2 0 0>;
 		};
 
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
@@ -361,27 +344,27 @@
 				compatible = "fsl,srio-msg-unit";
 				reg = <0x0 0x100>;
 				interrupts = <
-					53 2 /* msg1_tx_irq */
-					54 2>;/* msg1_rx_irq */
+					53 2 0 0  /* msg1_tx_irq */
+					54 2 0 0>;/* msg1_rx_irq */
 			};
 			message-unit@100 {
 				compatible = "fsl,srio-msg-unit";
 				reg = <0x100 0x100>;
 				interrupts = <
-					55 2  /* msg2_tx_irq */
-					56 2>;/* msg2_rx_irq */
+					55 2 0 0  /* msg2_tx_irq */
+					56 2 0 0>;/* msg2_rx_irq */
 			};
 			doorbell-unit@400 {
 				compatible = "fsl,srio-dbell-unit";
 				reg = <0x400 0x80>;
 				interrupts = <
-					49 2  /* bell_outb_irq */
-					50 2>;/* bell_inb_irq */
+					49 2 0 0 /* bell_outb_irq */
+					50 2 0 0>;/* bell_inb_irq */
 			};
 			port-write-unit@4e0 {
 				compatible = "fsl,srio-port-write-unit";
 				reg = <0x4e0 0x20>;
-				interrupts = <48 2>;
+				interrupts = <48 2 0 0>;
 			};
 		};
 
@@ -395,16 +378,14 @@
 	pci0: pcie@ffe08000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xffe08000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
+		clock-frequency = <100000000>;
+		interrupts = <24 2 0 0>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
@@ -545,7 +526,6 @@
 					  0x0 0x00010000>;
 				isa@1e {
 					device_type = "isa";
-					#interrupt-cells = <2>;
 					#size-cells = <1>;
 					#address-cells = <2>;
 					reg = <0xf000 0 0 0 0>;
@@ -562,8 +542,7 @@
 						#address-cells = <0>;
 						#interrupt-cells = <2>;
 						compatible = "chrp,iic";
-						interrupts = <9 2>;
-						interrupt-parent = <&mpic>;
+						interrupts = <9 2 0 0>;
 					};
 
 					i8042@60 {
@@ -571,8 +550,7 @@
 						#address-cells = <1>;
 						reg = <1 0x60 1 1 0x64 1>;
 						interrupts = <1 3 12 3>;
-						interrupt-parent =
-							<&i8259>;
+						interrupt-parent = <&i8259>;
 
 						keyboard@0 {
 							reg = <0>;
@@ -603,16 +581,14 @@
 	pci1: pcie@ffe09000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xffe09000 0x1000>;
 		bus-range = <0 0xff>;
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
+		clock-frequency = <100000000>;
+		interrupts = <25 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -644,8 +620,7 @@
 	rapidio@ffec0000 {
 		reg = <0xffec0000 0x11000>;
 		compatible = "fsl,srio";
-		interrupt-parent = <&mpic>;
-		interrupts = <48 2>;
+		interrupts = <48 2 0 0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		fsl,srio-rmu-handle = <&rmu>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index bb575e2..0a2c21f 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -16,6 +16,7 @@
 	compatible = "fsl,mpc8641hpcn";
 	#address-cells = <2>;
 	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -66,8 +67,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
 		reg = <0x0f 0xffe05000 0x0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xf 0xef800000 0x00800000
 			  2 0 0xf 0xffdf8000 0x00008000
@@ -118,8 +118,7 @@
 		mcm@1000 {
 			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
 		i2c@3000 {
@@ -128,8 +127,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -139,8 +137,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -156,32 +153,28 @@
 						"fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -195,8 +188,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
@@ -208,23 +200,19 @@
 				reg = <0x520 0x20>;
 
 				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <0>;
 				};
 				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <1>;
 				};
 				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <2>;
 				};
 				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
+					interrupts = <10 1 0 0>;
 					reg = <3>;
 				};
 				tbi0: tbi-phy@11 {
@@ -244,8 +232,7 @@
 			reg = <0x25000 0x1000>;
 			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
@@ -273,8 +260,7 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
@@ -302,8 +288,7 @@
 			reg = <0x27000 0x1000>;
 			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
@@ -327,8 +312,7 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -337,16 +321,15 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <28 2 0 0>;
 		};
 
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
@@ -361,16 +344,14 @@
 		cell-index = <0>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0x0f 0xffe08000 0x0 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x00000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
+		clock-frequency = <100000000>;
+		interrupts = <24 2 0 0>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
@@ -511,7 +492,6 @@
 					  0x0 0x00010000>;
 				isa@1e {
 					device_type = "isa";
-					#interrupt-cells = <2>;
 					#size-cells = <1>;
 					#address-cells = <2>;
 					reg = <0xf000 0 0 0 0>;
@@ -528,8 +508,7 @@
 						#address-cells = <0>;
 						#interrupt-cells = <2>;
 						compatible = "chrp,iic";
-						interrupts = <9 2>;
-						interrupt-parent = <&mpic>;
+						interrupts = <9 2 0 0>;
 					};
 
 					i8042@60 {
@@ -537,8 +516,7 @@
 						#address-cells = <1>;
 						reg = <1 0x60 1 1 0x64 1>;
 						interrupts = <1 3 12 3>;
-						interrupt-parent =
-							<&i8259>;
+						interrupt-parent = <&i8259>;
 
 						keyboard@0 {
 							reg = <0>;
@@ -570,16 +548,14 @@
 		cell-index = <1>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0x0f 0xffe09000 0x0 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
+		clock-frequency = <100000000>;
+		interrupts = <25 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
diff --git a/arch/powerpc/boot/dts/fsl/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
index 68f0ed7..47c83a0 100644
--- a/arch/powerpc/boot/dts/fsl/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
@@ -20,6 +20,7 @@
 	compatible = "wind,sbc8641";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpic>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -70,8 +71,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
 		reg = <0xf8005000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xf0000000 0x00010000	// 64KB EEPROM
@@ -137,8 +137,7 @@
 		mcm@1000 {
 			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
 			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <17 2 0 0>;
 		};
 
 		i2c@3000 {
@@ -147,8 +146,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -158,8 +156,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -175,32 +172,28 @@
 						"fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8641-dma-channel",
 						"fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -214,8 +207,7 @@
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
@@ -255,8 +247,7 @@
 			reg = <0x25000 0x1000>;
 			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
@@ -284,8 +275,7 @@
 			reg = <0x26000 0x1000>;
 			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
@@ -313,8 +303,7 @@
 			reg = <0x27000 0x1000>;
 			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
@@ -338,8 +327,7 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -348,17 +336,16 @@
 			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <28 2 0 0>;
 		};
 
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic", "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
 		};
@@ -373,16 +360,14 @@
 	pci0: pcie@f8008000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xf8008000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
+		clock-frequency = <100000000>;
+		interrupts = <24 2 0 0>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -411,16 +396,14 @@
 	pci1: pcie@f8009000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xf8009000 0x1000>;
 		bus-range = <0 0xff>;
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
+		clock-frequency = <100000000>;
+		interrupts = <25 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
-- 
2.7.2
