Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D851DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 14:50:43 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080404213932.GA15847@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
Content-Type: text/plain
Date: Mon, 07 Apr 2008 14:49:51 +1000
Message-Id: <1207543791.10388.468.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think I found one:

 .../...

> -	mr	r6,r3
>  	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
>  	/* disable interrupts so current_thread_info()->flags can't change */
>  	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
>  	SYNC
>  	MTMSRD(r10)
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	stwu	r1,-16(r1)
> +	stw	r3,12(r1)
> +	bl      trace_hardirqs_off
> +	lwz	r3,12(r1)
> +	addi	r1,r1,16
> +	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
> +#endif

Here, r12 is clobbered, though it's used two lines later:

> +	mr	r6,r3
>  	lwz	r9,TI_FLAGS(r12)

Here.

You can probably just move the rlwinm down as you moved the mr.

Note that I've been wondering wether we should attempt to trace all
those IRQ state change internally to the exception code. I've looked at
not doing it, which simplifies things a bit.

Unfortunately, that will make us occasionally trace redundant
enable/disable (which isn't a big problem per-se, just counters).

The idea is that I only kept the trace of disable in transfer_to_handler
and I modified the enable tracing in restore: moved it lower down, and
made it test for _MSR(r1):MSR_EE. I added a trace_irq_off just before
the preempt_schedule_irq() as well.

Anyway, let me know what you think.

Cheers,
Ben.
