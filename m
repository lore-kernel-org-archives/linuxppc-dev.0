Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6AA1C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 00:08:54 +1000 (EST)
Date: Sat, 3 Aug 2013 16:08:46 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 13/31] clk: wrap I/O access for improved portability
Message-ID: <20130803140846.GF2580@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-14-git-send-email-gsi@denx.de>
 <20130802223000.6450.97817@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130802223000.6450.97817@quantum>
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ trimming the CC: list for this strictly clock related and
  source code adjusting change, to not spam the device tree ML or
  other subsystem maintainers, just keeping ARM (for clock) and
  PPC lists and people in the loop ]

On Fri, Aug 02, 2013 at 15:30 -0700, Mike Turquette wrote:
> 
> Quoting Gerhard Sittig (2013-07-22 05:14:40)
> > the common clock drivers were motivated/initiated by ARM development
> > and apparently assume little endian peripherals
> > 
> > wrap register/peripherals access in the common code (div, gate, mux)
> > in preparation of adding COMMON_CLK support for other platforms
> > 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> 
> I've taken this into clk-next for testing. regmap deserves investigation
> but I don't think your series should be blocked on that. We can always
> overhaul the basic clock primitives with regmap support later on if that
> makes sense.
> 
> Regards,
> Mike

That's fine.  Though I will re-post this change when updating the
series, but this should not harm (won't conflict) as this
specific patch is stable and won't change any longer.  Keeping
this one patch in the series keeps the series applicable on top
of v3.11-rcN as well as clk-next.

Note that this patch only changes those parts of the code under
drivers/clk/ which get shared among platforms (div, gate, mux).
It doesn't touch non-shared and platform specific drivers.  I
felt this was the most appropriate thing to do.


> > ---
> >  drivers/clk/clk-divider.c    |    6 +++---
> >  drivers/clk/clk-gate.c       |    6 +++---
> >  drivers/clk/clk-mux.c        |    6 +++---
> >  include/linux/clk-provider.h |   17 +++++++++++++++++
> >  4 files changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 6d55eb2..2c07061 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >         struct clk_divider *divider = to_clk_divider(hw);
> >         unsigned int div, val;
> >  
> > -       val = readl(divider->reg) >> divider->shift;
> > +       val = clk_readl(divider->reg) >> divider->shift;
> >         val &= div_mask(divider);
> >  
> >         div = _get_div(divider, val);
> > @@ -230,11 +230,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> >         if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
> >                 val = div_mask(divider) << (divider->shift + 16);
> >         } else {
> > -               val = readl(divider->reg);
> > +               val = clk_readl(divider->reg);
> >                 val &= ~(div_mask(divider) << divider->shift);
> >         }
> >         val |= value << divider->shift;
> > -       writel(val, divider->reg);
> > +       clk_writel(val, divider->reg);
> >  
> >         if (divider->lock)
> >                 spin_unlock_irqrestore(divider->lock, flags);
> > diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> > index 790306e..b7fbd96 100644
> > --- a/drivers/clk/clk-gate.c
> > +++ b/drivers/clk/clk-gate.c
> > @@ -58,7 +58,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
> >                 if (set)
> >                         reg |= BIT(gate->bit_idx);
> >         } else {
> > -               reg = readl(gate->reg);
> > +               reg = clk_readl(gate->reg);
> >  
> >                 if (set)
> >                         reg |= BIT(gate->bit_idx);
> > @@ -66,7 +66,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
> >                         reg &= ~BIT(gate->bit_idx);
> >         }
> >  
> > -       writel(reg, gate->reg);
> > +       clk_writel(reg, gate->reg);
> >  
> >         if (gate->lock)
> >                 spin_unlock_irqrestore(gate->lock, flags);
> > @@ -89,7 +89,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
> >         u32 reg;
> >         struct clk_gate *gate = to_clk_gate(hw);
> >  
> > -       reg = readl(gate->reg);
> > +       reg = clk_readl(gate->reg);
> >  
> >         /* if a set bit disables this clk, flip it before masking */
> >         if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> > diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> > index 614444c..02ef506 100644
> > --- a/drivers/clk/clk-mux.c
> > +++ b/drivers/clk/clk-mux.c
> > @@ -42,7 +42,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
> >          * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
> >          * val = 0x4 really means "bit 2, index starts at bit 0"
> >          */
> > -       val = readl(mux->reg) >> mux->shift;
> > +       val = clk_readl(mux->reg) >> mux->shift;
> >         val &= mux->mask;
> >  
> >         if (mux->table) {
> > @@ -89,11 +89,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
> >         if (mux->flags & CLK_MUX_HIWORD_MASK) {
> >                 val = mux->mask << (mux->shift + 16);
> >         } else {
> > -               val = readl(mux->reg);
> > +               val = clk_readl(mux->reg);
> >                 val &= ~(mux->mask << mux->shift);
> >         }
> >         val |= index << mux->shift;
> > -       writel(val, mux->reg);
> > +       clk_writel(val, mux->reg);
> >  
> >         if (mux->lock)
> >                 spin_unlock_irqrestore(mux->lock, flags);
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 1ec14a7..c4f7799 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -12,6 +12,7 @@
> >  #define __LINUX_CLK_PROVIDER_H
> >  
> >  #include <linux/clk.h>
> > +#include <linux/io.h>
> >  
> >  #ifdef CONFIG_COMMON_CLK
> >  
> > @@ -490,5 +491,21 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
> >  #define of_clk_init(matches) \
> >         { while (0); }
> >  #endif /* CONFIG_OF */
> > +
> > +/*
> > + * wrap access to peripherals in accessor routines
> > + * for improved portability across platforms
> > + */
> > +
> > +static inline u32 clk_readl(u32 __iomem *reg)
> > +{
> > +       return readl(reg);
> > +}
> > +
> > +static inline void clk_writel(u32 val, u32 __iomem *reg)
> > +{
> > +       writel(val, reg);
> > +}
> > +
> >  #endif /* CONFIG_COMMON_CLK */
> >  #endif /* CLK_PROVIDER_H */
> > -- 
> > 1.7.10.4


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
