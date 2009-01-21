Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 66F854752A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:24 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1577843ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:22 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/8] powerpc/5200: Trim cruft from device trees
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:18 -0700
Message-ID: <20090121205518.31232.58846.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Trim out obsolete/extraneous properties and tighten up some usage
conventions.  Changes include:
- removal of device_type properties
- removal of cell-index properties
- Addition of gpio-controller and #gpio-cells properties to gpio
  nodes
- Move common interrupt-parent property out of device nodes and
  into top level parent node.

This patch also include what looks to be just trivial editorial
whitespace/format changes, but there is real method in this
madness.  Editorial changes were made to keep the all the
mpc5200 board device trees as similar as possible so that diffs
between them only show the real differences between the boards.
The pcm030 device tree was most affected by this because many
of the comments had been changed from // to /* */ style and
some cell values where changed from decimal to hex format when
it was cloned from one of the other 5200 device trees.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/boot/dts/cm5200.dts    |   45 ++-------
 arch/powerpc/boot/dts/lite5200.dts  |   52 ----------
 arch/powerpc/boot/dts/lite5200b.dts |   63 ++----------
 arch/powerpc/boot/dts/motionpro.dts |   42 ++------
 arch/powerpc/boot/dts/pcm030.dts    |  182 +++++++++++++----------------------
 arch/powerpc/boot/dts/tqm5200.dts   |   32 +-----
 6 files changed, 104 insertions(+), 312 deletions(-)


diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 2f74cc4..11ada32 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -17,6 +17,7 @@
 	compatible = "schindler,cm5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -66,7 +67,6 @@
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
 		};
 
@@ -74,84 +74,76 @@
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x670 0x10>;
 			interrupts = <1 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
-		gpio@b00 {
+		gpio_simple: gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
-		gpio@c00 {
+		gpio_wkup: gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
@@ -161,7 +153,6 @@
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 10 0  3 11 0
 			              3 12 0  3 13 0  3 14 0  3 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
@@ -170,48 +161,34 @@
 		};
 
 		serial@2000 {		// PSC1
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <0>;  // Logical port assignment
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		serial@2200 {		// PSC2
-			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
-			port-number = <1>;  // Logical port assignment
 			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		serial@2400 {		// PSC3
-			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
-			port-number = <2>;  // Logical port assignment
 			reg = <0x2400 0x100>;
 			interrupts = <2 3 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		serial@2c00 {		// PSC6
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <5>;  // Logical port assignment
 			reg = <0x2c00 0x100>;
 			interrupts = <2 4 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		ethernet@3000 {
-			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			phy-handle = <&phy0>;
 		};
 
@@ -221,10 +198,8 @@
 			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
-			interrupt-parent = <&mpc5200_pic>;
 
 			phy0: ethernet-phy@0 {
-				device_type = "ethernet-phy";
 				reg = <0>;
 			};
 		};
@@ -235,7 +210,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 
@@ -245,9 +219,8 @@
 		};
 	};
 
-	lpb {
-		model = "fsl,lpb";
-		compatible = "fsl,lpb";
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <0 0 0xfc000000 0x2000000>;
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 3f7a5dc..de30b3f 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -17,6 +17,7 @@
 	compatible = "fsl,lite5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -58,96 +59,74 @@
 			// 5200 interrupts are encoded into two levels;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			device_type = "interrupt-controller";
 			compatible = "fsl,mpc5200-pic";
 			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <0>;
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
 		};
 
 		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <1>;
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <2>;
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <3>;
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <4>;
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <5>;
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <6>;
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
 			compatible = "fsl,mpc5200-gpt";
-			cell-index = <7>;
 			reg = <0x670 0x10>;
 			interrupts = <1 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		can@900 {
 			compatible = "fsl,mpc5200-mscan";
-			cell-index = <0>;
 			interrupts = <2 17 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x900 0x80>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200-mscan";
-			cell-index = <1>;
 			interrupts = <2 18 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x980 0x80>;
 		};
 
@@ -155,39 +134,33 @@
 			compatible = "fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
 			compatible = "fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
-			device_type = "dma-controller";
 			compatible = "fsl,mpc5200-bestcomm";
 			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 10 0  3 11 0
 			              3 12 0  3 13 0  3 14 0  3 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
@@ -196,13 +169,10 @@
 		};
 
 		serial@2000 {		// PSC1
-			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
-			port-number = <0>;  // Logical port assignment
 			cell-index = <0>;
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		// PSC2 in ac97 mode example
@@ -211,7 +181,6 @@
 		//	cell-index = <1>;
 		//	reg = <0x2200 0x100>;
 		//	interrupts = <2 2 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC3 in CODEC mode example
@@ -220,27 +189,22 @@
 		//	cell-index = <2>;
 		//	reg = <0x2400 0x100>;
 		//	interrupts = <2 3 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC4 in uart mode example
 		//serial@2600 {		// PSC4
-		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200-psc-uart";
 		//	cell-index = <3>;
 		//	reg = <0x2600 0x100>;
 		//	interrupts = <2 11 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC5 in uart mode example
 		//serial@2800 {		// PSC5
-		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200-psc-uart";
 		//	cell-index = <4>;
 		//	reg = <0x2800 0x100>;
 		//	interrupts = <2 12 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC6 in spi mode example
@@ -249,16 +213,13 @@
 		//	cell-index = <5>;
 		//	reg = <0x2c00 0x100>;
 		//	interrupts = <2 4 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		ethernet@3000 {
-			device_type = "network";
 			compatible = "fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			phy-handle = <&phy0>;
 		};
 
@@ -268,30 +229,24 @@
 			compatible = "fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
-			interrupt-parent = <&mpc5200_pic>;
 
 			phy0: ethernet-phy@1 {
-				device_type = "ethernet-phy";
 				reg = <1>;
 			};
 		};
 
 		ata@3a00 {
-			device_type = "ata";
 			compatible = "fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		i2c@3d00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
-			cell-index = <0>;
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 
@@ -299,14 +254,12 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
-			cell-index = <1>;
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 		sram@8000 {
-			compatible = "fsl,mpc5200-sram","sram";
+			compatible = "fsl,mpc5200-sram";
 			reg = <0x8000 0x4000>;
 		};
 	};
