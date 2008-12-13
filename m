Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B3A3DE084
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 10:47:36 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mBDNlWRo016103
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 17:47:33 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix compile issues with mpc8572ds.dts
Date: Sat, 13 Dec 2008 17:47:32 -0600
Message-Id: <1229212052-6178-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the localbus reg & range properties to respect that the top
level #address-cells and #size-cells = 2.  The original commit
(c64ef80b517680f1e228b2ee55e3ce7cd94c7fe0) did not do that.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds.dts |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index f7dae30..a10506e 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -67,17 +67,17 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
-		reg = <0xffe05000 0x1000>;
+		reg = <0 0xffe05000 0 0x1000>;
 		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
-		ranges = <0x0 0x0 0xe8000000 0x08000000
-			  0x1 0x0 0xe0000000 0x08000000
-			  0x2 0x0 0xffa00000 0x00040000
-			  0x3 0x0 0xffdf0000 0x00008000
-			  0x4 0x0 0xffa40000 0x00040000
-			  0x5 0x0 0xffa80000 0x00040000
-			  0x6 0x0 0xffac0000 0x00040000>;
+		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
+			  0x1 0x0 0x0 0xe0000000 0x08000000
+			  0x2 0x0 0x0 0xffa00000 0x00040000
+			  0x3 0x0 0x0 0xffdf0000 0x00008000
+			  0x4 0x0 0x0 0xffa40000 0x00040000
+			  0x5 0x0 0x0 0xffa80000 0x00040000
+			  0x6 0x0 0x0 0xffac0000 0x00040000>;
 
 		nor@0,0 {
 			#address-cells = <1>;
-- 
1.5.6.5
