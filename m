Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2sPk4QtXzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 18:07:22 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id q2so9493478pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 01:07:22 -0700 (PDT)
Date: Mon, 1 Aug 2016 18:07:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 10/11] powerpc: Support to replay PMIs
Message-ID: <20160801180716.5d0a47de@roar.ozlabs.ibm.com>
In-Reply-To: <1469991989-28409-11-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-11-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon,  1 Aug 2016 00:36:28 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Code to replay the Performance Monitoring Interrupts(PMI).
> In the masked_interrupt handler, for PMIs we reset the MSR[EE]
> and return. This is due the fact that PMIs are level triggered.
> In the __check_irq_replay(), we enabled the MSR[EE] which will
> fire the interrupt for us.
> 
> Patch also adds a new arch_local_irq_disable_var() variant. New
> variant takes an input value to write to the paca->soft_enabled.
> This will be used in following patch to implement the tri-state
> value for soft-enabled.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 14 ++++++++++++++
>  arch/powerpc/kernel/irq.c         |  9 ++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index a7b86edc94bf..9f235d25b9f8 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -84,6 +84,20 @@ static inline unsigned long arch_local_irq_disable(void)
>  	return flags;
>  }
>  
> +static inline unsigned long soft_irq_set_level(int value)
> +{
> +	unsigned long flags, zero;
> +
> +	asm volatile(
> +		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
> +		: "=r" (flags), "=&r" (zero)
> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> +		  "i" (value)
> +		: "memory");
> +
> +	return flags;
> +}
> +
>  extern void arch_local_irq_restore(unsigned long);
>  
>  static inline void arch_local_irq_enable(void)
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 857e1e8188e5..9d70e51db8bc 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -158,9 +158,16 @@ notrace unsigned int __check_irq_replay(void)
>  	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
>  		return 0x900;
>  
> +	/*
> +	 * In masked_handler() for PMI, we disable MSR[EE] and return.
> +	 * When replaying it, just enabling the MSR[EE] will do
> +	 * trick, since the PMI are "level" triggered.
> +	 */
> +	local_paca->irq_happened &= ~PACA_IRQ_PMI;
> +
>  	/* Finally check if an external interrupt happened */
>  	local_paca->irq_happened &= ~PACA_IRQ_EE;
> -	if (happened & PACA_IRQ_EE)
> +	if ((happened & PACA_IRQ_EE) || (happened & PACA_IRQ_PMI))
>  		return 0x500;

This will replay hardware_interrupt_common in the case we got a PMI
interrupt but no EE.

Should we just follow the normal pattern here, return 0xf00 for PMI,
and replay the same as the other cases?

Thanks,
Nick
