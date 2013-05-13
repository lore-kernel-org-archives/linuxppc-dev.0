Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F12562C0188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 05:25:19 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id hz10so4937706pad.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 12:25:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: <Yuantian.Tang@freescale.com>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1365497187-8305-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1365497187-8305-1-git-send-email-Yuantian.Tang@freescale.com>
Message-ID: <20130513192513.10068.7049@quantum>
Subject: Re: [PATCH v3] clk: add PowerPC corenet clock driver support
Date: Mon, 13 May 2013 12:25:13 -0700
Cc: ulf.hansson@linaro.org, linux-doc@vger.kernel.org, viresh.kumar@linaro.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linus.walleij@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Yuantian.Tang@freescale.com (2013-04-09 01:46:26)
> From: Tang Yuantian <yuantian.tang@freescale.com>
> =

> This adds the clock driver for Freescale PowerPC corenet
> series SoCs using common clock infrastructure.
> =

> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Patch #1 looks good to me.  I've taken it into clk-next for now, but by
aware that I'll be rebasing that branch until at least -rc3 comes out,
so don't use it for a stable branch.

I did not take in patch #2, I guess you'll send that through a PPC tree?

Regards,
Mike

> ---
> v3:
>         - remove the module author and description
> v2:
>         - add the document for device tree clock bindings
> =

