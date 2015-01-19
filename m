Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B99AB1A0D3D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 04:25:34 +1100 (AEDT)
Received: by mail-pa0-f47.google.com with SMTP id kq14so39984407pab.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 09:25:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: <Yuantian.Tang@freescale.com>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1421301821-18917-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1421301821-18917-1-git-send-email-Yuantian.Tang@freescale.com>
Message-ID: <20150119172522.22722.44902@quantum>
Subject: Re: [PATCH 1/2] clock: redefine variable clocks_per_pll as a struct
 member
Date: Mon, 19 Jan 2015 09:25:22 -0800
Cc: b07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Yuantian.Tang@freescale.com (2015-01-14 22:03:40)
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> =

> redefine variable clocks_per_pll as a struct member
> =

> If there are multiple PLL clock nodes, this variable will
> get overwritten. Redefining it as a struct member can avoid that.
> =

> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>

Applied to clk-next towards 3.20.

Regards,
Mike

> ---
> These patches are based on following three patches which are acked
> by Scott wood <scottwood@freescale.com>:
>         1. http://patchwork.ozlabs.org/patch/417292/
>                 Revert "clk: ppc-corenet: Fix Section mismatch warning"
>         2. http://patchwork.ozlabs.org/patch/417295/
>                 powerpc: call of_clk_init() from time_init()
>         3. http://patchwork.ozlabs.org/patch/417297/
>                 clk: ppc-corenet: fix section mismatch warning
> =

>  drivers/clk/clk-ppc-corenet.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> =

> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
> index 57a2de4..5e9bb18 100644
> --- a/drivers/clk/clk-ppc-corenet.c
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -19,6 +19,7 @@
>  struct cmux_clk {
>         struct clk_hw hw;
>         void __iomem *reg;
> +       unsigned int clk_per_pll;
>         u32 flags;
>  };
>  =

> @@ -27,14 +28,12 @@ struct cmux_clk {
>  #define CLKSEL_ADJUST          BIT(0)
>  #define to_cmux_clk(p)         container_of(p, struct cmux_clk, hw)
>  =

> -static unsigned int clocks_per_pll;
> -
>  static int cmux_set_parent(struct clk_hw *hw, u8 idx)
>  {
>         struct cmux_clk *clk =3D to_cmux_clk(hw);
>         u32 clksel;
>  =

> -       clksel =3D ((idx / clocks_per_pll) << 2) + idx % clocks_per_pll;
> +       clksel =3D ((idx / clk->clk_per_pll) << 2) + idx % clk->clk_per_p=
ll;
>         if (clk->flags & CLKSEL_ADJUST)
>                 clksel +=3D 8;
>         clksel =3D (clksel & 0xf) << CLKSEL_SHIFT;
> @@ -52,7 +51,7 @@ static u8 cmux_get_parent(struct clk_hw *hw)
>         clksel =3D (clksel >> CLKSEL_SHIFT) & 0xf;
>         if (clk->flags & CLKSEL_ADJUST)
>                 clksel -=3D 8;
> -       clksel =3D (clksel >> 2) * clocks_per_pll + clksel % 4;
> +       clksel =3D (clksel >> 2) * clk->clk_per_pll + clksel % 4;
>  =

>         return clksel;
>  }
> @@ -72,6 +71,7 @@ static void __init core_mux_init(struct device_node *np)
>         u32     offset;
>         const char *clk_name;
>         const char **parent_names;
> +       struct of_phandle_args clkspec;
>  =

>         rc =3D of_property_read_u32(np, "reg", &offset);
>         if (rc) {
> @@ -105,6 +105,17 @@ static void __init core_mux_init(struct device_node =
*np)
>                 goto err_clk;
>         }
>  =

> +       rc =3D of_parse_phandle_with_args(np, "clocks", "#clock-cells", 0,
> +                                       &clkspec);
> +       if (rc) {
> +               pr_err("%s: parse clock node error\n", __func__);
> +               goto err_clk;
> +       }
> +
> +       cmux_clk->clk_per_pll =3D of_property_count_strings(clkspec.np,
> +                       "clock-output-names");
> +       of_node_put(clkspec.np);
> +
>         node =3D of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen"=
);
>         if (node && (offset >=3D 0x80))
>                 cmux_clk->flags =3D CLKSEL_ADJUST;
> @@ -181,9 +192,6 @@ static void __init core_pll_init(struct device_node *=
np)
>                 goto err_map;
>         }
>  =

> -       /* output clock number per PLL */
> -       clocks_per_pll =3D count;
> -
>         subclks =3D kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
>         if (!subclks) {
>                 pr_err("%s: could not allocate subclks\n", __func__);
> -- =

> 2.1.0.27.g96db324
>=20
