Return-Path: <mturquette@linaro.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 715592C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 09:30:15 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id xa7so1214596pbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2013 16:30:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20130723131406.GI19071@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-18-git-send-email-gsi@denx.de>
 <20130723131406.GI19071@book.gsilab.sittig.org>
Message-ID: <20130802233009.6450.21915@quantum>
Subject: Re: [PATCH v3 17/31] clk: mpc512x: introduce COMMON_CLK for MPC512x
Date: Fri, 02 Aug 2013 16:30:09 -0700
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Quoting Gerhard Sittig (2013-07-23 06:14:06)
> [ summary: "shared gate" support desirable? approach acceptable? ]
> =

> On Mon, Jul 22, 2013 at 14:14 +0200, Gerhard Sittig wrote:
> > =

> > this change implements a clock driver for the MPC512x PowerPC platform
> > which follows the COMMON_CLK approach and uses common clock drivers
> > shared with other platforms
> > =

> > [ ... ]
> > =

> > some of the clock items get pre-enabled in the clock driver to not have
> > them automatically disabled by the underlying clock subsystem because of
> > their being unused -- this approach is desirable because
> > [ ... ]
> > - some help introduce support for and migrate to the common
> >   infrastructure, while more appropriate support for specific hardware
> >   constraints isn't available yet (remaining changes are strictly
> >   internal to the clock driver and won't affect peripheral drivers)
> =

> This remark was related to the CAN clocks of the MPC512x SoC.

Gerhard,

Thanks for the patch (way far down below here). I'll check into it to
see if that implementation looks OK. It would be helpful if another
platform with shared gates could weigh in on whether the implementation
works for them.

Still, a shared gate solution is not a prerequisite for this series,
correct?

Regards,
Mike

> =

> The clock subtrees which are involved in generating CAN bitrates
> include one path from the XTAL to an internal MCLK (this is part
> of the CCF support for the platform), and another path from the
> MCLK or yet another IP bus clock to the actual bitrate on the
> wire (this is taken care of within the mscan(4) driver).
> =

> The MCLK generation for CAN is documented in the MPC5121e
> Reference Manual, chapter 5, section 5.2.5 "MSCAN Clock
> Generation".  SYS, REF (both internal), PSC_MCLK_IN, and SPDIF_TX
> (both external) are muxed, gated, and divided.  The result is
> muxed with IP.  The result is fed into the MSCAN component and
> gets muxed with IP again (can't tell why, maybe for backwards
> compatibility).
> =

> In parallel to this MCLK block there is SCCR2[25], the "BDLC and
> MSCAN clock enable", documented in section 5.3.1.3 "System Clock
> Control Register 2".  So there is a gate that "somehow needs to
> get setup" yet isn't part of the visible MCLK chain.
> =

> The series up to and including v3 approaches the problem by
> - adding a gate after the second MCLK mux, which gets exported
>   for client lookups and is the MCLK input for the mscan(4)
>   driver
> - creating that gate for each of the four MSCAN clocks of the
>   SoC, all of them referencing the single "enable" bit in the
>   SCCR2 register
> - pre-enabling the MSCAN clocks from within the clock driver, and
>   thus avoid having the clock disabled from the common
>   infrastructure, because disabling one of these clocks had
>   closed the shared gate and thus had broken all other clock uses
> =

> > clkdev registration provides "alias names" for few clock items
> > [ ... ]
> > =

