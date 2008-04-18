Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 5AD18DE3D3
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:46:18 +1000 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JZJ009Y2LX1R0E0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Apr 2008 16:46:13 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JZJ00BGPLWVXT70@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 18 Apr 2008 16:46:14 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JZJ0095BLWTDK10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Apr 2008 16:46:06 -0600 (MDT)
Date: Fri, 18 Apr 2008 09:13:04 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/POWERPC] mpc5200: remove "mpc5200b-*" from compatible lists in
	dts files
To: linuxppc-dev@ozlabs.org, m8@semihalf.com
Message-id: <20080418161218.12738.25844.stgit@trillian.secretlab.ca>
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

From: Grant Likely <grant.likely@secretlab.ca>

The mpc5200b is a bug fix of the mpc5200 with a few incompatible changes.
By rights, the current dts trees are the most "correct", but in practical
purposes there is no value in the 5200b devices having 2 compatible
entries for each internal peripheral node.  Freescale has done a good job
of documenting exactly where the incompatibilities lie, so it restrict
the extra compatible properties to devices with *documented* changes.

Removing the extra 'b' fields makes the device trees smaller
---

 arch/powerpc/boot/dts/cm5200.dts    |   48 +++++++++++++------------
 arch/powerpc/boot/dts/lite5200b.dts |   66 ++++++++++++++++++-----------------
 arch/powerpc/boot/dts/motionpro.dts |   50 +++++++++++++--------------
 arch/powerpc/kernel/prom_init.c     |    2 +
 drivers/net/fec_mpc52xx_phy.c       |    2 +
 5 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 2f74cc4..5f929c3 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -43,14 +43,14 @@
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "fsl,mpc5200b-immr";
+		compatible = "fsl,mpc5200-immr";
 		ranges = <0 0xf0000000 0x0000c000>;
 		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
-			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
+			compatible = "fsl,mpc5200-cdm";
 			reg = <0x200 0x38>;
 		};
 
@@ -58,12 +58,12 @@
 			// 5200 interrupts are encoded into two levels;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			compatible = "fsl,mpc5200-pic";
 			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -71,91 +71,91 @@
 		};
 
 		timer@610 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@660 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@670 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x670 0x10>;
 			interrupts = <1 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		rtc@800 {	// Real time clock
-			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
+			compatible = "fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@b00 {
-			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			compatible = "fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
-			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
+			compatible = "fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
-			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			compatible = "fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
-			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
+			compatible = "fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
-			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
+			compatible = "fsl,mpc5200-bestcomm";
 			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
@@ -165,13 +165,13 @@
 		};
 
 		xlb@1f00 {
-			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			compatible = "fsl,mpc5200-xlb";
 			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
-			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
@@ -198,7 +198,7 @@
 
 		serial@2c00 {		// PSC6
 			device_type = "serial";
-			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <5>;  // Logical port assignment
 			reg = <0x2c00 0x100>;
 			interrupts = <2 4 0>;
@@ -207,7 +207,7 @@
 
 		ethernet@3000 {
 			device_type = "network";
-			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			compatible = "fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
@@ -218,7 +218,7 @@
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			compatible = "fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
@@ -232,7 +232,7 @@
 		i2c@3d40 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -240,7 +240,7 @@
 		};
 
 		sram@8000 {
-			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
+			compatible = "fsl,mpc5200-sram";
 			reg = <0x8000 0x4000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 7bd5b9c..0f3e68d 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -43,14 +43,14 @@
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "fsl,mpc5200b-immr";
+		compatible = "fsl,mpc5200-immr";
 		ranges = <0 0xf0000000 0x0000c000>;
 		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
-			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
+			compatible = "fsl,mpc5200-cdm";
 			reg = <0x200 0x38>;
 		};
 
@@ -59,12 +59,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			compatible = "fsl,mpc5200-pic";
 			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <0>;
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
@@ -73,7 +73,7 @@
 		};
 
 		timer@610 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <1>;
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
@@ -81,7 +81,7 @@
 		};
 
 		timer@620 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <2>;
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
@@ -89,7 +89,7 @@
 		};
 
 		timer@630 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <3>;
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
@@ -97,7 +97,7 @@
 		};
 
 		timer@640 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <4>;
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
@@ -105,7 +105,7 @@
 		};
 
 		timer@650 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <5>;
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
@@ -113,7 +113,7 @@
 		};
 
 		timer@660 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <6>;
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
@@ -121,7 +121,7 @@
 		};
 
 		timer@670 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			cell-index = <7>;
 			reg = <0x670 0x10>;
 			interrupts = <1 16 0>;