@@ -325,7 +278,6 @@
 				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
-		interrupt-parent = <&mpc5200_pic>;
 		bus-range = <0 0>;
 		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
 			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 63e3bb4..c63e356 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -17,6 +17,7 @@
 	compatible = "fsl,lite5200b";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -58,136 +59,112 @@
 			// 5200 interrupts are encoded into two levels;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			device_type = "interrupt-controller";
 			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
 			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <0>;
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
 		};
 
 		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <1>;
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <2>;
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <3>;
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <4>;
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <5>;
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <6>;
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <7>;
 			reg = <0x670 0x10>;
 			interrupts = <1 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		can@900 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
-			cell-index = <0>;
 			interrupts = <2 17 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x900 0x80>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
-			cell-index = <1>;
 			interrupts = <2 18 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x980 0x80>;
 		};
 
-		gpio@b00 {
+		gpio_simple: gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
-		gpio@c00 {
+		gpio_wkup: gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
-			device_type = "dma-controller";
 			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
 			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 10 0  3 11 0
 			              3 12 0  3 13 0  3 14 0  3 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
@@ -196,13 +173,10 @@
 		};
 
 		serial@2000 {		// PSC1
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <0>;  // Logical port assignment
 			cell-index = <0>;
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		// PSC2 in ac97 mode example
@@ -211,7 +185,6 @@
 		//	cell-index = <1>;
 		//	reg = <0x2200 0x100>;
 		//	interrupts = <2 2 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC3 in CODEC mode example
@@ -220,27 +193,22 @@
 		//	cell-index = <2>;
 		//	reg = <0x2400 0x100>;
 		//	interrupts = <2 3 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC4 in uart mode example
 		//serial@2600 {		// PSC4
-		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 		//	cell-index = <3>;
 		//	reg = <0x2600 0x100>;
 		//	interrupts = <2 11 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC5 in uart mode example
 		//serial@2800 {		// PSC5
-		//	device_type = "serial";
 		//	compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 		//	cell-index = <4>;
 		//	reg = <0x2800 0x100>;
 		//	interrupts = <2 12 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		// PSC6 in spi mode example
@@ -249,49 +217,40 @@
 		//	cell-index = <5>;
 		//	reg = <0x2c00 0x100>;
 		//	interrupts = <2 4 0>;
-		//	interrupt-parent = <&mpc5200_pic>;
 		//};
 
 		ethernet@3000 {
-			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			phy-handle = <&phy0>;
 		};
 
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
-			interrupt-parent = <&mpc5200_pic>;
 
 			phy0: ethernet-phy@0 {
-				device_type = "ethernet-phy";
 				reg = <0>;
 			};
 		};
 
 		ata@3a00 {
-			device_type = "ata";
 			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		i2c@3d00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-			cell-index = <0>;
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 
@@ -299,14 +258,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-			cell-index = <1>;
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
+
 		sram@8000 {
-			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
+			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
 			reg = <0x8000 0x4000>;
 		};
 	};
@@ -330,7 +288,6 @@
 				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
-		interrupt-parent = <&mpc5200_pic>;
 		bus-range = <0 0>;
 		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
 			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 52ba6f9..7be8ca0 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -17,6 +17,7 @@
 	compatible = "promess,motionpro";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -66,7 +67,6 @@
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
 		};
 
