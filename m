Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6880A2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 03:11:34 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kl13so3538478pab.34
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 10:11:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20130803143956.GH2580@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-18-git-send-email-gsi@denx.de>
 <20130723131406.GI19071@book.gsilab.sittig.org>
 <20130802233009.6450.21915@quantum>
 <20130803143956.GH2580@book.gsilab.sittig.org>
Message-ID: <20130805171122.5348.59628@quantum>
Subject: Re: [PATCH v3 17/31] clk: mpc512x: introduce COMMON_CLK for MPC512x
Date: Mon, 05 Aug 2013 10:11:22 -0700
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

Quoting Gerhard Sittig (2013-08-03 07:39:56)
> [ we are strictly talking about clocks and source code again,
>   I have trimmed the CC: list to not spam the device tree ML or
>   subsystem maintainers ]
> =

> On Fri, Aug 02, 2013 at 16:30 -0700, Mike Turquette wrote:
> > =

> > Quoting Gerhard Sittig (2013-07-23 06:14:06)
> > > [ summary: "shared gate" support desirable? approach acceptable? ]
> > > =

> > > On Mon, Jul 22, 2013 at 14:14 +0200, Gerhard Sittig wrote:
> > > > =

> > > > this change implements a clock driver for the MPC512x PowerPC platf=
orm
> > > > which follows the COMMON_CLK approach and uses common clock drivers
> > > > shared with other platforms
> > > > =

> > > > [ ... ]
> > > > =

> > > > some of the clock items get pre-enabled in the clock driver to not =
have
> > > > them automatically disabled by the underlying clock subsystem becau=
se of
> > > > their being unused -- this approach is desirable because
> > > > [ ... ]
> > > > - some help introduce support for and migrate to the common
> > > >   infrastructure, while more appropriate support for specific hardw=
are
> > > >   constraints isn't available yet (remaining changes are strictly
> > > >   internal to the clock driver and won't affect peripheral drivers)
> > > =

> > > This remark was related to the CAN clocks of the MPC512x SoC.
> > =

> > Gerhard,
> > =

> > Thanks for the patch (way far down below here). I'll check into it to
> > see if that implementation looks OK. It would be helpful if another
> > platform with shared gates could weigh in on whether the implementation
> > works for them.
> > =

> > Still, a shared gate solution is not a prerequisite for this series,
> > correct?
> =

> Well, the recent CAN driver related discussion suggested that I
> had a mental misconception there.  The need for "shared gates"
> was felt because of mixing up unrelated paths in the clock tree.
> But the MCLK subtree is for bitrate generation, while the BDLC
> gate is for register access into the peripheral controller.
> =

> Currently I'm investigating how I can cleanly tell those
> individual aspects apart.  Telling the gate for register access
> (in ARM speak often referred to as 'ipg') from the bitrate
> generation (the 'per' clock, or 'mclk' here) seems so much more
> appropriate.
> =

> After clean separation, and more testing to make sure nothing
> gets broken throughout the series, there will be v4.
> =

> =

> So "shared gate" support might have become obsolete for the
> MPC512x platform.  But if others need it, the outlined approach
> (patch below) may be viable.  The change to the common code is
> minimal.  The use in the platform's clock driver was kind of
> overengineered for the case of exactly one such gate, but this
> immediately makes it a working approach for several gates, if
> others need it.
> =

> I'll trim the motivation and just leave the suggested approach
> for "shared gates" here.  Feel free to drop it or to only
> resurrect it as the need may re-arise later.  So far nobody
> appears to have felt the need up to now ...

You can drop it. If your platform does not need it and nobody else has
said that they require shared gates then there is no reason to spend
more time on it.

Regards,
Mike

> =

> > > [ ... ]
> > > =

> > > The question now is how to correctly support the situation where
> > > a gate is shared between subtrees yet isn't really part of any
> > > path within the subtrees.  I really cannot find a single spot
> > > where to introduce the gate such that it's not duplicated.
> > > =

> > > The appropriate solution would not be to pre-enable those clocks,
> > > but to either introduce another gate clock type which supports a
> > > shared reference, or to add support for the shared reference to
> > > the existing gate code.
> > > =

> > > =

> > > I'd rather not duplicate most or all of the code of clk-gate.c,
> > > instead I looked into how to add "shared gate" support to the
> > > existing driver.
> > > =

> > > My question is whether the approach is acceptable.  It adds
> > > minimal overhead and shall be OK for the enable/disable path from
> > > a technical POV.  And it doesn't feel like too much of a stretch.
> > > But there may be non-technical reasons to reject the approach.
> > > I'd like to learn whether to follow that path before preparing
> > > another version of the patch series.
> > > =

