Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 624A0DDF15
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 05:24:11 +1000 (EST)
Message-ID: <468D45CD.1080008@ru.mvista.com>
Date: Thu, 05 Jul 2007 23:26:05 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: powerpc stacktrace and lockdep support
References: <20070108135458.GA23395@lst.de>	<1182898073.4769.6.camel@johannes.berg>	<1182970829.4769.62.camel@johannes.berg>
	<1183047642.3735.0.camel@johannes.berg>
In-Reply-To: <1183047642.3735.0.camel@johannes.berg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg wrote:
> This one doesn't break 32-bit build by simply disabling irqtrace for
> 32-bit.

> --- linux-2.6-git32.orig/include/asm-powerpc/hw_irq.h	2007-06-28 14:53:58.730430447 +0200
> +++ linux-2.6-git32/include/asm-powerpc/hw_irq.h	2007-06-28 14:58:41.508430447 +0200
> @@ -27,7 +27,7 @@ static inline unsigned long local_get_fl
>  	return flags;
>  }
>  
> -static inline unsigned long local_irq_disable(void)
> +static inline unsigned long raw_local_irq_disable(void)
>  {
>  	unsigned long flags, zero;
>  
> @@ -39,14 +39,15 @@ static inline unsigned long local_irq_di
>  	return flags;
>  }
>  
> -extern void local_irq_restore(unsigned long);
> +extern void raw_local_irq_restore(unsigned long);
>  extern void iseries_handle_interrupts(void);
>  
> -#define local_irq_enable()	local_irq_restore(1)
> -#define local_save_flags(flags)	((flags) = local_get_flags())
> -#define local_irq_save(flags)	((flags) = local_irq_disable())
> +#define raw_local_irq_enable()	raw_local_irq_restore(1)
> +#define raw_local_save_flags(flags)	((flags) = local_get_flags())
> +#define raw_local_irq_save(flags)	((flags) = raw_local_irq_disable())
>  
> -#define irqs_disabled()		(local_get_flags() == 0)
> +#define raw_irqs_disabled()		(local_get_flags() == 0)
> +#define raw_irqs_disabled_flags(flags)		((flags) == 0)
>  
>  #define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
>  #define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
> @@ -108,6 +109,7 @@ static inline void local_irq_save_ptr(un
>  #define local_save_flags(flags)	((flags) = mfmsr())
>  #define local_irq_save(flags)	local_irq_save_ptr(&flags)
>  #define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
> +#define irqs_disabled_flags(flags)		(((flags) & MSR_EE) == 0)
>  
>  #define hard_irq_enable()	local_irq_enable()
>  #define hard_irq_disable()	local_irq_disable()
> --- linux-2.6-git32.orig/include/asm-powerpc/irqflags.h	2007-06-28 14:53:58.779430447 +0200
> +++ linux-2.6-git32/include/asm-powerpc/irqflags.h	2007-06-28 14:52:51.821430447 +0200
> @@ -15,17 +15,4 @@
>   */
>  #include <asm-powerpc/hw_irq.h>
>  
> -/*
> - * Do the CPU's IRQ-state tracing from assembly code. We call a
> - * C function, so save all the C-clobbered registers:
> - */
> -#ifdef CONFIG_TRACE_IRQFLAGS
> -
> -#error No support on PowerPC yet for CONFIG_TRACE_IRQFLAGS
> -
> -#else
> -# define TRACE_IRQS_ON
> -# define TRACE_IRQS_OFF
> -#endif
> -
>  #endif

    I suggest to also remove these 3 lines from the heading comment in this 
file -- they're not true anyway:

  * This file gets included from lowlevel asm headers too, to provide
  * wrapped versions of the local_irq_*() APIs, based on the
  * raw_local_irq_*() macros from the lowlevel headers.

> --- linux-2.6-git32.orig/arch/powerpc/kernel/head_64.S	2007-06-28 14:53:58.679430447 +0200
> +++ linux-2.6-git32/arch/powerpc/kernel/head_64.S	2007-06-28 14:48:33.858430447 +0200
> @@ -394,6 +394,12 @@ label##_iSeries:							\
>  	EXCEPTION_PROLOG_ISERIES_2;					\
>  	b	label##_common;						\
>  
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +#define TRACE_DISABLE_INTS bl .powerpc_trace_hardirqs_off
> +#else
> +#define TRACE_DISABLE_INTS
> +#endif
> +

    Erm, weren't those supposed to be in <asm-powerpc/irqflags.h>?

>  #ifdef CONFIG_PPC_ISERIES
>  #define DISABLE_INTS				\
>  	li	r11,0;				\
> @@ -405,14 +411,15 @@ BEGIN_FW_FTR_SECTION;				\
>  	mfmsr	r10;				\
>  	ori	r10,r10,MSR_EE;			\
>  	mtmsrd	r10,1;				\
> -END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
> +END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES);	\
> +	TRACE_DISABLE_INTS
>  
>  #else
>  #define DISABLE_INTS				\
>  	li	r11,0;				\
>  	stb	r11,PACASOFTIRQEN(r13);		\
> -	stb	r11,PACAHARDIRQEN(r13)
> -
> +	stb	r11,PACAHARDIRQEN(r13);		\
> +	TRACE_DISABLE_INTS
>  #endif /* CONFIG_PPC_ISERIES */
>  
>  #define ENABLE_INTS				\
> @@ -965,24 +972,38 @@ bad_stack:

    The following code seemed over-engineered:

