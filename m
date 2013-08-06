Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EBA1E2C0393
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:46:32 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 16/31] dts: mpc512x: add clock related device tree specs
Date: Tue,  6 Aug 2013 22:43:56 +0200
Message-Id: <1375821851-31609-17-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this addresses the clock driver aka provider's side of clocks
- prepare for future '<&clks ID>' phandle references for device tree
  based clock lookup in client drivers
- introduce a 'clocks' subtree with an 'osc' node for the crystal
  or oscillator SoC input (fixed frequency)
- provide default values with 33MHz oscillator frequency in the
  common include (the 66MHz IPS bus already was there), add
  override values for the ifm AC14xx board which deviates from
  the reference design (25MHz xtal, 80MHz IPS bus)

Reviewed-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts   |    7 +++++++
 arch/powerpc/boot/dts/mpc5121.dtsi |   15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a543c40..a1b8837 100644
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
index bd14c00..8f4cba0 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+#include <dt-bindings/clock/mpc512x-clock.h>
+
 /dts-v1/;
 
 / {
@@ -73,6 +75,16 @@
 		ranges = <0x0 0x0 0xfc000000 0x04000000>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc {
+			compatible = "fsl,mpc512x-osc", "fixed-clock";
+			clock-frequency = <33000000>;
+		};
+	};
+
 	soc@80000000 {
 		compatible = "fsl,mpc5121-immr";
 		#address-cells = <1>;
@@ -118,9 +130,10 @@
 		};
 
 		/* Clock control */
-		clock@f00 {
+		clks: clock@f00 {
 			compatible = "fsl,mpc5121-clock";
 			reg = <0xf00 0x100>;
+			#clock-cells = <1>;
 		};
 
 		/* Power Management Controller */
-- 
1.7.10.4
