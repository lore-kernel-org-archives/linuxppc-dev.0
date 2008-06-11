Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B040DE39A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 01:07:01 +1000 (EST)
Message-Id: <CB93E897-6E25-4F80-86D1-00A80B1B1967@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D28F98D@insardxms01.ap.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Kprobes for book-e
Date: Wed, 11 Jun 2008 10:05:58 -0500
References: <7B7EF7F090B9804A830ACC82F2CDE95D28F98D@insardxms01.ap.sony.com>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 9:18 AM, Sulibhavi, Madhvesh wrote:

> Hi Kumar,
>
> I could switch to different version of binutils and
> boot the recent git for ebony target. The kprobes
> booke patches attached below got applied and
> i didnot see any issues.  These patches can be
> now pushed to main line?

there's a bit more cleanup, but I don't see any reason we cant get  
this done quickly.

> Below is the revised patch set after addressing some
> cleanups in traps.c and bug fixes to kprobes.c discussed
> earlier. Also added the support to Documentation/kprobes.txt
> and KRETPROBES check in powerpc/Kconfig file.

See my comments below.

> -Madhvesh
>
> ---------------------------------------------------------------------
> arch/powerpc/kernel/kprobes.c |   35 ++++++++++++++++++++++++++++++ 
> +----
> arch/powerpc/kernel/misc_32.S |    2 +-
> arch/powerpc/kernel/traps.c   |   26 +++++++++++++++++++++++++-
> 3 files changed, 57 insertions(+), 6 deletions(-)

Your patch got line wrapped by your mailer.  Take a look at  
Documentation/email-clients.tx

> static void __kprobes prepare_singlestep(struct kprobe *p, struct
> pt_regs *regs)
> {
> +#ifdef CONFIG_BOOKE
> +	regs->msr &= ~(MSR_EE); /* Turn off 'Externel Interrupt' bits */
> +	regs->msr &= ~(MSR_CE); /* Turn off 'Critical Interrupt' bits */
> +	regs->msr |= MSR_DE;

can we remove MSR_EE and MSR_CE here?
>
> +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> +#else
> 	regs->msr |= MSR_SE;
> +#endif
>
> 	/*
> 	 * On powerpc we should single step on the original
> @@ -158,7 +181,7 @@ static int __kprobes kprobe_handler(stru
> 			kprobe_opcode_t insn = *p->ainsn.insn;
> 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
> 					is_trap(insn)) {
> -				regs->msr &= ~MSR_SE;
> +				regs->msr &= ~MSR_SINGLESTEP; /* Turn
> off 'trace' bits */
> 				regs->msr |= kcb->kprobe_saved_msr;
> 				goto no_kprobe;
> 			}
> @@ -398,7 +421,7 @@ out:
> 	 * will have SE set, in which case, continue the remaining
> processing
> 	 * of do_debug, as if this is not a probe hit.
> 	 */
> -	if (regs->msr & MSR_SE)
> +	if (single_stepping(regs))
> 		return 0;
>
> 	return 1;
> @@ -421,7 +444,7 @@ int __kprobes kprobe_fault_handler(struc
> 		 * normal page fault.
> 		 */
> 		regs->nip = (unsigned long)cur->addr;
> -		regs->msr &= ~MSR_SE;
> +		regs->msr &= ~MSR_SINGLESTEP; /* Turn off 'trace' bits
> */
> 		regs->msr |= kcb->kprobe_saved_msr;
> 		if (kcb->kprobe_status == KPROBE_REENTER)
> 			restore_previous_kprobe(kcb);
> Index: b/arch/powerpc/kernel/misc_32.S
> ===================================================================
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -489,7 +489,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID
>  *
>  * flush_icache_range(unsigned long start, unsigned long stop)
>  */
> -_GLOBAL(__flush_icache_range)
> +_KPROBE(__flush_icache_range)
> BEGIN_FTR_SECTION
> 	blr				/* for 601, do nothing */
> END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> Index: b/arch/powerpc/kernel/traps.c
> ===================================================================
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1030,7 +1030,7 @@ void SoftwareEmulation(struct pt_regs *r
>
> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>
> -void DebugException(struct pt_regs *regs, unsigned long debug_status)
> +void __kprobes DebugException(struct pt_regs *regs, unsigned long
> debug_status)
> {
> 	if (debug_status & DBSR_IC) {	/* instruction completion */
> 		regs->msr &= ~MSR_DE;
> @@ -1041,6 +1041,12 @@ void DebugException(struct pt_regs *regs
> 			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) &
> ~DBCR0_IC);
> 			/* Clear the instruction completion event */
> 			mtspr(SPRN_DBSR, DBSR_IC);
> +#ifdef CONFIG_KPROBES
> +			if (notify_die(DIE_SSTEP, "single_step", regs,
> 5,
> +			       5, SIGTRAP) == NOTIFY_STOP) {
> +				return;
> +			}
> +#endif
> 			if (debugger_sstep(regs))
> 				return;
> 		}
> Index: b/Documentation/kprobes.txt
> ===================================================================
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -172,6 +172,7 @@ architectures:
> - ia64 (Does not support probes on instruction slot1.)
> - sparc64 (Return probes not yet implemented.)
> - arm
> +- ppc32
>
> 3. Configuring Kprobes
>
> Index: b/arch/powerpc/Kconfig
> ===================================================================
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -108,7 +108,7 @@ config PPC
> 	select HAVE_IDE
> 	select HAVE_OPROFILE
> 	select HAVE_KPROBES
> -	select HAVE_KRETPROBES
> +	select HAVE_KRETPROBES if (HAVE_KPROBES)

why bother?  we select HAVE_KPROBES one line earlier?

>
> 	select HAVE_LMB
>
> config EARLY_PRINTK
>
>
> -------------------------------------------------------------------
> This email is confidential and intended only for the use of the  
> individual or entity named above and may contain information that is  
> privileged. If you are not the intended recipient, you are notified  
> that any dissemination, distribution or copying of this email is  
> strictly prohibited. If you have received this email in error,  
> please notify us immediately by return email or telephone and  
> destroy the original message. - This mail is sent via Sony Asia  
> Pacific Mail Gateway.
> -------------------------------------------------------------------
