Return-Path: <mturquette@linaro.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C7152C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 09:41:26 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id xa7so1221207pbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2013 16:41:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1374495298-22019-19-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-19-git-send-email-gsi@denx.de>
Message-ID: <20130802234120.6450.57074@quantum>
Subject: Re: [PATCH v3 18/31] dts: mpc512x: add clock specs for client lookups
Date: Fri, 02 Aug 2013 16:41:20 -0700
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

Quoting Gerhard Sittig (2013-07-22 05:14:45)
> this addresses the client side of device tree based clock lookups
> =

> add clock specifiers to the mbx, nfc, mscan, sdhc, i2c, axe, diu, viu,
> mdio, fec, usb, pata, psc, psc fifo, and pci nodes in the shared
> mpc5121.dtsi include
> =

> these specs map 'clock-names' encoded in drivers to their respective
> 'struct clk' items in the platform's clock driver
> =

> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> ---
>  arch/powerpc/boot/dts/mpc5121.dtsi |   79 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 79 insertions(+)
> =

> diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/m=
pc5121.dtsi
> index 8f4cba0..3657ae6 100644
> --- a/arch/powerpc/boot/dts/mpc5121.dtsi
> +++ b/arch/powerpc/boot/dts/mpc5121.dtsi
> @@ -51,6 +51,10 @@
>                 compatible =3D "fsl,mpc5121-mbx";
>                 reg =3D <0x20000000 0x4000>;
>                 interrupts =3D <66 0x8>;
> +               clocks =3D <&clks MPC512x_CLK_MBX_BUS>,
> +                        <&clks MPC512x_CLK_MBX_3D>,
> +                        <&clks MPC512x_CLK_MBX>;
> +               clock-names =3D "mbx-bus", "mbx-3d", "mbx";
>         };
>  =

>         sram@30000000 {
> @@ -64,6 +68,8 @@
>                 interrupts =3D <6 8>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
> +               clocks =3D <&clks MPC512x_CLK_NFC>;
> +               clock-names =3D "per";
>         };
>  =

>         localbus@80000020 {
> @@ -153,12 +159,22 @@
>                         compatible =3D "fsl,mpc5121-mscan";
>                         reg =3D <0x1300 0x80>;
>                         interrupts =3D <12 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_IPS>,
> +                                <&clks MPC512x_CLK_SYS>,
> +                                <&clks MPC512x_CLK_REF>,
> +                                <&clks MPC512x_CLK_MSCAN0_MCLK>;
> +                       clock-names =3D "ips", "sys", "ref", "mclk";
>                 };
>  =

>                 can@1380 {
>                         compatible =3D "fsl,mpc5121-mscan";
>                         reg =3D <0x1380 0x80>;
>                         interrupts =3D <13 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_IPS>,
> +                                <&clks MPC512x_CLK_SYS>,
> +                                <&clks MPC512x_CLK_REF>,
> +                                <&clks MPC512x_CLK_MSCAN1_MCLK>;
> +                       clock-names =3D "ips", "sys", "ref", "mclk";
>                 };
>  =

>                 sdhc@1500 {
> @@ -167,6 +183,9 @@
>                         interrupts =3D <8 0x8>;
>                         dmas =3D <&dma0 30>;
>                         dma-names =3D "rx-tx";
> +                       clocks =3D <&clks MPC512x_CLK_IPS>,
> +                                <&clks MPC512x_CLK_SDHC>;
> +                       clock-names =3D "ipg", "per";
>                 };
>  =

