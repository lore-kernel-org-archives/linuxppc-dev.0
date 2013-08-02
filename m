Return-Path: <mturquette@linaro.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 44BD92C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 08:30:06 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id u10so1136866pdi.22
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2013 15:30:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1374495298-22019-14-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-14-git-send-email-gsi@denx.de>
Message-ID: <20130802223000.6450.97817@quantum>
Subject: Re: [PATCH v3 13/31] clk: wrap I/O access for improved portability
Date: Fri, 02 Aug 2013 15:30:00 -0700
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

Quoting Gerhard Sittig (2013-07-22 05:14:40)
> the common clock drivers were motivated/initiated by ARM development
> and apparently assume little endian peripherals
> =

> wrap register/peripherals access in the common code (div, gate, mux)
> in preparation of adding COMMON_CLK support for other platforms
> =

> Signed-off-by: Gerhard Sittig <gsi@denx.de>

I've taken this into clk-next for testing. regmap deserves investigation
but I don't think your series should be blocked on that. We can always
overhaul the basic clock primitives with regmap support later on if that
makes sense.

Regards,
Mike

> ---
>  drivers/clk/clk-divider.c    |    6 +++---
>  drivers/clk/clk-gate.c       |    6 +++---
>  drivers/clk/clk-mux.c        |    6 +++---
>  include/linux/clk-provider.h |   17 +++++++++++++++++
>  4 files changed, 26 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 6d55eb2..2c07061 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct c=
lk_hw *hw,
>         struct clk_divider *divider =3D to_clk_divider(hw);
>         unsigned int div, val;
>  =

> -       val =3D readl(divider->reg) >> divider->shift;
> +       val =3D clk_readl(divider->reg) >> divider->shift;
>         val &=3D div_mask(divider);
>  =

>         div =3D _get_div(divider, val);
> @@ -230,11 +230,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, =
unsigned long rate,
>         if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
>                 val =3D div_mask(divider) << (divider->shift + 16);
>         } else {
> -               val =3D readl(divider->reg);
> +               val =3D clk_readl(divider->reg);
>                 val &=3D ~(div_mask(divider) << divider->shift);
>         }
>         val |=3D value << divider->shift;
> -       writel(val, divider->reg);
> +       clk_writel(val, divider->reg);
>  =

>         if (divider->lock)
>                 spin_unlock_irqrestore(divider->lock, flags);
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index 790306e..b7fbd96 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -58,7 +58,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int e=
nable)
>                 if (set)
>                         reg |=3D BIT(gate->bit_idx);
>         } else {
> -               reg =3D readl(gate->reg);
> +               reg =3D clk_readl(gate->reg);
>  =

>                 if (set)
>                         reg |=3D BIT(gate->bit_idx);
> @@ -66,7 +66,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int e=
nable)
>                         reg &=3D ~BIT(gate->bit_idx);
>         }
>  =

> -       writel(reg, gate->reg);
> +       clk_writel(reg, gate->reg);
>  =

>         if (gate->lock)
>                 spin_unlock_irqrestore(gate->lock, flags);
> @@ -89,7 +89,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
>         u32 reg;
>         struct clk_gate *gate =3D to_clk_gate(hw);
>  =

> -       reg =3D readl(gate->reg);
> +       reg =3D clk_readl(gate->reg);
>  =

>         /* if a set bit disables this clk, flip it before masking */
>         if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 614444c..02ef506 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -42,7 +42,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
>          * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock,=
 so
>          * val =3D 0x4 really means "bit 2, index starts at bit 0"
>          */
> -       val =3D readl(mux->reg) >> mux->shift;
> +       val =3D clk_readl(mux->reg) >> mux->shift;
>         val &=3D mux->mask;
>  =

>         if (mux->table) {
> @@ -89,11 +89,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 i=
ndex)
>         if (mux->flags & CLK_MUX_HIWORD_MASK) {
>                 val =3D mux->mask << (mux->shift + 16);
>         } else {
> -               val =3D readl(mux->reg);
> +               val =3D clk_readl(mux->reg);
>                 val &=3D ~(mux->mask << mux->shift);
>         }
>         val |=3D index << mux->shift;
> -       writel(val, mux->reg);
> +       clk_writel(val, mux->reg);
>  =

>         if (mux->lock)
>                 spin_unlock_irqrestore(mux->lock, flags);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 1ec14a7..c4f7799 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -12,6 +12,7 @@
>  #define __LINUX_CLK_PROVIDER_H
>  =

>  #include <linux/clk.h>
> +#include <linux/io.h>
>  =

>  #ifdef CONFIG_COMMON_CLK
>  =

> @@ -490,5 +491,21 @@ static inline const char *of_clk_get_parent_name(str=
uct device_node *np,
>  #define of_clk_init(matches) \
>         { while (0); }
>  #endif /* CONFIG_OF */
> +
> +/*
> + * wrap access to peripherals in accessor routines
> + * for improved portability across platforms
> + */
> +
> +static inline u32 clk_readl(u32 __iomem *reg)
> +{
> +       return readl(reg);
> +}
> +
> +static inline void clk_writel(u32 val, u32 __iomem *reg)
> +{
> +       writel(val, reg);
> +}
> +
>  #endif /* CONFIG_COMMON_CLK */
>  #endif /* CLK_PROVIDER_H */
> -- =

> 1.7.10.4
