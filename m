Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE8F32C009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 10:11:59 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: [PATCH v1 4/4] powerpc/512x: dts: add MPC5125 clock specs
Date: Tue, 10 Dec 2013 14:11:37 +0100
Message-Id: <1386681097-14126-5-git-send-email-gsi@denx.de>
In-Reply-To: <1386681097-14126-1-git-send-email-gsi@denx.de>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add clock related specs to the MPC5125 "tower" board DTS
- add clock providers (crystal/oscillator, clock control module)
- add consumers (the CAN, SDHC, I2C, DIU, FEC, USB, PSC peripherals)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/mpc5125twr.dts |   53 +++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
index 0a0fe92216ae..806479ffc607 100644
--- a/arch/powerpc/boot/dts/mpc5125twr.dts
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -12,6 +12,8 @@
  * option) any later version.
  */
 
+#include <dt-bindings/clock/mpc512x-clock.h>
+
 /dts-v1/;
 
 / {
@@ -54,6 +56,17 @@
 		reg = <0x30000000 0x08000>;		// 32K at 0x30000000
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
@@ -87,9 +100,12 @@
 			reg = <0xe00 0x100>;
 		};
 
-		clock@f00 {	// Clock control
+		clks: clock@f00 {	// Clock control
 			compatible = "fsl,mpc5121-clock";
 			reg = <0xf00 0x100>;
+			#clock-cells = <1>;
+			clocks = <&osc>;
+			clock-names = "osc";
 		};
 
 		pmc@1000{  // Power Management Controller
@@ -114,18 +130,33 @@
 			compatible = "fsl,mpc5121-mscan";
 			interrupts = <12 0x8>;
 			reg = <0x1300 0x80>;
+			clocks = <&clks MPC512x_CLK_BDLC>,
+				 <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SYS>,
+				 <&clks MPC512x_CLK_REF>,
+				 <&clks MPC512x_CLK_MSCAN0_MCLK>;
+			clock-names = "ipg", "ips", "sys", "ref", "mclk";
 		};
 
 		can@1380 {
 			compatible = "fsl,mpc5121-mscan";
 			interrupts = <13 0x8>;
 			reg = <0x1380 0x80>;
+			clocks = <&clks MPC512x_CLK_BDLC>,
+				 <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SYS>,
+				 <&clks MPC512x_CLK_REF>,
+				 <&clks MPC512x_CLK_MSCAN1_MCLK>;
+			clock-names = "ipg", "ips", "sys", "ref", "mclk";
 		};
 
 		sdhc@1500 {
 			compatible = "fsl,mpc5121-sdhc";
 			interrupts = <8 0x8>;
 			reg = <0x1500 0x100>;
+			clocks = <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SDHC>;
+			clock-names = "ipg", "per";
 		};
 
 		i2c@1700 {
@@ -134,6 +165,8 @@
 			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
 			reg = <0x1700 0x20>;
 			interrupts = <0x9 0x8>;
+			clocks = <&clks MPC512x_CLK_I2C>;
+			clock-names = "ipg";
 		};
 
 		i2c@1720 {
@@ -142,6 +175,8 @@
 			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
 			reg = <0x1720 0x20>;
 			interrupts = <0xa 0x8>;
+			clocks = <&clks MPC512x_CLK_I2C>;
+			clock-names = "ipg";
 		};
 
 		i2c@1740 {
@@ -150,6 +185,8 @@
 			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
 			reg = <0x1740 0x20>;
 			interrupts = <0xb 0x8>;
+			clocks = <&clks MPC512x_CLK_I2C>;
+			clock-names = "ipg";
 		};
 
 		i2ccontrol@1760 {
@@ -161,6 +198,8 @@
 			compatible = "fsl,mpc5121-diu";
 			reg = <0x2100 0x100>;
 			interrupts = <64 0x8>;
+			clocks = <&clks MPC512x_CLK_DIU>;
+			clock-names = "ipg";
 		};
 
 		mdio@2800 {
@@ -180,6 +219,8 @@
 			interrupts = <4 0x8>;
 			phy-handle = < &phy0 >;
 			phy-connection-type = "rmii";
+			clocks = <&clks MPC512x_CLK_FEC>;
+			clock-names = "per";
 		};
 
 		// IO control
@@ -196,6 +237,8 @@
 			interrupts = <43 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			clocks = <&clks MPC512x_CLK_USB1>;
+			clock-names = "ipg";
 		};
 
 		// 5125 PSCs are not 52xx or 5121 PSC compatible
@@ -206,6 +249,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC1>,
+				 <&clks MPC512x_CLK_PSC1_MCLK>;
+			clock-names = "ipg", "mclk";
 		};
 
 		// PSC9 uart1 aka ttyPSC1
@@ -215,12 +261,17 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC9>,
+				 <&clks MPC512x_CLK_PSC9_MCLK>;
+			clock-names = "ipg", "mclk";
 		};
 
 		pscfifo@11f00 {
 			compatible = "fsl,mpc5121-psc-fifo";
 			reg = <0x11f00 0x100>;
 			interrupts = <40 0x8>;
+			clocks = <&clks MPC512x_CLK_PSC_FIFO>;
+			clock-names = "ipg";
 		};
 
 		dma@14000 {
-- 
1.7.10.4
