Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp113.mail.mud.yahoo.com (smtp113.mail.mud.yahoo.com
	[209.191.84.66]) by ozlabs.org (Postfix) with SMTP id 8F82DDDEFA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 17:18:59 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 17:18:42 +1000
References: <1211852026.3286.36.camel@pasglop>
	<200806031611.13817.nickpiggin@yahoo.com.au>
	<18500.60032.989380.864674@cargo.ozlabs.ibm.com>
In-Reply-To: <18500.60032.989380.864674@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031718.43393.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 June 2008 16:53, Paul Mackerras wrote:
> Nick Piggin writes:
> > So your readl can pass an earlier cacheable store or earlier writel?
>
> No.  It's quite gross at the moment, it has a sync before the access
> (i.e. a full mb()) and a twi; isync sequence after the access that
> stalls execution until the data comes back.

OK.


> > > We don't provide meaningless ones like writel + cacheable store for
> > > example. (PCI posting would defeat it anyway).
> >
> > What do you mean by meaningless? Ordering of writel followed by a
> > cacheable store  is meaningful eg. for retaining io operations within
> > locks. OK, you explicitly have some extra code for spin_unlock, but
> > not for bit locks, mutexes, etc. It would make sense to have the
> > default operations _very_ strongly ordered IMO, and then move drivers
> > to be more relaxed when they are verified.
>
> It's meaningless in the sense that nothing guarantees that the writel
> has actually hit the device, even if we put a full mb() barrier in
> between the writel and the cacheable write.  That would guarantee that
> the writel had got to the PCI host bridge, and couldn't be reordered
> with other accesses to the device, but not that the device had
> actually seen it.

OK, but I think fits OK with our SMP ordering model for cacheable
stores: no amount of barriers on CPU0 will guarantee that CPU1 has
seen the store, you actually have to observe a causual effect
of the store before you can say that.


> I don't mind adding code to the mutex unlock to do the same as
> spin_unlock, but I really don't want to have *two* sync instructions
> for every MMIO write.  One is bad enough.

So you can't provide iostore/store ordering without another sync
after the writel store?

I guess the problem with providing exceptions is that it makes it
hard for people who absolutely don't know or care about ordering.
I don't like having to think about it "hmm, we can allow this type
of reordering... oh, unless some silly device does X...".

If we come up with a sane set of weakly ordered accessors
(including io_*mb()), it will make it easier to go through the
important drivers and improve them. We don't have to enforce the
the new semantics strictly until then if they'll slow you down
too much in the meantime.
