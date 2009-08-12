Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AC59DB7B73
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 09:15:47 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8EC2DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 09:15:46 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Brown <broonie@sirena.org.uk>
In-Reply-To: <20090812230023.GB7519@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
	<20090812222031.GC4731@sirena.org.uk>
	<1250116373.3587.46.camel@pasglop>
	<20090812230023.GB7519@sirena.org.uk>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 09:15:22 +1000
Message-Id: <1250118922.3587.67.camel@pasglop>
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

> The problem is that you've got a chip which has a clock tree of its own
> which could benefit from using the clock API internally (in this case
> because it helps generalisation to the case where it's on the CPU for
> the MMC block to be able to just use the clock API for its clocks).

I see.

> Ideally the MFD core for the tmio would be able to extend the clock tree
> so that the MMC driver can work without knowing what sort of device it's
> part of.  Having the platform know about the clocks in the MFD means
> teaching each platform that might use the chip about the clocking
> structure of the chip in some way.  However, there's a concern about
> making the clock API too heavyweight for the on-SoC clocks that are the
> major application.  Things like per-clock memory consumption are an
> issue on bigger chips.

Right. Well, my proposal of linkage of clock providers via the
device-tree would definitely solve that problem for us at least,
provided the various parts of the chip are represented as nodes in the
DT.

> > Having more "generic" clock providers for off-SoC clock chips is an idea
> > that went through my mind but you may be right that it's not necessarily
> > something we need to cater for initially, it can be handled by platform
> > for now easily enough.
> 
> So long as that's clear to device tree users that should be fine.

That's my thought too.

Cheers,
Ben.