>  arch/powerpc/platforms/Kconfig.cputype |   1 +
>  drivers/clk/Kconfig                    |   7 +
>  drivers/clk/Makefile                   |   1 +
>  drivers/clk/clk-ppc-corenet.c          | 280 +++++++++++++++++++++++++++=
++++++
>  4 files changed, 289 insertions(+)
>  create mode 100644 drivers/clk/clk-ppc-corenet.c
> =

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platfo=
rms/Kconfig.cputype
> index 18e3b76..cf065b8 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -158,6 +158,7 @@ config E500
>  config PPC_E500MC
>         bool "e500mc Support"
>         select PPC_FPU
> +       select COMMON_CLK
>         depends on E500
>         help
>           This must be enabled for running on e500mc (and derivatives
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index a47e6ee..6e2fd9c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -63,6 +63,13 @@ config CLK_TWL6040
>           McPDM. McPDM module is using the external bit clock on the McPD=
M bus
>           as functional clock.
>  =

> +config CLK_PPC_CORENET
> +       bool "Clock driver for PowerPC corenet platforms"
> +       depends on PPC_E500MC && OF
> +       ---help---
> +         This adds the clock driver support for Freescale PowerPC corenet
> +         platforms using common clock framework.
> +
>  endmenu
>  =

>  source "drivers/clk/mvebu/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 300d477..6720319 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_X86)             +=3D x86/
>  obj-$(CONFIG_COMMON_CLK_WM831X) +=3D clk-wm831x.o
>  obj-$(CONFIG_COMMON_CLK_MAX77686) +=3D clk-max77686.o
>  obj-$(CONFIG_CLK_TWL6040)      +=3D clk-twl6040.o
> +obj-$(CONFIG_CLK_PPC_CORENET)  +=3D clk-ppc-corenet.o
> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
> new file mode 100644
> index 0000000..a2d483f
> --- /dev/null
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -0,0 +1,280 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * clock driver for Freescale PowerPC corenet SoCs.
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +struct cmux_clk {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       u32 flags;
> +};
> +
> +#define PLL_KILL                       BIT(31)
> +#define        CLKSEL_SHIFT            27
> +#define CLKSEL_ADJUST          BIT(0)
> +#define to_cmux_clk(p)         container_of(p, struct cmux_clk, hw)
> +
> +static void __iomem *base;
> +static unsigned int clocks_per_pll;
> +
> +static int cmux_set_parent(struct clk_hw *hw, u8 idx)
> +{
> +       struct cmux_clk *clk =3D to_cmux_clk(hw);
> +       u32 clksel;
> +
> +       clksel =3D ((idx / clocks_per_pll) << 2) + idx % clocks_per_pll;
> +       if (clk->flags & CLKSEL_ADJUST)
> +               clksel +=3D 8;
> +       clksel =3D (clksel & 0xf) << CLKSEL_SHIFT;
> +       iowrite32be(clksel, clk->reg);
> +
> +       return 0;
> +}
> +
> +static u8 cmux_get_parent(struct clk_hw *hw)
> +{
> +       struct cmux_clk *clk =3D to_cmux_clk(hw);
> +       u32 clksel;
> +
> +       clksel =3D ioread32be(clk->reg);
> +       clksel =3D (clksel >> CLKSEL_SHIFT) & 0xf;
> +       if (clk->flags & CLKSEL_ADJUST)
> +               clksel -=3D 8;
> +       clksel =3D (clksel >> 2) * clocks_per_pll + clksel % 4;
> +
> +       return clksel;
> +}
> +
> +const struct clk_ops cmux_ops =3D {
> +       .get_parent =3D cmux_get_parent,
> +       .set_parent =3D cmux_set_parent,
> +};
> +
> +static void __init core_mux_init(struct device_node *np)
> +{
> +       struct clk *clk;
> +       struct clk_init_data init;
> +       struct cmux_clk *cmux_clk;
> +       struct device_node *node;
> +       int rc, count, i;
> +       u32     offset;
> +       const char *clk_name;
> +       const char **parent_names;
> +
> +       rc =3D of_property_read_u32(np, "reg", &offset);
> +       if (rc) {
> +               pr_err("%s: could not get reg property\n", np->name);
> +               return;
> +       }
> +
> +       /* get the input clock source count */
> +       count =3D of_property_count_strings(np, "clock-names");
> +       if (count < 0) {
> +               pr_err("%s: get clock count error\n", np->name);
> +               return;
> +       }
> +       parent_names =3D kzalloc((sizeof(char *) * count), GFP_KERNEL);
> +       if (!parent_names) {
> +               pr_err("%s: could not allocate parent_names\n", __func__);
> +               return;
> +       }
> +
> +       for (i =3D 0; i < count; i++)
> +               parent_names[i] =3D of_clk_get_parent_name(np, i);
> +
> +       cmux_clk =3D kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);
> +       if (!cmux_clk) {
> +               pr_err("%s: could not allocate cmux_clk\n", __func__);
> +               goto err_name;
> +       }
> +       cmux_clk->reg =3D base + offset;
> +
> +       node =3D of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen"=
);
> +       if (node && (offset >=3D 0x80))
> +               cmux_clk->flags =3D CLKSEL_ADJUST;
> +
> +       rc =3D of_property_read_string_index(np, "clock-output-names",
> +                       0, &clk_name);
> +       if (rc) {
> +               pr_err("%s: read clock names error\n", np->name);
> +               goto err_clk;
> +       }
> +
> +       init.name =3D clk_name;
> +       init.ops =3D &cmux_ops;
> +       init.parent_names =3D parent_names;
> +       init.num_parents =3D count;
> +       init.flags =3D 0;
> +       cmux_clk->hw.init =3D &init;
> +
> +       clk =3D clk_register(NULL, &cmux_clk->hw);
> +       if (IS_ERR(clk)) {
> +               pr_err("%s: could not register clock\n", clk_name);
> +               goto err_clk;
> +       }
> +
> +       rc =3D of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +       if (rc) {
> +               pr_err("Could not register clock provider for node:%s\n",
> +                        np->name);
> +               goto err_clk;
> +       }
> +       goto err_name;
> +
> +err_clk:
> +       kfree(cmux_clk);
> +err_name:
> +       /* free *_names because they are reallocated when registered */
> +       kfree(parent_names);
> +}
> +
> +static void __init core_pll_init(struct device_node *np)
> +{
> +       u32 offset, mult;
> +       int i, rc, count;
> +       const char *clk_name, *parent_name;
> +       struct clk_onecell_data *onecell_data;
> +       struct clk      **subclks;
> +
> +       rc =3D of_property_read_u32(np, "reg", &offset);
> +       if (rc) {
> +               pr_err("%s: could not get reg property\n", np->name);
> +               return;
> +       }
> +
> +       /* get the multiple of PLL */
> +       mult =3D ioread32be(base + offset);
> +
> +       /* check if this PLL is disabled */
> +       if (mult & PLL_KILL) {
> +               pr_debug("PLL:%s is disabled\n", np->name);
> +               return;
> +       }
> +       mult =3D (mult >> 1) & 0x3f;
> +
> +       parent_name =3D of_clk_get_parent_name(np, 0);
> +       if (!parent_name) {
> +               pr_err("PLL: %s must have a parent\n", np->name);
> +               return;
> +       }
> +
> +       count =3D of_property_count_strings(np, "clock-output-names");
> +       if (count < 0 || count > 4) {
> +               pr_err("%s: clock is not supported\n", np->name);
> +               return;
> +       }
> +
> +       /* output clock number per PLL */
> +       clocks_per_pll =3D count;
> +
> +       subclks =3D kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
> +       if (!subclks) {
> +               pr_err("%s: could not allocate subclks\n", __func__);
> +               return;
> +       }
> +
> +       onecell_data =3D kzalloc(sizeof(struct clk_onecell_data), GFP_KER=
NEL);
> +       if (!onecell_data) {
> +               pr_err("%s: could not allocate onecell_data\n", __func__);
> +               goto err_clks;
> +       }
> +
> +       for (i =3D 0; i < count; i++) {
> +               rc =3D of_property_read_string_index(np, "clock-output-na=
mes",
> +                               i, &clk_name);
> +               if (rc) {
> +                       pr_err("%s: could not get clock names\n", np->nam=
e);
> +                       goto err_cell;
> +               }
> +
> +               /*
> +                * when count =3D=3D 4, there are 4 output clocks:
> +                * /1, /2, /3, /4 respectively
> +                * when count < 4, there are at least 2 output clocks:
> +                * /1, /2, (/4, if count =3D=3D 3) respectively.
> +                */
> +               if (count =3D=3D 4)
> +                       subclks[i] =3D clk_register_fixed_factor(NULL, cl=
k_name,
> +                                       parent_name, 0, mult, 1 + i);
> +               else
> +
> +                       subclks[i] =3D clk_register_fixed_factor(NULL, cl=
k_name,
> +                                       parent_name, 0, mult, 1 << i);
> +
> +               if (IS_ERR(subclks[i])) {
> +                       pr_err("%s: could not register clock\n", clk_name=
);
> +                       goto err_cell;
> +               }
> +       }
> +
> +       onecell_data->clks =3D subclks;
> +       onecell_data->clk_num =3D count;
> +
> +       rc =3D of_clk_add_provider(np, of_clk_src_onecell_get, onecell_da=
ta);
> +       if (rc) {
> +               pr_err("Could not register clk provider for node:%s\n",
> +                        np->name);
> +               goto err_cell;
> +       }
> +
> +       return;
> +err_cell:
> +       kfree(onecell_data);
> +err_clks:
> +       kfree(subclks);
> +}
> +
> +static const struct of_device_id clk_match[] __initconst =3D {
> +       { .compatible =3D "fixed-clock", .data =3D of_fixed_clk_setup, },
> +       { .compatible =3D "fsl,core-pll-clock", .data =3D core_pll_init, =
},
> +       { .compatible =3D "fsl,core-mux-clock", .data =3D core_mux_init, =
},
> +       {}
> +};
> +
> +static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np;
> +
> +       np =3D pdev->dev.of_node;
> +       base =3D of_iomap(np, 0);
> +       if (!base) {
> +               dev_err(&pdev->dev, "iomap error\n");
> +               return -ENOMEM;
> +       }
> +       of_clk_init(clk_match);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id ppc_clk_ids[] __initconst =3D {
> +       { .compatible =3D "fsl,qoriq-clockgen-1.0", },
> +       { .compatible =3D "fsl,qoriq-clockgen-2", },
> +       {}
> +};
> +
> +static struct platform_driver ppc_corenet_clk_driver =3D {
> +       .driver =3D {
> +               .name =3D "ppc_corenet_clock",
> +               .owner =3D THIS_MODULE,
> +               .of_match_table =3D ppc_clk_ids,
> +       },
> +       .probe =3D ppc_corenet_clk_probe,
> +};
> +
> +static int __init ppc_corenet_clk_init(void)
> +{
> +       return platform_driver_register(&ppc_corenet_clk_driver);
> +}
> +subsys_initcall(ppc_corenet_clk_init);
> -- =

> 1.8.0
