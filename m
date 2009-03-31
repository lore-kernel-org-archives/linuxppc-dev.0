Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D938ADDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:48:51 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2VDmkPC023307
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 08:48:46 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Use fsl,
	mpc85.. as prefix for memory ctrl & l2-cache nodes
Date: Tue, 31 Mar 2009 08:48:46 -0500
Message-Id: <1238507326-8851-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Older devices tree's used "fsl,85.." instead of the preferred
"fsl,mpc85.." for the memory controller & l2 cache controller nodes.
The EDAC code is the only use of these and has been updated for some
time to support both "fsl,85.." and "fsl,mpc85.."

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/ksi8560.dts      |    4 ++--
 arch/powerpc/boot/dts/sbc8548.dts      |    4 ++--
 arch/powerpc/boot/dts/sbc8560.dts      |    4 ++--
 arch/powerpc/boot/dts/stx_gp3_8560.dts |    4 ++--
 arch/powerpc/boot/dts/tqm8540.dts      |    4 ++--
 arch/powerpc/boot/dts/tqm8541.dts      |    4 ++--
 arch/powerpc/boot/dts/tqm8555.dts      |    4 ++--
 arch/powerpc/boot/dts/tqm8560.dts      |    4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index 308fe7c..c9cfd37 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -57,14 +57,14 @@
 		bus-frequency = <0>;				/* Fixed by bootwrapper */
 
 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <0x12 0x2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <0x20>;		/* 32 bytes */
 			cache-size = <0x40000>;			/* L2, 256K */
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 9c5079f..b1f1416 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -156,14 +156,14 @@
 		compatible = "simple-bus";
 
 		memory-controller@2000 {
-			compatible = "fsl,8548-memory-controller";
+			compatible = "fsl,mpc8548-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <0x12 0x2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8548-l2-cache-controller";
+			compatible = "fsl,mpc8548-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <0x20>;	// 32 bytes
 			cache-size = <0x80000>;	// L2, 512K
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index b772405..c4564b8 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -61,14 +61,14 @@
 		clock-frequency = <0>;
 
 		memory-controller@2000 {
-			compatible = "fsl,8560-memory-controller";
+			compatible = "fsl,mpc8560-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <0x12 0x2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8560-l2-cache-controller";
+			compatible = "fsl,mpc8560-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <0x20>;	// 32 bytes
 			cache-size = <0x40000>;		// L2, 256K
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index 8b17395..ea6b151 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -57,14 +57,14 @@
 		compatible = "fsl,mpc8560-immr", "simple-bus";
 
 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index ac9413a..231bae7 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -59,14 +59,14 @@
 		compatible = "fsl,mpc8540-immr", "simple-bus";
 
 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index c71bb5d..4356a1f 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -58,14 +58,14 @@
 		compatible = "fsl,mpc8541-immr", "simple-bus";
 
 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index a133ded..06d366e 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -58,14 +58,14 @@
 		compatible = "fsl,mpc8555-immr", "simple-bus";
 
 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 649e2e5..feff915 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -60,14 +60,14 @@
 		compatible = "fsl,mpc8560-immr", "simple-bus";
 
 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
 			cache-size = <0x40000>;	// L2, 256K
-- 
1.5.6.6
