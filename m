Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 4B31BDDFA1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:41:13 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Some EMAC related changes in Canyonlands &
	Glacier dts files
Date: Thu,  3 Apr 2008 15:35:06 +0200
Message-Id: <1207229706-5588-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes some problems in the Canyonlands 460EX and Glacier 460GT
dts files:

- Add "mdio-device = <&EMAC0>" to all all EMAC's except for EMAC0 itself
  (the 460EX/GT only can access the PHY via the EMAC0 instance)
- Add TAH support to Canyonlands dts

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/canyonlands.dts |   19 +++++++++++++++----
 arch/powerpc/boot/dts/glacier.dts     |    5 ++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 657f2b4..6f3d38a 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -215,6 +215,16 @@
 				has-mdio;
 			};
 
+			TAH0: emac-tah@ef601350 {
+				compatible = "ibm,tah-460ex", "ibm,tah";
+				reg = <ef601350 30>;
+			};
+
+			TAH1: emac-tah@ef601450 {
+				compatible = "ibm,tah-460ex", "ibm,tah";
+				reg = <ef601450 30>;
+			};
+
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-460ex", "ibm,emac4";
@@ -236,10 +246,10 @@
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
 				phy-map = <00000000>;
-				zmii-device = <&ZMII0>;
-				zmii-channel = <0>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				tah-device = <&TAH0>;
+				tah-channel = <0>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -265,12 +275,13 @@
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
 				phy-map = <00000000>;
-				zmii-device = <&ZMII0>;
-				zmii-channel = <1>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
+				tah-device = <&TAH1>;
+				tah-channel = <1>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
+				mdio-device = <&EMAC0>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index 7a7c9bf..958a5ca 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -287,9 +287,10 @@
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
 				tah-device = <&TAH1>;
-				tah-channel = <0>;
+				tah-channel = <1>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
+				mdio-device = <&EMAC0>;
 			};
 
 			EMAC2: ethernet@ef601100 {
@@ -317,6 +318,7 @@
 				rgmii-channel = <0>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
+				mdio-device = <&EMAC0>;
 			};
 
 			EMAC3: ethernet@ef601200 {
@@ -344,6 +346,7 @@
 				rgmii-channel = <1>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
+				mdio-device = <&EMAC0>;
 			};
 		};
 
-- 
1.5.4.5
