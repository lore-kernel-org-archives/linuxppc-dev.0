Return-Path: <shh.xie@gmail.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0075.outbound.protection.outlook.com [207.46.100.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B078A1A08CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 00:18:25 +1100 (AEDT)
From: <shh.xie@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <scottwood@freescale.com>
Subject: [PATCH][v4] power/fsl: add MDIO dt binding for FMan
Date: Wed, 28 Jan 2015 19:54:24 +0800
Message-ID: <1422446064-3901-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shaohui Xie <Shaohui.Xie@freescale.com>

This binding is for FMan MDIO, it covers FMan v2 & FMan v3.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
changes for V4:
revised MDIO interrupt related statement.

changes in v3:
rephrase the 'Definition' of property 'bus-frequency', don't include the
property in example.

changes in v2:
addressed comments from Scott in V1.

 .../devicetree/bindings/powerpc/fsl/fman.txt       | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index edeea16..774c24f 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -7,6 +7,7 @@ CONTENTS
   - FMan MURAM Node
   - FMan dTSEC/XGEC/mEMAC Node
   - FMan IEEE 1588 Node
+  - FMan MDIO Node
   - Example
 
 =============================================================================
@@ -357,6 +358,69 @@ ptp-timer@fe000 {
 };
 
 =============================================================================
+FMan MDIO Node
+
+DESCRIPTION
+
+The MDIO is a bus to which the PHY devices are connected.
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: A standard property.
+		Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
+		Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
+		Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
+		FMan v3.
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property.
+
+- bus-frequency
+		Usage: optional
+		Value type: <u32>
+		Definition: Specifies the external MDIO bus clock speed to
+		be used, if different from the standard 2.5 MHz.
+		This may be due to the standard speed being unsupported (e.g.
+		due to a hardware problem), or to advertise that all relevant
+		components in the system support a faster speed.
+
+- interrupts
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: Event interrupt of external MDIO controller.
+
+- fsl,fman-internal-mdio
+		Usage: required for internal MDIO
+		Value type: boolean
+		Definition: Fman has internal MDIO for internal PCS(Physical
+		Coding Sublayer) PHYs and external MDIO for external PHYs.
+		The settings and programming routines for internal/external
+		MDIO are different. Must be included for internal MDIO.
+
+EXAMPLE
+
+Example for FMan v2 external MDIO:
+
+mdio@f1000 {
+	compatible = "fsl,fman-xmdio";
+	reg = <0xf1000 0x1000>;
+	interrupts = <101 2 0 0>;
+};
+
+Example for FMan v3 internal MDIO:
+
+mdio@f1000 {
+	compatible = "fsl,fman-memac-mdio";
+	reg = <0xf1000 0x1000>;
+	fsl,fman-internal-mdio;
+};
+
+=============================================================================
 Example
 
 fman@400000 {
@@ -531,4 +595,10 @@ fman@400000 {
 		compatible = "fsl,fman-ptp-timer";
 		reg = <0xfe000 0x1000>;
 	};
+
+	mdio@f1000 {
+		compatible = "fsl,fman-xmdio";
+		reg = <0xf1000 0x1000>;
+		interrupts = <101 2 0 0>;
+	};
 };
-- 
1.8.4.1
