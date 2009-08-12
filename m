Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 37C71B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 09:47:52 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95ADBDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 09:47:51 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20090812234048.GB7118@flint.arm.linux.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
	<20090812222843.GA7118@flint.arm.linux.org.uk>
	<1250117569.3587.64.camel@pasglop>
	<20090812234048.GB7118@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 09:47:31 +1000
Message-Id: <1250120851.3587.71.camel@pasglop>
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

> > Ok. So I may have misunderstood what names were for. In my mind, those
> > were the name of the clock input on the HW device :-)
> 
> Oh, I do hope I didn't say that was wrong, because that is quite
> correct.  What the idea with passing a NULL 'name' with drivers
> which only had one input was to force people to avoid using 'name'
> as the sole way to match.

I see. So basically, they are meant to be the input names, but have been
abused by people to be "global scope" clock names and hence mess
happened.

> When I originally wrote the AMBA primecell drivers, I did use things
> like 'UARTCLK' and 'AACICLK' for the clk_get() name - since these
> were the name on the device, and that really only provided people
> with a bad example to follow.  Especially if you consider that the
> hardware I had was FPGA based development boards where the clocking
> layout lent itself well to ignoring the 'dev' argument.

Right.

> > Right. I didn't intend to name the clock sources. I intended to name the
> > clock -inputs- of a given device. IE. clk_get(dev, name) in my mind
> > meant "give me the clock provider that feeds my "name" input).
> 
> That's absolutely the right way to look at it!

Cool :-) It did feel right indeed.

> > Allright but passing a NULL doesn't help for drivers with multiple clock
> > inputs. IE. How do you want to deal with that ? Do you want to deprecate
> > the named API and instead provide a new clk_get_for_input(dev,
> > clk_input) (clk_input could be name or numerical ... tbd) ?
> 
> NULL certainly doesn't help for drivers with multiple clock inputs.
> For those, you have to explicitly name the input.  To take the
> example commits I pointed at (the OMAP watchdog driver) OMAP blocks
> generally have two clock inputs - a functional clock and an
> interface clock.

Right, that's a common setup.

> Originally, the driver was effectively setup to match by clock source
> name (wdt2_fck, wdt2_ick) which was SoC specific.  What the commits
> did was convert things to looking using the names of the inputs
> (aka consumer name) - so dev + "fck" and dev + "ick".

Ok, cool, so we are on the same page.

> That results in clkdev looking up the clocks for device "omap_wdt"
> for inputs "fck" and "ick" respectively.  On OMAP1 platforms, there
> isn't an "ick" as such, so there's a match-any-device dummy "ick"
> entry.  On OMAP2 and OMAP3 (the later revs) there are specific
> clocks for these, and so the dummy entry is missing.
> 
> So, the approach I took was: where it is well defined that a device
> has only one clock input, we pass a NULL name.  If it has more than
> one clock input, we pass the specific consumer name required.

Makes sense. I think this will work beautifully with the device-tree too
with the idea of having properties that then provide the binding for a
given clock input to the clock provider and the clock ID on that
provider (my proposal makes the later a number because doing strings can
be awkward in OF land in such mapping tables but I might go back to
strings, we'll see).

> > Or am I missing a piece of the puzzle ?
> 
> Maybe - and since you're just starting to look at clkdev, I'll point
> out that it's actually not intuitive which way around the "wildcard"
> matching works in clkdev.  The clk_get() arguments aren't the
> wildcards, they're in the clk_lookup structure.  Yes, it seems odd,
> but if you consider it from the point of view of the platform code
> wanting to match clocks to a specific set of devices and clock inputs,
> it's actually the way around that you want.

Ok. I'll read up a bit and see if I can get my head around it.

Thanks !

Cheers,
Ben.
