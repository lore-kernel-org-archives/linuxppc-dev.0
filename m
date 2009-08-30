Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF905B7DAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 05:37:23 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 98825DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 05:37:22 +1000 (EST)
Date: Sun, 30 Aug 2009 23:37:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Message-ID: <20090830193721.GC17519@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add power management controller nodes;
- Add interrupts for RTC nodes, the RTC interrupt may be used as a
  wakeup source;
- Add sleep properties and sleep-nexus nodes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts      |  119 +++++++++++++++++++----------
 arch/powerpc/boot/dts/mpc8569mds.dts      |  111 ++++++++++++++++++---------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 3 files changed, 153 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 00c2bbd..6d892ba 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -40,6 +40,8 @@
 			i-cache-line-size = <32>;	// 32 bytes
 			d-cache-size = <0x8000>;		// L1, 32K
 			i-cache-size = <0x8000>;		// L1, 32K
+			sleep = <&pmc 0x00008000	// core
+				 &pmc 0x00004000>;	// timebase
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -94,31 +96,41 @@
 			interrupts = <16 2>;
 		};
 
-		i2c@3000 {
+		i2c-sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x00000004>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1374";
-				reg = <0x68>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <43 2>;
+				interrupt-parent = <&mpic>;
+				dfsrr;
+
+				rtc@68 {
+					compatible = "dallas,ds1374";
+					reg = <0x68>;
+					interrupts = <3 1>;
+					interrupt-parent = <&mpic>;
+				};
 			};
