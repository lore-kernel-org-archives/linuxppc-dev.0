Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 87BC0B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 07:45:05 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16672DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 07:45:05 +1000 (EST)
Date: Wed, 12 Aug 2009 22:44:45 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20090812214444.GA4731@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250112847.3587.26.camel@pasglop>
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

On Thu, Aug 13, 2009 at 07:34:07AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-08-12 at 13:35 +0100, Mark Brown wrote:

> > What happens if another clock gets added or the list gets reordered for
> > some reason?

> The device-tree is mostly static in that regard. I'm not sure what you
> mean. Clocks are referenced by IDs so if you want to add more clocks you
> can just add them to the end. The "NULL" case is typically for things
> that have only one clock (which seems to be reasonably common in ARM
> land).

The issue I'm worrying about here is what happens if the device has only
one clock in current revisions of the hardware but another revision of
the same hardware is produced which adds another clock.  When that
happens your NULL lookup gets confused.

> I think it's reasonable to ask whoever produces the device-tree to keep
> the two properties in sync.

It's not just the device tree, it's also the drivers which have to be
able to cope with whatever random device tree that's thrown at them.
This is less of a problem on ARM where it's fairly straightforward to
adjust the users at the same time as the driver but if you've got a
device tree delivered via a completely different distribution mechanism
it gets more sticky.

> > Note that the present ARM implementations don't handle anything except
> > the core SoC normally.

> Ok, interesting. I don't see why the API would prevent going further
> tho. In any case, that isn't a big deal, at least until somebody proves
> me wrong, I believe what I proposed remains simple enough and leaves
> enough to the actual implementations to allow pretty much anything in
> that area.

The problem with the API at the minute in this regard is that there is
no standard way of registering new clocks.  Only something that knows
about the magic sauce for a given architecture (if any) is able to add
clocks.  My concern here is that if PowerPC moves in this direction
without some general agreement from elsewhere then there may be problems
for drivers.
