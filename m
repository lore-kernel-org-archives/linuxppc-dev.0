Return-Path: <srs0=gggb=ld=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v9lg1M7WzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:58:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41v9lg0Vbrz8tPN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:58:39 +1000 (AEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41v9ld5H1Cz9s4c
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 20:58:37 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so6587272pgp.11
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 03:58:37 -0700 (PDT)
Date: Mon, 20 Aug 2018 20:58:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michal Suchanek
 <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v8 2/5] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
Message-ID: <20180820205829.47c182da@roar.ozlabs.ibm.com>
In-Reply-To: <153469849725.21878.4415545320115735468.stgit@jupiter.in.ibm.com>
References: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
 <153469849725.21878.4415545320115735468.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 19 Aug 2018 22:38:17 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> On pseries, as of today system crashes if we get a machine check
> exceptions due to SLB errors. These are soft errors and can be fixed by
> flushing the SLBs so the kernel can continue to function instead of
> system crash. We do this in real mode before turning on MMU. Otherwise
> we would run into nested machine checks. This patch now fetches the
> rtas error log in real mode and flushes the SLBs on SLB errors.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.com>
> ---
> 
> Changes in V8:
> - Use flush_and_reload_slb() from mce_power.c.
> ---
>  arch/powerpc/include/asm/machdep.h       |    1 
>  arch/powerpc/include/asm/mce.h           |    3 +
>  arch/powerpc/kernel/exceptions-64s.S     |  129 ++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/mce.c                |   15 +++
>  arch/powerpc/kernel/mce_power.c          |    2 
>  arch/powerpc/platforms/powernv/setup.c   |   11 +++
>  arch/powerpc/platforms/pseries/pseries.h |    1 
>  arch/powerpc/platforms/pseries/ras.c     |   54 ++++++++++++-
>  arch/powerpc/platforms/pseries/setup.c   |    1 
>  9 files changed, 212 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index a47de82fb8e2..b4831f1338db 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -108,6 +108,7 @@ struct machdep_calls {
>  
>  	/* Early exception handlers called in realmode */
>  	int		(*hmi_exception_early)(struct pt_regs *regs);
> +	long		(*machine_check_early)(struct pt_regs *regs);
>  
>  	/* Called during machine check exception to retrive fixup address. */
>  	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index 3a1226e9b465..78a1da95a394 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -210,4 +210,7 @@ extern void release_mce_event(void);
>  extern void machine_check_queue_event(void);
>  extern void machine_check_print_event_info(struct machine_check_event *evt,
>  					   bool user_mode);
> +#ifdef CONFIG_PPC_BOOK3S_64
> +extern void flush_and_reload_slb(void);
> +#endif /* CONFIG_PPC_BOOK3S_64 */
>  #endif /* __ASM_PPC64_MCE_H__ */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 285c6465324a..12f056179112 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -332,6 +332,9 @@ TRAMP_REAL_BEGIN(machine_check_pSeries)
>  machine_check_fwnmi:
>  	SET_SCRATCH0(r13)		/* save r13 */
>  	EXCEPTION_PROLOG_0(PACA_EXMC)
> +BEGIN_FTR_SECTION
> +	b	machine_check_pSeries_early
> +END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
>  machine_check_pSeries_0:
>  	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
>  	/*
> @@ -343,6 +346,103 @@ machine_check_pSeries_0:
>  
>  TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
>  
> +TRAMP_REAL_BEGIN(machine_check_pSeries_early)
> +BEGIN_FTR_SECTION
> +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> +	mr	r10,r1			/* Save r1 */
> +	lhz	r11,PACA_IN_MCE(r13)
> +	cmpwi	r11,0			/* Are we in nested machine check */
> +	bne	0f			/* Yes, we are. */
> +	/* First machine check entry */
> +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
> +0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
> +	addi	r11,r11,1		/* increment paca->in_mce */
> +	sth	r11,PACA_IN_MCE(r13)
> +	/* Limit nested MCE to level 4 to avoid stack overflow */
> +	cmpwi	r11,MAX_MCE_DEPTH
> +	bgt	1f			/* Check if we hit limit of 4 */
> +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
> +	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
> +	EXCEPTION_PROLOG_COMMON_1()
> +	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> +	EXCEPTION_PROLOG_COMMON_3(0x200)
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call ABI */
> +	ld	r12,_MSR(r1)
> +	andi.	r11,r12,MSR_PR		/* See if coming from user. */
> +	bne	2f			/* continue in V mode if we are. */
> +
> +	/*
> +	 * At this point we are not sure about what context we come from.
> +	 * We may be in the middle of swithing stack. r1 may not be valid.
> +	 * Hence stay on emergency stack, call machine_check_exception and
> +	 * return from the interrupt.
> +	 * But before that, check if this is an un-recoverable exception.
> +	 * If yes, then stay on emergency stack and panic.
> +	 */
> +	andi.	r11,r12,MSR_RI
> +	beq	1f
> +
> +	/*
> +	 * Check if we have successfully handled/recovered from error, if not
> +	 * then stay on emergency stack and panic.
> +	 */
> +	cmpdi	r3,0		/* see if we handled MCE successfully */
> +	beq	1f		/* if !handled then panic */
> +
> +	/* Stay on emergency stack and return from interrupt. */
> +	LOAD_HANDLER(r10,mce_return)
> +	mtspr	SPRN_SRR0,r10
> +	ld	r10,PACAKMSR(r13)
> +	mtspr	SPRN_SRR1,r10
> +	RFI_TO_KERNEL
> +	b	.
> +
> +1:	LOAD_HANDLER(r10,unrecover_mce)
> +	mtspr	SPRN_SRR0,r10
> +	ld	r10,PACAKMSR(r13)
> +	/*
> +	 * We are going down. But there are chances that we might get hit by
> +	 * another MCE during panic path and we may run into unstable state
> +	 * with no way out. Hence, turn ME bit off while going down, so that
> +	 * when another MCE is hit during panic path, hypervisor will
> +	 * power cycle the lpar, instead of getting into MCE loop.
> +	 */
> +	li	r3,MSR_ME
> +	andc	r10,r10,r3		/* Turn off MSR_ME */
> +	mtspr	SPRN_SRR1,r10
> +	RFI_TO_KERNEL
> +	b	.
> +
> +	/* Move original SRR0 and SRR1 into the respective regs */
> +2:	ld	r9,_MSR(r1)
> +	mtspr	SPRN_SRR1,r9
> +	ld	r3,_NIP(r1)
> +	mtspr	SPRN_SRR0,r3
> +	ld	r9,_CTR(r1)
> +	mtctr	r9
> +	ld	r9,_XER(r1)
> +	mtxer	r9
> +	ld	r9,_LINK(r1)
> +	mtlr	r9
> +	REST_GPR(0, r1)
> +	REST_8GPRS(2, r1)
> +	REST_GPR(10, r1)
> +	ld	r11,_CCR(r1)
> +	mtcr	r11
> +	/* Decrement paca->in_mce. */
> +	lhz	r12,PACA_IN_MCE(r13)
> +	subi	r12,r12,1
> +	sth	r12,PACA_IN_MCE(r13)
> +	REST_GPR(11, r1)
> +	REST_2GPRS(12, r1)
> +	/* restore original r1. */
> +	ld	r1,GPR1(r1)
> +	SET_SCRATCH0(r13)		/* save r13 */
> +	EXCEPTION_PROLOG_0(PACA_EXMC)
> +	b	machine_check_pSeries_0
> +END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
> +
>  EXC_COMMON_BEGIN(machine_check_common)
>  	/*
>  	 * Machine check is different because we use a different
> @@ -536,6 +636,35 @@ EXC_COMMON_BEGIN(unrecover_mce)
>  	bl	unrecoverable_exception
>  	b	1b
>  
> +EXC_COMMON_BEGIN(mce_return)
> +	/* Invoke machine_check_exception to print MCE event and return. */
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	machine_check_exception
> +	ld	r9,_MSR(r1)
> +	mtspr	SPRN_SRR1,r9
> +	ld	r3,_NIP(r1)
> +	mtspr	SPRN_SRR0,r3
> +	ld	r9,_CTR(r1)
> +	mtctr	r9
> +	ld	r9,_XER(r1)
> +	mtxer	r9
> +	ld	r9,_LINK(r1)
> +	mtlr	r9
> +	REST_GPR(0, r1)
> +	REST_8GPRS(2, r1)
> +	REST_GPR(10, r1)
> +	ld	r11,_CCR(r1)
> +	mtcr	r11
> +	/* Decrement paca->in_mce. */
> +	lhz	r12,PACA_IN_MCE(r13)
> +	subi	r12,r12,1
> +	sth	r12,PACA_IN_MCE(r13)
> +	REST_GPR(11, r1)
> +	REST_2GPRS(12, r1)
> +	/* restore original r1. */
> +	ld	r1,GPR1(r1)
> +	RFI_TO_KERNEL
> +	b	.
>  
>  EXC_REAL(data_access, 0x300, 0x80)
>  EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index efdd16a79075..ae17d8aa60c4 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -488,10 +488,19 @@ long machine_check_early(struct pt_regs *regs)
>  {
>  	long handled = 0;
>  
> -	__this_cpu_inc(irq_stat.mce_exceptions);
> +	/*
> +	 * For pSeries we count mce when we go into virtual mode machine
> +	 * check handler. Hence skip it. Also, We can't access per cpu
> +	 * variables in real mode for LPAR.
> +	 */
> +	if (early_cpu_has_feature(CPU_FTR_HVMODE))
> +		__this_cpu_inc(irq_stat.mce_exceptions);

Could this be moved into powernv's virtual mode handler as well, do you
think?

>  
> -	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
> -		handled = cur_cpu_spec->machine_check_early(regs);
> +	/*
> +	 * See if platform is capable of handling machine check.
> +	 */
> +	if (ppc_md.machine_check_early)
> +		handled = ppc_md.machine_check_early(regs);
>  	return handled;
>  }
>  
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index 368eb23f27c2..135b0b5a702e 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -60,7 +60,7 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>  
>  /* flush SLBs and reload */
>  #ifdef CONFIG_PPC_BOOK3S_64
> -static void flush_and_reload_slb(void)
> +void flush_and_reload_slb(void)
>  {
>  	/* Invalidate all SLBs */
>  	slb_flush_all_realmode();
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index f96df0a25d05..b74c93bc2e55 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -431,6 +431,16 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
>  	return ret_freq;
>  }
>  
> +static long pnv_machine_check_early(struct pt_regs *regs)
> +{
> +	long handled = 0;
> +
> +	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
> +		handled = cur_cpu_spec->machine_check_early(regs);
> +
> +	return handled;
> +}
> +
>  define_machine(powernv) {
>  	.name			= "PowerNV",
>  	.probe			= pnv_probe,
> @@ -442,6 +452,7 @@ define_machine(powernv) {
>  	.machine_shutdown	= pnv_shutdown,
>  	.power_save             = NULL,
>  	.calibrate_decr		= generic_calibrate_decr,
> +	.machine_check_early	= pnv_machine_check_early,
>  #ifdef CONFIG_KEXEC_CORE
>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
>  #endif
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 60db2ee511fb..ec2a5f61d4a4 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -24,6 +24,7 @@ struct pt_regs;
>  
>  extern int pSeries_system_reset_exception(struct pt_regs *regs);
>  extern int pSeries_machine_check_exception(struct pt_regs *regs);
> +extern long pSeries_machine_check_realmode(struct pt_regs *regs);
>  
>  #ifdef CONFIG_SMP
>  extern void smp_init_pseries(void);
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 4a0b201e25aa..73500a24e9c2 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -27,6 +27,7 @@
>  #include <asm/machdep.h>
>  #include <asm/rtas.h>
>  #include <asm/firmware.h>
> +#include <asm/mce.h>
>  
>  #include "pseries.h"
>  
> @@ -523,6 +524,37 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>  	return 0; /* need to perform reset */
>  }
>  
> +static int mce_handle_error(struct rtas_error_log *errp)
> +{
> +	struct pseries_errorlog *pseries_log;
> +	struct pseries_mc_errorlog *mce_log;
> +	int disposition = rtas_error_disposition(errp);
> +	uint8_t error_type;
> +
> +	if (!rtas_error_extended(errp))
> +		goto out;
> +
> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
> +	if (pseries_log == NULL)
> +		goto out;
> +
> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
> +	error_type = mce_log->error_type;
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
> +			(error_type == MC_ERROR_TYPE_SLB)) {
> +		/* Store the old slb content someplace. */
> +		flush_and_reload_slb();
> +		disposition = RTAS_DISP_FULLY_RECOVERED;
> +		rtas_set_disposition_recovered(errp);
> +	}
> +#endif

I suppose this is the right thing to do here, and the hardware or
firmware should upgrade to a UE error if this keeps failing?

For a later patch series, but you could flush the ERAT and recover
ERAT errors here too. TLB would be possible in the guest too when
hypervisor allows tlbie access. For phyp presumably the HV should
take care of flushing the TLB and not pass that down to the guest
(unless there is a guest hypercall to flush the TLB).

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
