Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvG5X4dpRzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 16:12:32 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0559VAI031543
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 00:12:30 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27sctjpax2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 00:12:30 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 10:42:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 05892E0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 10:43:21 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v055CNK539256190
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 10:42:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v055CN8c032377
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 10:42:23 +0530
Received: from [9.121.0.140] (sriharisrinidhi.in.ibm.com [9.121.0.140])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v055CJXa032082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 10:42:19 +0530
Subject: Re: [PATCH v3 2/3] Keep interrupts enabled even on soft disable
To: linuxppc-dev@lists.ozlabs.org
References: <20170105045538.32658-1-bsingharora@gmail.com>
 <20170105045538.32658-3-bsingharora@gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 5 Jan 2017 10:42:19 +0530
MIME-Version: 1.0
In-Reply-To: <20170105045538.32658-3-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <95fadb74-7a2b-f4bc-a554-85a386ea5923@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 05 January 2017 10:25 AM, Balbir Singh wrote:
> This patch removes the disabling of interrupts
> in soft-disable mode, when interrupts are received
> (in lazy mode). The new scheme keeps the interrupts
> enabled when we receive an interrupt and does the
> following:
>
>     When an external interrupt is received, we
>     store the interrupt in local_paca via
>     ppc_md.get_irq(). Later when interrupts are
>     enabled and replayed, we reuse the stored
>     interrupt and process it via generic_handle_irq
>
> NOTE: This works only for PPC_XICS at the moment
> and we'll enable it for XIVE in the future. MPIC/
> OpenPIC is not supported due to the requirement
> that external interrupts/IPIs need unique priorities.
> At the cost of adding more space in the PACA, we
> can store multiple priorities and support more
> controllers, but I think we can live with supporting
> only XICS for now and XIVE in the future.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>   arch/powerpc/include/asm/paca.h      |  1 +
>   arch/powerpc/kernel/exceptions-64s.S | 25 +++++++++++++---
>   arch/powerpc/kernel/irq.c            | 55 ++++++++++++++++++++++++++++++++++--
>   arch/powerpc/kernel/paca.c           |  1 +
>   4 files changed, 76 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 6a6792b..dcbcaa6 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -163,6 +163,7 @@ struct paca_struct {
>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>   	u64 tm_scratch;                 /* TM scratch area for reclaim */
>   #endif
> +	u32 irq;			/* IRQ pending */
>
>   #ifdef CONFIG_PPC_POWERNV
>   	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index d39d611..cf64bc4 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1273,6 +1273,23 @@ EXC_REAL_NONE(0x1800, 0x1900)
>   EXC_VIRT_NONE(0x5800, 0x5900)
>   #endif
>
> +/*
> + * Currently we support keeping interrupts
> + * enabled only for XICS. We can enhance this
> + * as we add support for other controllers
> + */
> +#ifdef CONFIG_PPC_XICS
> +#define MASKED_INTERRUPT_DISABLE(_H)			\
> +	GET_SCRATCH0(r10);				\
> +	std	r13,PACA_EXGEN+EX_R13(r13);		\
> +	EXCEPTION_PROLOG_PSERIES_1(handle_irq_mask, _H);
> +#else
> +#define MASKED_INTERRUPT_DISABLE(_H)			\
> +	mfspr	r10,SPRN_##_H##SRR1;			\
> +	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
> +	rotldi	r10,r10,16;				\
> +	mtspr	SPRN_##_H##SRR1,r10;
> +#endif
>
>   /*
>    * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
> @@ -1287,6 +1304,7 @@ EXC_VIRT_NONE(0x5800, 0x5900)
>   #define MASKED_INTERRUPT(_H)				\
>   masked_##_H##interrupt:					\
>   	std	r11,PACA_EXGEN+EX_R11(r13);		\
> +	std	r12,PACA_EXGEN+EX_R12(r13);		\
>   	lbz	r11,PACAIRQHAPPENED(r13);		\
>   	or	r11,r11,r10;				\
>   	stb	r11,PACAIRQHAPPENED(r13);		\
> @@ -1300,10 +1318,7 @@ masked_##_H##interrupt:					\
>   	beq	2f;					\
>   	cmpwi	r10,PACA_IRQ_HMI;			\
>   	beq	2f;					\
> -	mfspr	r10,SPRN_##_H##SRR1;			\
> -	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
> -	rotldi	r10,r10,16;				\
> -	mtspr	SPRN_##_H##SRR1,r10;			\
> +	MASKED_INTERRUPT_DISABLE(_H)			\
>   2:	mtcrf	0x80,r9;				\
>   	ld	r9,PACA_EXGEN+EX_R9(r13);		\
>   	ld	r10,PACA_EXGEN+EX_R10(r13);		\
> @@ -1321,6 +1336,8 @@ USE_FIXED_SECTION(virt_trampolines)
>   	MASKED_INTERRUPT()
>   	MASKED_INTERRUPT(H)
>
> +EXC_COMMON(handle_irq_mask, 0x500, handle_masked_irq)
> +
>   #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
>   TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
>   	/*
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a018f5c..f34f06b 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -96,7 +96,6 @@ extern int tau_interrupts(int);
>   #ifdef CONFIG_PPC64
>
>   int distribute_irqs = 1;
> -
>   static inline notrace unsigned long get_irq_happened(void)
>   {
>   	unsigned long happened;
> @@ -498,6 +497,54 @@ static inline void check_stack_overflow(void)
>   #endif
>   }
>
> +#ifdef CONFIG_PPC_XICS
> +static inline notrace int get_paca_irq(void)
> +{
> +	int irq;
> +
> +	__asm__ __volatile__("lbz %0,%1(13)"
> +	: "=r" (irq) : "i" (offsetof(struct paca_struct, irq)));
> +
> +	return irq;
> +}
> +
> +static inline notrace void set_paca_irq(int irq)
> +{
> +	__asm__ __volatile__("stb %0,%1(13)"
> +	: : "r" (irq), "i" (offsetof(struct paca_struct, irq)));
Can we add "memory" to the clobber list, since you are writing
to PACA?

> +}
> +
> +void handle_masked_irq(struct pt_regs *regs)
> +{
> +	/*
> +	 * TODO: Add support for XIVE as applicable
> +	 */
> +	unsigned int irq;
> +	/*
> +	 * NOTE, we don't use irq_enter/exit, otherwise
> +	 * our accounting and tracing might be incorrect.
> +	 */
> +	irq = ppc_md.get_irq();
> +
> +	/*
> +	 * Store away irq in PACA for replay later
> +	 */
> +	set_paca_irq(irq);
> +}
> +
> +#else
> +
> +static inline notrace int get_paca_irq(void)
> +{
> +	return -1;
> +}
> +
> +static inline notrace void set_paca_irq(int irq)
> +{
> +}
> +
> +#endif /* CONFIG_PPC_XICS */
> +
>   void __do_irq(struct pt_regs *regs)
>   {
>   	unsigned int irq;
> @@ -513,7 +560,11 @@ void __do_irq(struct pt_regs *regs)
>   	 *
>   	 * This will typically lower the interrupt line to the CPU
>   	 */
> -	irq = ppc_md.get_irq();
> +	irq = get_paca_irq();
> +	if (irq != -1)
> +		set_paca_irq(-1);
> +	else
> +		irq = ppc_md.get_irq();
>
>   	/* We can hard enable interrupts now to allow perf interrupts */
>   	may_hard_irq_enable();
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index fa20060..2ad6108 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -168,6 +168,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
>   	/* For now -- if we have threads this will be adjusted later */
>   	new_paca->tcd_ptr = &new_paca->tcd;
>   #endif
> +	new_paca->irq = -1;
>   }
>
>   /* Put the paca pointer into r13 and SPRG_PACA */
