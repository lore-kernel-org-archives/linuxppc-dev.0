Return-Path: <SRS0=Oat7=T7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 85C75DE366
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 03:10:03 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Add TAH support to taishan dts
Date: Thu, 13 Mar 2008 17:00:03 +0100
Message-Id: <1205424003-21182-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds TAH (TCP/IP Acceleration Hardware) support to the
taishan 440GX dts. It depends on the NEWEMAC/tah patch that adds the
compatible "ibm,tah" property to the matching table.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/taishan.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 8278068..b5aad74 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -232,6 +232,15 @@
 				reg = <40000790 8>;
 			};
 
+			TAH0: emac-tah@40000b50 {
+				compatible = "ibm,tah-440gx", "ibm,tah";
+				reg = <40000b50 30>;
+			};
+
+			TAH1: emac-tah@40000d50 {
+				compatible = "ibm,tah-440gx", "ibm,tah";
+				reg = <40000d50 30>;
+			};
 
 			EMAC0: ethernet@40000800 {
 				unused = <1>;
@@ -297,6 +306,8 @@
 				rgmii-channel = <0>;
  				zmii-device = <&ZMII0>;
 				zmii-channel = <2>;
+				tah-device = <&TAH0>;
+				tah-channel = <0>;
 			};
 
 		 	EMAC3: ethernet@40000e00 {
@@ -320,6 +331,8 @@
 				rgmii-channel = <1>;
  				zmii-device = <&ZMII0>;
 				zmii-channel = <3>;
+				tah-device = <&TAH1>;
+				tah-channel = <0>;
 			};
 
 
-- 
1.5.4.4
