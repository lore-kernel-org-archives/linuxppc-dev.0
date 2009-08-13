Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8A7F6B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 13:46:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D92A9DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 13:46:17 +1000 (EST)
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
Date: Thu, 13 Aug 2009 13:45:46 +1000
Message-Id: <1250135146.3587.87.camel@pasglop>
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

On Thu, 2009-08-13 at 00:40 +0100, Russell King wrote:

> Maybe - and since you're just starting to look at clkdev, I'll point
> out that it's actually not intuitive which way around the "wildcard"
> matching works in clkdev.  The clk_get() arguments aren't the
> wildcards, they're in the clk_lookup structure.  Yes, it seems odd,
> but if you consider it from the point of view of the platform code
> wanting to match clocks to a specific set of devices and clock inputs,
> it's actually the way around that you want.

Ok so I had a look, it's basically a list of bindings between a device
"ID" (dev_name(dev)) and a clock input name, matched to a struct clk *.

I'm not entirely sure I want to port that over, because I believe that I
can do better with the device-tree, but then, it will mostly depend
whether we end up wanting to use drivers that do rely on the clkdev
mechanism.

For one, I'm not 100% certain that our dev_id's are unique. Then, that
means that at some stage, the clock source provider need to create the
struct clk for anything devices -may- need, so for all the device clock
connections in the system, it cannot be done on-demand.

I'm thus tempted to pursue for now an approach where the connection is
provided by the device-tree exclusively (or override platform code but
that's to be avoided most of the time), we'll see where it takes us.
IE. 

In case you haven't looked at what I had in mind there, basically the
device-node of a device contains properties linking each clock input to
the device node of the clock provider, along with the ID of that clock
within the provider space. So all I need is register clock providers,
that get passed in clk_get() with the "translated" clock ID and that can
spit out struct clk* "on demand".

For example, if I have an external PLL chip that provides 4 clocks, I
can register a clock provider driver attached to that device-node (which
can then also contain properties indicating to the driver how to program
the said PLL chip if so desired).

Then, if 2 of those lines (PLL1 and PLL3) go respectively to a device
SYS_CLK and PHY_CLK inputs, for example, then all I need is to have a
"clock-names" and "clock-map" properties in that device node. The first
one contains "SYS_CLK" and "PHY_CLK", and the second one, a list of two
items, each being the the phandle to the PLL and respectively 1 and 3.

I could just parse the tree and generate all the struct clk* at boot
time and somewhat generate clkdev for them etc... but I believe that
isn't needed, ie, clkdev is an ARM specific mechanism for expressing the
linkage between devices and clock sources but not something that we
would benefit from moving over since we can do better, I believe, with
the device-tree.

Or am I missing something still ? :-)

Cheers,
Ben.
