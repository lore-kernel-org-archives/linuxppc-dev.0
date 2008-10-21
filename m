Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A436DDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:20:05 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m9L4K2Hj022871
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 23:20:02 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Move mpc8572ds.dts to address-cells/size-cells
	= <2>
Date: Mon, 20 Oct 2008 23:20:02 -0500
Message-Id: <1224562802-17416-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the top-level #address-cells and #size-cells to <2> so the
mpc8572ds.dts is easier to deal with both a true 32-bit physical
or 36-bit physical address space.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds.dts |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index e124dd1..cadd465 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -13,8 +13,8 @@
 / {
 	model = "fsl,MPC8572DS";
 	compatible = "fsl,MPC8572DS";
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -61,7 +61,6 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x0 0x0>;	// Filled by U-Boot
 	};
 
 	soc8572@ffe00000 {
@@ -69,8 +68,8 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <0x0 0xffe00000 0x100000>;
-		reg = <0xffe00000 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
+		ranges = <0x0 0 0xffe00000 0x100000>;
+		reg = <0 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		memory-controller@2000 {
@@ -351,10 +350,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe08000 0x1000>;
+		reg = <0 0xffe08000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xffc00000 0x0 0x10000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
@@ -561,10 +560,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe09000 0x1000>;
+		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xffc10000 0x0 0x10000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <26 2>;
@@ -598,10 +597,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe0a000 0x1000>;
+		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xffc20000 0x0 0x10000>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <27 2>;
-- 
1.5.5.1
