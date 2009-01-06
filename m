Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97596DE497
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 03:26:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n06GQ00d027762
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 10:26:00 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix PCIe error interrupts
Date: Tue,  6 Jan 2009 10:26:00 -0600
Message-Id: <1231259160-29464-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCIe interrupts for 8544ds and 8572ds were incorrect.  The 8572 case
was found by Liu Yu.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8544ds.dts            |    4 ++--
 arch/powerpc/boot/dts/mpc8572ds.dts            |    4 ++--
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    2 +-
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index f1fb207..fc448d4 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -293,7 +293,7 @@
 			  0x1000000 0x0 0x0 0xe1010000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
+		interrupts = <25 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -330,7 +330,7 @@
 			  0x1000000 0x0 0x0 0xe1020000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
+		interrupts = <26 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index a10506e..c14890d 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -679,7 +679,7 @@
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
+		interrupts = <25 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -716,7 +716,7 @@
 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <27 2>;
+		interrupts = <26 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index c114c4e..fd462ef 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -457,7 +457,7 @@
 			  0x1000000 0x0 0x0 0xffc10000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
+		interrupts = <25 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index 04ecda1..e35230f 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -208,7 +208,7 @@
 			  0x1000000 0x0 0x0 0xffc20000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <27 2>;
+		interrupts = <26 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
-- 
1.5.6.5
