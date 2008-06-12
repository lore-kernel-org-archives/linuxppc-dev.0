Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp104.mail.mud.yahoo.com (smtp104.mail.mud.yahoo.com
	[209.191.85.214]) by ozlabs.org (Postfix) with SMTP id A191CDE12D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 21:27:27 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 12 Jun 2008 21:27:18 +1000
References: <1211852026.3286.36.camel@pasglop>
	<200806111329.35894.nickpiggin@yahoo.com.au>
	<200806110907.12070.jbarnes@virtuousgeek.org>
In-Reply-To: <200806110907.12070.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806122127.19230.nickpiggin@yahoo.com.au>
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

On Thursday 12 June 2008 02:07, Jesse Barnes wrote:
> On Tuesday, June 10, 2008 8:29 pm Nick Piggin wrote:

> > You mention strong ordering WRT spin_unlock, which suggests that
> > you would prefer to take option #2 (the current powerpc one): io/io
> > is ordered and io is contained inside spinlocks, but io/cacheable
> > in general is not ordered.
>
> I was thinking it would be good for the weaker accessors, but now that I
> think about it you could just use the new io_* barrier functions.
>
> I didn't mean to imply that I wasn't in favor of the io/cacheable ordering
> as well.
>
> > For any high performance drivers that are well maintained (ie. the
> > ones where slowdown might be noticed), everyone should have a pretty
> > good handle on memory ordering requirements, so it shouldn't take
> > long to go through and convert them to relaxed accessors.
>
> Yep.  Thanks for working on this, Nick, it's definitely a good thing that
> you're taking control of it. :)

Well, I really am just trying to help the kernel for everyone (and every
architecture). Performance for all architectures really is my #2 priority,
so if any arch becomes irrepearably slower under a proposal I would
go back to the drawing board.

I'll come up with a proposal in the form of an initial code+documentation
patch when I get some more time on it.
