Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjMXY68hZzDwPm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 13:43:09 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id i5so533929pgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 18:43:09 -0800 (PST)
Date: Tue, 20 Dec 2016 12:42:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 10/12] powerpc: Add new set of soft_enabled_ functions
Message-ID: <20161220124248.1019356c@roar.ozlabs.ibm.com>
In-Reply-To: <1482134828-18811-11-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-11-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 19 Dec 2016 13:37:06 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> To support disabling and enabling of irq with PMI, set of
> new powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
> functions are added. And powerpc_local_irq_save() implemented,
> by adding a new soft_enabled manipulation function soft_enabled_or_return().
> Local_irq_pmu_* macros are provided to access these powerpc_local_irq_pmu*
> functions which includes trace_hardirqs_on|off() to match what we
> have in include/linux/irqflags.h.

These macros look good. There's a couple of hunks which maybe
could be moved to other patches in the series. Probably not a
big deal, but again if you resubmit.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 62 ++++++++++++++++++++++++++++++++++++++-
>  arch/powerpc/kernel/irq.c         |  4 +++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index ac9a17ea1d66..7be90b73a943 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -90,6 +90,20 @@ static inline notrace unsigned long soft_enabled_set_return(unsigned long enable
>  	return flags;
>  }
>  
> +static inline notrace unsigned long soft_enabled_or_return(unsigned long enable)
> +{
> +	unsigned long flags, zero;
> +
> +	asm volatile(
> +		"mr %1,%3; lbz %0,%2(13); or %1,%0,%1; stb %1,%2(13)"
> +		: "=r" (flags), "=&r"(zero)
> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> +		 "r" (enable)
> +		: "memory");
> +
> +	return flags;
> +}
> +
>  static inline unsigned long arch_local_save_flags(void)
>  {
>  	return soft_enabled_return();
> @@ -114,7 +128,7 @@ static inline unsigned long arch_local_irq_save(void)
>  
>  static inline bool arch_irqs_disabled_flags(unsigned long flags)
>  {
> -	return flags == IRQ_DISABLE_MASK_LINUX;
> +	return flags & IRQ_DISABLE_MASK_LINUX;
>  }
>  
>  static inline bool arch_irqs_disabled(void)
> @@ -122,6 +136,52 @@ static inline bool arch_irqs_disabled(void)
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
>  
> +/*
> + * To support disabling and enabling of irq with PMI, set of
> + * new powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
> + * functions are added. These macros are implemented using generic
> + * linux local_irq_* code from include/linux/irqflags.h.
> + */
> +#define raw_local_irq_pmu_save(flags)					\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		flags = soft_enabled_or_return(IRQ_DISABLE_MASK_LINUX | \
> +				IRQ_DISABLE_MASK_PMU);			\
> +	} while(0)
> +
> +#define raw_local_irq_pmu_restore(flags)				\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		arch_local_irq_restore(flags);				\
> +	} while(0)
> +
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +#define powerpc_local_irq_pmu_save(flags)			\
> +	 do {							\
> +		raw_local_irq_pmu_save(flags);			\
> +		trace_hardirqs_off();				\
> +	} while(0)
> +#define powerpc_local_irq_pmu_restore(flags)			\
> +	do {							\
> +		if (raw_irqs_disabled_flags(flags)) {		\
> +			raw_local_irq_pmu_restore(flags);	\
> +			trace_hardirqs_off();			\
> +		} else {					\
> +			trace_hardirqs_on();			\
> +			raw_local_irq_pmu_restore(flags);	\
> +		}						\
> +	} while(0)
> +#else
> +#define powerpc_local_irq_pmu_save(flags)			\
> +	do {							\
> +		raw_local_irq_pmu_save(flags);			\
> +	} while(0)
> +#define powerpc_local_irq_pmu_restore(flags)			\
> +	do {							\
> +		raw_local_irq_pmu_restore(flags);		\
> +	} while (0)
> +#endif  /* CONFIG_TRACE_IRQFLAGS */
> +
>  #ifdef CONFIG_PPC_BOOK3E
>  #define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory")
>  #define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory")
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 299b55071612..9010f996e238 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -227,6 +227,10 @@ notrace void arch_local_irq_restore(unsigned long en)
>  	unsigned char irq_happened;
>  	unsigned int replay;
>  
> +#ifdef CONFIG_IRQ_DEBUG_SUPPORT
> +	WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX);
> +#endif
> +
>  	/* Write the new soft-enabled value */
>  	soft_enabled_set(en);
>  
