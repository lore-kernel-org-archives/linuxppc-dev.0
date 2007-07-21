Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2B56CDDED2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 08:43:14 +1000 (EST)
Date: Sun, 22 Jul 2007 00:43:11 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Update kuroboxH[GD].dts with i2c rtc entries, cleanup
Message-ID: <Pine.LNX.4.60.0707220028370.13322@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Let's fix rtc on linkstation ppc machines again, plus .dts cleanup as 
suggested by Segher Boessenkool.

Thanks
Guennadi
---
Guennadi Liakhovetski

Device tree update: add rtc nodes on i2c, remove bogus 0-size cache-line 
declarations, rename interrupt-controller nodes, remove erroneous 
interrupt-parent line, accidentally introduced by a recent patch.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index a983680..1225374 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -33,12 +33,10 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 		PowerPC,603e { /* Really 8241 */
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <bebc200>;	/* Fixed by bootwrapper */
-			timebase-frequency = <1743000>; /* Fixed by bootwrapper */
-			bus-frequency = <0>;		/* From bootloader */
+			clock-frequency = <bebc200>;	/* Fixed by bootloader */
+			timebase-frequency = <1743000>; /* Fixed by bootloader */
+			bus-frequency = <0>;		/* Fixed by bootloader */
 			/* Following required by dtc but not used */
-			i-cache-line-size = <0>;
-			d-cache-line-size = <0>;
 			i-cache-size = <4000>;
 			d-cache-size = <4000>;
 		};
@@ -64,11 +62,19 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 			  fef00000 fef00000 00100000>;	/* pci iack */
 
 		i2c@80003000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
 			interrupt-parent = <&mpic>;
+
+			rtc@32 {
+				device_type = "rtc";
+				compatible = "ricoh,rs5c372b";
+				reg = <32>;
+			};
 		};
 
 		serial@80004500 {
@@ -91,7 +97,7 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 			interrupt-parent = <&mpic>;
 		};
 
-		mpic: pic@80040000 {
+		mpic: interrupt-controller@80040000 {
 			#interrupt-cells = <2>;
 			#address-cells = <0>;
 			device_type = "open-pic";
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 5cf42dc..579aa8b 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -33,12 +33,10 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 		PowerPC,603e { /* Really 8241 */
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */
-			timebase-frequency = <1F04000>; /* Fixed by bootwrapper */
-			bus-frequency = <0>;		/* From bootloader */
+			clock-frequency = <fdad680>;	/* Fixed by bootloader */
+			timebase-frequency = <1F04000>; /* Fixed by bootloader */
+			bus-frequency = <0>;		/* Fixed by bootloader */
 			/* Following required by dtc but not used */
-			i-cache-line-size = <0>;
-			d-cache-line-size = <0>;
 			i-cache-size = <4000>;
 			d-cache-size = <4000>;
 		};
@@ -64,11 +62,19 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 			  fef00000 fef00000 00100000>;	/* pci iack */
 
 		i2c@80003000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
 			interrupt-parent = <&mpic>;
+
+			rtc@32 {
+				device_type = "rtc";
+				compatible = "ricoh,rs5c372b";
+				reg = <32>;
+			};
 		};
 
 		serial@80004500 {
@@ -91,8 +97,7 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 			interrupt-parent = <&mpic>;
 		};
 
-		mpic: pic@80040000 {
-			interrupt-parent = <&mpic>;
+		mpic: interrupt-controller@80040000 {
 			#interrupt-cells = <2>;
 			#address-cells = <0>;
 			device_type = "open-pic";