@@ -74,35 +74,30 @@
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		motionpro-led@660 {	// Motion-PRO status LED
@@ -110,7 +105,6 @@
 			label = "motionpro-statusled";
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			blink-delay = <100>; // 100 msec
 		};
 
@@ -119,49 +113,46 @@
 			label = "motionpro-readyled";
 			reg = <0x670 0x10>;
 			interrupts = <1 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
 			interrupts = <2 18 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x980 0x80>;
 		};
 
-		gpio@b00 {
+		gpio_simple: gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
-		gpio@c00 {
+		gpio_wkup: gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
@@ -171,7 +162,6 @@
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 10 0  3 11 0
 			              3 12 0  3 13 0  3 14 0  3 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
@@ -180,12 +170,9 @@
 		};
 
 		serial@2000 {		// PSC1
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <0>;  // Logical port assignment
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		// PSC2 in spi master mode 
@@ -194,26 +181,20 @@
 			cell-index = <1>;
 			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		// PSC5 in uart mode
 		serial@2800 {		// PSC5
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <4>;  // Logical port assignment
 			reg = <0x2800 0x100>;
 			interrupts = <2 12 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		ethernet@3000 {
-			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			phy-handle = <&phy0>;
 		};
 
@@ -223,10 +204,8 @@
 			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
-			interrupt-parent = <&mpc5200_pic>;
 
 			phy0: ethernet-phy@2 {
-				device_type = "ethernet-phy";
 				reg = <2>;
 			};
 		};
@@ -235,7 +214,6 @@
 			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		i2c@3d40 {
@@ -244,7 +222,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 
 			rtc@68 {
@@ -259,8 +236,8 @@
 		};
 	};
 
-	lpb {
-		compatible = "fsl,lpb";
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <0 0 0xff000000 0x01000000
@@ -273,7 +250,6 @@
 			compatible = "promess,motionpro-kollmorgen";
 			reg = <1 0 0x10000>;
 			interrupts = <1 1 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		// 8-bit board CPLD on LocalPlus Bus CS2
diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index be2c11c..8958347 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -19,6 +19,7 @@
 	compatible = "phytec,pcm030";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -29,26 +30,26 @@
 			reg = <0>;
 			d-cache-line-size = <32>;
 			i-cache-line-size = <32>;
-			d-cache-size = <0x4000>;	/* L1, 16K          */
-			i-cache-size = <0x4000>;	/* L1, 16K          */
-			timebase-frequency = <0>;	/* From Bootloader  */
-			bus-frequency = <0>;		/* From Bootloader  */
-			clock-frequency = <0>;		/* From Bootloader  */
+			d-cache-size = <0x4000>;	// L1, 16K
+			i-cache-size = <0x4000>;	// L1, 16K
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x04000000>;	/* 64MB */
+		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc5200b-immr";
-		ranges = <0x0 0xf0000000 0x0000c000>;
-		bus-frequency = <0>;		/* From bootloader */
-		system-frequency = <0>;		/* From bootloader */
+		ranges = <0 0xf0000000 0x0000c000>;
+		bus-frequency = <0>;		// from bootloader
+		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
 			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
@@ -56,87 +57,70 @@
 		};
 
 		mpc5200_pic: interrupt-controller@500 {
-			/* 5200 interrupts are encoded into two levels; */
+			// 5200 interrupts are encoded into two levels;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			device_type = "interrupt-controller";
 			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
 			reg = <0x500 0x80>;
 		};
 
-		timer@600 {	/* General Purpose Timer */
+		timer@600 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <0>;
 			reg = <0x600 0x10>;
-			interrupts = <0x1 0x9 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 9 0>;
 			fsl,has-wdt;
 		};
 
-		timer@610 {	/* General Purpose Timer */
+		timer@610 {	// General Purpose Timer
 			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
-			cell-index = <1>;
 			reg = <0x610 0x10>;
-			interrupts = <0x1 0xa 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 10 0>;
 		};
 
-		gpt2: timer@620 { /* General Purpose Timer in GPIO mode */
+		gpt2: timer@620 {	// General Purpose Timer in GPIO mode
 			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
-			cell-index = <2>;
 			reg = <0x620 0x10>;
-			interrupts = <0x1 0xb 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 11 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
 
-		gpt3: timer@630 { /* General Purpose Timer in GPIO mode */
+		gpt3: timer@630 {	// General Purpose Timer in GPIO mode
 			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
-			cell-index = <3>;
 			reg = <0x630 0x10>;
-			interrupts = <0x1 0xc 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 12 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
 
-		gpt4: timer@640 { /* General Purpose Timer in GPIO mode */
+		gpt4: timer@640 {	// General Purpose Timer in GPIO mode
 			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
-			cell-index = <4>;
 			reg = <0x640 0x10>;
-			interrupts = <0x1 0xd 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 13 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
 
-		gpt5: timer@650 { /* General Purpose Timer in GPIO mode */
+		gpt5: timer@650 {	// General Purpose Timer in GPIO mode
 			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
-			cell-index = <5>;
 			reg = <0x650 0x10>;
-			interrupts = <0x1 0xe 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 14 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
 
-		gpt6: timer@660 { /* General Purpose Timer in GPIO mode */
+		gpt6: timer@660 {	// General Purpose Timer in GPIO mode
 			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
-			cell-index = <6>;
 			reg = <0x660 0x10>;
-			interrupts = <0x1 0xf 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 15 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
 
-		gpt7: timer@670 { /* General Purpose Timer in GPIO mode */
+		gpt7: timer@670 {	// General Purpose Timer in GPIO mode
 			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
-			cell-index = <7>;
 			reg = <0x670 0x10>;
-			interrupts = <0x1 0x10 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 16 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
@@ -144,40 +128,33 @@
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
-			interrupts = <0x1 0x5 0x0 0x1 0x6 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 5 0 1 6 0>;
 		};
 
 		can@900 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
-			cell-index = <0>;
-			interrupts = <0x2 0x11 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 17 0>;
 			reg = <0x900 0x80>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
-			cell-index = <1>;
-			interrupts = <0x2 0x12 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 18 0>;
 			reg = <0x980 0x80>;
 		};
 
 		gpio_simple: gpio@b00 {
 			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
-			interrupts = <0x1 0x7 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 7 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
 
-		gpio_wkup: gpio-wkup@c00 {
+		gpio_wkup: gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
-			interrupts = <0x1 0x8 0x0 0x0 0x3 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <1 8 0 0 3 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
@@ -185,26 +162,22 @@
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
-			interrupts = <0x2 0xd 0x0 0x2 0xe 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 13 0 2 14 0>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
-			interrupts = <0x2 0x6 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 6 0>;
 		};
 
 		dma-controller@1200 {
-			device_type = "dma-controller";
 			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
 			reg = <0x1200 0x80>;
-			interrupts = <0x3 0x0 0x0  0x3 0x1 0x0  0x3 0x2 0x0  0x3 0x3 0x0
-			              0x3 0x4 0x0  0x3 0x5 0x0  0x3 0x6 0x0  0x3 0x7 0x0
-			              0x3 0x8 0x0  0x3 0x9 0x0  0x3 0xa 0x0  0x3 0xb 0x0
-			              0x3 0xc 0x0  0x3 0xd 0x0  0x3 0xe 0x0  0x3 0xf 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
+			              3 4 0  3 5 0  3 6 0  3 7 0
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
 		};
 
 		xlb@1f00 {
@@ -213,24 +186,19 @@
 		};
 
 		ac97@2000 { /* PSC1 in ac97 mode */
-			device_type = "sound";
 			compatible = "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
 			cell-index = <0>;
 			reg = <0x2000 0x100>;
-			interrupts = <0x2 0x2 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 1 0>;
 		};
 
 		/* PSC2 port is used by CAN1/2 */
 
 		serial@2400 { /* PSC3 in UART mode */
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <0>;
 			cell-index = <2>;
 			reg = <0x2400 0x100>;
-			interrupts = <0x2 0x3 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 3 0>;
 		};
 
 		/* PSC4 is ??? */
@@ -238,55 +206,44 @@
 		/* PSC5 is ??? */
 
 		serial@2c00 { /* PSC6 in UART mode */
-			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			port-number = <1>;
 			cell-index = <5>;
 			reg = <0x2c00 0x100>;
-			interrupts = <0x2 0x4 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 4 0>;
 		};
 
 		ethernet@3000 {
-			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
-			local-mac-address = [00 00 00 00 00 00];
-			interrupts = <0x2 0x5 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <2 5 0>;
 			phy-handle = <&phy0>;
 		};
 
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
-			reg = <0x3000 0x400>;	/* fec range, since we need to setup fec interrupts */
-			interrupts = <0x2 0x5 0x0>;	/* these are for "mii command finished", not link changes & co. */
-			interrupt-parent = <&mpc5200_pic>;
-
-			phy0:ethernet-phy@0 {
-				device_type = "ethernet-phy";
-				reg = <0x0>;
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+
+			phy0: ethernet-phy@0 {
+				reg = <0>;
 			};
 		};
 
 		ata@3a00 {
-			device_type = "ata";
 			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
-			interrupts = <0x2 0x7 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 7 0>;
 		};
 
 		i2c@3d00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-			cell-index = <0>;
 			reg = <0x3d00 0x40>;
-			interrupts = <0x2 0xf 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 15 0>;
 			fsl5200-clocking;
 		};
 
@@ -294,10 +251,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-			cell-index = <1>;
 			reg = <0x3d40 0x40>;
-			interrupts = <0x2 0x10 0x0>;
-			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <2 16 0>;
 			fsl5200-clocking;
 			rtc@51 {
 				compatible = "nxp,pcf8563";
@@ -307,7 +262,7 @@
 		};
 
 		sram@8000 {
-			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
+			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
 			reg = <0x8000 0x4000>;
 		};
 
@@ -340,22 +295,21 @@
 		device_type = "pci";
 		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
 		reg = <0xf0000d00 0x100>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <0xc000 0x0 0x0 0x1 &mpc5200_pic 0x0 0x0 0x3 /* 1st slot */
-				 0xc000 0x0 0x0 0x2 &mpc5200_pic 0x1 0x1 0x3
-				 0xc000 0x0 0x0 0x3 &mpc5200_pic 0x1 0x2 0x3
-				 0xc000 0x0 0x0 0x4 &mpc5200_pic 0x1 0x3 0x3
-
-				 0xc800 0x0 0x0 0x1 &mpc5200_pic 0x1 0x1 0x3 /* 2nd slot */
-				 0xc800 0x0 0x0 0x2 &mpc5200_pic 0x1 0x2 0x3
-				 0xc800 0x0 0x0 0x3 &mpc5200_pic 0x1 0x3 0x3
-				 0xc800 0x0 0x0 0x4 &mpc5200_pic 0x0 0x0 0x3>;
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
-		interrupts = <0x2 0x8 0x0 0x2 0x9 0x0 0x2 0xa 0x0>;
-		interrupt-parent = <&mpc5200_pic>;
+		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0xb0000000 0x0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 906302e..c9590b5 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -17,6 +17,7 @@
 	compatible = "tqc,tqm5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -66,36 +67,33 @@
 			compatible = "fsl,mpc5200-gpt";
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl,has-wdt;
 		};
 
 		can@900 {
 			compatible = "fsl,mpc5200-mscan";
 			interrupts = <2 17 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x900 0x80>;
 		};
 
 		can@980 {
 			compatible = "fsl,mpc5200-mscan";
 			interrupts = <2 18 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x980 0x80>;
 		};
 
-		gpio@b00 {
+		gpio_simple: gpio@b00 {
 			compatible = "fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
 		};
 
 		usb@1000 {
 			compatible = "fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
@@ -105,7 +103,6 @@
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 10 0  3 11 0
 			              3 12 0  3 13 0  3 14 0  3 15 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		xlb@1f00 {
@@ -114,39 +111,28 @@
 		};
 
 		serial@2000 {		// PSC1
-			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
-			port-number = <0>;  // Logical port assignment
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		serial@2200 {		// PSC2
-			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
-			port-number = <1>;  // Logical port assignment
 			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		serial@2400 {		// PSC3
-			device_type = "serial";
 			compatible = "fsl,mpc5200-psc-uart";
-			port-number = <2>;  // Logical port assignment
 			reg = <0x2400 0x100>;
 			interrupts = <2 3 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		ethernet@3000 {
-			device_type = "network";
 			compatible = "fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			phy-handle = <&phy0>;
 		};
 
@@ -156,10 +142,8 @@
 			compatible = "fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
-			interrupt-parent = <&mpc5200_pic>;
 
 			phy0: ethernet-phy@0 {
-				device_type = "ethernet-phy";
 				reg = <0>;
 			};
 		};
@@ -168,7 +152,6 @@
 			compatible = "fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
-			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		i2c@3d40 {
@@ -177,7 +160,6 @@
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 
 			 rtc@68 {
@@ -192,9 +174,8 @@
 		};
 	};
 
-	lpb {
-		model = "fsl,lpb";
-		compatible = "fsl,lpb";
+	localbus {
+		compatible = "fsl,mpc5200-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <0 0 0xfc000000 0x02000000>;
@@ -223,7 +204,6 @@
 				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
-		interrupt-parent = <&mpc5200_pic>;
 		bus-range = <0 0>;
 		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
 			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
