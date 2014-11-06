Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0144.outbound.protection.outlook.com [65.55.169.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 635C91A27DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 02:57:41 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <yuantian.tang@Freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/3] dt/bindings: qoriq-clock: Add binding for the platform
 PLL
Date: Thu, 6 Nov 2014 09:48:12 -0600
Message-ID: <1415288893-4457-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1415288893-4457-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1415288893-4457-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: I7950afa9650d15ec7ce2cca89bb2a1e38586d4a5
---

v2: Whitespace fixes

 Documentation/devicetree/bindings/clock/qoriq-clock.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 5666812..266ff9d 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -62,6 +62,8 @@ Required properties:
 		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
 		It takes parent's clock-frequency as its clock.
+	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
+	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
 - #clock-cells: From common clock binding. The number of cells in a
 	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
 	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
@@ -128,8 +130,16 @@ Example for clock block and clock provider:
 			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
 			clock-output-names = "cmux1";
 		};
+
+		platform-pll: platform-pll@c00 {
+			#clock-cells = <1>;
+			reg = <0xc00 0x4>;
+			compatible = "fsl,qoriq-platform-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "platform-pll", "platform-pll-div2";
+		};
 	};
-  }
+};
 
 Example for clock consumer:
 
@@ -139,4 +149,4 @@ Example for clock consumer:
 		clocks = <&mux0>;
 		...
 	};
-  }
+};
-- 
2.1.3
