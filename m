Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EE761A019A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 01:05:12 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [v3] dt/bindings: qoriq-clock: Add binding for FMan clock mux
Date: Tue, 14 Apr 2015 13:56:08 +0300
Message-ID: <1429008968-24707-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

v3: Addressed feedback from Scott:
	- Removed clock specifier description.

v2: Addressed feedback from Scott:
	- Moved the "fman-clk-mux" clock provider details
	  under "clocks" property.

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 .../devicetree/bindings/clock/qoriq-clock.txt      |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index b0d7b73..2bb3b38 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -65,9 +65,10 @@ Required properties:
 		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
 	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
+	* "fsl,fman-clk-mux" for the Frame Manager clock.
 - #clock-cells: From common clock binding. The number of cells in a
-	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
-	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
+	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0" and
+	"fsl,fman-clk-mux" clocks or <1> for "fsl,qoriq-core-pll-[1,2].0".
 	For "fsl,qoriq-core-pll-1.0" clocks, the single
 	clock-specifier cell may take the following values:
 	* 0 - equal to the PLL frequency
@@ -145,6 +146,18 @@ Example for clock block and clock provider:
 			clocks = <&sysclk>;
 			clock-output-names = "platform-pll", "platform-pll-div2";
 		};
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			reg = <0x10 4>
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>, <&pll0 3>,
+				 <&platform_pll 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0", "pll0-div2", "pll0-div3",
+				      "pll0-div4", "platform-pll", "pll1-div2",
+				      "pll1-div3";
+			clock-output-names = "fm0-clk";
+		};
 	};
 };
 
-- 
1.7.9.5
