Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81DA6B7B7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:33:15 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEF3CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 08:33:14 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Brown <broonie@sirena.org.uk>
In-Reply-To: <20090812222031.GC4731@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
	<20090812222031.GC4731@sirena.org.uk>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 08:32:53 +1000
Message-Id: <1250116373.3587.46.camel@pasglop>
Mime-Version: 1.0
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 23:20 +0100, Mark Brown wrote:

> ...which is much easier if you discourage people from using the NULL
> name in the first place :)  

Agreed.

> My concern is more about new device tree and
> older driver code than the other way round (which wouldn't suprise me,
> if only during things like bisection).

Right. That would only be a problem with NULL name -and- the new
device-tree changing the first clock in the list instead of adding to
the end, but I see your point, and it's a valid concern.

> There was a recent thread on linux-kernel (last week) about the tmio_mmc
> drivers - it's a MMC controller which is present in both some SH CPUs
> and some MFD chips.  I can probably dig up a more exact reference if
> required.

Or maybe just explain quickly how it needs to "register new clocks" in
ways that can be problematic. I'm not trying to be dense, I'm really not
sure what the problem you are trying to highlight is :-)

> Probably you will be able to, like the ARMs have, get a very long way
> with just supporting the on-SoC clock tree just now and can punt on
> dealing with other things for now.  It's where a large part of the
> interesting clocking in a lot of embedded systems is.

Right. And having the platform able to always trump the device-tree will
allow for hacks if necessary. If they start growing out of control, that
will tell us that we need to do something differently :-)

I'm afraid of over-design, so I'd rather go for something minimalist yet
flexible, which seems to be the case here, as the actual clock provider
implementation and platform code have pretty much all latitude to do
whatever they want.

Having more "generic" clock providers for off-SoC clock chips is an idea
that went through my mind but you may be right that it's not necessarily
something we need to cater for initially, it can be handled by platform
for now easily enough.

Cheers,
Ben.
