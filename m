Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A32671007D7
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 17:45:57 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pB86jo4L000747
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 00:45:50 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: update compatiable on fsl 16550 uart nodes
Date: Thu,  8 Dec 2011 00:45:50 -0600
Message-Id: <1323326750-6554-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale serial port's are pretty much a 16550, however there are
some FSL specific bugs and features.  Add a "fsl,ns16550" compatiable
string to allow code to handle those FSL specific issues.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/asp834x-redboot.dts    |    4 ++--
 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi   |    4 ++--
 arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi |    4 ++--
 arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi |    4 ++--
 arch/powerpc/boot/dts/gef_ppc9a.dts          |    4 ++--
 arch/powerpc/boot/dts/gef_sbc310.dts         |    4 ++--
 arch/powerpc/boot/dts/gef_sbc610.dts         |    4 ++--
 arch/powerpc/boot/dts/kmeter1.dts            |    2 +-
 arch/powerpc/boot/dts/kuroboxHD.dts          |    4 ++--
 arch/powerpc/boot/dts/kuroboxHG.dts          |    4 ++--
 arch/powerpc/boot/dts/mpc8308_p1m.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8308rdb.dts         |    4 ++--
 arch/powerpc/boot/dts/mpc8313erdb.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8315erdb.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8349emitx.dts       |    4 ++--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4 ++--
 arch/powerpc/boot/dts/mpc834x_mds.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc836x_rdk.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8377_mds.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8377_rdb.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8377_wlan.dts       |    4 ++--
 arch/powerpc/boot/dts/mpc8378_mds.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8378_rdb.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8379_mds.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8379_rdb.dts        |    4 ++--
 arch/powerpc/boot/dts/mpc8540ads.dts         |    4 ++--
 arch/powerpc/boot/dts/mpc8541cds.dts         |    4 ++--
 arch/powerpc/boot/dts/mpc8555cds.dts         |    4 ++--
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |    4 ++--
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    4 ++--
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts   |    4 ++--
 arch/powerpc/boot/dts/sbc8349.dts            |    4 ++--
 arch/powerpc/boot/dts/sbc8548.dts            |    4 ++--
 arch/powerpc/boot/dts/sbc8641d.dts           |    4 ++--
 arch/powerpc/boot/dts/socrates.dts           |    4 ++--
 arch/powerpc/boot/dts/storcenter.dts         |    4 ++--
 arch/powerpc/boot/dts/stxssa8555.dts         |    4 ++--
 arch/powerpc/boot/dts/tqm8540.dts            |    4 ++--
 arch/powerpc/boot/dts/tqm8541.dts            |    4 ++--
 arch/powerpc/boot/dts/tqm8548-bigflash.dts   |    4 ++--
 arch/powerpc/boot/dts/tqm8548.dts            |    4 ++--
 arch/powerpc/boot/dts/tqm8555.dts            |    4 ++--
 arch/powerpc/boot/dts/xcalibur1501.dts       |    4 ++--
 arch/powerpc/boot/dts/xpedite5200.dts        |    4 ++--
 arch/powerpc/boot/dts/xpedite5200_xmon.dts   |    4 ++--
 arch/powerpc/boot/dts/xpedite5301.dts        |    4 ++--
 arch/powerpc/boot/dts/xpedite5330.dts        |    4 ++--
 arch/powerpc/boot/dts/xpedite5370.dts        |    4 ++--
 51 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 261d10c..227290d 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -256,7 +256,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <400000000>;
 			interrupts = <9 0x8>;
