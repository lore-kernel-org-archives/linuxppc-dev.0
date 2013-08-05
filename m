Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 426412C0077
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 21:37:36 +1000 (EST)
Date: Mon, 5 Aug 2013 12:37:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v3 17/31] clk: mpc512x: introduce COMMON_CLK for MPC512x
Message-ID: <20130805113720.GE9910@e106331-lin.cambridge.arm.com>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-18-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374495298-22019-18-git-send-email-gsi@denx.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 01:14:44PM +0100, Gerhard Sittig wrote:
> this change implements a clock driver for the MPC512x PowerPC platform
> which follows the COMMON_CLK approach and uses common clock drivers
> shared with other platforms
>
> this driver implements the publicly announced set of clocks (which can
> get referenced by means of symbolic identifiers from the dt-bindings
> header file), as well as generates additional 'struct clk' items where
> the SoC hardware cannot easily get mapped to the common primitives of
> the clock API, or requires "intermediate" clock nodes to represent
> clocks that have both gates and dividers
>
> the previous PPC_CLOCK implementation is kept in place and remains in
> parallel to the common clock implementation for test and comparison
> during migration, a compile time option picks one of the two
> alternatives (Kconfig switch, common clock used by default)
>
> some of the clock items get pre-enabled in the clock driver to not have
> them automatically disabled by the underlying clock subsystem because of
> their being unused -- this approach is desirable because
> - some of the clocks are useful to have for diagnostics and information
>   despite their not getting claimed by any drivers (CPU, internal and
>   external RAM, internal busses, boot media)
> - some of the clocks aren't claimed by their peripheral drivers yet,
>   either because of missing driver support or because device tree specs
>   aren't available yet (but the workarounds will get removed as the
>   drivers get adjusted and the device tree provides the clock specs)
> - some help introduce support for and migrate to the common
>   infrastructure, while more appropriate support for specific hardware
>   constraints isn't available yet (remaining changes are strictly
>   internal to the clock driver and won't affect peripheral drivers)
>
> clkdev registration provides "alias names" for few clock items
> - to not break those peripheral drivers which encode their component
>   index into the name that is used for clock lookup (UART, SPI, USB)
> - to not break those drivers which use names for the clock lookup which
>   were encoded in the previous PPC_CLOCK implementation (NFC, VIU, CAN)
> this workaround will get removed as these drivers get adjusted after
> device tree based clock lookup has become available
>
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/platforms/512x/Kconfig           |   14 +-
>  arch/powerpc/platforms/512x/Makefile          |    4 +-
>  arch/powerpc/platforms/512x/clock-commonclk.c |  786 +++++++++++++++++++++++++
>  include/linux/clk-provider.h                  |   16 +
>  4 files changed, 818 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c
>

[...]

> +static int get_freq_from_dt(char *propname)
> +{
> +       struct device_node *np;
> +       const unsigned int *prop;
> +       int val;
> +
> +       val = 0;
> +       np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-immr");
> +       if (np) {
> +               prop = of_get_property(np, propname, NULL);
> +               if (prop)
> +                       val = *prop;
> +           of_node_put(np);
> +       }
> +       return val;
> +}

Can you not use of_property_read_u32 here rather than of_get_property?

Also, this seems rather unlike the common clock bindings method for
describing frequencies in the dt. Given there's nothing in mainline
using this yet, we can do it 'right' from the start.

[...]

> +       /*
> +        * externally provided clocks (when implemented in hardware,
> +        * device tree may specify values which otherwise were unknown)
> +        */
> +       freq = get_freq_from_dt("psc_mclk_in");
> +       if (!freq)
> +               freq = 25000000;
> +       clks[MPC512x_CLK_PSC_MCLK_IN] = mpc512x_clk_fixed("psc_mclk_in", freq);
> +       freq = get_freq_from_dt("spdif_tx_in");
> +       clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed("spdif_tx_in", freq);
> +       freq = get_freq_from_dt("spdif_rx_in");
> +       clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed("spdif_rx_in", freq);

Can we not just use fixed-clocks for these in the dt? It feels odd to
describe them in a compeltely differnet way in the dt, especially as
we'll have to maintain some backwards compatibility for a while...

I see for psc_mclk_in we assume a default value if not present. I'm not
sure how to handle that, but I assume there's some way of finding out if
we've already registered a clock output with the same name?

Thanks,
Mark.
