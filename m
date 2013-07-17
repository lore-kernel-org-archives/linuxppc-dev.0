Return-Path: <gsi@denx.de>
Date: Wed, 17 Jul 2013 14:07:42 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 05/24] clk: wrap I/O access for improved portability
Message-ID: <20130717120742.GM7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130715193829.GS14452@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 15, 2013 at 21:38 +0200, Sascha Hauer wrote:
> 
> On Mon, Jul 15, 2013 at 08:47:34PM +0200, Gerhard Sittig wrote:
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 6d55eb2..2c07061 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >  	struct clk_divider *divider = to_clk_divider(hw);
> >  	unsigned int div, val;
> >  
> > -	val = readl(divider->reg) >> divider->shift;
> > +	val = clk_readl(divider->reg) >> divider->shift;
> >  	val &= div_mask(divider);
> 
> Would it be an option to use regmap for the generic dividers/muxes
> instead? This should be suitable for ppc and also for people who want to
> use the generic clocks on i2c devices.

Does regmap assume that those registers form a (dense) array of
equal sized items?  Does it introduce unconditional indirection
and requirement for explicit setup beyond mere mapping?  What's
the overhead compared to the readl/inbe32 approach that's
currently resolved at compile time?

Neither of the above needs to be a blocker, just needs to be
acceptable after consideration.  So far nobody appears to have
felt pain with the LE32 register assumption.


BTW does the common clock support that I introduce for MPC512x
only cover those parts from crystal over internal busses to
internal peripherals (register files).

It does not include bitrate generation within the peripherals --
this appears to remain the domain of individual drivers, which
keep manipulating register fields to derive wire bitrates from
internal references.  Sharing drivers between platforms with and
without common clock support forbids the switch anyway, or both
CCF abstraction as well as local register manipulation need to
get implemented in parallel, as I did for the mscan(4) driver.

Some of these bitrate related registers aren't 32bit entities and
thus could not get managed by the common clock primitives in
their current form.  Some of the IP blocks may even spread
integer values across several non-adjacent bit fields for legacy
reasons, but I guess that these aren't in the scope of the shared
primitives either (and they may not be popular either).


While we are at improvements for the common clock primitives:

What I missed was support for fractional dividers, i.e. dividers
with a register bitfield backed divider part but a fixed factor
multiplier part.  Currently there's only dividers (bitfield
factor or bitfield with table lookup for the factor) and
fixed-factor (multiplier and divider, but both of them fixed and
not adjustable by register manipulation).  This was addressed by
"intermediate" clock items ("ungated", "x4")


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
