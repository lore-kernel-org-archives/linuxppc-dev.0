Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B13702C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:08 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 03/17] dts: mpc512x: add clock related device tree specs
Date: Sat, 30 Nov 2013 23:51:23 +0100
Message-Id: <1385851897-23475-4-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Detlev Zundel <dzu@denx.de>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>,
 Ian Campbell <ian.campbell@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this addresses the clock driver aka provider's side of clocks
- introduce a 'clocks' subtree with an 'osc' node for the crystal
  or oscillator SoC input (fixed frequency)
- the 'clock@f00' clock-control-module node references the 'osc' for
  its input, and is another provider for all the clocks which the
  CCM component manages
- prepare for future references to clocks from peripheral nodes
  by means of the <&clks ID> syntax and symbolic ID names which a
  header file provides
- provide default values with 33MHz oscillator frequency in the
  common include (the 66MHz IPS bus already was there), and add
  override values for the ifm AC14xx board which deviates from
  the reference design (25MHz xtal, 80MHz IPS bus)

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Mike Turquette <mturquette@linaro.org> # for v3, before &osc
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts   |    7 +++++++
 arch/powerpc/boot/dts/mpc5121.dtsi |   18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a543c4088cba..a1b883730b31 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -139,7 +139,14 @@
 		};
 	};
 
+	clocks {
+		osc {
+			clock-frequency = <25000000>;
+		};
+	};
+
 	soc@80000000 {
+		bus-frequency = <80000000>;	/* 80 MHz ips bus */
 
 		clock@f00 {
 			compatible = "fsl,mpc5121rev2-clock", "fsl,mpc5121-clock";
diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index bd14c00e5146..9bfcb7558197 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+#include <dt-bindings/clock/mpc512x-clock.h>
+
 /dts-v1/;
 
 / {
@@ -73,6 +75,17 @@
 		ranges = <0x0 0x0 0xfc000000 0x04000000>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc: osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <33000000>;
+		};
+	};
+
 	soc@80000000 {
 		compatible = "fsl,mpc5121-immr";
 		#address-cells = <1>;
@@ -118,9 +131,12 @@
 		};
 
 		/* Clock control */
-		clock@f00 {
+		clks: clock@f00 {
 			compatible = "fsl,mpc5121-clock";
 			reg = <0xf00 0x100>;
+			#clock-cells = <1>;
+			clocks = <&osc>;
+			clock-names = "osc";
 		};
 
 		/* Power Management Controller */
-- 
1.7.10.4