> [ ... ]
> > +
> > +/* setup the MCLK clock subtree of an individual PSC/MSCAN/SPDIF */
> > +static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry)
> > +{
> > +     size_t clks_idx_pub, clks_idx_int;
> > +     u32 __iomem *mccr_reg;  /* MCLK control register (mux, en, div) */
> > +     u32 __iomem *sccr_reg;  /* system clock control register (enable)=
 */
> > +     int sccr_bit;
> > +     int div;
> > +
> > +     /* derive a few parameters from the component type and index */
> > +     switch (entry->type) {
> > +     case MCLK_TYPE_PSC:
> > +             clks_idx_pub =3D MPC512x_CLK_PSC0_MCLK + entry->comp_idx;
> > +             clks_idx_int =3D MPC512x_CLK_MCLKS_FIRST
> > +                          + (entry->comp_idx) * MCLK_MAX_IDX;
> > +             mccr_reg =3D &clkregs->psc_ccr[entry->comp_idx];
> > +             break;
> > +     case MCLK_TYPE_MSCAN:
> > +             clks_idx_pub =3D MPC512x_CLK_MSCAN0_MCLK + entry->comp_id=
x;
> > +             clks_idx_int =3D MPC512x_CLK_MCLKS_FIRST
> > +                          + (NR_PSCS + entry->comp_idx) * MCLK_MAX_IDX;
> > +             mccr_reg =3D &clkregs->mscan_ccr[entry->comp_idx];
> > +             break;
> > +     case MCLK_TYPE_SPDIF:
> > +             clks_idx_pub =3D MPC512x_CLK_SPDIF_MCLK;
> > +             clks_idx_int =3D MPC512x_CLK_MCLKS_FIRST
> > +                          + (NR_PSCS + NR_MSCANS) * MCLK_MAX_IDX;
> > +             mccr_reg =3D &clkregs->spccr;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +     if (entry->bit_sccr1 >=3D 0) {
> > +             sccr_reg =3D &clkregs->sccr1;
> > +             sccr_bit =3D entry->bit_sccr1;
> > +     } else if (entry->bit_sccr2 >=3D 0) {
> > +             sccr_reg =3D &clkregs->sccr2;
> > +             sccr_bit =3D entry->bit_sccr2;
> > +     } else {
> > +             sccr_reg =3D NULL;
> > +     }
> > +
> > +     /*
> > +      * this was grabbed from the PPC_CLOCK implementation, which
> > +      * enforced a specific MCLK divider while the clock was gated
> > +      * during setup (that's a documented hardware requirement)
> > +      *
> > +      * the PPC_CLOCK implementation might even have violated the
> > +      * "MCLK <=3D IPS" constraint, the fixed divider value of 1
> > +      * results in a divider of 2 and thus MCLK =3D SYS/2 which equals
> > +      * CSB which is greater than IPS; the serial port setup may have
> > +      * adjusted the divider which the clock setup might have left in
> > +      * an undesirable state
> > +      *
> > +      * initial setup is:
> > +      * - MCLK 0 from SYS
> > +      * - MCLK DIV such to not exceed the IPS clock
> > +      * - MCLK 0 enabled
> > +      * - MCLK 1 from MCLK DIV
> > +      */
> > +     div =3D clk_get_rate(clks[MPC512x_CLK_SYS]);
> > +     div /=3D clk_get_rate(clks[MPC512x_CLK_IPS]);
> > +     out_be32(mccr_reg, (0 << 16));
> > +     out_be32(mccr_reg, (0 << 16) | ((div - 1) << 17));
> > +     out_be32(mccr_reg, (1 << 16) | ((div - 1) << 17));
> > +
> > +     /*
> > +      * create the 'struct clk' items of the MCLK's clock subtree
> > +      *
> > +      * note that by design we always create all nodes and won't take
> > +      * shortcuts here, because
> > +      * - the "internal" MCLK_DIV and MCLK_OUT signal in turn are
> > +      *   selectable inputs to the CFM while those who "actually use"
> > +      *   the PSC/MSCAN/SPDIF (serial drivers et al) need the MCLK
> > +      *   for their bitrate
> > +      * - in the absence of "aliases" for clocks we need to create
> > +      *   individial 'struct clk' items for whatever might get
> > +      *   referenced or looked up, even if several of those items are
> > +      *   identical from the logical POV (their rate value)
> > +      * - for easier future maintenance and for better reflection of
> > +      *   the SoC's documentation, it appears appropriate to generate
> > +      *   clock items even for those muxers which actually are NOPs
> > +      *   (those with two inputs of which one is reserved)
> > +      */
> > +     clks[clks_idx_int + MCLK_IDX_MUX0] =3D mpc512x_clk_muxed(
> > +                     entry->name_mux0,
> > +                     &parent_names_mux0[0], ARRAY_SIZE(parent_names_mu=
x0),
> > +                     mccr_reg, 14, 2);
> > +     clks[clks_idx_int + MCLK_IDX_EN0] =3D mpc512x_clk_gated(
> > +                     entry->name_en0, entry->name_mux0,
> > +                     mccr_reg, 16);
> > +     clks[clks_idx_int + MCLK_IDX_DIV0] =3D mpc512x_clk_divider(
> > +                     entry->name_div0,
> > +                     entry->name_en0, CLK_SET_RATE_GATE,
> > +                     mccr_reg, 17, 15, 0);
> > +     if (entry->has_mclk1) {
> > +             clks[clks_idx_int + MCLK_IDX_MUX1] =3D mpc512x_clk_muxed(
> > +                             entry->name_mux1,
> > +                             &entry->parent_names_mux1[0],
> > +                             ARRAY_SIZE(entry->parent_names_mux1),
> > +                             mccr_reg, 7, 1);
> > +     } else {
> > +             clks[clks_idx_int + MCLK_IDX_MUX1] =3D mpc512x_clk_factor(
> > +                             entry->name_mux1, entry->parent_names_mux=
1[0],
> > +                             1, 1);
> > +     }
> > +     if (sccr_reg) {
> > +             clks[clks_idx_pub] =3D mpc512x_clk_gated(
> > +                             entry->name_mclk,
> > +                             entry->name_mux1, sccr_reg, sccr_bit);
> > +     } else {
> > +             clks[clks_idx_pub] =3D mpc512x_clk_factor(
> > +                             entry->name_mclk,
> > +                             entry->name_mux1, 1, 1);
> > +     }
> > +
> > +     /*
> > +      * without this "clock device" registration, "simple" lookups in
> > +      * the SPI master initialization and serial port setup will fail
> > +      *
> > +      * those drivers need to get adjusted to lookup their required
> > +      * clocks from device tree specs, and device tree nodes need to
> > +      * provide the clock specs, before this clkdev registration
> > +      * becomes obsolete
> > +      */
> > +     clk_register_clkdev(clks[clks_idx_pub], entry->name_mclk, NULL);
> > +}
> > [ ... ]
> =

> This was the routine which sets up _one_ MCLK block, note the
> assignment at the routine's end to the "published" clock item
> that's the gate's output after the second mux stage.
> =

> > [ ... ]
> > +     clks[MPC512x_CLK_I2C] =3D mpc512x_clk_gated("i2c", "ips",
> > +                                               &clkregs->sccr2, 26);
> > +     mpc512x_clk_setup_mclks(mclk_mscan_data, ARRAY_SIZE(mclk_mscan_da=
ta));
> > +     clks[MPC512x_CLK_SDHC] =3D mpc512x_clk_gated("sdhc", "sdhc-ug",
> > +                                                &clkregs->sccr2, 24);
> > +     mpc512x_clk_setup_mclks(mclk_spdif_data, ARRAY_SIZE(mclk_spdif_da=
ta));
> > [ ... ]
> =

> This is the invocation of the routine which sets up four MCLK
> blocks for the MSCAN components, while all of them refer to bit
> 25 of SCCR2.
> =

> > [ ... ]
> > +
> > +     /* enable some of the clocks here unconditionally because ... */
> > +     pr_debug("automatically enabling some clocks\n");
> > +     /* some are essential yet never get claimed by any driver */
> > +     clk_prepare_enable(clks[MPC512x_CLK_DUMMY]);
> > +     clk_prepare_enable(clks[MPC512x_CLK_E300]);     /* PowerPC CPU */
> > +     clk_prepare_enable(clks[MPC512x_CLK_DDR]);      /* DRAM */
> > +     clk_prepare_enable(clks[MPC512x_CLK_MEM]);      /* SRAM */
> > +     clk_prepare_enable(clks[MPC512x_CLK_IPS]);      /* SoC periph */
> > +     clk_prepare_enable(clks[MPC512x_CLK_LPC]);      /* boot media */
> > +     /* some are required yet no dependencies were declared */
> > +     clk_prepare_enable(clks[MPC512x_CLK_PSC_FIFO]);
> > +     /* some are not yet acquired by their respective drivers */
> > +     clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console=
 */
> > +     clk_prepare_enable(clks[MPC512x_CLK_FEC]);      /* network, NFS */
> > +     clk_prepare_enable(clks[MPC512x_CLK_DIU]);      /* display */
> > +     clk_prepare_enable(clks[MPC512x_CLK_I2C]);
> > +     /*
> > +      * some have their individual clock subtree with separate clock
> > +      * items and their individual enable counters, yet share a
> > +      * common gate (refer to the same register location) while the
> > +      * common clock driver code is not aware of the fact and the
> > +      * platform's code doesn't provide specific support either
> > +      *
> > +      * what might happen is that e.g. enabling two MSCAN clock items
> > +      * and disabling one of them will disable the common gate and
> > +      * thus break the other MSCAN clock as well
> > +      */
> > +     clk_prepare_enable(clks[MPC512x_CLK_MSCAN0_MCLK]);
> > +     clk_prepare_enable(clks[MPC512x_CLK_MSCAN1_MCLK]);
> > +     clk_prepare_enable(clks[MPC512x_CLK_MSCAN2_MCLK]);
> > +     clk_prepare_enable(clks[MPC512x_CLK_MSCAN3_MCLK]);
> > +}
> =