@@ -129,7 +129,7 @@
 		};
 
 		rtc@800 {	// Real time clock
-			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
+			compatible = "fsl,mpc5200-rtc";
 			device_type = "rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
@@ -137,7 +137,7 @@
 		};
 
 		can@900 {
-			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			compatible = "fsl,mpc5200-mscan";
 			cell-index = <0>;
 			interrupts = <2 17 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -145,7 +145,7 @@
 		};
 
 		can@980 {
-			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			compatible = "fsl,mpc5200-mscan";
 			cell-index = <1>;
 			interrupts = <2 18 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -153,28 +153,28 @@
 		};
 
 		gpio@b00 {
-			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			compatible = "fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
-			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
+			compatible = "fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
-			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			compatible = "fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
-			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
+			compatible = "fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -182,7 +182,7 @@
 
 		dma-controller@1200 {
 			device_type = "dma-controller";
-			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
+			compatible = "fsl,mpc5200-bestcomm";
 			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
@@ -192,13 +192,13 @@
 		};
 
 		xlb@1f00 {
-			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			compatible = "fsl,mpc5200-xlb";
 			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
-			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
 			cell-index = <0>;
 			reg = <0x2000 0x100>;
@@ -208,7 +208,7 @@
 
 		// PSC2 in ac97 mode example
 		//ac97@2200 {		// PSC2
-		//	compatible = "fsl,mpc5200b-psc-ac97","fsl,mpc5200-psc-ac97";
+		//	compatible = "fsl,mpc5200b-psc-ac97";
 		//	cell-index = <1>;
 		//	reg = <0x2200 0x100>;
 		//	interrupts = <2 2 0>;
@@ -217,7 +217,7 @@
 
 		// PSC3 in CODEC mode example
 		//i2s@2400 {		// PSC3
-		//	compatible = "fsl,mpc5200b-psc-i2s"; //not 5200 compatible
+		//	compatible = "fsl,mpc5200-psc-i2s";
 		//	cell-index = <2>;
 		//	reg = <0x2400 0x100>;
 		//	interrupts = <2 3 0>;
@@ -227,7 +227,7 @@
 		// PSC4 in uart mode example
 		//serial@2600 {		// PSC4
 		//	device_type = "serial";
-		//	compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+		//	compatible = "fsl,mpc5200-psc-uart";
 		//	cell-index = <3>;
 		//	reg = <0x2600 0x100>;
 		//	interrupts = <2 11 0>;
@@ -237,7 +237,7 @@
 		// PSC5 in uart mode example
 		//serial@2800 {		// PSC5
 		//	device_type = "serial";
-		//	compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+		//	compatible = "fsl,mpc5200-psc-uart";
 		//	cell-index = <4>;
 		//	reg = <0x2800 0x100>;
 		//	interrupts = <2 12 0>;
@@ -246,7 +246,7 @@
 
 		// PSC6 in spi mode example
 		//spi@2c00 {		// PSC6
-		//	compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
+		//	compatible = "fsl,mpc5200-psc-spi";
 		//	cell-index = <5>;
 		//	reg = <0x2c00 0x100>;
 		//	interrupts = <2 4 0>;
@@ -255,7 +255,7 @@
 
 		ethernet@3000 {
 			device_type = "network";
-			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			compatible = "fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
@@ -266,7 +266,7 @@
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
+			compatible = "fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
@@ -279,7 +279,7 @@
 
 		ata@3a00 {
 			device_type = "ata";
-			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
+			compatible = "fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -288,7 +288,7 @@
 		i2c@3d00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
@@ -299,7 +299,7 @@
 		i2c@3d40 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
@@ -307,7 +307,7 @@
 			fsl5200-clocking;
 		};
 		sram@8000 {
-			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
+			compatible = "fsl,mpc5200-sram","sram";
 			reg = <0x8000 0x4000>;
 		};
 	};
@@ -317,7 +317,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
-		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
+		compatible = "fsl,mpc5200-pci";
 		reg = <0xf0000d00 0x100>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 9e3c921..9422d59 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -43,14 +43,14 @@
 	soc5200@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "fsl,mpc5200b-immr";
+		compatible = "fsl,mpc5200-immr";
 		ranges = <0 0xf0000000 0x0000c000>;
 		reg = <0xf0000000 0x00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
-			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
+			compatible = "fsl,mpc5200-cdm";
 			reg = <0x200 0x38>;
 		};
 
@@ -58,12 +58,12 @@
 			// 5200 interrupts are encoded into two levels;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			compatible = "fsl,mpc5200-pic";
 			reg = <0x500 0x80>;
 		};
 
 		timer@600 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x600 0x10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -71,35 +71,35 @@
 		};
 
 		timer@610 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x610 0x10>;
 			interrupts = <1 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@620 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x620 0x10>;
 			interrupts = <1 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@630 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x630 0x10>;
 			interrupts = <1 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@640 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x640 0x10>;
 			interrupts = <1 13 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		timer@650 {	// General Purpose Timer
-			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			compatible = "fsl,mpc5200-gpt";
 			reg = <0x650 0x10>;
 			interrupts = <1 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -123,49 +123,49 @@
 		};
 
 		rtc@800 {	// Real time clock
-			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
+			compatible = "fsl,mpc5200-rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		can@980 {
-			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			compatible = "fsl,mpc5200-mscan";
 			interrupts = <2 18 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			reg = <0x980 0x80>;
 		};
 
 		gpio@b00 {
-			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			compatible = "fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio@c00 {
-			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
+			compatible = "fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		spi@f00 {
-			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			compatible = "fsl,mpc5200-spi";
 			reg = <0xf00 0x20>;
 			interrupts = <2 13 0 2 14 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		usb@1000 {
-			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
+			compatible = "fsl,mpc5200-ohci","ohci-be";
 			reg = <0x1000 0xff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		dma-controller@1200 {
-			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
+			compatible = "fsl,mpc5200-bestcomm";
 			reg = <0x1200 0x80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
@@ -175,13 +175,13 @@
 		};
 
 		xlb@1f00 {
-			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			compatible = "fsl,mpc5200-xlb";
 			reg = <0x1f00 0x100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
-			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
@@ -190,7 +190,7 @@
 
 		// PSC2 in spi master mode 
 		spi@2200 {		// PSC2
-			compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
+			compatible = "fsl,mpc5200-psc-spi";
 			cell-index = <1>;
 			reg = <0x2200 0x100>;
 			interrupts = <2 2 0>;
@@ -200,7 +200,7 @@
 		// PSC5 in uart mode
 		serial@2800 {		// PSC5
 			device_type = "serial";
-			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			compatible = "fsl,mpc5200-psc-uart";
 			port-number = <4>;  // Logical port assignment
 			reg = <0x2800 0x100>;
 			interrupts = <2 12 0>;
@@ -209,7 +209,7 @@
 
 		ethernet@3000 {
 			device_type = "network";
-			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			compatible = "fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
@@ -220,7 +220,7 @@
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			compatible = "fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
@@ -232,7 +232,7 @@
 		};
 
 		ata@3a00 {
-			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
+			compatible = "fsl,mpc5200-ata";
 			reg = <0x3a00 0x100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -241,7 +241,7 @@
 		i2c@3d40 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -255,7 +255,7 @@
 		};
 
 		sram@8000 {
-			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
+			compatible = "fsl,mpc5200-sram";
 			reg = <0x8000 0x4000>;
 		};
 	};
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6d6df1e..af837b2 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2179,7 +2179,7 @@ static void __init fixup_device_tree_efika_add_phy(void)
 				" 1 encode-int s\" #address-cells\" property"
 				" 0 encode-int s\" #size-cells\" property"
 				" s\" mdio\" device-name"
-				" s\" fsl,mpc5200b-mdio\" encode-string"
+				" s\" fsl,mpc5200-mdio\" encode-string"
 				" s\" compatible\" property"
 				" 0xf0003000 0x400 reg"
 				" 0x2 encode-int"
diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index 1d0cd1d..cdca6fe 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -185,7 +185,7 @@ static struct of_device_id mpc52xx_fec_mdio_match[] = {
 };
 
 struct of_platform_driver mpc52xx_fec_mdio_driver = {
-	.name = "mpc5200b-fec-phy",
+	.name = "mpc5200-fec-phy",
 	.probe = mpc52xx_fec_mdio_probe,
 	.remove = mpc52xx_fec_mdio_remove,
 	.match_table = mpc52xx_fec_mdio_match,
