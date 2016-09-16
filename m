Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbBV548CGzDsZW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:34:21 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id pp5so3336258pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:34:21 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:34:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/13] powerpc: Add a Kconfig and a functions to set new
 soft_enabled mask
Message-ID: <20160916203411.5f0cab34@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-13-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-13-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:32:02 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add warn_on
> to alert the invalid transitions. Have also moved the code under
> the CONFIG_TRACE_IRQFLAGS in arch_local_irq_restore() to new Kconfig
> as suggested.

I can't tempt you to put the Kconfig changes into their own patch? :)


> To support disabling and enabling of irq with PMI, set of
> new powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
> functions are added. And powerpc_local_irq_save() implemented,
> by adding a new soft_enabled manipulation function soft_enabled_or_return().
> Local_irq_pmu_* macros are provided to access these powerpc_local_irq_pmu*
> functions which includes trace_hardirqs_on|off() to match what we
> have in include/linux/irqflags.h.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> @@ -81,6 +81,20 @@ static inline notrace unsigned long soft_enabled_set_return(unsigned long enable
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
> +		  "r" (enable)
> +		: "memory");
> +
> +	return flags;
> +}

Another candidate for builtin_constification using immediates. And do you
actually need the initial mr instruction there?


> @@ -105,7 +119,7 @@ static inline unsigned long arch_local_irq_save(void)
>  
>  static inline bool arch_irqs_disabled_flags(unsigned long flags)
>  {
> -	return flags == IRQ_DISABLE_MASK_LINUX;
> +	return (flags);
>  }
>  
>  static inline bool arch_irqs_disabled(void)

This part logically belongs in patch 11, but it also needs to be changed,
I think? Keep in mind it's the generic kernel asking whether it has "Linux
interrupts" disabled.

    return flags & IRQ_DISABLE_MASK_LINUX;

> @@ -113,6 +127,59 @@ static inline bool arch_irqs_disabled(void)
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
>  
> +static inline void powerpc_local_irq_pmu_restore(unsigned long flags)
> +{
> +	arch_local_irq_restore(flags);
> +}
> +
> +static inline unsigned long powerpc_local_irq_pmu_disable(void)
> +{
> +	return soft_enabled_or_return(IRQ_DISABLE_MASK_LINUX | IRQ_DISABLE_MASK_PMU);
> +}
> +
> +static inline unsigned long powerpc_local_irq_pmu_save(void)
> +{
> +	return powerpc_local_irq_pmu_disable();
> +}
> +
> +#define raw_local_irq_pmu_save(flags)					\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		flags = powerpc_local_irq_pmu_save();			\
> +	} while(0)
> +
> +#define raw_local_irq_pmu_restore(flags)				\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		powerpc_local_irq_pmu_restore(flags);			\
> +	} while(0)
> +
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +#define local_irq_pmu_save(flags)		\
> +	do {					\
> +		raw_local_irq_pmu_save(flags);	\
> +		trace_hardirqs_off();		\
> +	} while(0)
> +#define local_irq_pmu_restore(flags)			\
> +	do {						\
> +		if (raw_irqs_disabled_flags(flags)) {   \
> +			raw_local_irq_pmu_restore(flags);\
> +			trace_hardirqs_off();		\
> +		} else {				\
> +			trace_hardirqs_on();		\
> +			raw_local_irq_pmu_restore(flags);\
> +		}					\
> +	} while(0)
> +#else
> +#define local_irq_pmu_save(flags)		\
> +	do {					\
> +		raw_local_irq_pmu_save(flags);	\
> +	} while(0)
> +#define local_irq_pmu_restore(flags)			\
> +	do { raw_local_irq_pmu_restore(flags); } while (0)
> +#endif /* CONFIG_TRACE_IRQFLAGS */
> +
> +

This looks pretty good. When I suggested powerpc_ prefix, I intended in these
functions here, so it wouldn't match with the local_irq_ namespace of generic
kernel. But that was just an idea. If you prefer to do it this way, could you
just drop the powerpc_ wrappers entirely?

A comment above that says it comes from the generic Linux local_irq code
might be an idea too.

Provided at least the arch_irqs_disabled_flags comment gets addressed:

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
