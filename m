Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 41928B7BB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:53:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A53EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 08:53:13 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20090812222843.GA7118@flint.arm.linux.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
	<20090812222843.GA7118@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 08:52:49 +1000
Message-Id: <1250117569.3587.64.camel@pasglop>
Mime-Version: 1.0
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Mark Brown <broonie@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 23:28 +0100, Russell King wrote:

> On Thu, Aug 13, 2009 at 07:56:32AM +1000, Benjamin Herrenschmidt wrote:
> > Maybe we can make clock-names non-optional though in the DT as an
> > incentive not to use the simple 1-clock "NULL" path.
> 
> We used to pass names.  Everyone got the idea that they could ignore
> the struct device argument, and chaos ensued in drivers - people wanted
> to name each of their individual clk structures uniquely, and pass
> clock names, or even struct clk pointers into drivers via platform data.
> Some drivers conditionalized the clock name depending on the SoC they
> were built for in the driver code.

Hi Russell ! Thanks a lot for your feedback.

Ok. So I may have misunderstood what names were for. In my mind, those
were the name of the clock input on the HW device :-) Hence my
clock-map, which maps a clock input to a clock provider. IE. It was all
to be taken as a tuple (device,name) that defines a given clock input on
a given device.

> Providing the clkdev infrastructure (which I'll talk about in another
> email, probably tomorrow) and ensuring that single-clock drivers pass
> a NULL name has ensured that people back away from that broken kind
> of thinking.  It has certainly cut down on the code size and the
> complexity in drivers.

Ok, thanks, I need to read up on clkdev then, I've missed that bit.

> IIRC, there were some drivers shrunk by about 100 LOC by using the
> clk API as I originally intended it to be used - which clkdev
> facilitates.

Ok.

> > > It's not just the device tree, it's also the drivers which have to be
> > > able to cope with whatever random device tree that's thrown at them.
> > 
> > Well, the clocks are named. At some stage, the binding for a given
> > device will define what clock names it expects. I don't see that
> > differing from what the ARM folks do.
> 
> The difference is that I'm trying to avoid the "name each clock source
> and have each driver ask for the clock by name".  Such an approach
> at first seems simple and logical, but experience has shown that it
> eventually creates more problems as things progress.

Right. I didn't intend to name the clock sources. I intended to name the
clock -inputs- of a given device. IE. clk_get(dev, name) in my mind
meant "give me the clock provider that feeds my "name" input).

> Take a look at these two commits:
> 
> 39a80c7f379e1c1d3e63b204b8353b7381d0a3d5
> 4c5e1946b5f89c33e3bc8ed73fa7ba8f31e37cc5

Thanks, I will.

> to see how moving from a per-clk naming system to a dev+consumer naming
> allowed omap_wdt to be cleaned up.  (OMAP3 added more clk naming
> conditions in the driver, so had this cleanup not happened the driver
> would have more stuff in it.)
> 
> What I'm saying is that always passing a bunch of names has been well
> proven to lead people down the wrong path of matching only by names
> and then running into problems later.  We need drivers passing a NULL
> name to ensure that people get the right idea.  Comments in code/headers
> don't seem to work. ;(

Allright but passing a NULL doesn't help for drivers with multiple clock
inputs. IE. How do you want to deal with that ? Do you want to deprecate
the named API and instead provide a new clk_get_for_input(dev,
clk_input) (clk_input could be name or numerical ... tbd) ?

Or am I missing a piece of the puzzle ?

Cheers,
Ben.
