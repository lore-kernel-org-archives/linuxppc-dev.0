Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp118.mail.mud.yahoo.com (smtp118.mail.mud.yahoo.com
	[209.191.84.167]) by ozlabs.org (Postfix) with SMTP id C942DDDEEA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 12:06:00 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:05:45 +1000
References: <1211852026.3286.36.camel@pasglop>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806041205.45833.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 June 2008 05:07, Linus Torvalds wrote:
> On Tue, 3 Jun 2008, Trent Piepho wrote:
> > On Tue, 3 Jun 2008, Linus Torvalds wrote:
> > > On Tue, 3 Jun 2008, Nick Piggin wrote:
> > > > Linus: on x86, memory operations to wc and wc+ memory are not ordered
> > > > with one another, or operations to other memory types (ie. load/load
> > > > and store/store reordering is allowed). Also, as you know, store/load
> > > > reordering is explicitly allowed as well, which covers all memory
> > > > types. So perhaps it is not quite true to say readl/writel is
> > > > strongly ordered by default even on x86. You would have to put in
> > > > some mfence instructions in them to make it so.
> >
> > So on x86, these could be re-ordered?
> >
> > writel(START_OPERATION, CONTROL_REGISTER);
> > status = readl(STATUS_REGISTER);
>
> With both registers in a WC+ area, yes. The write may be in the WC buffers
> until the WC buffers are flushed (short list: a fence, a serializing
> instruction, a read-write to uncached memory, or an interrupt. There are
> others, but those are the main ones).
>
> But if the status register is in uncached memory (which is the only *sane*
> thing to do), then it doesn't matter if the control register is in WC
> memory. Because the status register read is itself serializing with the WC
> buffer, it's actually fine.

Actually, according to the document I am looking at (the AMD one), a UC
store may pass a previous WC store.

So you could have some code that writes to some WC memory on the card,
and then stores to an UC control register to start up the operation on
that memory, couldn't you? Those can go out of order.
