Return-Path: <Shruti@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 830F21A0240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 06:17:20 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH v2 1/7] dt: Introduce the FMan 10 Gb/s MDIO binding
Date: Wed, 16 Jul 2014 15:17:05 -0500
Message-ID: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Shruti@Freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This document covers FManv2 and FManv3 mEMAC MDIO

Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---
 .../devicetree/bindings/net/fsl-xgmac-phy.txt      | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt

diff --git a/Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt b/Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt
new file mode 100644
index 0000000..2f2d56d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt
@@ -0,0 +1,29 @@
+*MDIO IO device
+
+The MDIO is a bus to which the PHY devices are connected. For each
+device that exists on this bus, a child node should be created.
+
+Required properties:
+	- compatible: Currently supported strings/devices are:
+			- "fsl,fman-xmdio" (Must be used for 10 Gb/s MDIO from FMan v2.
+			  Can be used for 1/10 Gb/s MDIO from FMan v3)
+			- "fsl,fman-memac-mdio" (Must be used for 1/10 Gb/s MDIO from
+			  FMan v3)
+	- reg
+
+	Example for FMan v2:
+		mdio@f1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,fman-xmdio";
+			reg = <0xf1000 0x1000>;
+		};
+
+	Example for FMan v3:
+
+		mdio@f1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+			reg = <0xf1000 0x1000>;
+		}
-- 
1.8.3.1
