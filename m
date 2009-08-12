Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80878B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:20:51 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23687DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 08:20:51 +1000 (EST)
Date: Wed, 12 Aug 2009 23:20:31 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20090812222031.GC4731@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250114192.3587.41.camel@pasglop>
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

On Thu, Aug 13, 2009 at 07:56:32AM +1000, Benjamin Herrenschmidt wrote:

> Maybe we can make clock-names non-optional though in the DT as an
> incentive not to use the simple 1-clock "NULL" path.

Yeah, that was more what I was thinking - apply some pressure on people
not to use the NULL clock feature for the device tree stuff.

> Possibly yes, and that's a reason why we tend to discourage that ;-) But
> again, it boils down to settling with a naming convention for a given
> device. If clocks are added later on, the driver will have to cope with
> the new clocks not existing, of course, or the platform can cater for
> it.

...which is much easier if you discourage people from using the NULL
name in the first place :)  My concern is more about new device tree and
older driver code than the other way round (which wouldn't suprise me,
if only during things like bisection).

> Do you have maybe a precise example scenario where your above statement
> about the lack of facility for registering new clocks is a problem ? I'm
> curious to see a real life example so I can think better about how it
> can be solved (or whether it needs to be solved).

There was a recent thread on linux-kernel (last week) about the tmio_mmc
drivers - it's a MMC controller which is present in both some SH CPUs
and some MFD chips.  I can probably dig up a more exact reference if
required.

Probably you will be able to, like the ARMs have, get a very long way
with just supporting the on-SoC clock tree just now and can punt on
dealing with other things for now.  It's where a large part of the
interesting clocking in a lot of embedded systems is.
