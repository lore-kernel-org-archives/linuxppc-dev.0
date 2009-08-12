Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB44DB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 07:34:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B2E4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 07:34:25 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Brown <broonie@sirena.org.uk>
In-Reply-To: <20090812123551.GC11227@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 07:34:07 +1000
Message-Id: <1250112847.3587.26.camel@pasglop>
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

On Wed, 2009-08-12 at 13:35 +0100, Mark Brown wrote:
> On Wed, Aug 12, 2009 at 05:57:05PM +1000, Benjamin Herrenschmidt wrote:
> 
> >  - From the above, question: Do we want to keep that parent pointer ?
> > Does it make sense ? Will we have objects that are clock providers and
> > themselves source from multiple parent ? Or we don't care and it becomes
> 
> That happens and at times one or more of the sources is off-chip.

Right. That's somewhat what I thought. I think the best approach
initially is not to impose a hierarchy in our "core" and keep that to
the actual clock provider implementation. We'll see in the long term
with practice whether we then want to move some of that back into core.

> What happens if another clock gets added or the list gets reordered for
> some reason?

The device-tree is mostly static in that regard. I'm not sure what you
mean. Clocks are referenced by IDs so if you want to add more clocks you
can just add them to the end. The "NULL" case is typically for things
that have only one clock (which seems to be reasonably common in ARM
land).

I think it's reasonable to ask whoever produces the device-tree to keep
the two properties in sync.

> Note that the present ARM implementations don't handle anything except
> the core SoC normally.

Ok, interesting. I don't see why the API would prevent going further
tho. In any case, that isn't a big deal, at least until somebody proves
me wrong, I believe what I proposed remains simple enough and leaves
enough to the actual implementations to allow pretty much anything in
that area.

Cheers,
Ben.
