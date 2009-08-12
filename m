Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A9F49B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:29:23 +1000 (EST)
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA991DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 08:29:22 +1000 (EST)
Date: Wed, 12 Aug 2009 23:28:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARM clock API to PowerPC
Message-ID: <20090812222843.GA7118@flint.arm.linux.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250114192.3587.41.camel@pasglop>
Sender: Russell King <rmk@arm.linux.org.uk>
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

On Thu, Aug 13, 2009 at 07:56:32AM +1000, Benjamin Herrenschmidt wrote:
> Maybe we can make clock-names non-optional though in the DT as an
> incentive not to use the simple 1-clock "NULL" path.

We used to pass names.  Everyone got the idea that they could ignore
the struct device argument, and chaos ensued in drivers - people wanted
to name each of their individual clk structures uniquely, and pass
clock names, or even struct clk pointers into drivers via platform data.
Some drivers conditionalized the clock name depending on the SoC they
were built for in the driver code.

Providing the clkdev infrastructure (which I'll talk about in another
email, probably tomorrow) and ensuring that single-clock drivers pass
a NULL name has ensured that people back away from that broken kind
of thinking.  It has certainly cut down on the code size and the
complexity in drivers.

IIRC, there were some drivers shrunk by about 100 LOC by using the
clk API as I originally intended it to be used - which clkdev
facilitates.

> > It's not just the device tree, it's also the drivers which have to be
> > able to cope with whatever random device tree that's thrown at them.
> 
> Well, the clocks are named. At some stage, the binding for a given
> device will define what clock names it expects. I don't see that
> differing from what the ARM folks do.

The difference is that I'm trying to avoid the "name each clock source
and have each driver ask for the clock by name".  Such an approach
at first seems simple and logical, but experience has shown that it
eventually creates more problems as things progress.

Take a look at these two commits:

39a80c7f379e1c1d3e63b204b8353b7381d0a3d5
4c5e1946b5f89c33e3bc8ed73fa7ba8f31e37cc5

to see how moving from a per-clk naming system to a dev+consumer naming
allowed omap_wdt to be cleaned up.  (OMAP3 added more clk naming
conditions in the driver, so had this cleanup not happened the driver
would have more stuff in it.)

What I'm saying is that always passing a bunch of names has been well
proven to lead people down the wrong path of matching only by names
and then running into problems later.  We need drivers passing a NULL
name to ensure that people get the right idea.  Comments in code/headers
don't seem to work. ;(

-- 
Russell King
