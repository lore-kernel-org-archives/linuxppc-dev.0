Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3560DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 01:23:54 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2OENn5D017762
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 09:23:50 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/83xx: Update ranges in gianfar node to match other
	dts
Date: Tue, 24 Mar 2009 09:23:49 -0500
Message-Id: <1237904629-16250-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The gianfar@25000 node was missing its ranges prop for the mdio bus
and provided an explicit ranges property on gianfar@24000 to match
change from commit:

commit 70b3adbba056f5d9081f1ec9b4a629e3c7502072
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Mar 19 21:01:45 2009 +0300

    powerpc/83xx: Move gianfar mdio nodes under the ethernet nodes

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Fixup reg based on Anton's review

- k

 arch/powerpc/boot/dts/mpc8313erdb.dts |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 3ebf7ec..761faa7 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -180,7 +180,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			sleep = <&pmc 0x20000000>;
-			ranges;
+			ranges = <0x0 0x24000 0x1000>;
 
 			cell-index = <0>;
 			device_type = "network";
@@ -195,11 +195,11 @@
 			fixed-link = <1 1 1000 0 0>;
 			fsl,magic-packet;
 
-			mdio@24520 {
+			mdio@520 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,gianfar-mdio";
-				reg = <0x24520 0x20>;
+				reg = <0x520 0x20>;
 				phy4: ethernet-phy@4 {
 					interrupt-parent = <&ipic>;
 					interrupts = <20 0x8>;
@@ -221,6 +221,7 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <34 0x8 33 0x8 32 0x8>;
 			interrupt-parent = <&ipic>;
@@ -229,11 +230,11 @@
 			sleep = <&pmc 0x10000000>;
 			fsl,magic-packet;
 
-			mdio@25520 {
+			mdio@520 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,gianfar-tbi";
-				reg = <0x25520 0x20>;
+				reg = <0x520 0x20>;
 
 				tbi1: tbi-phy@11 {
 					reg = <0x11>;
-- 
1.5.6.6