> This is the pre-enable workaround for the MSCAN0 to MSCAN3 clock
> items.
> =

> The above approach does work in that it introduces complete
> support for common clock on the MPC512x platform, with the CAN
> component being operational, and the clock driver using shared
> logic across platforms.
> =

> The remaining issue is that regardless of whether CAN is used,
> the (chip internal) clock is enabled.  This may not be a problem
> when bitrates aren't generated and the wire isn't driven.
> =

> =

> The question now is how to correctly support the situation where
> a gate is shared between subtrees yet isn't really part of any
> path within the subtrees.  I really cannot find a single spot
> where to introduce the gate such that it's not duplicated.
> =

> The appropriate solution would not be to pre-enable those clocks,
> but to either introduce another gate clock type which supports a
> shared reference, or to add support for the shared reference to
> the existing gate code.
> =

> =

> I'd rather not duplicate most or all of the code of clk-gate.c,
> instead I looked into how to add "shared gate" support to the
> existing driver.
> =

> My question is whether the approach is acceptable.  It adds
> minimal overhead and shall be OK for the enable/disable path from
> a technical POV.  And it doesn't feel like too much of a stretch.
> But there may be non-technical reasons to reject the approach.
> I'd like to learn whether to follow that path before preparing
> another version of the patch series.
> =

