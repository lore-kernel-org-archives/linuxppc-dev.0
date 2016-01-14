Return-Path: <shh.xie@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0081.outbound.protection.outlook.com [157.56.111.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 811111A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 19:51:10 +1100 (AEDT)
From: <shh.xie@gmail.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <netdev@vger.kernel.org>, <f.fainelli@gmail.com>, <davem@davemloft.net>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: [PATCH 2/3] [v2] powerpc: fsl: update fman dt binding for PCS PHY
Date: Thu, 14 Jan 2016 16:27:18 +0800
Message-ID: <1452760038-12442-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shaohui Xie <Shaohui.Xie@freescale.com>

PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this needs
to change corresponding serdes lane settings, so a reference is needed
for serdes lane. This patch describes properties needed for PCS PHY to
support backplane.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
changes in v2:
addressed Rob's comments.
based on http://patchwork.ozlabs.org/patch/560936/

 Documentation/devicetree/bindings/powerpc/fsl/fman.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index 55c2c03..5ca909a 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -432,6 +432,16 @@ example of how to define a PHY (Internal PHY has no interrupt line).
 - For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
 - For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS PHY,
   PCS PHY addr must be '0'.
+  PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this needs to
+  change the corresponding serdes lane settings.
+
+  PCS PHY node properties required for backplane:
+
+  - compatible: must be "ethernet-phy-ieee802.3-c45".
+  - phy-mode: string, operation mode of the PHY interface; must be "1000base-kx"
+    for 1000BASE-KX, or "10gbase-kr" for 10GBASE-KR.
+  - fsl-lane-handle: phandle, specifies a reference to a node representing a Serdes.
+  - fsl-lane-reg: offset and length of the register set for the serdes lane.
 
 EXAMPLE
 
@@ -464,7 +474,11 @@ mdio@f1000 {
 	fsl,fman-internal-mdio;
 
 	pcsphy6: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		phy-mode = "10gbase-kr";
 		reg = <0x0>;
+		fsl-lane-handle = <&serdes>;
+		fsl-lane-reg = <0x18c0 0x40>;
 	};
 };
 
-- 
2.1.0.27.g96db324
