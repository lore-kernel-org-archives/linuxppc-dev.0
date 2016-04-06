Return-Path: <prvs=0904e20e8b=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg6P33GFTzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 23:43:03 +1000 (AEST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH] powerpc: define the fman node for the kmcoge4 DTS
Date: Wed,  6 Apr 2016 15:37:05 +0200
Message-Id: <1459949825-10533-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the FMAN mac driver has been merged the fman node is relevant.

The kmcoge4 board implements 3 ethernet interfaces, 1 with a RGMII phy
and 2 with fixed 1 Giga SGMII links.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 arch/powerpc/boot/dts/fsl/kmcoge4.dts | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
index 6858ec9..1cec66d 100644
--- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
@@ -106,6 +106,45 @@
 		sata@221000 {
 			status = "disabled";
 		};
+
+		fman0: fman@400000 {
+			enet0: ethernet@e0000 {
+				phy-connection-type = "sgmii";
+				local-mac-address = [00 11 22 33 44 55];
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+			mdio0: mdio@e1120 {
+				front_phy: ethernet-phy@11 {
+					reg = <0x11>;
+				};
+			};
+
+			enet1: ethernet@e2000 {
+				phy-connection-type = "sgmii";
+				local-mac-address = [00 11 22 33 44 56];
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+			enet2: ethernet@e4000 {
+				status = "disabled";
+			};
+
+			enet3: ethernet@e6000 {
+				status = "disabled";
+			};
+			enet4: ethernet@e8000 {
+				phy-handle = <&front_phy>;
+				phy-connection-type = "rgmii";
+			};
+			enet5: ethernet@f0000 {
+				status = "disabled";
+			};
+		};
 	};
 
 	rio: rapidio@ffe0c0000 {
-- 
1.8.3.1