>   */
>  fast_exc_return_irq:			/* restores irq state too */
>  	ld	r3,SOFTE(r1)
> -	ld	r12,_MSR(r1)
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	cmpdi	r3,0
> +	beq	1f
> +	bl	.trace_hardirqs_on

	b 	2f
1:

> +	bl	.trace_hardirqs_off

2:

> +	ld	r3,SOFTE(r1)
> +#endif
	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
> +	ld	r12,_MSR(r1)
>  	rldicl	r4,r12,49,63		/* get MSR_EE to LSB */
>  	stb	r4,PACAHARDIRQEN(r13)	/* restore paca->hard_enabled */
> -	b	1f
> +	b	3f

[...]

> --- linux-2.6-git32.orig/arch/powerpc/kernel/entry_64.S	2007-06-28 14:53:58.729430447 +0200
> +++ linux-2.6-git32/arch/powerpc/kernel/entry_64.S	2007-06-28 14:49:13.125430447 +0200
[...]
> @@ -491,8 +498,20 @@ BEGIN_FW_FTR_SECTION
>  4:
>  END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
>  #endif
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	cmpdi	r5,0
> +	beq	5f
> +	bl	.trace_hardirqs_on
> +	ld	r5,SOFTE(r1)
>  	stb	r5,PACASOFTIRQEN(r13)
> -
> +	b	6f
> +5:
> +	stb	r5,PACASOFTIRQEN(r13)
> +	bl	.trace_hardirqs_off
> +6:
> +#else
> +	stb	r5,PACASOFTIRQEN(r13)
> +#endif

    Again, could have been more compact... unless trace_hardirqs_*() calls 
need to be in certain order WRT writes to PACASOFTIRQEN -- if so, in the 1st 
case that I've pointed out the order was not identical (probably wrong?)...

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6-git32/arch/powerpc/kernel/irqtrace.S	2007-06-28 14:49:25.754430447 +0200
> @@ -0,0 +1,47 @@
> +/*
> + * crappy helper for irq-trace
> + */
> +
> +#include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
> +
> +#define STACKSPACE	GPR0 + 16*8

    I guess this should be 16*4 for PPC32.

> +
> +#ifdef __powerpc64__
> +#define ST	std
> +#define L	ld
> +#else
> +#define ST	stw
> +#define L	lw
> +#endif
> +
> +#define PRE				\
> +	subi	r1,r1,STACKSPACE ;	\
> +	SAVE_GPR(0, r1) ;		\
> +	SAVE_8GPRS(2, r1) ;		\
> +	SAVE_4GPRS(10, r1) ;		\
> +	mfcr	r0 ;			\
> +	ST	r0, (14*8)(r1) ;	\
> +	mflr	r0 ;			\
> +	ST	r0, (15*8)(r1)

    Didn't you forget to add GPR0 to the offsets here?

> +#define POST				\
> +	REST_8GPRS(2, r1) ;		\
> +	REST_4GPRS(10, r1) ;		\
> +	L	r0, (14*8)(r1) ;	\
> +	mtcr	r0 ;			\
> +	L	r0, (15*8)(r1) ;	\
> +	mtlr	r0 ;			\
> +	REST_GPR(0, r1) ;		\
> +	addi	r1,r1,STACKSPACE

    You certainly did. I bet you're clobbering GPR11/12 (if I didn't miscount)...

WBR, Sergei
