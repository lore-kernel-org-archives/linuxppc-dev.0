Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44F37DDF1C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 23:41:46 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6JDfRtM014233
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 09:41:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6JDfHJg215820
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 09:41:17 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6JDfGWt010808
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 09:41:16 -0400
Date: Sat, 19 Jul 2008 09:37:52 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: luisgpm@linux.vnet.ibm.com
Subject: Re: [RFC] 4xx hardware watchpoint support
Message-ID: <20080719093752.5aada45c@zod.rchland.ibm.com>
In-Reply-To: <1213992894.6635.41.camel@gargoyle>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jun 2008 17:14:53 -0300
Luis Machado <luisgpm@linux.vnet.ibm.com> wrote:
> 
> Follows a re-worked patch that unifies the handling of hardware
> watchpoint structures for DABR-based and DAC-based processors.
> 
> The flow is exactly the same for DABR-based processors.
> 
> As for the DAC-based code, i've eliminated the "dac" field from the
> thread structure, since now we use the "dabr" field to represent DAC1 of
> the DAC-based processors. As a consequence, i removed all the
> occurrences of "dac" throughout the code, using "dabr" in those cases.
> 
> The function "set_dabr" sets the correct register (DABR OR DAC) for each
> specific processor now, instead of only setting the value for DABR-based
> processors.
> 
> "do_dac" was merged with "do_dabr" as they were mostly equivalent pieces
> of code. I've moved "do_dabr" to "arch/powerpc/kernel/process.c" so it
> is visible for DAC-based code as well.
> 
> Tested on a Taishan 440GX with success.
> 
> Is it OK to leave it as "dabr" for both DABR and DAC? What do you think
> of the patch overall?

Aside from the comment I mention below (which really does need fixing),
the overall look of the patch seems good.

> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/process.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/process.c	2008-06-20 02:51:16.000000000 -0700
> @@ -241,6 +241,35 @@
>  }
>  #endif /* CONFIG_SMP */
> 
> +void do_dabr(struct pt_regs *regs, unsigned long address,
> +		    unsigned long error_code)
> +{
> +	siginfo_t info;
> +
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) == NOTIFY_STOP)
> +		return;
> +
> +	if (debugger_dabr_match(regs))
> +		return;
> +#else
> +        /* Clear the DAC and struct entries.  One shot trigger.  */
> +        mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
> +                                                        | DBCR0_IDM));

This doesn't look right for how it's coded.  This would be the
CONFIG_4xx || CONFIG_BOOKE case, but CONFIG_4xx includes PowerPC 405.
That has a different bit layout among the DBCR registers.  Namely, on
405 you would be clearing the TDE and IAC1 events because the DAC
events are in DBCR1, not DBCR0.

<snip>

> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/signal.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/signal.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/signal.c	2008-06-20 02:51:16.000000000 -0700
> @@ -144,8 +144,12 @@
>  	 * user space. The DABR will have been cleared if it
>  	 * triggered inside the kernel.
>  	 */
> -	if (current->thread.dabr)
> +	if (current->thread.dabr) {
>  		set_dabr(current->thread.dabr);
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +		mtspr(SPRN_DBCR0, current->thread.dbcr0);
> +#endif

This has the same problem I mention above, as the 44x bit layout is
stored in dbcr0 throughout the code.

> +	}
> 
>  	if (is32) {
>          	if (ka.sa.sa_flags & SA_SIGINFO)
> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/traps.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/traps.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/traps.c	2008-06-20 02:54:37.000000000 -0700
> @@ -1045,6 +1045,21 @@
>  				return;
>  		}
>  		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
> +	} else if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {
> +		regs->msr &= ~MSR_DE;
> +	        printk("\nWatchpoint Triggered\n");
> +		if (user_mode(regs)) {
> +			current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W |
> +								DBCR0_IDM);
> +		} else {
> +			/* Disable DAC interupts.  */
> +			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R |
> +							DBSR_DAC1W | DBCR0_IDM));
> +			/* Clear the DAC event.  */
> +			mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W));

And again here.

josh
