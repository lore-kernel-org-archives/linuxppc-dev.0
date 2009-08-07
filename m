Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03F5CB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:08:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67967DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:08:27 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7728NSG019337
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 21:08:24 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Move mpc8536ds.dts to address-cells/size-cells
	= <2>
Date: Thu,  6 Aug 2009 21:08:23 -0500
Message-Id: <1249610903-7016-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the top-level #address-cells and #size-cells to <2> so the
mpc8536ds.dts is easier to deal with both a true 32-bit physical
or 36-bit physical address space.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8536ds.dts |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index e781ad2..22caf69 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -14,8 +14,8 @@
 / {
 	model = "fsl,mpc8536ds";
 	compatible = "fsl,mpc8536ds";
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -42,7 +42,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 00000000>;	// Filled by U-Boot
+		reg = <0 0 0 0>;	// Filled by U-Boot
 	};
 
 	soc@ffe00000 {
@@ -50,7 +50,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <0x0 0xffe00000 0x100000>;
+		ranges = <0x0 0 0xffe00000 0x100000>;
 		bus-frequency = <0>;		// Filled out by uboot.
 
 		ecm-law@0 {
@@ -347,13 +347,13 @@
 		interrupt-parent = <&mpic>;
 		interrupts = <24 0x2>;
 		bus-range = <0 0xff>;
-		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xffc00000 0 0x00010000>;
+		ranges = <0x02000000 0 0x80000000 0 0x80000000 0 0x10000000
+			  0x01000000 0 0x00000000 0 0xffc00000 0 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe08000 0x1000>;
+		reg = <0 0xffe08000 0 0x1000>;
 	};
 
 	pci1: pcie@ffe09000 {
@@ -362,10 +362,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe09000 0x1000>;
+		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 0xff>;
-		ranges = <0x02000000 0 0x98000000 0x98000000 0 0x08000000
-			  0x01000000 0 0x00000000 0xffc20000 0 0x00010000>;
+		ranges = <0x02000000 0 0x98000000 0 0x98000000 0 0x08000000
+			  0x01000000 0 0x00000000 0 0xffc20000 0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <25 0x2>;
@@ -398,10 +398,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe0a000 0x1000>;
+		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 0xff>;
-		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x08000000
-			  0x01000000 0 0x00000000 0xffc10000 0 0x00010000>;
+		ranges = <0x02000000 0 0x90000000 0 0x90000000 0 0x08000000
+			  0x01000000 0 0x00000000 0 0xffc10000 0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <26 0x2>;
@@ -434,10 +434,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xffe0b000 0x1000>;
+		reg = <0 0xffe0b000 0 0x1000>;
 		bus-range = <0 0xff>;
-		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x20000000
-			  0x01000000 0 0x00000000 0xffc30000 0 0x00010000>;
+		ranges = <0x02000000 0 0xa0000000 0 0xa0000000 0 0x20000000
+			  0x01000000 0 0x00000000 0 0xffc30000 0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <27 0x2>;
-- 
1.6.0.6
