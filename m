Return-Path: <paulus@ozlabs.org>
Date: Thu, 8 Aug 2013 14:51:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/9] powerpc: handle machine check in Linux host.
Message-ID: <20130808045143.GC12112@iris.ozlabs.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093815.5389.7668.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130807093815.5389.7668.stgit@mars.in.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 03:08:15PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Move machine check entry point into Linux. So far we were dependent on
> firmware to decode MCE error details and handover the high level info to OS.
> 
> This patch introduces early machine check routine that saves the MCE
> information (srr1, srr0, dar and dsisr) to the emergency stack. We allocate
> stack frame on emergency stack and set the r1 accordingly. This allows us
> to be prepared to take another exception without loosing context. One thing
> to note here that, if we get another machine check while ME bit is off then
> we risk a checkstop. Hence we restrict ourselves to save only MCE information
> and turn the ME bit on.

Some comments below:

> + * Swicth to emergency stack and handle re-entrancy (though we currently
      ^
      Switch

> + * don't test for overflow). Save MCE registers srr1, srr0, dar and
> + * dsisr and then turn the ME bit on.
> + */
> +#define __EARLY_MACHINE_CHECK_HANDLER(area, label)			\
> +	/* Check if we are laready using emergency stack. */		\
> +	ld	r10,PACAEMERGSP(r13);					\
> +	subi	r10,r10,THREAD_SIZE;					\
> +	rldicr	r10,r10,0,(63 - THREAD_SHIFT);				\
> +	rldicr	r11,r1,0,(63 - THREAD_SHIFT);				\
> +	cmpd	r10,r11;	/* Are we using emergency stack? */	\

This assumes that r1 contains a host kernel stack pointer value.
However, we could be coming in from a guest, or from userspace, in
which case r1 could have any value at all, and we shouldn't even be
considering using it as our stack pointer.

There is another complication, too: if we are coming in from a KVM
guest running on a secondary thread (not thread 0), we will be using
part of the emergency stack already (see kvm_start_guest in
arch/powerpc/kvm/book3s_hv_rmhandlers.S).  However, because we have
come in from a guest, r1 contains a guest value, and we would have to
look in KVM data structures to find out how much of the emergency
stack we have already used.  I'm not sure at the moment what the best
way to fix this is.

> +	mr	r11,r1;			/* Save current stack pointer */\
> +	beq	0f;							\
> +	ld	r1,PACAEMERGSP(r13);	/* Use emergency stack */	\
> +0:	subi	r1,r1,INT_FRAME_SIZE;	/* alloc stack frame */		\
> +	std	r11,GPR1(r1);						\
> +	std	r11,0(r1);		/* make stack chain pointer */	\
> +	mfspr	r11,SPRN_SRR0;		/* Save SRR0 */			\
> +	std	r11,_NIP(r1);						\
> +	mfspr	r11,SPRN_SRR1;		/* Save SRR1 */			\
> +	std	r11,_MSR(r1);						\
> +	mfspr	r11,SPRN_DAR;		/* Save DAR */			\
> +	std 	r11,_DAR(r1);						\
> +	mfspr	r11,SPRN_DSISR;		/* Save DSISR */		\
> +	std	r11,_DSISR(r1);						\
> +	mfmsr	r11;			/* get MSR value */		\
> +	ori	r11,r11,MSR_ME;		/* turn on ME bit */		\
> +	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
> +	LOAD_HANDLER(r12,label)						\
> +	mtspr	SPRN_SRR0,r12;						\
> +	mtspr	SPRN_SRR1,r11;						\
> +	rfid;								\
> +	b	.	/* prevent speculative execution */
> +#define EARLY_MACHINE_CHECK_HANDLER(area, label)			\
> +	__EARLY_MACHINE_CHECK_HANDLER(area, label)

Given this is only used in one place, why make this a macro?  Wouldn't
it be simpler and neater to just spell out this code in the place
where you use the macro?

> +	/*
> +	 * Handle machine check early in real mode. We come here with
> +	 * ME bit on with MMU (IR and DR) off and using emergency stack.
> +	 */
> +	.align	7
> +	.globl machine_check_handle_early
> +machine_check_handle_early:
> +	std	r9,_CCR(r1)	/* Save CR in stackframe */
> +	std	r0,GPR0(r1)	/* Save r0, r2 - r10 */
> +	EXCEPTION_PROLOG_COMMON_2(0x200, PACA_EXMC)
> +	bl	.save_nvgprs
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	.machine_check_early
> +	cmpdi	r3,0			/* Did we handle it? */
> +	ld	r9,_MSR(r1)
> +	beq	1f
> +	ori	r9,r9,MSR_RI		/* Yes we have handled it. */

I don't think this is a good idea.  MSR_RI being off means either that
the machine check happened at a time when SRR0 and SRR1 contained live
contents, which have been overwritten by the machine check interrupt,
or else that the CPU was not able to determine a precise state at
which the interrupt could be taken.  Neither of those problems would
be fixed by our machine check handler.

What was the rationale for setting RI in this situation?

> +	/* Move original SRR0 and SRR1 into the respective regs */
> +1:	mtspr	SPRN_SRR1,r9
> +	ld	r3,_NIP(r1)
> +	mtspr	SPRN_SRR0,r3
> +	REST_NVGPRS(r1)
> +	ld	r9,_CTR(r1)
> +	mtctr	r9
> +	ld	r9,_XER(r1)
> +	mtxer	r9
> +	ld	r9,_CCR(r1)
> +	mtcr	r9
> +BEGIN_FTR_SECTION
> +	ld	r9,ORIG_GPR3(r1)
> +	mtspr	SPRN_CFAR,r9
> +END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
> +	ld	r9,_LINK(r1)
> +	mtlr	r9
> +	REST_GPR(0, r1)
> +	REST_8GPRS(2, r1)
> +	REST_2GPRS(10, r1)
> +	REST_GPR(12, r1)
> +	/*
> +	 * restore orig stack pointer. We have already saved MCE info
> +	 * to per cpu MCE event buffer.
> +	 */
> +	ld	r1,GPR1(r1)
> +	b	machine_check_pSeries

What about r13?  I don't see that you have restored it at this point.

> +
>  	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
>  	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
>  	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index bf33c22..1720e08 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -286,6 +286,18 @@ void system_reset_exception(struct pt_regs *regs)
>  
>  	/* What should we do here? We could issue a shutdown or hard reset. */
>  }
> +
> +/*
> + * This function is called in real mode. Strictly no printk's please.
> + *
> + * regs->nip and regs->msr contains srr0 and ssr1.
> + */
> +long machine_check_early(struct pt_regs *regs)
> +{
> +	/* TODO: handle/decode machine check reason */
> +	return 0;
> +}
> +
>  #endif
>  
>  /*
