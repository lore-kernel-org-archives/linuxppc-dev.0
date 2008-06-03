Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8AA4DE9E0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 05:08:18 +1000 (EST)
Date: Tue, 3 Jun 2008 12:07:22 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
Message-ID: <alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<20080602072403.GA20222@flint.arm.linux.org.uk>
	<200806031416.18195.nickpiggin@yahoo.com.au>
	<alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 3 Jun 2008, Trent Piepho wrote:

> On Tue, 3 Jun 2008, Linus Torvalds wrote:
> > On Tue, 3 Jun 2008, Nick Piggin wrote:
> > > 
> > > Linus: on x86, memory operations to wc and wc+ memory are not ordered
> > > with one another, or operations to other memory types (ie. load/load
> > > and store/store reordering is allowed). Also, as you know, store/load
> > > reordering is explicitly allowed as well, which covers all memory
> > > types. So perhaps it is not quite true to say readl/writel is strongly
> > > ordered by default even on x86. You would have to put in some
> > > mfence instructions in them to make it so.
> 
> So on x86, these could be re-ordered?
> 
> writel(START_OPERATION, CONTROL_REGISTER);
> status = readl(STATUS_REGISTER);

With both registers in a WC+ area, yes. The write may be in the WC buffers 
until the WC buffers are flushed (short list: a fence, a serializing 
instruction, a read-write to uncached memory, or an interrupt. There are 
others, but those are the main ones).

But if the status register is in uncached memory (which is the only *sane* 
thing to do), then it doesn't matter if the control register is in WC 
memory. Because the status register read is itself serializing with the WC 
buffer, it's actually fine.

So this is used for putting things like ring queues in WC memory, and fill 
them up with writes, and get nice bursty write traffic with the CPU 
automatically buffering it up (think "stdio.h on a really low level"). And 
if you then have the command registers in UC memory or using IO port 
accesses, reading and writing to them will automatically serialize.

> > Well, you have to ask for WC/WC+ anyway, so it's immaterial. A driver that
> > does that needs to be aware of it. IOW, it's a non-issue, imnsho.
> 
> You need to ask for coherent DMA memory too.

Not on x86.

And I don't care what anybody else says - x86 is *so* totally dominant, 
that other architectures have to live with the fact that 99.9% of all 
drivers are written for and tested on x86. As a result, anything else is 
"theory".

Are some drivers good and are careful? Yes. Are most? No, and even if they 
were, people making changes would mostly test them on x86. Architectures 
should strive to basically act as closely as possible to x86 semantics in 
order to not get nasty surprises.

And architectures that can't do that well enough *will* often find that 
they need to fix drivers, and only a small small subset of all kernel 
drivers will generally work out-of-the-box.

If you're ready to do that, your architecture can do anything it damn well 
pleases ;)

			Linus
