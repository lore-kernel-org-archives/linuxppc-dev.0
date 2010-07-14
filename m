Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B5E7B6F16
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 14:09:16 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o6E49Bp1027915
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:09:12 -0500
Subject: Re: [PATCH 09/13] powerpc/book3e: Add generic 64-bit idle
	powersave support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Jul 2010 14:09:11 +1000
Message-ID: <1279080551.28659.452.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-09 at 16:16 +1000, Benjamin Herrenschmidt wrote:
> We use a similar technique to ppc32: We set a thread local flag
> to indicate that we are about to enter or have entered the stop
> state, and have fixup code in the async interrupt entry code that
> reacts to this flag to make us return to a different location
> (sets NIP to LINK in our case).

 .../...

Commenting on my own patch ... :-) This has issues:

> +_GLOBAL(book3e_idle)
> +	/* Save LR for later */
> +	mflr	r0
> +	std	r0,16(r1)
> +
> +	/* Hard disable interrupts */
> +	wrteei	0
> +
> +	/* Now check if an interrupt came in while we were soft disabled
> +	 * since we may otherwise lose it (doorbells etc...). We know
> +	 * that since PACAHARDIRQEN will have been cleared in that case.
> +	 */
> +	lbz	r3,PACAHARDIRQEN(r13)
> +	cmpwi	cr0,r3,0
> +	beqlr
> +
> +	/* Now we are going to mark ourselves as soft and hard enables in
> +	 * order to be able to take interrupts while asleep. We inform lockdep
> +	 * of that. We don't actually turn interrupts on just yet tho.
> +	 */
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	bl	.trace_hardirqs_on

Oops... we just clobbered our saved LR on the stack. Need a stackframe

> +#endif
> +	li	r0,1
> +	stb	r0,PACASOFTIRQEN(r13)
> +	stb	r0,PACAHARDIRQEN(r13)
> +	
> +	/* Interrupts will make use return to LR, so get something we want
> +	 * in there
> +	 */
> +	bl	1f

We return here with IRQs enabled, we really need to turn them back off
or bad things will happen if an interrupt pops before we clear
TFL_NAPPING.

I'll send a respin.

Cheers,
Ben.

> +	/* We are back from the interrupt, the caller will local_irq_enable()
> +	 * so to avoid stupid warning, let's turn them off here if irqtrace
> +	 * is enabled.
> +	 */
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	li	r0,0
> +	stb	r0,PACASOFTIRQEN(r13)
> +	bl	.trace_hardirqs_off
> +#endif
> +	ld	r0,16(r1)
> +	mtlr	r0
> +	blr
> +
> +1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
> +	 * to the right spot
> +	*/
> +	clrrdi	r11,r1,THREAD_SHIFT
> +	ld	r10,TI_LOCAL_FLAGS(r11)
> +	ori	r10,r10,_TLF_NAPPING
> +	std	r10,TI_LOCAL_FLAGS(r11)
> +
> +	/* We can now re-enable hard interrupts and go to sleep */
> +	wrteei	1
> +1:	PPC_WAIT(0)
> +	b	1b
> +
> +#endif /* CONFIG_PPC64 */
> \ No newline at end of file
