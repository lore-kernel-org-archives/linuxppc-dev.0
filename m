Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9C618DE3E4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:46:19 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JZJ005XGLX6QV80@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Apr 2008 16:46:18 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JZJ006B0LWVYL50@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 18 Apr 2008 16:46:18 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JZJ00LK8LWTOY30@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Apr 2008 16:46:06 -0600 (MDT)
Date: Fri, 18 Apr 2008 09:10:04 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1 format
To: linuxppc-dev@ozlabs.org, m8@semihalf.com
Message-id: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update dts files to current format

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/dts/cm5200.dts    |   98 +++++++++++------------
 arch/powerpc/boot/dts/lite5200.dts  |  132 ++++++++++++++++----------------
 arch/powerpc/boot/dts/lite5200b.dts |  146 +++++++++++++++++------------------
 arch/powerpc/boot/dts/motionpro.dts |  118 ++++++++++++++--------------
 arch/powerpc/boot/dts/tqm5200.dts   |   80 ++++++++++---------
 5 files changed, 286 insertions(+), 288 deletions(-)

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index c6ca631..2f74cc4 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -10,11 +10,7 @@
  * option) any later version.
  */
 
-/*
- * WARNING: Do not depend on this tree layout remaining static just yet.
- * The MPC5200 device tree conventions are still in flux
- * Keep an eye on the linuxppc-dev mailing list for more details
- */
+/dts-v1/;
 
 / {
 	model = "schindler,cm5200";
@@ -29,10 +25,10 @@
 		PowerPC,5200@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;		// L1, 16K
+			i-cache-size = <0x4000>;		// L1, 16K
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -41,34 +37,34 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;	// 64MB
+		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc5200b-immr";
-		ranges = <0 f0000000 0000c000>;
-		reg = <f0000000 00000100>;
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
 			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
-			reg = <200 38>;
+			reg = <0x200 0x38>;
 		};
 
