Return-Path: <SRS0=wK9d=QY=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id E2C8ADDDFA
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 21:27:24 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] 4xx: Change Kilauea dts to support new EMAC device tree
	properties
Date: Sat,  1 Dec 2007 11:25:00 +0100
Message-Id: <1196504700-24381-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The recent changes from Benjamin Herrenschmidt to the ibm_newemac now
make it possible to support other 4xx variants by just defining the
correct properties in the device tree. In this case of the 405EX we
need to define "has-mdio" in the RGMII node and "has-inverted-stacr-oc"
and "has-new-stacr-staopc" in the EMAC node same as on the 440EPx.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/kilauea.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index c824e8f..b090940 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -194,6 +194,7 @@
 				device_type = "rgmii-interface";
 				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
 				reg = <ef600b00 104>;
+				has-mdio;
 			};
 
 			EMAC0: ethernet@ef600900 {
@@ -220,6 +221,8 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
 			};
 
 			EMAC1: ethernet@ef600a00 {
@@ -246,6 +249,8 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
 			};
 		};
 	};
-- 
1.5.3.6.985.g65c6a4