> The diffs were taken with the '-w -b' options to demonstrate
> their essence and not drown it in whitespace changes.  The
> implementation assumes that the caller which registers the gate
> (the platform's clock driver) provides both the counter cell and
> the lock.  And that all gates with a "shared use counter" use the
> same lock (which is satisfied as they all get registered from the
> same spot in the platform's clock driver).
> =

> The CLK_IGNORE_UNUSED flag addresses a different problem.  The
> SoC has four MSCAN components, while two of them are enabled in
> the device tree (the other two are present but disabled).  So
> during probe two of the clocks get enabled.  After probe all
> unused clocks automatically get disabled (that's another two).
> So the "shared use counter" drops to zero although components are
> in use, because "disable, it's unused" isn't told from "disable
> after enable, regular use".  The flag would become obsolete if
> the common gate logic would implement a separate disable_unused()
> routine, but I guess this isn't necessary and the use of the flag
> is appropriate.
> =

> That the example use creates a field for just one counter is to
> better demonstrate the use and potential extension as need
> arises.  Reducing this to a mere integer variable would be a
> micro optimization.
> =

> =

> The extension of the existing clk_gate implementation:
> =

> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -46,6 +46,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int e=
nable)
>         struct clk_gate *gate =3D to_clk_gate(hw);
>         int set =3D gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
>         unsigned long flags =3D 0;
> +       int need_reg_access;
>         u32 reg;
>  =

>         set ^=3D enable;
> @@ -53,6 +54,20 @@ static void clk_gate_endisable(struct clk_hw *hw, int =
enable)
>         if (gate->lock)
>                 spin_lock_irqsave(gate->lock, flags);
>  =

> +       /*
> +        * if a "shared use counter" was specified, keep track of enable
> +        * and disable calls and only access hardware registers upon the
> +        * very first enable or very last disable call
> +        */
> +       if (!gate->share_count) {
> +               need_reg_access =3D 1;
> +       } else if (enable) {
> +               need_reg_access =3D (*gate->share_count)++ =3D=3D 0;
> +       } else {
> +               need_reg_access =3D --(*gate->share_count) =3D=3D 0;
> +       }
> +
> +       if (need_reg_access) {
>                 if (gate->flags & CLK_GATE_HIWORD_MASK) {
>                         reg =3D BIT(gate->bit_idx + 16);
>                         if (set)
> @@ -67,6 +82,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int e=
nable)
>                 }
>  =

>                 clk_writel(reg, gate->reg);
> +       }
>  =

>         if (gate->lock)
>                 spin_unlock_irqrestore(gate->lock, flags);
> @@ -118,10 +134,11 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
>   * @clk_gate_flags: gate-specific flags for this clock
>   * @lock: shared register lock for this clock
>   */
> -struct clk *clk_register_gate(struct device *dev, const char *name,
> +struct clk *clk_register_gate_shared(struct device *dev, const char *nam=
e,
>                 const char *parent_name, unsigned long flags,
>                 void __iomem *reg, u8 bit_idx,
> -               u8 clk_gate_flags, spinlock_t *lock)
> +               u8 clk_gate_flags, spinlock_t *lock,
> +               int *share_count)
>  {
>         struct clk_gate *gate;
>         struct clk *clk;
> @@ -152,6 +169,7 @@ struct clk *clk_register_gate(struct device *dev, con=
st char *name,
>         gate->bit_idx =3D bit_idx;
>         gate->flags =3D clk_gate_flags;
>         gate->lock =3D lock;
> +       gate->share_count =3D share_count;
>         gate->hw.init =3D &init;
>  =

>         clk =3D clk_register(dev, &gate->hw);
> @@ -161,3 +179,14 @@ struct clk *clk_register_gate(struct device *dev, co=
nst char *name,
>  =

>         return clk;
>  }
> +
> +struct clk *clk_register_gate(struct device *dev, const char *name,
> +               const char *parent_name, unsigned long flags,
> +               void __iomem *reg, u8 bit_idx,
> +               u8 clk_gate_flags, spinlock_t *lock)
> +{
> +
> +       return clk_register_gate_shared(dev, name, parent_name, flags,
> +                                       reg, bit_idx, clk_gate_flags,
> +                                       lock, NULL);
> +}
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -222,6 +222,7 @@ struct clk_gate {
>         u8              bit_idx;
>         u8              flags;
>         spinlock_t      *lock;
> +       int             *share_count;
>  };
>  =

>  #define CLK_GATE_SET_TO_DISABLE                BIT(0)
> @@ -232,6 +233,11 @@ struct clk *clk_register_gate(struct device *dev, co=
nst char *name,
>                 const char *parent_name, unsigned long flags,
>                 void __iomem *reg, u8 bit_idx,
>                 u8 clk_gate_flags, spinlock_t *lock);
> +struct clk *clk_register_gate_shared(struct device *dev, const char *nam=
e,
> +               const char *parent_name, unsigned long flags,
> +               void __iomem *reg, u8 bit_idx,
> +               u8 clk_gate_flags, spinlock_t *lock,
> +               int *share_count);
>  =

>  struct clk_div_table {
>         unsigned int    val;
> =

> =

> How to use these shared gates:
> =

> --- a/arch/powerpc/platforms/512x/clock-commonclk.c
> +++ b/arch/powerpc/platforms/512x/clock-commonclk.c
> @@ -123,6 +123,39 @@ static inline struct clk *mpc512x_clk_gated(
>                                  reg, pos, 0, &clklock);
>  }
>  =

> +enum mpc512x_clk_shared_gate_id_t {
> +       MPC512x_CLK_SHARED_GATE_MSCAN,
> +       MPC512x_CLK_SHARED_GATE_MAX,
> +};
> +
> +static int mpc512x_clk_gate_counters[MPC512x_CLK_SHARED_GATE_MAX];
> +
> +/*
> + * implementor's note:  since clk_gate items don't implement a separate
> + * .disable_unused() callback, their .disable() routine gets called and
> + * "disable the clock as we can't see it's in use" cannot be told from
> + * "regular disable, count these events please"
> + *
> + * passing the CLK_IGNORE_UNUSED flag upon clock creation will suppress
> + * the "disable, unused" call, so use counts won't get unbalanced, the
> + * clock either never got enabled and thus need not get disabled, or
> + * part of the hardware got enabled while disabling the other part isn't
> + * wanted
> + */
> +static inline struct clk *mpc512x_clk_gated_shared(
> +       const char *name, const char *parent_name,
> +       u32 __iomem *reg, u8 pos,
> +       enum mpc512x_clk_shared_gate_id_t share_id)
> +{
> +       int clkflags;
> +
> +       clkflags =3D CLK_SET_RATE_PARENT;
> +       clkflags |=3D CLK_IGNORE_UNUSED;
> +       return clk_register_gate_shared(NULL, name, parent_name, clkflags,
> +                                       reg, pos, 0, &clklock,
> +                                       &mpc512x_clk_gate_counters[share_=
id]);
> +}
> +
>  static inline struct clk *mpc512x_clk_muxed(const char *name,
>         const char **parent_names, int parent_count,
>         u32 __iomem *reg, u8 pos, u8 len)
> @@ -520,9 +553,16 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup=
_data *entry)
>                                 1, 1);
>         }
>         if (sccr_reg) {
> +               if (entry->type =3D=3D MCLK_TYPE_MSCAN) {
> +                       clks[clks_idx_pub] =3D mpc512x_clk_gated_shared(
> +                                       entry->name_mclk,
> +                                       entry->name_mux1, sccr_reg, sccr_=
bit,
> +                                       MPC512x_CLK_SHARED_GATE_MSCAN);
> +               } else {
>                         clks[clks_idx_pub] =3D mpc512x_clk_gated(
>                                         entry->name_mclk,
>                                         entry->name_mux1, sccr_reg, sccr_=
bit);
> +               }
>         } else {
>                 clks[clks_idx_pub] =3D mpc512x_clk_factor(
>                                 entry->name_mclk,
> =

> Local tests have shown that the extension solves the problem of
> how to satisfy the SoC's constraints on the MPC512x platform.
> The MSCAN clocks no longer need to get pre-enabled, instead they
> get setup and enabled only as the mscan(4) driver probes devices
> according to how it was instructed (device tree nodes).
> =

> What do you think?  Is the "shared gate" support in the common
> logic appropriate?  I'd rather not duplicate all of this code
> just to introduce the specific gate I need, while most of the
> logic is identical to the existing gate implementation.  The
> desire isn't to override the gate's operations, but to wrap them
> and to consult a counter in addition, while the register access
> still applies.
> =

> =

> =

> virtually yours
> Gerhard Sittig
> -- =

> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
