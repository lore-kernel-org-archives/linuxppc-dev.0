Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 585D72C03F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:46:48 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 18/31] dts: mpc512x: add clock specs for client lookups
Date: Tue,  6 Aug 2013 22:43:58 +0200
Message-Id: <1375821851-31609-19-git-send-email-gsi@denx.de>
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

this addresses the client side of device tree based clock lookups

add clock specifiers to the mbx, nfc, mscan, sdhc, i2c, axe, diu, viu,
mdio, fec, usb, pata, psc, psc fifo, and pci nodes in the shared
mpc5121.dtsi include

these specs map 'clock-names' encoded in drivers to their respective
'struct clk' items in the platform's clock driver

Reviewed-by: Mike Turquette <mturquette@linaro.org>	# for v3: w/o bdlc, PSC ipg
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/mpc5121.dtsi |   95 ++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index 8f4cba0..4cef164 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -51,6 +51,10 @@
 		compatible = "fsl,mpc5121-mbx";
 		reg = <0x20000000 0x4000>;
 		interrupts = <66 0x8>;
+		clocks = <&clks MPC512x_CLK_MBX_BUS>,
+			 <&clks MPC512x_CLK_MBX_3D>,
+			 <&clks MPC512x_CLK_MBX>;
+		clock-names = "mbx-bus", "mbx-3d", "mbx";
 	};
 
 	sram@30000000 {
@@ -64,6 +68,8 @@
 		interrupts = <6 8>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+		clocks = <&clks MPC512x_CLK_NFC>;
+		clock-names = "per";
 	};
 
 	localbus@80000020 {
@@ -153,12 +159,24 @@
 			compatible = "fsl,mpc5121-mscan";
 			reg = <0x1300 0x80>;
 			interrupts = <12 0x8>;
+			clocks = <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SYS>,
+				 <&clks MPC512x_CLK_REF>,
+				 <&clks MPC512x_CLK_MSCAN0_MCLK>,
+				 <&clks MPC512x_CLK_BDLC>;
+			clock-names = "ips", "sys", "ref", "mclk", "ipg";
 		};
 
 		can@1380 {
 			compatible = "fsl,mpc5121-mscan";
 			reg = <0x1380 0x80>;
 			interrupts = <13 0x8>;
+			clocks = <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SYS>,
+				 <&clks MPC512x_CLK_REF>,
+				 <&clks MPC512x_CLK_MSCAN1_MCLK>,
+				 <&clks MPC512x_CLK_BDLC>;
+			clock-names = "ips", "sys", "ref", "mclk", "ipg";
 		};
 
 		sdhc@1500 {
@@ -167,6 +185,9 @@
 			interrupts = <8 0x8>;
 			dmas = <&dma0 30>;
 			dma-names = "rx-tx";
+			clocks = <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SDHC>;
+			clock-names = "ipg", "per";
 		};
 
 		i2c@1700 {
@@ -175,6 +196,8 @@
 			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
 			reg = <0x1700 0x20>;
 			interrupts = <9 0x8>;
+			clocks = <&clks MPC512x_CLK_I2C>;
+			clock-names = "per";
 		};
 
 		i2c@1720 {
@@ -183,6 +206,8 @@
 			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
 			reg = <0x1720 0x20>;
 			interrupts = <10 0x8>;
+			clocks = <&clks MPC512x_CLK_I2C>;
+			clock-names = "per";
 		};
 
 		i2c@1740 {
@@ -191,6 +216,8 @@
 			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
 			reg = <0x1740 0x20>;
 			interrupts = <11 0x8>;
+			clocks = <&clks MPC512x_CLK_I2C>;
+			clock-names = "per";
 		};
 
 		i2ccontrol@1760 {
@@ -202,30 +229,48 @@
 			compatible = "fsl,mpc5121-axe";
 			reg = <0x2000 0x100>;
 			interrupts = <42 0x8>;
+			clocks = <&clks MPC512x_CLK_AXE>;
+			clock-names = "per";
 		};
 
 		display@2100 {
 			compatible = "fsl,mpc5121-diu";
 			reg = <0x2100 0x100>;
 			interrupts = <64 0x8>;
+			clocks = <&clks MPC512x_CLK_DIU>;
+			clock-names = "per";
 		};
 
 		can@2300 {
 			compatible = "fsl,mpc5121-mscan";
 			reg = <0x2300 0x80>;
 			interrupts = <90 0x8>;
+			clocks = <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SYS>,
+				 <&clks MPC512x_CLK_REF>,
+				 <&clks MPC512x_CLK_MSCAN2_MCLK>,
+				 <&clks MPC512x_CLK_BDLC>;
+			clock-names = "ips", "sys", "ref", "mclk", "ipg";
 		};
 
 		can@2380 {
 			compatible = "fsl,mpc5121-mscan";
 			reg = <0x2380 0x80>;
 			interrupts = <91 0x8>;
+			clocks = <&clks MPC512x_CLK_IPS>,
+				 <&clks MPC512x_CLK_SYS>,
+				 <&clks MPC512x_CLK_REF>,
+				 <&clks MPC512x_CLK_MSCAN3_MCLK>,
+				 <&clks MPC512x_CLK_BDLC>;
+			clock-names = "ips", "sys", "ref", "mclk", "ipg";
 		};
 
 		viu@2400 {
 			compatible = "fsl,mpc5121-viu";
 			reg = <0x2400 0x400>;
 			interrupts = <67 0x8>;
+			clocks = <&clks MPC512x_CLK_VIU>;
+			clock-names = "per";
 		};
 
 		mdio@2800 {
@@ -233,6 +278,8 @@
 			reg = <0x2800 0x800>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&clks MPC512x_CLK_FEC>;
+			clock-names = "per";
 		};
 
 		eth0: ethernet@2800 {
@@ -241,6 +288,8 @@
 			reg = <0x2800 0x800>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <4 0x8>;
+			clocks = <&clks MPC512x_CLK_FEC>;
+			clock-names = "per";
 		};
 
 		/* USB1 using external ULPI PHY */