> > > The diffs were taken with the '-w -b' options to demonstrate
> > > their essence and not drown it in whitespace changes.  The
> > > implementation assumes that the caller which registers the gate
> > > (the platform's clock driver) provides both the counter cell and
> > > the lock.  And that all gates with a "shared use counter" use the
> > > same lock (which is satisfied as they all get registered from the
> > > same spot in the platform's clock driver).
> > > =

> > > The CLK_IGNORE_UNUSED flag addresses a different problem.  The
> > > SoC has four MSCAN components, while two of them are enabled in
> > > the device tree (the other two are present but disabled).  So
> > > during probe two of the clocks get enabled.  After probe all
> > > unused clocks automatically get disabled (that's another two).
> > > So the "shared use counter" drops to zero although components are
> > > in use, because "disable, it's unused" isn't told from "disable
> > > after enable, regular use".  The flag would become obsolete if
> > > the common gate logic would implement a separate disable_unused()
> > > routine, but I guess this isn't necessary and the use of the flag
> > > is appropriate.
> > > =

> > > That the example use creates a field for just one counter is to
> > > better demonstrate the use and potential extension as need
> > > arises.  Reducing this to a mere integer variable would be a
> > > micro optimization.
> > > =

> > > =

> > > The extension of the existing clk_gate implementation:
> > > =

> > > --- a/drivers/clk/clk-gate.c
> > > +++ b/drivers/clk/clk-gate.c
> > > @@ -46,6 +46,7 @@ static void clk_gate_endisable(struct clk_hw *hw, i=
nt enable)
> > >         struct clk_gate *gate =3D to_clk_gate(hw);
> > >         int set =3D gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
> > >         unsigned long flags =3D 0;
> > > +       int need_reg_access;
> > >         u32 reg;
> > >  =

> > >         set ^=3D enable;
> > > @@ -53,6 +54,20 @@ static void clk_gate_endisable(struct clk_hw *hw, =
int enable)
> > >         if (gate->lock)
> > >                 spin_lock_irqsave(gate->lock, flags);
> > >  =

> > > +       /*
> > > +        * if a "shared use counter" was specified, keep track of ena=
ble
> > > +        * and disable calls and only access hardware registers upon =
the
> > > +        * very first enable or very last disable call
> > > +        */
> > > +       if (!gate->share_count) {
> > > +               need_reg_access =3D 1;
> > > +       } else if (enable) {
> > > +               need_reg_access =3D (*gate->share_count)++ =3D=3D 0;
> > > +       } else {
> > > +               need_reg_access =3D --(*gate->share_count) =3D=3D 0;
> > > +       }
> > > +
> > > +       if (need_reg_access) {
> > >                 if (gate->flags & CLK_GATE_HIWORD_MASK) {
> > >                         reg =3D BIT(gate->bit_idx + 16);
> > >                         if (set)
> > > @@ -67,6 +82,7 @@ static void clk_gate_endisable(struct clk_hw *hw, i=
nt enable)
> > >                 }
> > >  =

> > >                 clk_writel(reg, gate->reg);
> > > +       }
> > >  =

> > >         if (gate->lock)
> > >                 spin_unlock_irqrestore(gate->lock, flags);
> > > @@ -118,10 +134,11 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
> > >   * @clk_gate_flags: gate-specific flags for this clock
> > >   * @lock: shared register lock for this clock
> > >   */
> > > -struct clk *clk_register_gate(struct device *dev, const char *name,
> > > +struct clk *clk_register_gate_shared(struct device *dev, const char =
*name,
> > >                 const char *parent_name, unsigned long flags,
> > >                 void __iomem *reg, u8 bit_idx,
> > > -               u8 clk_gate_flags, spinlock_t *lock)
> > > +               u8 clk_gate_flags, spinlock_t *lock,
> > > +               int *share_count)
> > >  {
> > >         struct clk_gate *gate;
> > >         struct clk *clk;
> > > @@ -152,6 +169,7 @@ struct clk *clk_register_gate(struct device *dev,=
 const char *name,
> > >         gate->bit_idx =3D bit_idx;
> > >         gate->flags =3D clk_gate_flags;
> > >         gate->lock =3D lock;
> > > +       gate->share_count =3D share_count;
> > >         gate->hw.init =3D &init;
> > >  =

> > >         clk =3D clk_register(dev, &gate->hw);
> > > @@ -161,3 +179,14 @@ struct clk *clk_register_gate(struct device *dev=
, const char *name,
> > >  =

> > >         return clk;
> > >  }
> > > +
> > > +struct clk *clk_register_gate(struct device *dev, const char *name,
> > > +               const char *parent_name, unsigned long flags,
> > > +               void __iomem *reg, u8 bit_idx,
> > > +               u8 clk_gate_flags, spinlock_t *lock)
> > > +{
> > > +
> > > +       return clk_register_gate_shared(dev, name, parent_name, flags,
> > > +                                       reg, bit_idx, clk_gate_flags,
> > > +                                       lock, NULL);
> > > +}
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -222,6 +222,7 @@ struct clk_gate {
> > >         u8              bit_idx;
> > >         u8              flags;
> > >         spinlock_t      *lock;
> > > +       int             *share_count;
> > >  };
> > >  =

> > >  #define CLK_GATE_SET_TO_DISABLE                BIT(0)
> > > @@ -232,6 +233,11 @@ struct clk *clk_register_gate(struct device *dev=
, const char *name,
> > >                 const char *parent_name, unsigned long flags,
> > >                 void __iomem *reg, u8 bit_idx,
> > >                 u8 clk_gate_flags, spinlock_t *lock);
> > > +struct clk *clk_register_gate_shared(struct device *dev, const char =
*name,
> > > +               const char *parent_name, unsigned long flags,
> > > +               void __iomem *reg, u8 bit_idx,
> > > +               u8 clk_gate_flags, spinlock_t *lock,
> > > +               int *share_count);
> > >  =

> > >  struct clk_div_table {
> > >         unsigned int    val;
> > > =

> > > =

> > > How to use these shared gates:
> > > =

> > > --- a/arch/powerpc/platforms/512x/clock-commonclk.c
> > > +++ b/arch/powerpc/platforms/512x/clock-commonclk.c
> > > @@ -123,6 +123,39 @@ static inline struct clk *mpc512x_clk_gated(
> > >                                  reg, pos, 0, &clklock);
> > >  }
> > >  =

> > > +enum mpc512x_clk_shared_gate_id_t {
> > > +       MPC512x_CLK_SHARED_GATE_MSCAN,
> > > +       MPC512x_CLK_SHARED_GATE_MAX,
> > > +};
> > > +
> > > +static int mpc512x_clk_gate_counters[MPC512x_CLK_SHARED_GATE_MAX];
> > > +
> > > +/*
> > > + * implementor's note:  since clk_gate items don't implement a separ=
ate
> > > + * .disable_unused() callback, their .disable() routine gets called =
and
> > > + * "disable the clock as we can't see it's in use" cannot be told fr=
om
> > > + * "regular disable, count these events please"
> > > + *
> > > + * passing the CLK_IGNORE_UNUSED flag upon clock creation will suppr=
ess
> > > + * the "disable, unused" call, so use counts won't get unbalanced, t=
he
> > > + * clock either never got enabled and thus need not get disabled, or
> > > + * part of the hardware got enabled while disabling the other part i=
sn't
> > > + * wanted
> > > + */
> > > +static inline struct clk *mpc512x_clk_gated_shared(
> > > +       const char *name, const char *parent_name,
> > > +       u32 __iomem *reg, u8 pos,
> > > +       enum mpc512x_clk_shared_gate_id_t share_id)
> > > +{
> > > +       int clkflags;
> > > +
> > > +       clkflags =3D CLK_SET_RATE_PARENT;
> > > +       clkflags |=3D CLK_IGNORE_UNUSED;
> > > +       return clk_register_gate_shared(NULL, name, parent_name, clkf=
lags,
> > > +                                       reg, pos, 0, &clklock,
> > > +                                       &mpc512x_clk_gate_counters[sh=
are_id]);
> > > +}
> > > +
> > >  static inline struct clk *mpc512x_clk_muxed(const char *name,
> > >         const char **parent_names, int parent_count,
> > >         u32 __iomem *reg, u8 pos, u8 len)
> > > @@ -520,9 +553,16 @@ static void mpc512x_clk_setup_mclk(struct mclk_s=
etup_data *entry)
> > >                                 1, 1);
> > >         }
> > >         if (sccr_reg) {
> > > +               if (entry->type =3D=3D MCLK_TYPE_MSCAN) {
> > > +                       clks[clks_idx_pub] =3D mpc512x_clk_gated_shar=
ed(
> > > +                                       entry->name_mclk,
> > > +                                       entry->name_mux1, sccr_reg, s=
ccr_bit,
> > > +                                       MPC512x_CLK_SHARED_GATE_MSCAN=
);
> > > +               } else {
> > >                         clks[clks_idx_pub] =3D mpc512x_clk_gated(
> > >                                         entry->name_mclk,
> > >                                         entry->name_mux1, sccr_reg, s=
ccr_bit);
> > > +               }
> > >         } else {
> > >                 clks[clks_idx_pub] =3D mpc512x_clk_factor(
> > >                                 entry->name_mclk,
> > > =

> > > Local tests have shown that the extension solves the problem of
> > > how to satisfy the SoC's constraints on the MPC512x platform.
> > > The MSCAN clocks no longer need to get pre-enabled, instead they
> > > get setup and enabled only as the mscan(4) driver probes devices
> > > according to how it was instructed (device tree nodes).
> > > =

> > > What do you think?  Is the "shared gate" support in the common
> > > logic appropriate?  I'd rather not duplicate all of this code
> > > just to introduce the specific gate I need, while most of the
> > > logic is identical to the existing gate implementation.  The
> > > desire isn't to override the gate's operations, but to wrap them
> > > and to consult a counter in addition, while the register access
> > > still applies.
> =

> =

> virtually yours
> Gerhard Sittig
> -- =

> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
