Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A325DE30B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 09:08:11 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080404213932.GA15847@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
Content-Type: text/plain
Date: Sat, 05 Apr 2008 09:07:31 +1100
Message-Id: <1207346851.10388.427.camel@pasglop>
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


>  config LOCKDEP_SUPPORT
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 69a91bd..bd3ce0f 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -144,6 +144,47 @@ transfer_to_handler:
>  	.globl transfer_to_handler_cont
>  transfer_to_handler_cont:
>  3:
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	lis	r11,reenable_mmu@h
> +	ori	r11,r11,reenable_mmu@l
> +	mtspr	SPRN_SRR0,r11
> +	mtspr	SPRN_SRR1,r10
> +	SYNC
> +	RFI

I don't think we need that on 4xx/BookE when using AS0 (that is also
true of the existing transfer_to_handler_cont, could be improved there.

> +reenable_mmu:				/* re-enable mmu so we can */
> +	mflr	r9			/* call C code, if necessary */
> +	mfmsr	r10
> +	lwz	r11,_MSR(r1)
> +	xor	r10,r10,r11
> +	andi.	r10,r10,MSR_EE		/* Did EE change? */
> +	beq	1f
> +	stwu	r1,-48(r1)		/* Yes, it must have been cleared */
> +	stw	r9,52(r1)
> +	stw	r0,16(r1)
> +	stw	r3,20(r1)
> +	stw	r4,24(r1)
> +	stw	r5,28(r1)
> +	stw	r6,32(r1)
> +	stw	r7,36(r1)
> +	stw	r8,40(r1)
> +	bl	trace_hardirqs_off
> +	lwz	r0,16(r1)
> +	lwz	r3,20(r1)
> +	lwz	r4,24(r1)
> +	lwz	r5,28(r1)
> +	lwz	r6,32(r1)
> +	lwz	r7,36(r1)
> +	lwz	r8,40(r1)
> +	lwz	r9,52(r1)
> +	addi	r1,r1,48

Why do yo save all the volatile regs ? They should have been saved on
the stack already by the exception prolog (the ptregs on the stack).

Also, only the system call really cares about -restoring- them. Maybe
you could stick that in an ifdef CONFIG_TRACE_IRQFLAGS section in
DoSyscall pulling them back off the ptregs in the stackframe. 

> +	tovirt(r9,r9)
> +	lwz	r11,0(r9)		/* virtual address of handler */
> +	lwz	r9,4(r9)		/* where to go when done */
> +	mtctr	r11
> +	mtlr	r9
> +	bctr				/* jump to handler */
> +#else /* CONFIG_TRACE_IRQFLAGS */
>  	mflr	r9
>  	lwz	r11,0(r9)		/* virtual address of handler */
>  	lwz	r9,4(r9)		/* where to go when done */
> @@ -152,6 +193,7 @@ transfer_to_handler_cont:
>  	mtlr	r9
>  	SYNC
>  	RFI				/* jump to handler, enable MMU */
> +#endif /* CONFIG_TRACE_IRQFLAGS */
>  
>  #ifdef CONFIG_6xx
>  4:	rlwinm	r12,r12,0,~_TLF_NAPPING
> @@ -220,12 +262,20 @@ ret_from_syscall:
>  #ifdef SHOW_SYSCALLS
>  	bl	do_show_syscall_exit
>  #endif
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

You may get away with pre-storing r3 in RESULT(r1), I'll have to double
check on monday... the 32 bits syscall exit code is a bit scary :-)

I'm pretty sure there's no need to allocate a stackframe. At worst,
there must be some ptregs field in the existing one that can be used.

That's all for today, I'll have another close look on monday.

Cheers,
Ben.
