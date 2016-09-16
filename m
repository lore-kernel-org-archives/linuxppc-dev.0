Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbB5T5zCNzDsck
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:16:29 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q2so804900pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:16:29 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:16:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/13] powerpc: Introduce new mask bit for soft_enabled
Message-ID: <20160916201620.7c927e60@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-10-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-10-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:59 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Currently soft_enabled is used as the flag to determine
> the interrupt state. Patch extends the soft_enabled
> to be used as a mask instead of a flag.

This should be the title of the patch, IMO. Introducing the new
mask bit is incidental (and could be moved to patch 11). The key
here of course is switching the tests from a flag to a mask.

Very cool that you got this all worked out without adding any
new instructions.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 4 ++--
>  arch/powerpc/include/asm/hw_irq.h        | 1 +
>  arch/powerpc/include/asm/irqflags.h      | 4 ++--
>  arch/powerpc/kernel/entry_64.S           | 4 ++--
>  arch/powerpc/kernel/exceptions-64e.S     | 6 +++---
>  5 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index dd3253bd0d8e..1eea4ab75607 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -430,9 +430,9 @@ label##_relon_hv:						\
>  
>  #define __SOFTEN_TEST(h, vec)						\
>  	lbz	r10,PACASOFTIRQEN(r13);					\
> -	cmpwi	r10,IRQ_DISABLE_MASK_LINUX;							\
> +	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
>  	li	r10,SOFTEN_VALUE_##vec;					\
> -	beq	masked_##h##interrupt
> +	bne	masked_##h##interrupt
>  #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
>  
>  #define SOFTEN_TEST_PR(vec)						\
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index fd9b421f9020..245262c02bab 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -32,6 +32,7 @@
>   */
>  #define IRQ_DISABLE_MASK_NONE		0
>  #define IRQ_DISABLE_MASK_LINUX		1
> +#define IRQ_DISABLE_MASK_PMU		2
>  
>  #endif /* CONFIG_PPC64 */
>  
> diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
> index d0ed2a7d7d10..9ff09747a226 100644
> --- a/arch/powerpc/include/asm/irqflags.h
> +++ b/arch/powerpc/include/asm/irqflags.h
> @@ -48,11 +48,11 @@
>  #define RECONCILE_IRQ_STATE(__rA, __rB)		\
>  	lbz	__rA,PACASOFTIRQEN(r13);	\
>  	lbz	__rB,PACAIRQHAPPENED(r13);	\
> -	cmpwi	cr0,__rA,IRQ_DISABLE_MASK_LINUX;\
> +	andi.	__rA,__rA,IRQ_DISABLE_MASK_LINUX;\
>  	li	__rA,IRQ_DISABLE_MASK_LINUX;	\
>  	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
>  	stb	__rB,PACAIRQHAPPENED(r13);	\
> -	beq	44f;				\
> +	bne	44f;				\
>  	stb	__rA,PACASOFTIRQEN(r13);	\
>  	TRACE_DISABLE_INTS;			\
>  44:
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 879aeb11ad29..533e363914a9 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -764,8 +764,8 @@ restore:
>  	 */
>  	ld	r5,SOFTE(r1)
>  	lbz	r6,PACASOFTIRQEN(r13)
> -	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
> -	beq	restore_irq_off
> +	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
> +	bne	restore_irq_off
>  
>  	/* We are enabling, were we already enabled ? Yes, just return */
>  	cmpwi	cr0,r6,IRQ_DISABLE_MASK_NONE
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 5c628b5696f6..8e40df2c2f30 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -212,8 +212,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>  	/* Interrupts had better not already be enabled... */
>  	twnei	r6,IRQ_DISABLE_MASK_LINUX
>  
> -	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
> -	beq	1f
> +	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
> +	bne	1f
>  
>  	TRACE_ENABLE_INTS
>  	stb	r5,PACASOFTIRQEN(r13)
> @@ -352,7 +352,7 @@ ret_from_mc_except:
>  
>  #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
>  	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
> -	cmpwi	cr0,r10,IRQ_DISABLE_MASK_LINUX;/* yes -> go out of line */ \
> +	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;/* yes -> go out of line */ \
>  	beq	masked_interrupt_book3e_##n
>  
>  #define PROLOG_ADDITION_2REGS_GEN(n)					    \