@@ -252,6 +301,8 @@
 			interrupts = <43 0x8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
+			clocks = <&clks MPC512x_CLK_USB1>;
+			clock-names = "per";
 		};
 
 		/* USB0 using internal UTMI PHY */
@@ -263,6 +314,8 @@
 			interrupts = <44 0x8>;
 			dr_mode = "otg";
 			phy_type = "utmi_wide";
+			clocks = <&clks MPC512x_CLK_USB2>;
+			clock-names = "per";
 		};
 
 		/* IO control */
@@ -281,6 +334,8 @@
 			compatible = "fsl,mpc5121-pata";
 			reg = <0x10200 0x100>;
 			interrupts = <5 0x8>;
+			clocks = <&clks MPC512x_CLK_PATA>;
+			clock-names = "per";
 		};
 
 		/* 512x PSCs are not 52xx PSC compatible */
@@ -292,6 +347,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC0_MCLK>,
+				 <&clks MPC512x_CLK_PSC0>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC1 */
@@ -301,6 +359,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC1_MCLK>,
+				 <&clks MPC512x_CLK_PSC1>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC2 */
@@ -310,6 +371,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC2_MCLK>,
+				 <&clks MPC512x_CLK_PSC2>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC3 */
@@ -319,6 +383,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC3_MCLK>,
+				 <&clks MPC512x_CLK_PSC3>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC4 */
@@ -328,6 +395,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC4_MCLK>,
+				 <&clks MPC512x_CLK_PSC4>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC5 */
@@ -337,6 +407,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC5_MCLK>,
+				 <&clks MPC512x_CLK_PSC5>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC6 */
@@ -346,6 +419,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC6_MCLK>,
+				 <&clks MPC512x_CLK_PSC6>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC7 */
@@ -355,6 +431,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC7_MCLK>,
+				 <&clks MPC512x_CLK_PSC7>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC8 */
@@ -364,6 +443,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC8_MCLK>,
+				 <&clks MPC512x_CLK_PSC8>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC9 */
@@ -373,6 +455,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC9_MCLK>,
+				 <&clks MPC512x_CLK_PSC9>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC10 */
@@ -382,6 +467,9 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC10_MCLK>,
+				 <&clks MPC512x_CLK_PSC10>;
+			clock-names = "mclk", "ipg";
 		};
 
 		/* PSC11 */
@@ -391,12 +479,17 @@
 			interrupts = <40 0x8>;
 			fsl,rx-fifo-size = <16>;
 			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC11_MCLK>,
+				 <&clks MPC512x_CLK_PSC11>;
+			clock-names = "mclk", "ipg";
 		};
 
 		pscfifo@11f00 {
 			compatible = "fsl,mpc5121-psc-fifo";
 			reg = <0x11f00 0x100>;
 			interrupts = <40 0x8>;
+			clocks = <&clks MPC512x_CLK_PSC_FIFO>;
+			clock-names = "per";
 		};
 
 		dma0: dma@14000 {
@@ -414,6 +507,8 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
+		clocks = <&clks MPC512x_CLK_PCI>;
+		clock-names = "per";
 
 		reg = <0x80008500 0x100	/* internal registers */
 		       0x80008300 0x8>;	/* config space access registers */
-- 
1.7.10.4
