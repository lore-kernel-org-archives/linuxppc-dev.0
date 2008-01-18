Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AFE4DDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 15:35:51 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0I4ZlD8030522
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 22:35:47 -0600
Date: Thu, 17 Jan 2008 22:33:30 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix incorrect interrupt map on FSL reference boards
Message-ID: <Pine.LNX.4.64.0801172233070.8206@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ULI based boards had the interrupt maps for USB on the ULI incorrectly
set.

Also, the MPC8572DS was missing the interrupt-map-mask for the 3rd PCIe
controller.

---
 arch/powerpc/boot/dts/mpc8544ds.dts    |    6 +++---
 arch/powerpc/boot/dts/mpc8572ds.dts    |    7 ++++---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |    6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 54b3bdf..688af9d 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -304,9 +304,9 @@
 		interrupt-map = <
 			// IDSEL 0x1c  USB
 			e000 0 0 1 &i8259 c 2
-			e100 0 0 1 &i8259 9 2
-			e200 0 0 1 &i8259 a 2
-			e300 0 0 1 &i8259 b 2
+			e100 0 0 2 &i8259 9 2
+			e200 0 0 3 &i8259 a 2
+			e300 0 0 4 &i8259 b 2

 			// IDSEL 0x1d  Audio
 			e800 0 0 1 &i8259 6 2
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 233e0d5..813c259 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -334,9 +334,9 @@

 			// IDSEL 0x1c  USB
 			e000 0 0 1 &i8259 c 2
-			e100 0 0 1 &i8259 9 2
-			e200 0 0 1 &i8259 a 2
-			e300 0 0 1 &i8259 b 2
+			e100 0 0 2 &i8259 9 2
+			e200 0 0 3 &i8259 a 2
+			e300 0 0 4 &i8259 b 2

 			// IDSEL 0x1d  Audio
 			e800 0 0 1 &i8259 6 2
@@ -481,6 +481,7 @@
 		clock-frequency = <1fca055>;
 		interrupt-parent = <&mpic>;
 		interrupts = <1b 2>;
+		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
 			0000 0 0 1 &mpic 0 1
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 86fc228..a719179 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -326,9 +326,9 @@

 			// IDSEL 0x1c  USB
 			e000 0 0 1 &i8259 c 2
-			e100 0 0 1 &i8259 9 2
-			e200 0 0 1 &i8259 a 2
-			e300 0 0 1 &i8259 b 2
+			e100 0 0 2 &i8259 9 2
+			e200 0 0 3 &i8259 a 2
+			e300 0 0 4 &i8259 b 2

 			// IDSEL 0x1d  Audio
 			e800 0 0 1 &i8259 6 2
-- 
1.5.3.7
