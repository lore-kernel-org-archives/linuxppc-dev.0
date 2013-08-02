Return-Path: <mturquette@linaro.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4346B2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 08:46:19 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id y11so1146264pdj.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2013 15:46:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1374495298-22019-17-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-17-git-send-email-gsi@denx.de>
Message-ID: <20130802224613.6450.5857@quantum>
Subject: Re: [PATCH v3 16/31] dts: mpc512x: add clock related device tree specs
Date: Fri, 02 Aug 2013 15:46:13 -0700
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

Quoting Gerhard Sittig (2013-07-22 05:14:43)
> this addresses the clock driver aka provider's side of clocks
> - prepare for future '<&clks ID>' phandle references for device tree
>   based clock lookup in client drivers
> - introduce a 'clocks' subtree with an 'osc' node for the crystal
>   or oscillator SoC input (fixed frequency)
> - provide default values with 33MHz oscillator frequency in the
>   common include (the 66MHz IPS bus already was there), add
>   override values for the ifm AC14xx board which deviates from
>   the reference design (25MHz xtal, 80MHz IPS bus)
> =

> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> ---
>  arch/powerpc/boot/dts/ac14xx.dts   |    7 +++++++
>  arch/powerpc/boot/dts/mpc5121.dtsi |   15 ++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> =

> diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac1=
4xx.dts
> index a543c40..a1b8837 100644
> --- a/arch/powerpc/boot/dts/ac14xx.dts
> +++ b/arch/powerpc/boot/dts/ac14xx.dts
> @@ -139,7 +139,14 @@
>                 };
>         };
>  =

> +       clocks {
> +               osc {
> +                       clock-frequency =3D <25000000>;
> +               };
> +       };
> +
>         soc@80000000 {
> +               bus-frequency =3D <80000000>;     /* 80 MHz ips bus */
>  =

>                 clock@f00 {
>                         compatible =3D "fsl,mpc5121rev2-clock", "fsl,mpc5=
121-clock";
> diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/m=
pc5121.dtsi
> index bd14c00..8f4cba0 100644
> --- a/arch/powerpc/boot/dts/mpc5121.dtsi
> +++ b/arch/powerpc/boot/dts/mpc5121.dtsi
> @@ -9,6 +9,8 @@
>   * option) any later version.
>   */
>  =

> +#include <dt-bindings/clock/mpc512x-clock.h>
> +
>  /dts-v1/;
>  =

>  / {
> @@ -73,6 +75,16 @@
>                 ranges =3D <0x0 0x0 0xfc000000 0x04000000>;
>         };
>  =

> +       clocks {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               osc {
> +                       compatible =3D "fsl,mpc512x-osc", "fixed-clock";
> +                       clock-frequency =3D <33000000>;
> +               };
> +       };
> +
>         soc@80000000 {
>                 compatible =3D "fsl,mpc5121-immr";
>                 #address-cells =3D <1>;
> @@ -118,9 +130,10 @@
>                 };
>  =

>                 /* Clock control */
> -               clock@f00 {
> +               clks: clock@f00 {
>                         compatible =3D "fsl,mpc5121-clock";
>                         reg =3D <0xf00 0x100>;
> +                       #clock-cells =3D <1>;
>                 };
>  =

>                 /* Power Management Controller */
> -- =

> 1.7.10.4
