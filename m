Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynXK85t10zDrp4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 20:33:48 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH] powerpc/kmcent2: update the ethernet nodes to use phy-mode
Date: Thu, 30 Nov 2017 10:33:35 +0100
Message-Id: <20171130093335.8150-1-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fman driver only calls of_get_phy_node, ignoring the
phy-connection-type field. While we're at it, update the fixed link to
the new more readable way to specify it and set phy-mode to rgmii-id for
the node with a phy.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 arch/powerpc/boot/dts/fsl/kmcent2.dts | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dts/fsl/kmcent2.dts
index 5922c1ea0e96..095c9a661a08 100644
--- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
@@ -214,13 +214,19 @@
 
 		fman@400000 {
 			ethernet@e0000 {
-				fixed-link = <0 1 1000 0 0>;
-				phy-connection-type = "sgmii";
+				phy-mode = "sgmii";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
 			};
 
 			ethernet@e2000 {
-				fixed-link = <1 1 1000 0 0>;
-				phy-connection-type = "sgmii";
+				phy-mode = "sgmii";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
 			};
 
 			ethernet@e4000 {
@@ -233,7 +239,7 @@
 
 			ethernet@e8000 {
 				phy-handle = <&front_phy>;
-				phy-connection-type = "rgmii";
+				phy-mode = "rgmii-id";
 			};
 
 			mdio0: mdio@fc000 {
-- 
2.14.3
