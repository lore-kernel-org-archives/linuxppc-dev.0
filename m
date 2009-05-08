Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5CA3DDF7C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:06:03 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n48E5vh5009244
	for <linuxppc-dev@ozlabs.org>; Fri, 8 May 2009 09:05:58 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Removed reg property from 85xx/86xx soc node
Date: Fri,  8 May 2009 09:05:57 -0500
Message-Id: <1241791557-8598-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Between the addition of the ecm/mcm law nodes and the fact that the
get_immrbase() has been using the range property of the SoC to determine
the base address of CCSR space we no longer need the reg property at
the soc node level.  It has been ill specified and varied between device
trees to cover either the {e,m}cm-law node, some odd subset of CCSR
space or all of CCSR space.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/gef_ppc9a.dts            |    1 -
 arch/powerpc/boot/dts/gef_sbc310.dts           |    1 -
 arch/powerpc/boot/dts/gef_sbc610.dts           |    1 -
 arch/powerpc/boot/dts/mpc8536ds.dts            |    1 -
 arch/powerpc/boot/dts/mpc8540ads.dts           |    1 -
 arch/powerpc/boot/dts/mpc8541cds.dts           |    1 -
 arch/powerpc/boot/dts/mpc8544ds.dts            |    1 -
 arch/powerpc/boot/dts/mpc8548cds.dts           |    1 -
 arch/powerpc/boot/dts/mpc8555cds.dts           |    1 -
 arch/powerpc/boot/dts/mpc8560ads.dts           |    1 -
 arch/powerpc/boot/dts/mpc8568mds.dts           |    1 -
 arch/powerpc/boot/dts/mpc8569mds.dts           |    1 -
 arch/powerpc/boot/dts/mpc8572ds.dts            |    1 -
 arch/powerpc/boot/dts/mpc8572ds_36b.dts        |    1 -
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    1 -
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    1 -
 arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    1 -
 arch/powerpc/boot/dts/mpc8641_hpcn.dts         |    1 -
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts     |    1 -
 arch/powerpc/boot/dts/sbc8548.dts              |    1 -
 arch/powerpc/boot/dts/sbc8560.dts              |    1 -
 arch/powerpc/boot/dts/sbc8641d.dts             |    1 -
 arch/powerpc/boot/dts/socrates.dts             |    1 -
 arch/powerpc/boot/dts/stx_gp3_8560.dts         |    1 -
 arch/powerpc/boot/dts/tqm8540.dts              |    1 -
 arch/powerpc/boot/dts/tqm8541.dts              |    1 -
 arch/powerpc/boot/dts/tqm8548-bigflash.dts     |    1 -
 arch/powerpc/boot/dts/tqm8548.dts              |    1 -
 arch/powerpc/boot/dts/tqm8555.dts              |    1 -
 arch/powerpc/boot/dts/tqm8560.dts              |    1 -
 30 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index 38dd005..910944e 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -164,7 +164,6 @@
 		device_type = "soc";
 		compatible = "fsl,mpc8641-soc", "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
-		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <33333333>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 155776c..0f4c9ec 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -163,7 +163,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
-		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <33333333>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 6898d7e..217f8aa 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -128,7 +128,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
-		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <33333333>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index b6fd856..e781ad2 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -51,7 +51,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xffe00000 0x100000>;
-		reg = <0xffe00000 0x1000>;
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 7c8b109..9dc2929 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -55,7 +55,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index de9d8b5..9a3ad31 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -55,7 +55,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 9819d6c..98e94b4 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -57,7 +57,6 @@
 		compatible = "simple-bus";
 
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 6e40db7..475be14 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -60,7 +60,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 6291497..065b2f0 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -55,7 +55,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index a2347b5..a5bb1ec 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -55,7 +55,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x200>;
 		bus-frequency = <330000000>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index fcab168..073f140 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -62,7 +62,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index e16a5d4..69cec81 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -94,7 +94,6 @@
 		device_type = "soc";
 		compatible = "fsl,mpc8569-immr", "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 3f9a623..cafc128 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -182,7 +182,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0 0xffe00000 0x100000>;
-		reg = <0 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
index fee17f3..1197965 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
@@ -182,7 +182,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
-		reg = <0xf 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index abb1730..5bd1011 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -59,7 +59,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xffe00000 0x100000>;
-		reg = <0xffe00000 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index 0ded4a6..0efc345 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -58,7 +58,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x0 0xffe00000 0x100000>;
-		reg = <0xffe00000 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		L2: l2-cache-controller@20000 {
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 252db6e..cfc2c60 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -112,7 +112,6 @@
 		device_type = "soc";
 		compatible = "fsl,mpc8610-immr", "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
-		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 8bcccd7..848320e 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -114,7 +114,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xffe00000 0x00100000>;
-		reg = <0xffe00000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
index d4c909d..65893b9 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
@@ -107,7 +107,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x0f 0xffe00000 0x00100000>;
-		reg = <0x0f 0xffe00000 0x0 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 66c9165..9eefe00 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -151,7 +151,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x00000000 0xe0000000 0x00100000>;
-		reg = <0xe0000000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 		compatible = "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index ff6a522..239d57a 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -57,7 +57,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xff700000 0x00100000>;
-		reg = <0xff700000 0x00100000>;
 		clock-frequency = <0>;
 
 		ecm-law@0 {
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index aa8f931..ee5538f 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -126,7 +126,6 @@
 		device_type = "soc";
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xf8000000 0x00100000>;
-		reg = <0xf8000000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		mcm-law@0 {
diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/socrates.dts
index 779876a..feb4ef6 100644
--- a/arch/powerpc/boot/dts/socrates.dts
+++ b/arch/powerpc/boot/dts/socrates.dts
@@ -55,7 +55,6 @@
 		device_type = "soc";
 
 		ranges = <0x00000000 0xe0000000 0x00100000>;
-		reg = <0xe0000000 0x00001000>;	// CCSRBAR 1M
 		bus-frequency = <0>;		// Filled in by U-Boot
 		compatible = "fsl,mpc8544-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index ce35e89..b670d03 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -52,7 +52,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0 0xfdf00000 0x100000>;
-		reg = <0xfdf00000 0x1000>;
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8560-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 5e9eecc..7134753 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -54,7 +54,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x200>;
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8540-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 3c8d5c1..b30f637 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -53,7 +53,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x200>;
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8541-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 435d2b2..61f25e1 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -55,7 +55,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xa0000000 0x100000>;
-		reg = <0xa0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8548-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 3b8af5b..025759c 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -55,7 +55,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8548-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index a820bbe..95e2873 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -53,7 +53,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x200>;
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8555-immr", "simple-bus";
 
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index fa73550..ff70580 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -55,7 +55,6 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x100000>;
-		reg = <0xe0000000 0x200>;
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8560-immr", "simple-bus";
 
-- 
1.6.0.6
