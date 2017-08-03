Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNHXd3hm4zDqpt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 14:44:49 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so433635pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 21:44:49 -0700 (PDT)
Date: Thu, 3 Aug 2017 14:44:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 07/14] powerpc: Modify soft_enable from flag to mask
Message-ID: <20170803144430.179392b1@roar.ozlabs.ibm.com>
In-Reply-To: <1501732158-19009-8-git-send-email-maddy@linux.vnet.ibm.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1501732158-19009-8-git-send-email-maddy@linux.vnet.ibm.com>
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

Hi Maddy,

I've gone over this series a few times and it looks pretty good
to me. I'd like others to have a look before I do any more bike
shedding of it :)

Just with this one there are still a couple of places where this
is comparing the entire mask and not the LINUX bit:

> @@ -156,7 +156,7 @@ static inline void may_hard_irq_enable(void)
>  
>  static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
>  {
> -	return (regs->softe == IRQ_DISABLED);
> +	return (regs->softe == IRQ_DISABLE_MASK_LINUX);
>  }
>  
>  extern bool prep_irq_for_idle(void);


> @@ -767,7 +766,7 @@ resume_kernel:
>  	lwz	r8,TI_PREEMPT(r9)
>  	cmpwi	cr1,r8,0
>  	ld	r0,SOFTE(r1)
> -	cmpdi	r0,IRQ_DISABLED
> +	cmpdi	r0,IRQ_DISABLE_MASK_LINUX
>  	crandc	eq,cr1*4+eq,eq
>  	bne	restore
>  
> @@ -807,11 +806,11 @@ restore:
>  	 */
>  	ld	r5,SOFTE(r1)
>  	lbz	r6,PACASOFTIRQEN(r13)
> -	cmpwi	cr0,r5,IRQ_DISABLED
> -	beq	.Lrestore_irq_off
> +	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
> +	bne	.Lrestore_irq_off
>  
>  	/* We are enabling, were we already enabled ? Yes, just return */
> -	cmpwi	cr0,r6,IRQ_ENABLED
> +	cmpwi	cr0,r6,IRQ_DISABLE_MASK_NONE
>  	beq	cr0,.Ldo_restore
>  
>  	/*

> @@ -207,7 +207,7 @@ notrace void arch_local_irq_restore(unsigned long en)
>  
>  	/* Write the new soft-enabled value */
>  	soft_enabled_set(en);
> -	if (en == IRQ_DISABLED)
> +	if (en == IRQ_DISABLE_MASK_LINUX)
>  		return;
>  	/*
>  	 * From this point onward, we can take interrupts, preempt,

^^ This one is fixed in patch 11, but that should be done here.


> @@ -322,7 +322,7 @@ static inline void perf_read_regs(struct pt_regs *regs)
>   */
>  static inline int perf_intr_is_nmi(struct pt_regs *regs)
>  {
> -	return (regs->softe == IRQ_DISABLED);
> +	return (regs->softe == IRQ_DISABLE_MASK_LINUX);
>  }
>  
>  /*