@@ -266,7 +266,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <400000000>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
index 00fa1fd..5e268fd 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
@@ -35,7 +35,7 @@
 serial0: serial@4500 {
 	cell-index = <0>;
 	device_type = "serial";
-	compatible = "ns16550";
+	compatible = "fsl,ns16550", "ns16550";
 	reg = <0x4500 0x100>;
 	clock-frequency = <0>;
 	interrupts = <42 2 0 0>;
@@ -44,7 +44,7 @@ serial0: serial@4500 {
 serial1: serial@4600 {
 	cell-index = <1>;
 	device_type = "serial";
-	compatible = "ns16550";
+	compatible = "fsl,ns16550", "ns16550";
 	reg = <0x4600 0x100>;
 	clock-frequency = <0>;
 	interrupts = <42 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
index 66271e3..225c07b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
@@ -35,7 +35,7 @@
 serial0: serial@11c500 {
 	cell-index = <0>;
 	device_type = "serial";
-	compatible = "ns16550";
+	compatible = "fsl,ns16550", "ns16550";
 	reg = <0x11c500 0x100>;
 	clock-frequency = <0>;
 	interrupts = <36 2 0 0>;
@@ -44,7 +44,7 @@ serial0: serial@11c500 {
 serial1: serial@11c600 {
 	cell-index = <1>;
 	device_type = "serial";
-	compatible = "ns16550";
+	compatible = "fsl,ns16550", "ns16550";
 	reg = <0x11c600 0x100>;
 	clock-frequency = <0>;
 	interrupts = <36 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
index cf1a0ac..d23233a 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
@@ -35,7 +35,7 @@
 serial2: serial@11d500 {
 	cell-index = <2>;
 	device_type = "serial";
-	compatible = "ns16550";
+	compatible = "fsl,ns16550", "ns16550";
 	reg = <0x11d500 0x100>;
 	clock-frequency = <0>;
 	interrupts = <37 2 0 0>;
@@ -44,7 +44,7 @@ serial2: serial@11d500 {
 serial3: serial@11d600 {
 	cell-index = <3>;
 	device_type = "serial";
-	compatible = "ns16550";
+	compatible = "fsl,ns16550", "ns16550";
 	reg = <0x11d600 0x100>;
 	clock-frequency = <0>;
 	interrupts = <37 2 0 0>;
diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index 2266bbb..38dcb96 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -339,7 +339,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <0x2a 0x2>;
@@ -349,7 +349,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <0x1c 0x2>;
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 429e87d..5ab8932 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -337,7 +337,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <0x2a 0x2>;
@@ -347,7 +347,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <0x1c 0x2>;
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index d81201a..d5341f5 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -337,7 +337,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <0x2a 0x2>;
@@ -347,7 +347,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <0x1c 0x2>;
diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/dts/kmeter1.dts
index d16bae1..983aee1 100644
--- a/arch/powerpc/boot/dts/kmeter1.dts
+++ b/arch/powerpc/boot/dts/kmeter1.dts
@@ -80,7 +80,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <264000000>;
 			interrupts = <9 0x8>;
diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 8d725d1..0a45451 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -84,7 +84,7 @@ XXXX add flash parts, rtc, ??
 		serial0: serial@80004500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x80004500 0x8>;
 			clock-frequency = <97553800>;
 			current-speed = <9600>;
@@ -95,7 +95,7 @@ XXXX add flash parts, rtc, ??
 		serial1: serial@80004600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x80004600 0x8>;
 			clock-frequency = <97553800>;
 			current-speed = <57600>;
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index b13a11e..0e758b3 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -84,7 +84,7 @@ XXXX add flash parts, rtc, ??
 		serial0: serial@80004500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x80004500 0x8>;
 			clock-frequency = <130041000>;
 			current-speed = <9600>;
@@ -95,7 +95,7 @@ XXXX add flash parts, rtc, ??
 		serial1: serial@80004600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x80004600 0x8>;
 			clock-frequency = <130041000>;
 			current-speed = <57600>;
diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 697b3f6..22b0832 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -233,7 +233,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
@@ -243,7 +243,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
index a0bd188..f66d10d 100644
--- a/arch/powerpc/boot/dts/mpc8308rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
@@ -208,7 +208,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
@@ -218,7 +218,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index ac1eb32..1c836c6 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -261,7 +261,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -271,7 +271,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 4dd08c3..811848e 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -265,7 +265,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
@@ -275,7 +275,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 05ad8c9..da9c72d 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -105,7 +105,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -115,7 +115,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index f4fadb23a..ff7b15b 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -83,7 +83,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -93,7 +93,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 505dc84..2608679 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -283,7 +283,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <9 0x8>;
@@ -293,7 +293,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index eb73211..6cd044d 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -189,7 +189,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <9 0x8>;
@@ -199,7 +199,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 230febb..4552864 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -242,7 +242,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -252,7 +252,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 45cfa1c5..c0e450a 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -136,7 +136,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <264000000>;
 			interrupts = <9 0x8>;
@@ -146,7 +146,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <264000000>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index bdf4459..b6e9aec 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -102,7 +102,7 @@
 
 		serial0: serial@4500 {
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			interrupts = <9 8>;
 			interrupt-parent = <&ipic>;
@@ -112,7 +112,7 @@
 
 		serial1: serial@4600 {
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			interrupts = <10 8>;
 			interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 855782c..cfccef5 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -276,7 +276,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -286,7 +286,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index dbc1b98..353deff 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -321,7 +321,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -331,7 +331,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
index 9ea7830..ef4a305 100644
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
+++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -304,7 +304,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -314,7 +314,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index f70cf60..538fcb9 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -315,7 +315,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -325,7 +325,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 3447eb9..32333a9 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -321,7 +321,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -331,7 +331,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 645ec51..5387092 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -313,7 +313,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -323,7 +323,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 15560c6..46224c2 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -319,7 +319,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -329,7 +329,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 8d1bf0f..f99fb11 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -243,7 +243,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -253,7 +253,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 87ff965..0f5e939 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -209,7 +209,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -219,7 +219,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 5c5614f..fe10438 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -209,7 +209,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -219,7 +219,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 83c3218..6a109a0 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -175,7 +175,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -186,7 +186,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index fb8640e..1e8666c 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -328,7 +328,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -338,7 +338,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <28 2>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
index 8be8e70..fd4cd4d 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
@@ -328,7 +328,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -338,7 +338,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <28 2>;
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 0dc90f9..b1e45a8 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -222,7 +222,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -232,7 +232,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 94a3322..77be771 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -316,7 +316,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			interrupts = <0x2a 0x2>;
@@ -326,7 +326,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			interrupts = <0x2a 0x2>;
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index ee5538f..56bebce 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -347,7 +347,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -357,7 +357,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <28 2>;
diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/socrates.dts
index 38c3540..134a5ff 100644
--- a/arch/powerpc/boot/dts/socrates.dts
+++ b/arch/powerpc/boot/dts/socrates.dts
@@ -199,7 +199,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -209,7 +209,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
index eab680c..2a55573 100644
--- a/arch/powerpc/boot/dts/storcenter.dts
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -74,7 +74,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x20>;
 			clock-frequency = <97553800>; /* Hz */
 			current-speed = <115200>;
@@ -85,7 +85,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x20>;
 			clock-frequency = <97553800>; /* Hz */
 			current-speed = <9600>;
diff --git a/arch/powerpc/boot/dts/stxssa8555.dts b/arch/powerpc/boot/dts/stxssa8555.dts
index 49efd44..4f166b0 100644
--- a/arch/powerpc/boot/dts/stxssa8555.dts
+++ b/arch/powerpc/boot/dts/stxssa8555.dts
@@ -210,7 +210,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -220,7 +220,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 0a4cedb..ed264d9 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -250,7 +250,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -260,7 +260,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index f49d091..9252421 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -224,7 +224,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -234,7 +234,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 9452c3c..7adab94 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -305,7 +305,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
@@ -316,7 +316,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 619776f..589860e 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -305,7 +305,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
@@ -316,7 +316,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 81bad8c..aa6ff0d 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -224,7 +224,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -234,7 +234,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
index ac0a617..cc00f4d 100644
--- a/arch/powerpc/boot/dts/xcalibur1501.dts
+++ b/arch/powerpc/boot/dts/xcalibur1501.dts
@@ -531,7 +531,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -542,7 +542,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
index c41a80c..8fd7b70 100644
--- a/arch/powerpc/boot/dts/xpedite5200.dts
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -333,7 +333,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			current-speed = <115200>;
@@ -344,7 +344,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			current-speed = <115200>;
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index c0efcbb..0baa828 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -337,7 +337,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			current-speed = <9600>;
@@ -348,7 +348,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			current-speed = <9600>;
diff --git a/arch/powerpc/boot/dts/xpedite5301.dts b/arch/powerpc/boot/dts/xpedite5301.dts
index db7faf5..53c1c6a 100644
--- a/arch/powerpc/boot/dts/xpedite5301.dts
+++ b/arch/powerpc/boot/dts/xpedite5301.dts
@@ -441,7 +441,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -452,7 +452,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xpedite5330.dts b/arch/powerpc/boot/dts/xpedite5330.dts
index c364ca6..2152259 100644
--- a/arch/powerpc/boot/dts/xpedite5330.dts
+++ b/arch/powerpc/boot/dts/xpedite5330.dts
@@ -477,7 +477,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -488,7 +488,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xpedite5370.dts b/arch/powerpc/boot/dts/xpedite5370.dts
index 7a8a4af..11dbda1 100644
--- a/arch/powerpc/boot/dts/xpedite5370.dts
+++ b/arch/powerpc/boot/dts/xpedite5370.dts
@@ -439,7 +439,7 @@
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -450,7 +450,7 @@
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "fsl,ns16550", "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
-- 
1.7.3.4
