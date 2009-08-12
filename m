Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A7B9B7B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 09:00:47 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C915BDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 09:00:46 +1000 (EST)
Date: Thu, 13 Aug 2009 00:00:23 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20090812230023.GB7519@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
	<20090812222031.GC4731@sirena.org.uk>
	<1250116373.3587.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250116373.3587.46.camel@pasglop>
Subject: Re: ARM clock API to PowerPC
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

On Thu, Aug 13, 2009 at 08:32:53AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-08-12 at 23:20 +0100, Mark Brown wrote:

> > There was a recent thread on linux-kernel (last week) about the tmio_mmc
> > drivers - it's a MMC controller which is present in both some SH CPUs
> > and some MFD chips.  I can probably dig up a more exact reference if
> > required.

> Or maybe just explain quickly how it needs to "register new clocks" in
> ways that can be problematic. I'm not trying to be dense, I'm really not
> sure what the problem you are trying to highlight is :-)

The problem is that you've got a chip which has a clock tree of its own
which could benefit from using the clock API internally (in this case
because it helps generalisation to the case where it's on the CPU for
the MMC block to be able to just use the clock API for its clocks).

Ideally the MFD core for the tmio would be able to extend the clock tree
so that the MMC driver can work without knowing what sort of device it's
part of.  Having the platform know about the clocks in the MFD means
teaching each platform that might use the chip about the clocking
structure of the chip in some way.  However, there's a concern about
making the clock API too heavyweight for the on-SoC clocks that are the
major application.  Things like per-clock memory consumption are an
issue on bigger chips.

> Having more "generic" clock providers for off-SoC clock chips is an idea
> that went through my mind but you may be right that it's not necessarily
> something we need to cater for initially, it can be handled by platform
> for now easily enough.

So long as that's clear to device tree users that should be fine.
