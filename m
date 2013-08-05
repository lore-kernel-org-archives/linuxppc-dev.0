Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50ACA2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 03:01:51 +1000 (EST)
Date: Mon, 5 Aug 2013 19:01:28 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 17/31] clk: mpc512x: introduce COMMON_CLK for MPC512x
Message-ID: <20130805170128.GQ2580@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-18-git-send-email-gsi@denx.de>
 <20130805113720.GE9910@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130805113720.GE9910@e106331-lin.cambridge.arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Woodhouse <dwmw2@infradead.org>, Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 05, 2013 at 12:37 +0100, Mark Rutland wrote:
> 
> On Mon, Jul 22, 2013 at 01:14:44PM +0100, Gerhard Sittig wrote:
> > this change implements a clock driver for the MPC512x PowerPC platform
> > which follows the COMMON_CLK approach and uses common clock drivers
> > shared with other platforms
> >
> > this driver implements the publicly announced set of clocks (which can
> > get referenced by means of symbolic identifiers from the dt-bindings
> > header file), as well as generates additional 'struct clk' items where
> > the SoC hardware cannot easily get mapped to the common primitives of
> > the clock API, or requires "intermediate" clock nodes to represent
> > clocks that have both gates and dividers
> >
> > the previous PPC_CLOCK implementation is kept in place and remains in
> > parallel to the common clock implementation for test and comparison
> > during migration, a compile time option picks one of the two
> > alternatives (Kconfig switch, common clock used by default)
> >
> > some of the clock items get pre-enabled in the clock driver to not have
> > them automatically disabled by the underlying clock subsystem because of
> > their being unused -- this approach is desirable because
> > - some of the clocks are useful to have for diagnostics and information
> >   despite their not getting claimed by any drivers (CPU, internal and
> >   external RAM, internal busses, boot media)
> > - some of the clocks aren't claimed by their peripheral drivers yet,
> >   either because of missing driver support or because device tree specs
> >   aren't available yet (but the workarounds will get removed as the
> >   drivers get adjusted and the device tree provides the clock specs)
> > - some help introduce support for and migrate to the common
> >   infrastructure, while more appropriate support for specific hardware
> >   constraints isn't available yet (remaining changes are strictly
> >   internal to the clock driver and won't affect peripheral drivers)
> >
> > clkdev registration provides "alias names" for few clock items
> > - to not break those peripheral drivers which encode their component
> >   index into the name that is used for clock lookup (UART, SPI, USB)
> > - to not break those drivers which use names for the clock lookup which
> >   were encoded in the previous PPC_CLOCK implementation (NFC, VIU, CAN)
> > this workaround will get removed as these drivers get adjusted after
> > device tree based clock lookup has become available
> >
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  arch/powerpc/platforms/512x/Kconfig           |   14 +-
> >  arch/powerpc/platforms/512x/Makefile          |    4 +-
> >  arch/powerpc/platforms/512x/clock-commonclk.c |  786 +++++++++++++++++++++++++
> >  include/linux/clk-provider.h                  |   16 +
> >  4 files changed, 818 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c
> >
> 
> [...]
> 
> > +static int get_freq_from_dt(char *propname)
> > +{
> > +       struct device_node *np;
> > +       const unsigned int *prop;
> > +       int val;
> > +
> > +       val = 0;
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-immr");
> > +       if (np) {
> > +               prop = of_get_property(np, propname, NULL);
> > +               if (prop)
> > +                       val = *prop;
> > +           of_node_put(np);
> > +       }
> > +       return val;
> > +}
> 
> Can you not use of_property_read_u32 here rather than of_get_property?
> 
> Also, this seems rather unlike the common clock bindings method for
> describing frequencies in the dt. Given there's nothing in mainline
> using this yet, we can do it 'right' from the start.

This specific routine was taken in verbatim form from the former
PPC_CLOCK implementation.  Although I could re-implement it in
other ways if that was considered necessary.

> 
> [...]
> 
> > +       /*
> > +        * externally provided clocks (when implemented in hardware,
> > +        * device tree may specify values which otherwise were unknown)
> > +        */
> > +       freq = get_freq_from_dt("psc_mclk_in");
> > +       if (!freq)
> > +               freq = 25000000;
> > +       clks[MPC512x_CLK_PSC_MCLK_IN] = mpc512x_clk_fixed("psc_mclk_in", freq);
> > +       freq = get_freq_from_dt("spdif_tx_in");
> > +       clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed("spdif_tx_in", freq);
> > +       freq = get_freq_from_dt("spdif_rx_in");
> > +       clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed("spdif_rx_in", freq);
> 
> Can we not just use fixed-clocks for these in the dt? It feels odd to
> describe them in a compeltely differnet way in the dt, especially as
> we'll have to maintain some backwards compatibility for a while...
> 
> I see for psc_mclk_in we assume a default value if not present. I'm not
> sure how to handle that, but I assume there's some way of finding out if
> we've already registered a clock output with the same name?

I guess using fixed-clocks (i.e. clock items that completely get
described in the device tree, and are taken care of by a common
driver which attaches to anything that is said to be compatible)
would change behaviour, which I did not intend to introduce.

The above code does what the PPC_CLOCK implementation did: Always
create the clock items, while their _rate_ may or may not be
specified or overridden from device tree specs, and defaults
(non-zero or zero) always apply.


Thank you for the feedback and suggestions.  I've yet to find out
how much compatibility I'm allowed to break. :)  ATM I assume
that my changes do keep compatibility where appropriate, and only
change the device tree or its interpretation where the device
tree may be considered wrong (not that it would provide false
information, but it certainly lacked essential information about
the hardware, like clock related information, and thus it shall
be acceptable to require an update of the dtb to fix that gap).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
