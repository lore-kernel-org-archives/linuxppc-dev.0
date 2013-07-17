Return-Path: <gsi@denx.de>
Date: Wed, 17 Jul 2013 16:26:28 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
Message-ID: <20130717142628.GN7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-2-git-send-email-gsi@denx.de>
 <20130715201734.GF11538@sirena.org.uk>
 <20130717112229.GK7080@book.gsilab.sittig.org>
 <20130717120758.GR22506@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130717120758.GR22506@sirena.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>,
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

On Wed, Jul 17, 2013 at 13:07 +0100, Mark Brown wrote:
> 
> On Wed, Jul 17, 2013 at 01:22:29PM +0200, Gerhard Sittig wrote:
> > On Mon, Jul 15, 2013 at 21:17 +0100, Mark Brown wrote:
> > > On Mon, Jul 15, 2013 at 08:47:30PM +0200, Gerhard Sittig wrote:
> 
> > > >   sprintf(name, "psc%d_mclk", master->bus_num);
> > > >  	spiclk = clk_get(&master->dev, name);
> > > > -	clk_enable(spiclk);
> > > > +	clk_prepare_enable(spiclk);
> > > >  	mps->mclk = clk_get_rate(spiclk);
> > > >  	clk_put(spiclk);
> 
> > > This code is *clearly* buggy and should be fixed rather than papered
> > > over.  Not only is there no matching put the driver is also dropping the
> > > reference to the clock rather than holding on to it while it's in use.
> 
> > "This code" refers to the driver's original condition, right?  I
> > agree that the driver has been suffering from incomplete clock
> > handling since it was born three years ago.  And that this issue
> > shall get addressed.  The question is just whether it needs to be
> > part of this series which has a different focus.
> 
> This is a pretty long e-mail.  It'd probably have taken less time to
> fix the issues than to reply to the e-mail...  but anyway.

[ this is meta stuff, technical details are after the next quotation ]

Not quite.  Please consider that careful submission is as
expensive as thorough review is, and that a lot of work is done
before v1 gets submitted, which you may not always notice from
looking at a concentrated series that may no longer suggest how
much it took to get there (especially when prepared carefully).

As mentioned before I did not question the need to fix issues as
they get identified.  I just asked whether reworking the serial
driver is in the scope of this series which provides a different
clock driver implementation for the platform.  To me these two
things are orthogonal, while I did promise to see how I can
address your concerns.

Let's provide the technical information you need to judge the
quality of the submission and see why it shall be acceptable:


> A big part of the issue with the state of the driver is that there's
> obvious clock API abuse going on that isn't corrected here - the main
> one is that the sprintf() for the clock name is a fairly clear warning
> sign, the driver should be using a fixed value there.  This raises a
> warning flag for me about the quality of the common clock API
> implementation that's being sent and/or the potential for bugs to be
> noticed with the common clock framework.  I'd not expect this code to
> actually work, and looking at the rest of the series I don't see how it
> does since I can't see what forces the name.

Why the code does work:

OK, here is why the driver keeps its state throughout the set and
is operational as good or as bad as it was before:

The sprintf() in the SPI driver used to construct a name which
includes the PSC index.  This applies to the UART driver as well,
as they both use the PSC controller hardware to implement their
serial communication.

The corresponding clock name was found in the previous PPC_CLOCK
implementation since the clock driver provided those names which
include the PSC index (fixed strings in a table).

The initial COMMON_CLK implementation in part 09/24 registers
clkdev items for compatibility during migration.  The string
isn't greppable since it's constructed by the preprocessor in the
MCLK data setup, see the MCLK_SETUP_DATA_PSC() macro.

Part 13/24 adjusts the SPI driver to no longer construct a name,
but instead use a fixed string after OF based clock lookup became
available.  This shall meet your expectation and simplifies the
client side.  Part 15/24 does the same for the UART driver.

Part 16/24 removes the clkdev registration in the clock driver
after both the UART and SPI clients switched to OF clock lookups.

At this stage things are the way you would expect:  The client
uses a fixed string in the lookup, while lookup occurs via device
tree, and instances are supported without the clients'
constructing something based on a component index.

Remaining issues are not with the common clock support of the
platform, but in the serial driver and are identical to the
previous (actually: the initial) status.  While we agree on the
existance of the remaining issue and the desire to address it.
Just not on which context that fix shall be done in.


The series' status and perspective:

The UART and SPI drivers did work before, while it's true that
clock handling wasn't complete (in non-fatal ways).  This has
been the case in the past, and has been identified just now.

The serial drivers are kept operational during migration, and
still are operational after the series.  But now they use common
clock and OF lookups, which is an improvement for the platform in
my eyes.

It's true that the status of the serial driver isn't improved
with the series -- but it isn't degraded either, while
(additional) breakage actively gets prevented.

Now let me see how I can improve the SPI driver with regard to
overall clock handling and beyond mere operation by coincidence
in the absence of errors.  But please understand that I don't
want to stall the common clock support for a whole platform just
because some of the drivers it needs to touch to keep them
operational have other issues that weren't addressed yet, while
these issues aren't introduced with the series but preceed it.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
