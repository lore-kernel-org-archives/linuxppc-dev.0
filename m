Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-36.bluehost.com (outbound-mail-36.bluehost.com
	[69.89.20.190]) by ozlabs.org (Postfix) with SMTP id 9AFE7DE255
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 02:08:08 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 11 Jun 2008 09:07:11 -0700
References: <1211852026.3286.36.camel@pasglop>
	<200806101219.34995.jbarnes@virtuousgeek.org>
	<200806111329.35894.nickpiggin@yahoo.com.au>
In-Reply-To: <200806111329.35894.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806110907.12070.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday, June 10, 2008 8:29 pm Nick Piggin wrote:
> On Wednesday 11 June 2008 05:19, Jesse Barnes wrote:
> > On Tuesday, June 10, 2008 12:05 pm Roland Dreier wrote:
> > >  > me too.  That's the whole basis for readX_relaxed() and its cohorts:
> > >  > we make our weirdest machines (like altix) conform to the x86 norm.
> > >  > Then where it really kills us we introduce additional semantics to
> > >  > selected drivers that enable us to recover I/O speed on the abnormal
> > >  > platforms.
> > >
> > > Except as I pointed out before, Altix doesn't conform to the norm and
> > > many (most?) drivers are missing mmiowb()s that are needed for Altix.
> > > Just no one has plugged most devices into an Altix (or haven't stressed
> > > the driver in a way that exposes problems of IO ordering between CPUs).
> > >
> > > It would be a great thing to use the powerpc trick of setting a flag
> > > that is tested by spin_unlock()/mutex_unlock() and automatically doing
> > > the mmiowb() if needed, and then killing off mmiowb() entirely.
> >
> > Yeah I think that's what Nick's guidelines would guarantee.  And Jes is
> > already working on the spin_unlock change you mentioned, so mmiowb()
> > should be history soon (in name only, assuming Nick also introduces the
> > I/O barriers he talked about for ordering the looser accessors it would
> > still be there but would be called io_wmb or something).
>
> Exactly, yes. I guess everybody has had good intentions here, but
> as noticed, what is lacking is coordination and documentation.
>
> You mention strong ordering WRT spin_unlock, which suggests that
> you would prefer to take option #2 (the current powerpc one): io/io
> is ordered and io is contained inside spinlocks, but io/cacheable
> in general is not ordered.

I was thinking it would be good for the weaker accessors, but now that I think 
about it you could just use the new io_* barrier functions.

I didn't mean to imply that I wasn't in favor of the io/cacheable ordering as 
well.

> For any high performance drivers that are well maintained (ie. the
> ones where slowdown might be noticed), everyone should have a pretty
> good handle on memory ordering requirements, so it shouldn't take
> long to go through and convert them to relaxed accessors.

Yep.  Thanks for working on this, Nick, it's definitely a good thing that 
you're taking control of it. :)

Thanks,
Jesse
