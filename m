Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD03FDDEFE
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 00:35:59 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2ODZjUN013177
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 08:35:46 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/83xx: Update ranges in gianfar node to match other dts
Date: Tue, 24 Mar 2009 08:35:45 -0500
Message-Id: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The gianfar node @ 25000 was missing its ranges prop for the mdio bus
and provided an explicit ranges property on gianfar@24000 to match
all other .dts

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 3ebf7ec..20a0fa8 100644
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
@@ -221,6 +221,7 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <34 0x8 33 0x8 32 0x8>;
 			interrupt-parent = <&ipic>;
-- 
1.5.6.6
