Return-Path: <mturquette@linaro.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5264C2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 11:06:26 +1100 (EST)
Received: by mail-pb0-f50.google.com with SMTP id md12so87607pbc.23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 17:06:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 "tang yuantian" <Yuantian.Tang@freescale.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20140319215223.GA28070@home.buserror.net>
References: <1390267965-22408-1-git-send-email-Yuantian.Tang@freescale.com>
 <20140319215223.GA28070@home.buserror.net>
Message-ID: <20140320000616.21989.35743@quantum>
Subject: Re: clk: mpc85xx: Update the driver to align to new clock bindings
Date: Wed, 19 Mar 2014 17:06:16 -0700
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood (2014-03-19 14:52:23)
> On Tue, Jan 21, 2014 at 09:32:45AM +0800, tang yuantian wrote:
> > From: Tang Yuantian <yuantian.tang@freescale.com>
> > =

> > The clock bindings for Freescale CoreNet platform are updated.
> > So, the driver needs to be updated accordingly.
> > The main changes include:
> >       - Added a new node to present the input system clock
> >       - Changed PLL and MUX's compatible string
> > =

> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > =

> > ---
> > drivers/clk/clk-ppc-corenet.c | 70 +++++++++++++++++++++++++++++-------=
-------
> >  1 file changed, 48 insertions(+), 22 deletions(-)
> =

> Acked-by: Scott Wood <scottwood@freescale.com>
> =

> Mike, does this need to go to linux-arm-kernel@lists.infradead.org as per
> MAINTAINERS for drivers/clk?

Nope, I should probably change that to LKML just be politically correct.
The important thing is to Cc me (which the original poster did) and ping
me if I don't review your patch after a week or two (which you did).

This patch looks great and I've taken it into clk-next.

Thanks,
Mike

> =

> > diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corene=
t.c
> > index c4f76ed..8b284be 100644
> > --- a/drivers/clk/clk-ppc-corenet.c
> > +++ b/drivers/clk/clk-ppc-corenet.c
> > @@ -27,7 +27,6 @@ struct cmux_clk {
> >  #define CLKSEL_ADJUST                BIT(0)
> >  #define to_cmux_clk(p)               container_of(p, struct cmux_clk, =
hw)
> >  =

> > -static void __iomem *base;
> >  static unsigned int clocks_per_pll;
> >  =

> >  static int cmux_set_parent(struct clk_hw *hw, u8 idx)
> > @@ -100,7 +99,11 @@ static void __init core_mux_init(struct device_node=
 *np)
> >               pr_err("%s: could not allocate cmux_clk\n", __func__);
> >               goto err_name;
> >       }
> > -     cmux_clk->reg =3D base + offset;
> > +     cmux_clk->reg =3D of_iomap(np, 0);
> > +     if (!cmux_clk->reg) {
> > +             pr_err("%s: could not map register\n", __func__);
> > +             goto err_clk;
> > +     }
> =

> dev_err?  Though it looks like of_clk_init() makes it hard to pass a
> reference to the parent device (or anything else but a function pointer
> and device tree node) to the init function -- why?
> =

> >       node =3D of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen"=
);
> >       if (node && (offset >=3D 0x80))
> > @@ -143,38 +146,39 @@ err_name:
> >  =

> >  static void __init core_pll_init(struct device_node *np)
> >  {
> > -     u32 offset, mult;
> > +     u32 mult;
> >       int i, rc, count;
> >       const char *clk_name, *parent_name;
> >       struct clk_onecell_data *onecell_data;
> >       struct clk      **subclks;
> > +     void __iomem *base;
> >  =

> > -     rc =3D of_property_read_u32(np, "reg", &offset);
> > -     if (rc) {
> > -             pr_err("%s: could not get reg property\n", np->name);
> > +     base =3D of_iomap(np, 0);
> > +     if (!base) {
> > +             pr_err("clk-ppc: iomap error\n");
> >               return;
> >       }
> >  =

> >       /* get the multiple of PLL */
> > -     mult =3D ioread32be(base + offset);
> > +     mult =3D ioread32be(base);
> >  =

> >       /* check if this PLL is disabled */
> >       if (mult & PLL_KILL) {
> >               pr_debug("PLL:%s is disabled\n", np->name);
> > -             return;
> > +             goto err_map;
> >       }
> >       mult =3D (mult >> 1) & 0x3f;
> >  =

> >       parent_name =3D of_clk_get_parent_name(np, 0);
> >       if (!parent_name) {
> >               pr_err("PLL: %s must have a parent\n", np->name);
> > -             return;
> > +             goto err_map;
> >       }
> >  =

> >       count =3D of_property_count_strings(np, "clock-output-names");
> >       if (count < 0 || count > 4) {
> >               pr_err("%s: clock is not supported\n", np->name);
> > -             return;
> > +             goto err_map;
> >       }
> >  =

> >       /* output clock number per PLL */
> > @@ -183,7 +187,7 @@ static void __init core_pll_init(struct device_node=
 *np)
> >       subclks =3D kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
> >       if (!subclks) {
> >               pr_err("%s: could not allocate subclks\n", __func__);
> > -             return;
> > +             goto err_map;
> >       }
> >  =

> >       onecell_data =3D kzalloc(sizeof(struct clk_onecell_data), GFP_KER=
NEL);
> > @@ -230,30 +234,52 @@ static void __init core_pll_init(struct device_no=
de *np)
> >               goto err_cell;
> >       }
> >  =

> > +     iounmap(base);
> >       return;
> >  err_cell:
> >       kfree(onecell_data);
> >  err_clks:
> >       kfree(subclks);
> > +err_map:
> > +     iounmap(base);
> > +}
> =

> Consider devres -- is there a devres version of of_iomap()?
> =

> -Scott
