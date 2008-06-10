Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from accolon.hansenpartnership.com (accolon.hansenpartnership.com
	[76.243.235.52]) by ozlabs.org (Postfix) with ESMTP id 51683DEBE8
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 04:10:35 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200806101041.28829.jbarnes@virtuousgeek.org>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806101656.51211.nickpiggin@yahoo.com.au>
	<200806101041.28829.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 13:10:26 -0500
Message-Id: <1213121426.8536.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-10 at 10:41 -0700, Jesse Barnes wrote:
> On Monday, June 09, 2008 11:56 pm Nick Piggin wrote:
> > So that still doesn't tell us what *minimum* level of ordering we should
> > provide in the cross platform readl/writel API. Some relatively sane
> > suggestions would be:
> >
> > - as strong as x86. guaranteed not to break drivers that work on x86,
> >   but slower on some archs. To me, this is most pleasing. It is much
> >   much easier to notice something is going a little slower and to work
> >   out how to use weaker ordering there, than it is to debug some
> >   once-in-a-bluemoon breakage caused by just the right architecture,
> >   driver, etc. It totally frees up the driver writer from thinking
> >   about barriers, provided they get the locking right.
> >
> > - ordered WRT other IO accessors, constrained within spinlocks, but not
> >   cacheable memory. This is what powerpc does now. It's a little faster
> >   for them, and probably covers the vast majority of drivers, but there
> >   are real possibilities to get it wrong (trivial example: using bit
> >   locks or mutexes or any kind of open coded locking or lockless
> >   synchronisation can break).
> >
> > - (less sane) same as above, but not ordered WRT spinlocks. This is what
> >   ia64 (sn2) does. From a purist POV, it is a little less arbitrary than
> >   powerpc, but in practice, it will break a lot more drivers than powerpc.
> >
> > I was kind of joking about taking control of this issue :) But seriously,
> > it needs a decision to be made. I vote for #1. My rationale: I'm still
> > finding relatively major (well, found maybe 4 or 5 in the last couple of
> > years) bugs in the mm subsystem due to memory ordering problems. This is
> > apparently one of the most well reviewed and tested bit of code in the
> > kernel by people who know all about memory ordering. Not to mention that
> > mm/ does not have to worry about IO ordering at all. Then apparently
> > driver are the least reviewed and tested. Connect dots.
> >
> > Now that doesn't leave waker ordering architectures lumped with "slow old
> > x86 semantics". Think of it as giving them the benefit of sharing x86
> > development and testing :) We can then formalise the relaxed __ accessors
> > to be more complete (ie. +/- byteswapping). I'd also propose to add
> > io_rmb/io_wmb/io_mb that order io/io access, to help architectures like
> > sn2 where the io/cacheable barrier is pretty expensive.
> >
> > Any comments?
> 
> FWIW that approach sounds pretty good to me.  Arches that suffer from 
> performance penalties can still add lower level primitives and port selected 
> drivers over, so really they won't be losing much.  AFAICT though drivers 
> will still have to worry about regular memory ordering issues; they'll just 
> be safe from I/O related ones. :)  Still, the simplification is probably 
> worth it.

me too.  That's the whole basis for readX_relaxed() and its cohorts: we
make our weirdest machines (like altix) conform to the x86 norm.  Then
where it really kills us we introduce additional semantics to selected
drivers that enable us to recover I/O speed on the abnormal platforms.

About the only problem we've had is that architectures aren't very good
at co-ordinating for their additional accessors so we tend to get a
forest of strange ones growing up, which appear only in a few drivers
(i.e. the ones that need the speed ups) and which have no well
documented meaning.

James
