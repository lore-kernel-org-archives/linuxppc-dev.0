Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8136EDDF73
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:17:06 +1000 (EST)
Date: Mon, 7 Apr 2008 09:16:39 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20080407161639.GB9912@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
	<1207543791.10388.468.camel@pasglop>
MIME-Version: 1.0
In-Reply-To: <1207543791.10388.468.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 02:49:51PM +1000, Benjamin Herrenschmidt wrote:
> I think I found one:
> 
>  .../...
> 
> > -	mr	r6,r3
> >  	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
> >  	/* disable interrupts so current_thread_info()->flags can't change */
> >  	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
> >  	SYNC
> >  	MTMSRD(r10)
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +	stwu	r1,-16(r1)
> > +	stw	r3,12(r1)
> > +	bl      trace_hardirqs_off
> > +	lwz	r3,12(r1)
> > +	addi	r1,r1,16
> > +	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
> > +#endif
> 
> Here, r12 is clobbered, though it's used two lines later:

Ah yes. r12 is volatile, isn't it.  :-)  Good catch.

> > +	mr	r6,r3
> >  	lwz	r9,TI_FLAGS(r12)
> 
> Here.
> 
> You can probably just move the rlwinm down as you moved the mr.

I'll follow up with a revised patch that does exactly that.

> Note that I've been wondering wether we should attempt to trace all
> those IRQ state change internally to the exception code. I've looked at
> not doing it, which simplifies things a bit.
> 
> Unfortunately, that will make us occasionally trace redundant
> enable/disable (which isn't a big problem per-se, just counters).
> 
> The idea is that I only kept the trace of disable in transfer_to_handler
> and I modified the enable tracing in restore: moved it lower down, and
> made it test for _MSR(r1):MSR_EE. I added a trace_irq_off just before
> the preempt_schedule_irq() as well.
> 
> Anyway, let me know what you think.

The main purpose I did this code was to measure
interrupt-disabled intervals.  There, the redundant trace calls aren't
really an issue.

It all depends on how important you view the counters.  I think that
if we're going to go to the trouble to maintain counters, we should
make them accurate.  I admit that it took me quite a while to get the
counts correct. :-)  I think having an accurate measure of the redundant
interrupt disable/enables is useful.  And, after doing the code, I'd
prefer to see it stay.  :-)

Thanks,
-Dale
