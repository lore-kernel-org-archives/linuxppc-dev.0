Return-Path: <david-b@pacbell.net>
Received: from smtp121.sbc.mail.sp1.yahoo.com (smtp121.sbc.mail.sp1.yahoo.com
	[69.147.64.94]) by ozlabs.org (Postfix) with SMTP id C3F2FDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:03:04 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Date: Wed, 11 Jul 2007 10:02:54 -0700
References: <20070711093113.GE4375@moe.telargo.com>
	<200707110856.58463.david-b@pacbell.net>
	<20070711161633.GA4846@lst.de>
In-Reply-To: <20070711161633.GA4846@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707111002.55119.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 July 2007, Christoph Hellwig wrote:
> On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > > Umm, this is about the fifth almost identical implementation of
> > > the clk_ functions.  Please, please put it into common code.
> > > 
> > > And talk to the mips folks which just got a similar comment from me.
> > 
> > You mean like a lib/clock.c core, rather than an opsvector?
> 
> I mean an ops vector and surrounding wrappers.  Every architecture
> is reimplementing their own dispatch table which is rather annoying.

ARM doesn't.  :)

But then, nobody expects one kernel to support more than one
vendor's ARM chips; or usually, more than one generation of
that vendor's chips.  So any dispatch table is specific to
a given platform, and tuned to its quirks.  Not much to share
between OMAP and AT91, for example, except in some cases maybe
an arm926ejs block.


> What would a lib/clock.c do?

Some folk have suggested defining a core "struct clk {...}" with
some of the basics -- refcount, parent, maybe enough to support
the clk_get() lookup or even more -- so that the more obvious
stuff doesn't need constant re-implementation, and so that new
implementations become easier.  Platforms would wrap that with
whatever extensions they need.

I've not seen a solid proposal for such a thing, and it's not
clear to me how that would play with with older code (e.g. any
of the ARM implementations).

And I'm sure there are other suggestions ... I was mostly just
wondering just what you were suggesting.

- Dave