>                 i2c@1700 {
> @@ -175,6 +194,8 @@
>                         compatible =3D "fsl,mpc5121-i2c", "fsl-i2c";
>                         reg =3D <0x1700 0x20>;
>                         interrupts =3D <9 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_I2C>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 i2c@1720 {
> @@ -183,6 +204,8 @@
>                         compatible =3D "fsl,mpc5121-i2c", "fsl-i2c";
>                         reg =3D <0x1720 0x20>;
>                         interrupts =3D <10 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_I2C>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 i2c@1740 {
> @@ -191,6 +214,8 @@
>                         compatible =3D "fsl,mpc5121-i2c", "fsl-i2c";
>                         reg =3D <0x1740 0x20>;
>                         interrupts =3D <11 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_I2C>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 i2ccontrol@1760 {
> @@ -202,30 +227,46 @@
>                         compatible =3D "fsl,mpc5121-axe";
>                         reg =3D <0x2000 0x100>;
>                         interrupts =3D <42 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_AXE>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 display@2100 {
>                         compatible =3D "fsl,mpc5121-diu";
>                         reg =3D <0x2100 0x100>;
>                         interrupts =3D <64 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_DIU>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 can@2300 {
>                         compatible =3D "fsl,mpc5121-mscan";
>                         reg =3D <0x2300 0x80>;
>                         interrupts =3D <90 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_IPS>,
> +                                <&clks MPC512x_CLK_SYS>,
> +                                <&clks MPC512x_CLK_REF>,
> +                                <&clks MPC512x_CLK_MSCAN2_MCLK>;
> +                       clock-names =3D "ips", "sys", "ref", "mclk";
>                 };
>  =

>                 can@2380 {
>                         compatible =3D "fsl,mpc5121-mscan";
>                         reg =3D <0x2380 0x80>;
>                         interrupts =3D <91 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_IPS>,
> +                                <&clks MPC512x_CLK_SYS>,
> +                                <&clks MPC512x_CLK_REF>,
> +                                <&clks MPC512x_CLK_MSCAN3_MCLK>;
> +                       clock-names =3D "ips", "sys", "ref", "mclk";
>                 };
>  =

>                 viu@2400 {
>                         compatible =3D "fsl,mpc5121-viu";
>                         reg =3D <0x2400 0x400>;
>                         interrupts =3D <67 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_VIU>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 mdio@2800 {
> @@ -233,6 +274,8 @@
>                         reg =3D <0x2800 0x800>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
> +                       clocks =3D <&clks MPC512x_CLK_FEC>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 eth0: ethernet@2800 {
> @@ -241,6 +284,8 @@
>                         reg =3D <0x2800 0x800>;
>                         local-mac-address =3D [ 00 00 00 00 00 00 ];
>                         interrupts =3D <4 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_FEC>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 /* USB1 using external ULPI PHY */
> @@ -252,6 +297,8 @@
>                         interrupts =3D <43 0x8>;
>                         dr_mode =3D "otg";
>                         phy_type =3D "ulpi";
> +                       clocks =3D <&clks MPC512x_CLK_USB1>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 /* USB0 using internal UTMI PHY */
> @@ -263,6 +310,8 @@
>                         interrupts =3D <44 0x8>;
>                         dr_mode =3D "otg";
>                         phy_type =3D "utmi_wide";
> +                       clocks =3D <&clks MPC512x_CLK_USB2>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 /* IO control */
> @@ -281,6 +330,8 @@
>                         compatible =3D "fsl,mpc5121-pata";
>                         reg =3D <0x10200 0x100>;
>                         interrupts =3D <5 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_PATA>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 /* 512x PSCs are not 52xx PSC compatible */
> @@ -292,6 +343,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC0_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC1 */
> @@ -301,6 +354,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC1_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC2 */
> @@ -310,6 +365,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC2_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC3 */
> @@ -319,6 +376,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC3_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC4 */
> @@ -328,6 +387,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC4_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC5 */
> @@ -337,6 +398,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC5_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC6 */
> @@ -346,6 +409,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC6_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC7 */
> @@ -355,6 +420,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC7_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC8 */
> @@ -364,6 +431,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC8_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC9 */
> @@ -373,6 +442,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC9_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC10 */
> @@ -382,6 +453,8 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC10_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 /* PSC11 */
> @@ -391,12 +464,16 @@
>                         interrupts =3D <40 0x8>;
>                         fsl,rx-fifo-size =3D <16>;
>                         fsl,tx-fifo-size =3D <16>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC11_MCLK>;
> +                       clock-names =3D "mclk";
>                 };
>  =

>                 pscfifo@11f00 {
>                         compatible =3D "fsl,mpc5121-psc-fifo";
>                         reg =3D <0x11f00 0x100>;
>                         interrupts =3D <40 0x8>;
> +                       clocks =3D <&clks MPC512x_CLK_PSC_FIFO>;
> +                       clock-names =3D "per";
>                 };
>  =

>                 dma0: dma@14000 {
> @@ -414,6 +491,8 @@
>                 #address-cells =3D <3>;
>                 #size-cells =3D <2>;
>                 #interrupt-cells =3D <1>;
> +               clocks =3D <&clks MPC512x_CLK_PCI>;
> +               clock-names =3D "per";
>  =

>                 reg =3D <0x80008500 0x100 /* internal registers */
>                        0x80008300 0x8>; /* config space access registers =
*/
> -- =

> 1.7.10.4
