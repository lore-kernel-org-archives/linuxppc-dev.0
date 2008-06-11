Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp118.mail.mud.yahoo.com (smtp118.mail.mud.yahoo.com
	[209.191.84.167]) by ozlabs.org (Postfix) with SMTP id AF459DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 14:06:41 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 11 Jun 2008 14:06:27 +1000
References: <1211852026.3286.36.camel@pasglop>
	<200806111329.35894.nickpiggin@yahoo.com.au>
	<1213155644.25745.60.camel@pasglop>
In-Reply-To: <1213155644.25745.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806111406.28411.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
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

On Wednesday 11 June 2008 13:40, Benjamin Herrenschmidt wrote:
> On Wed, 2008-06-11 at 13:29 +1000, Nick Piggin wrote:
> > Exactly, yes. I guess everybody has had good intentions here, but
> > as noticed, what is lacking is coordination and documentation.
> >
> > You mention strong ordering WRT spin_unlock, which suggests that
> > you would prefer to take option #2 (the current powerpc one): io/io
> > is ordered and io is contained inside spinlocks, but io/cacheable
> > in general is not ordered.
>
> IO/cacheable -is- ordered on powepc in what we believe is the direction
> that matter: IO reads are fully ordered vs. anything and IO writes are
> ordered vs. previous cacheable stores. The only "relaxed" situation is
> IO writes followed by cacheable stores, which I believe shouldn't be
> a problem. (except for spinlocks for which we use the flag trick)

Spinlocks... mutexes, semaphores, rwsems, rwlocks, bit spinlocks, bit
mutexes, open coded bit locks (of which there are a number floating
around in drivers/).

But even assuming you get all of that fixed up. I wonder what is such
a big benefit to powerpc that you'll rather add the exception "cacheable
stores are not ordered with previous io stores" than to say "any driver
which works on x86 will work on powerpc as far as memory ordering goes"?
(don't you also need something to order io reads with cacheable reads?
as per my observation that your rmb is broken according to IBM docs)

Obviously you already have a sync instruction in your writel, so 1)
adding a second one doesn't slow it down by an order of mangnitude or
anything, just some small factor; and 2) you obviously want to be
converting high performance drivers to a more relaxed model anyway
regardless of whether there is one sync or two in there.

Has this ever been measured or thought carefully about? Beyond the
extent of "one sync good, two sync bad" ;)