-		mpc5200_pic: pic@500 {
+		mpc5200_pic: interrupt-controller@500 {
 			// 5200 interrupts are encoded into two levels;
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
-			reg = <500 80>;
+			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <600 10>;
+			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
@@ -76,108 +72,108 @@
 
 		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <610 10>;
-			interrupts = <1 a 0>;
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <620 10>;
-			interrupts = <1 b 0>;
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <630 10>;
-			interrupts = <1 c 0>;
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <640 10>;
-			interrupts = <1 d 0>;
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <650 10>;
-			interrupts = <1 e 0>;
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <660 10>;
-			interrupts = <1 f 0>;
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <670 10>;
-			interrupts = <1 10 0>;
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
-			reg = <800 100>;
+			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
-			reg = <b00 40>;
+			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
-			reg = <c00 40>;
+			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
-			reg = <f00 20>;
-			interrupts = <2 d 0 2 e 0>;
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
-			reg = <1000 ff>;
+			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
 			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
-			reg = <1200 80>;
+			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
-			              3 8 0  3 9 0  3 a 0  3 b 0
-			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
 			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
-			reg = <1f00 100>;
+			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
-			reg = <2000 100>;
+			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -186,7 +182,7 @@
 			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <1>;  // Logical port assignment
-			reg = <2200 100>;
+			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -195,7 +191,7 @@
 			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <2>;  // Logical port assignment
-			reg = <2400 100>;
+			reg = <0x2400 0x100>;
 			interrupts = <2 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -204,7 +200,7 @@
 			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 			port-number = <5>;  // Logical port assignment
-			reg = <2c00 100>;
+			reg = <0x2c00 0x100>;
 			interrupts = <2 4 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -212,7 +208,7 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
-			reg = <3000 400>;
+			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -223,7 +219,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
-			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
+			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
 
@@ -237,15 +233,15 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-			reg = <3d40 40>;
-			interrupts = <2 10 0>;
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 
 		sram@8000 {
 			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
-			reg = <8000 4000>;
+			reg = <0x8000 0x4000>;
 		};
 	};
 
@@ -254,12 +250,12 @@
 		compatible = "fsl,lpb";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <0 0 fc000000 2000000>;
+		ranges = <0 0 0xfc000000 0x2000000>;
 
 		// 16-bit flash device at LocalPlus Bus CS0
 		flash@0,0 {
 			compatible = "cfi-flash";
-			reg = <0 0 2000000>;
+			reg = <0 0 0x2000000>;
 			bank-width = <2>;
 			device-width = <2>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 09b4e16..2cf9a87 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -10,6 +10,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "fsl,lite5200";
 	compatible = "fsl,lite5200";
@@ -23,10 +25,10 @@
 		PowerPC,5200@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;	// L1, 16K
+			i-cache-size = <0x4000>;	// L1, 16K
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -35,21 +37,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;	// 64MB
+		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc5200-immr";
-		ranges = <0 f0000000 0000c000>;
-		reg = <f0000000 00000100>;
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
 			compatible = "fsl,mpc5200-cdm";
-			reg = <200 38>;
+			reg = <0x200 0x38>;
 		};
 
 		mpc5200_pic: interrupt-controller@500 {
@@ -58,13 +60,13 @@
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
 			compatible = "fsl,mpc5200-pic";
-			reg = <500 80>;
+			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <0>;
-			reg = <600 10>;
+			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
@@ -73,63 +75,63 @@
 		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <1>;
-			reg = <610 10>;
-			interrupts = <1 a 0>;
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <2>;
-			reg = <620 10>;
-			interrupts = <1 b 0>;
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <3>;
-			reg = <630 10>;
-			interrupts = <1 c 0>;
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <4>;
-			reg = <640 10>;
-			interrupts = <1 d 0>;
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <5>;
-			reg = <650 10>;
-			interrupts = <1 e 0>;
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <6>;
-			reg = <660 10>;
-			interrupts = <1 f 0>;
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
 			cell-index = <7>;
-			reg = <670 10>;
-			interrupts = <1 10 0>;
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200-rtc";
 			device_type = "rtc";
-			reg = <800 100>;
+			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -137,43 +139,43 @@
 		can@900 {
 			compatible = "fsl,mpc5200-mscan";
 			cell-index = <0>;
-			interrupts = <2 11 0>;
+			interrupts = <2 17 0>;
 			interrupt-parent = <&mpc5200_pic>;
-			reg = <900 80>;
+			reg = <0x900 0x80>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <2 12 0>;
+			interrupts = <2 18 0>;
 			interrupt-parent = <&mpc5200_pic>;
-			reg = <980 80>;
+			reg = <0x980 0x80>;
 		};
 
 		gpio@b00 {
 			compatible = "fsl,mpc5200-gpio";
-			reg = <b00 40>;
+			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
 			compatible = "fsl,mpc5200-gpio-wkup";
-			reg = <c00 40>;
+			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200-spi";
-			reg = <f00 20>;
-			interrupts = <2 d 0 2 e 0>;
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200-ohci","ohci-be";
-			reg = <1000 ff>;
+			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -181,17 +183,17 @@
 		dma-controller@1200 {
 			device_type = "dma-controller";
 			compatible = "fsl,mpc5200-bestcomm";
-			reg = <1200 80>;
+			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
-			              3 8 0  3 9 0  3 a 0  3 b 0
-			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
 			compatible = "fsl,mpc5200-xlb";
-			reg = <1f00 100>;
+			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
@@ -199,7 +201,7 @@
 			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
 			cell-index = <0>;
-			reg = <2000 100>;
+			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -208,7 +210,7 @@
 		//ac97@2200 {		// PSC2
 		//	compatible = "fsl,mpc5200-psc-ac97";
 		//	cell-index = <1>;
-		//	reg = <2200 100>;
+		//	reg = <0x2200 0x100>;
 		//	interrupts = <2 2 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
@@ -217,7 +219,7 @@
 		//i2s@2400 {		// PSC3
 		//	compatible = "fsl,mpc5200-psc-i2s";
 		//	cell-index = <2>;
-		//	reg = <2400 100>;
+		//	reg = <0x2400 0x100>;
 		//	interrupts = <2 3 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
@@ -227,8 +229,8 @@
 		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200-psc-uart";
 		//	cell-index = <3>;
-		//	reg = <2600 100>;
-		//	interrupts = <2 b 0>;
+		//	reg = <0x2600 0x100>;
+		//	interrupts = <2 11 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
@@ -237,8 +239,8 @@
 		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200-psc-uart";
 		//	cell-index = <4>;
-		//	reg = <2800 100>;
-		//	interrupts = <2 c 0>;
+		//	reg = <0x2800 0x100>;
+		//	interrupts = <2 12 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
@@ -246,7 +248,7 @@
 		//spi@2c00 {		// PSC6
 		//	compatible = "fsl,mpc5200-psc-spi";
 		//	cell-index = <5>;
-		//	reg = <2c00 100>;
+		//	reg = <0x2c00 0x100>;
 		//	interrupts = <2 4 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
@@ -254,7 +256,7 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200-fec";
-			reg = <3000 800>;
+			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -265,11 +267,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200-mdio";
-			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
 
-			phy0:ethernet-phy@1 {
+			phy0: ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				reg = <1>;
 			};
@@ -278,7 +280,7 @@
 		ata@3a00 {
 			device_type = "ata";
 			compatible = "fsl,mpc5200-ata";
-			reg = <3a00 100>;
+			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -288,8 +290,8 @@
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
-			reg = <3d00 40>;
-			interrupts = <2 f 0>;
+			reg = <0x3d00 0x40>;
+			interrupts = <2 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
@@ -299,14 +301,14 @@
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
-			reg = <3d40 40>;
-			interrupts = <2 10 0>;
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 		sram@8000 {
 			compatible = "fsl,mpc5200-sram","sram";
-			reg = <8000 4000>;
+			reg = <0x8000 0x4000>;
 		};
 	};
 
@@ -316,18 +318,18 @@
 		#address-cells = <3>;
 		device_type = "pci";
 		compatible = "fsl,mpc5200-pci";
-		reg = <f0000d00 100>;
-		interrupt-map-mask = <f800 0 0 7>;
-		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
-				 c000 0 0 2 &mpc5200_pic 0 0 3
-				 c000 0 0 3 &mpc5200_pic 0 0 3
-				 c000 0 0 4 &mpc5200_pic 0 0 3>;
+		reg = <0xf0000d00 0x100>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3
+				 0xc000 0 0 2 &mpc5200_pic 0 0 3
+				 0xc000 0 0 3 &mpc5200_pic 0 0 3
+				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
 		clock-frequency = <0>; // From boot loader
-		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupts = <2 8 0 2 9 0 2 10 0>;
 		interrupt-parent = <&mpc5200_pic>;
 		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 20000000
-			  02000000 0 a0000000 a0000000 0 10000000
-			  01000000 0 00000000 b0000000 0 01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 2e9bc39..7bd5b9c 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -10,11 +10,7 @@
  * option) any later version.
  */
 
-/*
- * WARNING: Do not depend on this tree layout remaining static just yet.
- * The MPC5200 device tree conventions are still in flux
- * Keep an eye on the linuxppc-dev mailing list for more details
- */
+/dts-v1/;
 
 / {
 	model = "fsl,lite5200b";
@@ -29,10 +25,10 @@
 		PowerPC,5200@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;	// L1, 16K
+			i-cache-size = <0x4000>;	// L1, 16K
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -41,21 +37,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;	// 256MB
+		reg = <0x00000000 0x10000000>;	// 256MB
 	};
 
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc5200b-immr";
-		ranges = <0 f0000000 0000c000>;
-		reg = <f0000000 00000100>;
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
 			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
-			reg = <200 38>;
+			reg = <0x200 0x38>;
 		};
 
 		mpc5200_pic: interrupt-controller@500 {
@@ -64,13 +60,13 @@
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
 			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
-			reg = <500 80>;
+			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <0>;
-			reg = <600 10>;
+			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
@@ -79,63 +75,63 @@
 		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <1>;
-			reg = <610 10>;
-			interrupts = <1 a 0>;
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <2>;
-			reg = <620 10>;
-			interrupts = <1 b 0>;
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <3>;
-			reg = <630 10>;
-			interrupts = <1 c 0>;
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <4>;
-			reg = <640 10>;
-			interrupts = <1 d 0>;
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <5>;
-			reg = <650 10>;
-			interrupts = <1 e 0>;
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <6>;
-			reg = <660 10>;
-			interrupts = <1 f 0>;
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			cell-index = <7>;
-			reg = <670 10>;
-			interrupts = <1 10 0>;
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
 			device_type = "rtc";
-			reg = <800 100>;
+			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -143,43 +139,43 @@
 		can@900 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
 			cell-index = <0>;
-			interrupts = <2 11 0>;
+			interrupts = <2 17 0>;
 			interrupt-parent = <&mpc5200_pic>;
-			reg = <900 80>;
+			reg = <0x900 0x80>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <2 12 0>;
+			interrupts = <2 18 0>;
 			interrupt-parent = <&mpc5200_pic>;
-			reg = <980 80>;
+			reg = <0x980 0x80>;
 		};
 
 		gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
-			reg = <b00 40>;
+			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
-			reg = <c00 40>;
+			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
-			reg = <f00 20>;
-			interrupts = <2 d 0 2 e 0>;
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
-			reg = <1000 ff>;
+			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -187,17 +183,17 @@
 		dma-controller@1200 {
 			device_type = "dma-controller";
 			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
-			reg = <1200 80>;
+			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
-			              3 8 0  3 9 0  3 a 0  3 b 0
-			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
 			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
-			reg = <1f00 100>;
+			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
@@ -205,7 +201,7 @@
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
 			cell-index = <0>;
-			reg = <2000 100>;
+			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -214,7 +210,7 @@
 		//ac97@2200 {		// PSC2
 		//	compatible = "fsl,mpc5200b-psc-ac97","fsl,mpc5200-psc-ac97";
 		//	cell-index = <1>;
-		//	reg = <2200 100>;
+		//	reg = <0x2200 0x100>;
 		//	interrupts = <2 2 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
@@ -223,7 +219,7 @@
 		//i2s@2400 {		// PSC3
 		//	compatible = "fsl,mpc5200b-psc-i2s"; //not 5200 compatible
 		//	cell-index = <2>;
-		//	reg = <2400 100>;
+		//	reg = <0x2400 0x100>;
 		//	interrupts = <2 3 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
@@ -233,8 +229,8 @@
 		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 		//	cell-index = <3>;
-		//	reg = <2600 100>;
-		//	interrupts = <2 b 0>;
+		//	reg = <0x2600 0x100>;
+		//	interrupts = <2 11 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
@@ -243,8 +239,8 @@
 		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 		//	cell-index = <4>;
-		//	reg = <2800 100>;
-		//	interrupts = <2 c 0>;
+		//	reg = <0x2800 0x100>;
+		//	interrupts = <2 12 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
@@ -252,7 +248,7 @@
 		//spi@2c00 {		// PSC6
 		//	compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
 		//	cell-index = <5>;
-		//	reg = <2c00 100>;
+		//	reg = <0x2c00 0x100>;
 		//	interrupts = <2 4 0>;
 		//	interrupt-parent = <&mpc5200_pic>;
 		//};
@@ -260,7 +256,7 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
-			reg = <3000 400>;
+			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -271,11 +267,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
-			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
 
-			phy0:ethernet-phy@0 {
+			phy0: ethernet-phy@0 {
 				device_type = "ethernet-phy";
 				reg = <0>;
 			};
@@ -284,7 +280,7 @@
 		ata@3a00 {
 			device_type = "ata";
 			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
-			reg = <3a00 100>;
+			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -294,8 +290,8 @@
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
-			reg = <3d00 40>;
-			interrupts = <2 f 0>;
+			reg = <0x3d00 0x40>;
+			interrupts = <2 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
@@ -305,14 +301,14 @@
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
-			reg = <3d40 40>;
-			interrupts = <2 10 0>;
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 		sram@8000 {
 			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
-			reg = <8000 4000>;
+			reg = <0x8000 0x4000>;
 		};
 	};
 
@@ -322,23 +318,23 @@
 		#address-cells = <3>;
 		device_type = "pci";
 		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
-		reg = <f0000d00 100>;
-		interrupt-map-mask = <f800 0 0 7>;
-		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
-				 c000 0 0 2 &mpc5200_pic 1 1 3
-				 c000 0 0 3 &mpc5200_pic 1 2 3
-				 c000 0 0 4 &mpc5200_pic 1 3 3
-
-				 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
-				 c800 0 0 2 &mpc5200_pic 1 2 3
-				 c800 0 0 3 &mpc5200_pic 1 3 3
-				 c800 0 0 4 &mpc5200_pic 0 0 3>;
+		reg = <0xf0000d00 0x100>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
+				 0xc000 0 0 2 &mpc5200_pic 1 1 3
+				 0xc000 0 0 3 &mpc5200_pic 1 2 3
+				 0xc000 0 0 4 &mpc5200_pic 1 3 3
+
+				 0xc800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
+				 0xc800 0 0 2 &mpc5200_pic 1 2 3
+				 0xc800 0 0 3 &mpc5200_pic 1 3 3
+				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
 		clock-frequency = <0>; // From boot loader
-		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupts = <2 8 0 2 9 0 2 10 0>;
 		interrupt-parent = <&mpc5200_pic>;
 		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 20000000
-			  02000000 0 a0000000 a0000000 0 10000000
-			  01000000 0 00000000 b0000000 0 01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 2b0dde0..9e3c921 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -10,6 +10,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "promess,motionpro";
 	compatible = "promess,motionpro";
@@ -23,10 +25,10 @@
 		PowerPC,5200@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;	// L1, 16K
+			i-cache-size = <0x4000>;	// L1, 16K
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -35,21 +37,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;	// 64MB
+		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc5200b-immr";
-		ranges = <0 f0000000 0000c000>;
-		reg = <f0000000 00000100>;
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
 			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
-			reg = <200 38>;
+			reg = <0x200 0x38>;
 		};
 
 		mpc5200_pic: interrupt-controller@500 {
@@ -57,12 +59,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
-			reg = <500 80>;
+			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <600 10>;
+			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
@@ -70,118 +72,118 @@
 
 		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <610 10>;
-			interrupts = <1 a 0>;
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <620 10>;
-			interrupts = <1 b 0>;
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <630 10>;
-			interrupts = <1 c 0>;
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <640 10>;
-			interrupts = <1 d 0>;
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			reg = <650 10>;
-			interrupts = <1 e 0>;
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		motionpro-led@660 {	// Motion-PRO status LED
 			compatible = "promess,motionpro-led";
 			label = "motionpro-statusled";
-			reg = <660 10>;
-			interrupts = <1 f 0>;
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
-			blink-delay = <64>; // 100 msec
+			blink-delay = <100>; // 100 msec
 		};
 
 		motionpro-led@670 {	// Motion-PRO ready LED
 			compatible = "promess,motionpro-led";
 			label = "motionpro-readyled";
-			reg = <670 10>;
-			interrupts = <1 10 0>;
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
-			reg = <800 100>;
+			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-		mscan@980 {
+		can@980 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
-			interrupts = <2 12 0>;
+			interrupts = <2 18 0>;
 			interrupt-parent = <&mpc5200_pic>;
-			reg = <980 80>;
+			reg = <0x980 0x80>;
 		};
 
 		gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
-			reg = <b00 40>;
+			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
-			reg = <c00 40>;
+			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
-			reg = <f00 20>;
-			interrupts = <2 d 0 2 e 0>;
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
-			reg = <1000 ff>;
+			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
 			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
-			reg = <1200 80>;
+			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
-			              3 8 0  3 9 0  3 a 0  3 b 0
-			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
 			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
-			reg = <1f00 100>;
+			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
-			reg = <2000 100>;
+			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -190,7 +192,7 @@
 		spi@2200 {		// PSC2
 			compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
 			cell-index = <1>;
-			reg = <2200 100>;
+			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -200,15 +202,15 @@
 			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 			port-number = <4>;  // Logical port assignment
-			reg = <2800 100>;
-			interrupts = <2 c 0>;
+			reg = <0x2800 0x100>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
-			reg = <3000 400>;
+			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -219,7 +221,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
-			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
+			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
 
@@ -231,7 +233,7 @@
 
 		ata@3a00 {
 			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
-			reg = <3a00 100>;
+			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -240,21 +242,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-			reg = <3d40 40>;
-			interrupts = <2 10 0>;
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 
 			rtc@68 {
 				device_type = "rtc";
 				compatible = "dallas,ds1339";
-				reg = <68>;
+				reg = <0x68>;
 			};
 		};
 
 		sram@8000 {
 			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
-			reg = <8000 4000>;
+			reg = <0x8000 0x4000>;
 		};
 	};
 
@@ -262,15 +264,15 @@
 		compatible = "fsl,lpb";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <0 0 ff000000 01000000
-			  1 0 50000000 00010000
-			  2 0 50010000 00010000
-			  3 0 50020000 00010000>;
+		ranges = <0 0 0xff000000 0x01000000
+			  1 0 0x50000000 0x00010000
+			  2 0 0x50010000 0x00010000
+			  3 0 0x50020000 0x00010000>;
 
 		// 8-bit DualPort SRAM on LocalPlus Bus CS1
 		kollmorgen@1,0 {
 			compatible = "promess,motionpro-kollmorgen";
-			reg = <1 0 10000>;
+			reg = <1 0 0x10000>;
 			interrupts = <1 1 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -278,13 +280,13 @@
 		// 8-bit board CPLD on LocalPlus Bus CS2
 		cpld@2,0 {
 			compatible = "promess,motionpro-cpld";
-			reg = <2 0 10000>;
+			reg = <2 0 0x10000>;
 		};
 
 		// 8-bit custom Anybus Module on LocalPlus Bus CS3
 		anybus@3,0 {
 			compatible = "promess,motionpro-anybus";
-			reg = <3 0 10000>;
+			reg = <3 0 0x10000>;
 		};
 		pro_module_general@3,0 {
 			compatible = "promess,pro_module_general";
@@ -292,13 +294,13 @@
 		};
 		pro_module_dio@3,800 {
 			compatible = "promess,pro_module_dio";
-			reg = <3 800 2>;
+			reg = <3 0x800 2>;
 		};
 
 		// 16-bit flash device at LocalPlus Bus CS0
 		flash@0,0 {
 			compatible = "cfi-flash";
-			reg = <0 0 01000000>;
+			reg = <0 0 0x01000000>;
 			bank-width = <2>;
 			device-width = <2>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 65bcea6..773a68e 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -10,6 +10,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "tqc,tqm5200";
 	compatible = "tqc,tqm5200";
@@ -23,10 +25,10 @@
 		PowerPC,5200@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;	// L1, 16K
+			i-cache-size = <0x4000>;	// L1, 16K
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -35,21 +37,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;	// 64MB
+		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc5200-immr";
-		ranges = <0 f0000000 0000c000>;
-		reg = <f0000000 00000100>;
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
 			compatible = "fsl,mpc5200-cdm";
-			reg = <200 38>;
+			reg = <0x200 0x38>;
 		};
 
 		mpc5200_pic: interrupt-controller@500 {
@@ -57,12 +59,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			compatible = "fsl,mpc5200-pic";
-			reg = <500 80>;
+			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			reg = <600 10>;
+			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
@@ -70,38 +72,38 @@
 
 		gpio@b00 {
 			compatible = "fsl,mpc5200-gpio";
-			reg = <b00 40>;
+			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200-ohci","ohci-be";
-			reg = <1000 ff>;
+			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
 			compatible = "fsl,mpc5200-bestcomm";
-			reg = <1200 80>;
+			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
-			              3 8 0  3 9 0  3 a 0  3 b 0
-			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
 			compatible = "fsl,mpc5200-xlb";
-			reg = <1f00 100>;
+			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
-			reg = <2000 100>;
+			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -110,7 +112,7 @@
 			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <1>;  // Logical port assignment
-			reg = <2200 100>;
+			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -119,7 +121,7 @@
 			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <2>;  // Logical port assignment
-			reg = <2400 100>;
+			reg = <0x2400 0x100>;
 			interrupts = <2 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -127,7 +129,7 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200-fec";
-			reg = <3000 400>;
+			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -137,8 +139,8 @@
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
-			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
+			compatible = "fsl,mpc5200-mdio";
+			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
 
@@ -150,7 +152,7 @@
 
 		ata@3a00 {
 			compatible = "fsl,mpc5200-ata";
-			reg = <3a00 100>;
+			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
@@ -159,21 +161,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
-			reg = <3d40 40>;
-			interrupts = <2 10 0>;
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 
 			 rtc@68 {
 				device_type = "rtc";
 				compatible = "dallas,ds1307";
-				reg = <68>;
+				reg = <0x68>;
 			};
 		};
 
 		sram@8000 {
 			compatible = "fsl,mpc5200-sram";
-			reg = <8000 4000>;
+			reg = <0x8000 0x4000>;
 		};
 	};
 
@@ -182,11 +184,11 @@
 		compatible = "fsl,lpb";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <0 0 fc000000 02000000>;
+		ranges = <0 0 0xfc000000 0x02000000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
-			reg = <0 0 02000000>;
+			reg = <0 0 0x02000000>;
 			bank-width = <4>;
 			device-width = <2>;
 			#size-cells = <1>;
@@ -200,18 +202,18 @@
 		#address-cells = <3>;
 		device_type = "pci";
 		compatible = "fsl,mpc5200-pci";
-		reg = <f0000d00 100>;
-		interrupt-map-mask = <f800 0 0 7>;
-		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
-				 c000 0 0 2 &mpc5200_pic 0 0 3
-				 c000 0 0 3 &mpc5200_pic 0 0 3
-				 c000 0 0 4 &mpc5200_pic 0 0 3>;
+		reg = <0xf0000d00 0x100>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3
+				 0xc000 0 0 2 &mpc5200_pic 0 0 3
+				 0xc000 0 0 3 &mpc5200_pic 0 0 3
+				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
 		clock-frequency = <0>; // From boot loader
-		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupts = <2 8 0 2 9 0 2 10 0>;
 		interrupt-parent = <&mpc5200_pic>;
 		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 10000000
-			  02000000 0 90000000 90000000 0 10000000
-			  01000000 0 00000000 a0000000 0 01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
+			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 };
