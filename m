Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp115.mail.mud.yahoo.com (smtp115.mail.mud.yahoo.com
	[209.191.84.164]) by ozlabs.org (Postfix) with SMTP id F2A6FDE206
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:08:43 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 12 Jun 2008 23:08:35 +1000
References: <1211852026.3286.36.camel@pasglop>
	<200806111535.24523.nickpiggin@yahoo.com.au>
	<18513.4925.711881.794221@cargo.ozlabs.ibm.com>
In-Reply-To: <18513.4925.711881.794221@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Message-Id: <200806122308.35556.nickpiggin@yahoo.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 June 2008 22:14, Paul Mackerras wrote:
> Nick Piggin writes:
> >                 /* turn off LED */
> >                 val64 = readq(&bar0->adapter_control);
> >                 val64 = val64 &(~ADAPTER_LED_ON);
> >                 writeq(val64, &bar0->adapter_control);
> >                 s2io_link(nic, LINK_DOWN);
> >         }
> >         clear_bit(__S2IO_STATE_LINK_TASK, &(nic->state));
> >
> > Now I can't say definitively that this is going to be wrong on
> > powerpc, because I don't know the code well enough. But I'd be
> > 90% sure that the unlock is not supposed to be visible to
> > other CPUs before the writeqs are queued to the card. On x86 it
> > wouldn't be.
>
> Interestingly, there is also a store to cacheable memory
> (nic->device_enabled_once), but no smp_wmb or equivalent before the
> clear_bit.  So there are other potential problems here besides the I/O
> related ones.

Yeah there sure is. That sucks too, but we go one step at a time ;)
I think proposing a strong ordering between set_bit/clear_bit would
actually be quite noticable slowdown in core kernel code at this
point.

Which reminds me, I have been meaning to do another pass of test and
set bit / clear bit conversions to the _lock primitives...


> Anyway, I have done some tests on a dual G5 here with putting a sync
> on both sides of the store in writel etc. (i.e. making readl/writel
> strongly ordered w.r.t. everything else), and as you predicted, there
> wasn't a noticeable performance degradation, at least not on the
> couple of things I tried.  So I am now inclined to accept your
> suggestion that we should do that.  I should probably do some similar
> checks on POWER6 and a few other machines first, though.

Oh good, thanks for looking into it. I guess it might be a little more
noticable on bigger POWER systems. And I think we might even need to do
a PCI read after every writel on sn2 systems in order to get the
semantics I want.

I can't say it won't be noticable. But if we consider the number of
drivers (maybe one or two dozen well maintained ones), and number of
sites in each driver (maybe one or two submission and completion
fastpaths which should have a minimum of IO operations in each one)
that will have to be converted in order to get performance as good or
better than it is currently with relaxed accessors.... and weigh that
against all the places in those and every other crappy obscure
driver that we *won't* have to audit, I really think we end up with
a net win even with some short term pain.