-		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
+			i2c@3100 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <1>;
+				compatible = "fsl-i2c";
+				reg = <0x3100 0x100>;
+				interrupts = <43 2>;
+				interrupt-parent = <&mpic>;
+				dfsrr;
+			};
 		};
 
 		dma@21300 {
@@ -128,6 +140,8 @@
 			reg = <0x21300 0x4>;
 			ranges = <0x0 0x21100 0x200>;
 			cell-index = <0>;
+			sleep = <&pmc 0x00000400>;
+
 			dma-channel@0 {
 				compatible = "fsl,mpc8568-dma-channel",
 						"fsl,eloplus-dma-channel";
@@ -176,6 +190,7 @@
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0x00000080>;
 
 			mdio@520 {
 				#address-cells = <1>;
@@ -228,6 +243,7 @@
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x00000040>;
 
 			mdio@520 {
 				#address-cells = <1>;
@@ -242,30 +258,47 @@
 			};
 		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+		duart-sleep-nexus {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x00000002>;
+			ranges;
+
+			serial0: serial@4500 {
+				cell-index = <0>;
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0x4500 0x100>;
+				clock-frequency = <0>;
+				interrupts = <42 2>;
+				interrupt-parent = <&mpic>;
+			};
+
+			serial1: serial@4600 {
+				cell-index = <1>;
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0x4600 0x100>;
+				clock-frequency = <0>;
+				interrupts = <42 2>;
+				interrupt-parent = <&mpic>;
+			};
 		};
 
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8548-guts";
+		global-utilities@e0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8568-guts", "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
+			ranges = <0 0xe0000 0x1000>;
 			fsl,has-rstcr;
-		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			pmc: power@70 {
+				compatible = "fsl,mpc8568-pmc",
+					     "fsl,mpc8548-pmc";
+				reg = <0x70 0x20>;
+			};
 		};
 
 		crypto@30000 {
@@ -277,6 +310,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0xfe>;
 			fsl,descriptor-types-mask = <0x12b0ebf>;
+			sleep = <&pmc 0x01000000>;
 		};
 
 		mpic: pic@40000 {
@@ -376,6 +410,7 @@
 		compatible = "fsl,qe";
 		ranges = <0x0 0xe0080000 0x40000>;
 		reg = <0xe0080000 0x480>;
+		sleep = <&pmc 0x00000800>;
 		brg-frequency = <0>;
 		bus-frequency = <396000000>;
 		fsl,qe-num-riscs = <2>;
@@ -509,6 +544,7 @@
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x0 0xe2000000 0x0 0x800000>;
+		sleep = <&pmc 0x80000000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -534,6 +570,7 @@
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
 			  0x1000000 0x0 0x0 0xe2800000 0x0 0x800000>;
+		sleep = <&pmc 0x20000000>;
 		clock-frequency = <33333333>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -570,5 +607,7 @@
 			      55 2 /* msg2_tx   */
 			      56 2 /* msg2_rx   */>;
 		interrupt-parent = <&mpic>;
+		sleep = <&pmc 0x00080000   /* controller */
+			 &pmc 0x00040000>; /* message unit */
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 880f896..b35e62c 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -41,6 +41,8 @@
 			i-cache-line-size = <32>;	// 32 bytes
 			d-cache-size = <0x8000>;		// L1, 32K
 			i-cache-size = <0x8000>;		// L1, 32K
+			sleep = <&pmc 0x00008000	// core
+				 &pmc 0x00004000>;	// timebase
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -59,6 +61,7 @@
 		reg = <0xe0005000 0x1000>;
 		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
+		sleep = <&pmc 0x08000000>;
 
 		ranges = <0x0 0x0 0xfe000000 0x02000000
 			  0x1 0x0 0xf8000000 0x00008000
@@ -158,51 +161,69 @@
 			interrupts = <18 2>;
 		};
 
-		i2c@3000 {
+		i2c-sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x00000004>;
+			ranges;
+
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <43 2>;
+				interrupt-parent = <&mpic>;
+				dfsrr;
+
+				rtc@68 {
+					compatible = "dallas,ds1374";
+					reg = <0x68>;
+					interrupts = <3 1>;
+					interrupt-parent = <&mpic>;
+				};
+			};
 
-			rtc@68 {
-				compatible = "dallas,ds1374";
-				reg = <0x68>;
+			i2c@3100 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <1>;
+				compatible = "fsl-i2c";
+				reg = <0x3100 0x100>;
+				interrupts = <43 2>;
+				interrupt-parent = <&mpic>;
+				dfsrr;
 			};
 		};
 
-		i2c@3100 {
+		duart-sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x00000002>;
+			ranges;
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
+			serial0: serial@4500 {
+				cell-index = <0>;
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0x4500 0x100>;
+				clock-frequency = <0>;
+				interrupts = <42 2>;
+				interrupt-parent = <&mpic>;
+			};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			serial1: serial@4600 {
+				cell-index = <1>;
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0x4600 0x100>;
+				clock-frequency = <0>;
+				interrupts = <42 2>;
+				interrupt-parent = <&mpic>;
+			};
 		};
 
 		L2: l2-cache-controller@20000 {
@@ -260,6 +281,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <72 0x8>;
 			interrupt-parent = <&mpic>;
+			sleep = <&pmc 0x00200000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 			status = "disabled";
@@ -276,6 +298,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0xbfe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x01000000>;
 		};
 
 		mpic: pic@40000 {
@@ -304,9 +327,18 @@
 		};
 
 		global-utilities@e0000 {
-			compatible = "fsl,mpc8569-guts";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8569-guts", "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
+			ranges = <0 0xe0000 0x1000>;
 			fsl,has-rstcr;
+
+			pmc: power@70 {
+				compatible = "fsl,mpc8569-pmc",
+					     "fsl,mpc8548-pmc";
+				reg = <0x70 0x20>;
+			};
 		};
 
 		par_io@e0100 {
@@ -422,6 +454,7 @@
 		compatible = "fsl,qe";
 		ranges = <0x0 0xe0080000 0x40000>;
 		reg = <0xe0080000 0x480>;
+		sleep = <&pmc 0x00000800>;
 		brg-frequency = <0>;
 		bus-frequency = <0>;
 		fsl,qe-num-riscs = <4>;
@@ -680,6 +713,7 @@
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
 			  0x1000000 0x0 0x00000000 0xe2800000 0x0 0x00800000>;
+		sleep = <&pmc 0x20000000>;
 		clock-frequency = <33333333>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
@@ -710,5 +744,6 @@
 			      55 2 /* msg2_tx   */
 			      56 2 /* msg2_rx   */>;
 		interrupt-parent = <&mpic>;
+		sleep = <&pmc 0x00080000>;
 	};
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 20a61d0..995ddad 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -300,6 +300,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .compatible = "fsl,qe", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,rapidio-delta", },
+	{ .compatible = "fsl,mpc8548-guts", },
 	{},
 };
 
-- 
1.6.3.3
