Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F8AAB6EFF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2012 08:10:38 +1100 (EST)
Message-ID: <1326921026.26116.34.camel@pasglop>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Date: Thu, 19 Jan 2012 08:10:26 +1100
In-Reply-To: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-01-18 at 16:35 +0200, Laurentiu Tudor wrote:
> This patch adds a menuconfig option that allows controlling
> the lazy interrupt disabling feature implemented by this
> commit:
> 
> commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
> Author: Paul Mackerras
> Date:   Wed Oct 4 16:47:49 2006 +1000
> 
>     [POWERPC] Lazy interrupt disabling for 64-bit machines
> 
> The code in 'powerpc/include/asm/hw_irq.h' was rearranged and
> cleaned-up a bit in order to reduce the number of needed #ifdef's.

It's still nasty. Do you have numbers showing that it's worth disabling
on BookE ?

Cheers,
Ben.

> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> ---
> Patch is against
> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
> 
>  arch/powerpc/Kconfig                 |   16 ++++++
>  arch/powerpc/include/asm/hw_irq.h    |   86 ++++++++++++++--------------------
>  arch/powerpc/include/asm/irqflags.h  |   22 +++++++++
>  arch/powerpc/include/asm/paca.h      |    4 ++
>  arch/powerpc/kernel/asm-offsets.c    |    3 +
>  arch/powerpc/kernel/entry_64.S       |    4 ++
>  arch/powerpc/kernel/exceptions-64e.S |   36 +++++++++++---
>  arch/powerpc/kernel/head_64.S        |   10 ++++
>  arch/powerpc/kernel/idle_book3e.S    |    7 +++
>  arch/powerpc/kernel/irq.c            |    5 ++
>  arch/powerpc/kernel/setup_64.c       |    2 +
>  11 files changed, 138 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index ce5e045..2792278 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -609,6 +609,22 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config PPC_LAZY_EE
> +	bool
> +	prompt "Lazy interrupt disabling" if PPC_BOOK3E_64
> +	default y if PPC_BOOK3S_64
> +	help
> +	  Local interrupt disabling functions don't disable
> +	  interrupts right away and instead just clear an
> +	  internal 'interrupts are enabled' flag. If an
> +	  interrupt is triggered during this time, the
> +	  interrupt handling code checks the flag, and if
> +	  interrupts are supposed to be off, disables them
> +	  for real and returns, skipping interrupt handling.
> +	  When interrupts are enabled back, the interrupt
> +	  fires again and this time gets handled.
> +
> +	  If unsure, say N.
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index bb712c9..6f32593 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -13,7 +13,20 @@
>  
>  extern void timer_interrupt(struct pt_regs *);
>  
> +#ifdef CONFIG_BOOKE
> +#define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory");
> +#define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory");
> +#else
>  #ifdef CONFIG_PPC64
> +#define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
> +#define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
> +#else
> +#define __hard_irq_enable()	mtmsr(mfmsr() | MSR_EE)
> +#define __hard_irq_disable()	mtmsr(mfmsr() & ~MSR_EE)
> +#endif
> +#endif /* CONFIG_BOOKE */
> +
> +#if defined(CONFIG_PPC64) && defined(CONFIG_PPC_LAZY_EE)
>  #include <asm/paca.h>
>  
>  static inline unsigned long arch_local_save_flags(void)
> @@ -49,9 +62,11 @@ static inline void arch_local_irq_enable(void)
>  	arch_local_irq_restore(1);
>  }
>  
> -static inline unsigned long arch_local_irq_save(void)
> +static inline void hard_irq_disable(void)
>  {
> -	return arch_local_irq_disable();
> +	__hard_irq_disable();
> +	get_paca()->soft_enabled = 0;
> +	get_paca()->hard_enabled = 0;
>  }
>  
>  static inline bool arch_irqs_disabled_flags(unsigned long flags)
> @@ -59,29 +74,7 @@ static inline bool arch_irqs_disabled_flags(unsigned long flags)
>  	return flags == 0;
>  }
>  
> -static inline bool arch_irqs_disabled(void)
> -{
> -	return arch_irqs_disabled_flags(arch_local_save_flags());
> -}
> -
> -#ifdef CONFIG_PPC_BOOK3E
> -#define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory");
> -#define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory");
> -#else
> -#define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
> -#define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
> -#endif
> -
> -#define  hard_irq_disable()			\
> -	do {					\
> -		__hard_irq_disable();		\
> -		get_paca()->soft_enabled = 0;	\
> -		get_paca()->hard_enabled = 0;	\
> -	} while(0)
> -
> -#else /* CONFIG_PPC64 */
> -
> -#define SET_MSR_EE(x)	mtmsr(x)
> +#else /* CONFIG_PPC64 && CONFIG_PPC_LAZY_EE */
>  
>  static inline unsigned long arch_local_save_flags(void)
>  {
> @@ -97,34 +90,24 @@ static inline void arch_local_irq_restore(unsigned long flags)
>  #endif
>  }
>  
> -static inline unsigned long arch_local_irq_save(void)
> +static inline void arch_local_irq_enable(void)
>  {
> -	unsigned long flags = arch_local_save_flags();
> -#ifdef CONFIG_BOOKE
> -	asm volatile("wrteei 0" : : : "memory");
> -#else
> -	SET_MSR_EE(flags & ~MSR_EE);
> -#endif
> -	return flags;
> +	__hard_irq_enable();
>  }
>  
> -static inline void arch_local_irq_disable(void)
> +static inline unsigned long arch_local_irq_disable(void)
>  {
> -#ifdef CONFIG_BOOKE
> -	asm volatile("wrteei 0" : : : "memory");
> -#else
> -	arch_local_irq_save();
> -#endif
> +	unsigned long flags;
> +
> +	flags = arch_local_save_flags();
> +	__hard_irq_disable();
> +
> +	return flags;
>  }
>  
> -static inline void arch_local_irq_enable(void)
> +static inline void hard_irq_disable(void)
>  {
> -#ifdef CONFIG_BOOKE
> -	asm volatile("wrteei 1" : : : "memory");
> -#else
> -	unsigned long msr = mfmsr();
> -	SET_MSR_EE(msr | MSR_EE);
> -#endif
> +	__hard_irq_disable();
>  }
>  
>  static inline bool arch_irqs_disabled_flags(unsigned long flags)
> @@ -132,15 +115,18 @@ static inline bool arch_irqs_disabled_flags(unsigned long flags)
>  	return (flags & MSR_EE) == 0;
>  }
>  
> +#endif /* CONFIG_PPC64 && CONFIG_PPC_LAZY_EE */
> +
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +	return arch_local_irq_disable();
> +}
> +
>  static inline bool arch_irqs_disabled(void)
>  {
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
>  
> -#define hard_irq_disable()		arch_local_irq_disable()
> -
> -#endif /* CONFIG_PPC64 */
> -
>  #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
>  
>  /*
> diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
> index b0b06d8..9685b75c 100644
> --- a/arch/powerpc/include/asm/irqflags.h
> +++ b/arch/powerpc/include/asm/irqflags.h
> @@ -39,6 +39,8 @@
>  #define TRACE_ENABLE_INTS	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_on)
>  #define TRACE_DISABLE_INTS	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_off)
>  
> +#ifdef CONFIG_PPC_LAZY_EE
> +
>  #define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)		\
>  	cmpdi	en,0;					\
>  	bne	95f;					\
> @@ -51,12 +53,32 @@
>  	TRACE_AND_RESTORE_IRQ_PARTIAL(en,96f);	\
>  	stb	en,PACASOFTIRQEN(r13);		\
>  96:
> +
> +#else /* CONFIG_PPC_LAZY_EE */
> +
> +#define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)		\
> +	cmpdi	en,0;					\
> +	bne	95f;					\
> +	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_off)	\
> +	b	skip;					\
> +95:	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_on)	\
> +	li	en,1;
> +#define TRACE_AND_RESTORE_IRQ(en)		\
> +	TRACE_AND_RESTORE_IRQ_PARTIAL(en,96f);	\
> +96:
> +
> +#endif /* CONFIG_PPC_LAZY_EE */
> +
>  #else
>  #define TRACE_ENABLE_INTS
>  #define TRACE_DISABLE_INTS
>  #define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)
> +#ifdef CONFIG_PPC_LAZY_EE
>  #define TRACE_AND_RESTORE_IRQ(en)		\
>  	stb	en,PACASOFTIRQEN(r13)
> +#else
> +#define TRACE_AND_RESTORE_IRQ(en)
> +#endif
>  #endif
>  #endif
>  
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 269c05a..b74c2b1 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -131,8 +131,12 @@ struct paca_struct {
>  	u64 saved_r1;			/* r1 save for RTAS calls or PM */
>  	u64 saved_msr;			/* MSR saved here by enter_rtas */
>  	u16 trap_save;			/* Used when bad stack is encountered */
> +
> +#ifdef CONFIG_PPC_LAZY_EE
>  	u8 soft_enabled;		/* irq soft-enable flag */
>  	u8 hard_enabled;		/* set if irqs are enabled in MSR */
> +#endif
> +
>  	u8 io_sync;			/* writel() needs spin_unlock sync */
>  	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
>  	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 04caee7..5b1fac9 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -146,8 +146,11 @@ int main(void)
>  	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
>  	DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
>  	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
> +#ifdef CONFIG_PPC_LAZY_EE
>  	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
>  	DEFINE(PACAHARDIRQEN, offsetof(struct paca_struct, hard_enabled));
> +#endif
> +
>  	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
>  #ifdef CONFIG_PPC_MM_SLICES
>  	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index d834425..ce7620b 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -124,8 +124,10 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  	ld	r12,_MSR(r1)
>  #endif /* CONFIG_TRACE_IRQFLAGS */
>  	li	r10,1
> +#ifdef CONFIG_PPC_LAZY_EE
>  	stb	r10,PACASOFTIRQEN(r13)
>  	stb	r10,PACAHARDIRQEN(r13)
> +#endif
>  	std	r10,SOFTE(r1)
>  #ifdef CONFIG_PPC_ISERIES
>  BEGIN_FW_FTR_SECTION
> @@ -602,10 +604,12 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
>  2:
>  	TRACE_AND_RESTORE_IRQ(r5);
>  
> +#ifdef CONFIG_PPC_LAZY_EE
>  	/* extract EE bit and use it to restore paca->hard_enabled */
>  	ld	r3,_MSR(r1)
>  	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
>  	stb	r4,PACAHARDIRQEN(r13)
> +#endif
>  
>  #ifdef CONFIG_PPC_BOOK3E
>  	b	.exception_return_book3e
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 429983c..d17abb3 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -96,11 +96,6 @@
>  #define PROLOG_ADDITION_NONE_DBG
>  #define PROLOG_ADDITION_NONE_MC
>  
> -#define PROLOG_ADDITION_MASKABLE_GEN					    \
> -	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
> -	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
> -	beq	masked_interrupt_book3e;
> -
>  #define PROLOG_ADDITION_2REGS_GEN					    \
>  	std	r14,PACA_EXGEN+EX_R14(r13);				    \
>  	std	r15,PACA_EXGEN+EX_R15(r13)
> @@ -120,11 +115,29 @@
>  	std	r14,PACA_EXMC+EX_R14(r13);				    \
>  	std	r15,PACA_EXMC+EX_R15(r13)
>  
> +#ifdef CONFIG_PPC_LAZY_EE
> +#define PROLOG_ADDITION_MASKABLE_GEN					    \
> +	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
> +	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
> +	beq	masked_interrupt_book3e;
> +
>  #define PROLOG_ADDITION_DOORBELL_GEN					    \
>  	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
>  	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
>  	beq	masked_doorbell_book3e
> -
> +#else /* CONFIG_PPC_LAZY_EE */
> +#define PROLOG_ADDITION_MASKABLE_GEN
> +#define PROLOG_ADDITION_DOORBELL_GEN
> +#endif /* CONFIG_PPC_LAZY_EE */
> +
> +#ifdef CONFIG_PPC_LAZY_EE
> +#define GET_IRQ_SOFT_ENABLED						    \
> +	lbz	r11,PACASOFTIRQEN(r13)
> +#else
> +#define GET_IRQ_SOFT_ENABLED						    \
> +	mfmsr	r11;							    \
> +	rlwimi	r11,r11,0,16,16
> +#endif
>  
>  /* Core exception code for all exceptions except TLB misses.
>   * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
> @@ -148,7 +161,7 @@
>  	mfspr	r8,SPRN_XER;		/* save XER in stackframe */	    \
>  	ld	r9,excf+EX_R1(r13);	/* load orig r1 back from PACA */   \
>  	lwz	r10,excf+EX_CR(r13);	/* load orig CR back from PACA	*/  \
> -	lbz	r11,PACASOFTIRQEN(r13);	/* get current IRQ softe */	    \
> +	GET_IRQ_SOFT_ENABLED;		/* get current IRQ softe */	    \
>  	ld	r12,exception_marker@toc(r2);				    \
>  	li	r0,0;							    \
>  	std	r3,GPR10(r1);		/* save r10 to stackframe */	    \
> @@ -169,11 +182,18 @@
>  
>  /* Variants for the "ints" argument */
>  #define INTS_KEEP
> +
> +#ifdef CONFIG_PPC_LAZY_EE
>  #define INTS_DISABLE_SOFT						    \
>  	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
>  	TRACE_DISABLE_INTS;
>  #define INTS_DISABLE_HARD						    \
>  	stb	r0,PACAHARDIRQEN(r13); /* and hard disabled */
> +#else
> +#define INTS_DISABLE_SOFT
> +#define INTS_DISABLE_HARD
> +#endif
> +
>  #define INTS_DISABLE_ALL						    \
>  	INTS_DISABLE_SOFT						    \
>  	INTS_DISABLE_HARD
> @@ -553,6 +573,7 @@ kernel_dbg_exc:
>  	MASKABLE_EXCEPTION(0x320, ehpriv, .unknown_exception, ACK_NONE)
>  
> 
> +#ifdef CONFIG_PPC_LAZY_EE
>  /*
>   * An interrupt came in while soft-disabled; clear EE in SRR1,
>   * clear paca->hard_enabled and return.
> @@ -577,6 +598,7 @@ masked_interrupt_book3e_common:
>  	mfspr	r13,SPRN_SPRG_GEN_SCRATCH;
>  	rfi
>  	b	.
> +#endif /* CONFIG_PPC_LAZY_EE */
>  
>  /*
>   * This is called from 0x300 and 0x400 handlers after the prologs with
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 06c7251..017d669 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -559,12 +559,14 @@ _GLOBAL(pmac_secondary_start)
>  	add	r13,r13,r4		/* for this processor.		*/
>  	SET_PACA(r13)			/* Save vaddr of paca in an SPRG*/
>  
> +#ifdef CONFIG_PPC_LAZY_EE
>  	/* Mark interrupts soft and hard disabled (they might be enabled
>  	 * in the PACA when doing hotplug)
>  	 */
>  	li	r0,0
>  	stb	r0,PACASOFTIRQEN(r13)
>  	stb	r0,PACAHARDIRQEN(r13)
> +#endif
>  
>  	/* Create a temp kernel stack for use before relocation is on.	*/
>  	ld	r1,PACAEMERGSP(r13)
> @@ -621,14 +623,18 @@ __secondary_start:
>  #ifdef CONFIG_PPC_ISERIES
>  BEGIN_FW_FTR_SECTION
>  	ori	r4,r4,MSR_EE
> +#ifdef CONFIG_PPC_LAZY_EE
>  	li	r8,1
>  	stb	r8,PACAHARDIRQEN(r13)
> +#endif
>  END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
>  #endif
> +#ifdef CONFIG_PPC_LAZY_EE
>  BEGIN_FW_FTR_SECTION
>  	stb	r7,PACAHARDIRQEN(r13)
>  END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
>  	stb	r7,PACASOFTIRQEN(r13)
> +#endif
>  
>  	mtspr	SPRN_SRR0,r3
>  	mtspr	SPRN_SRR1,r4
> @@ -775,8 +781,10 @@ _INIT_GLOBAL(start_here_common)
>  
>  	/* Load up the kernel context */
>  5:
> +#ifdef CONFIG_PPC_LAZY_EE
>  	li	r5,0
>  	stb	r5,PACASOFTIRQEN(r13)	/* Soft Disabled */
> +#endif
>  #ifdef CONFIG_PPC_ISERIES
>  BEGIN_FW_FTR_SECTION
>  	mfmsr	r5
> @@ -785,7 +793,9 @@ BEGIN_FW_FTR_SECTION
>  	li	r5,1
>  END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
>  #endif
> +#ifdef CONFIG_PPC_LAZY_EE
>  	stb	r5,PACAHARDIRQEN(r13)	/* Hard Disabled on others */
> +#endif
>  
>  	bl	.start_kernel
>  
> diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
> index 16c002d..34b09e0 100644
> --- a/arch/powerpc/kernel/idle_book3e.S
> +++ b/arch/powerpc/kernel/idle_book3e.S
> @@ -28,6 +28,7 @@ _GLOBAL(book3e_idle)
>  	/* Hard disable interrupts */
>  	wrteei	0
>  
> +#ifdef CONFIG_PPC_LAZY_EE
>  	/* Now check if an interrupt came in while we were soft disabled
>  	 * since we may otherwise lose it (doorbells etc...). We know
>  	 * that since PACAHARDIRQEN will have been cleared in that case.
> @@ -35,6 +36,7 @@ _GLOBAL(book3e_idle)
>  	lbz	r3,PACAHARDIRQEN(r13)
>  	cmpwi	cr0,r3,0
>  	beqlr
> +#endif
>  
>  	/* Now we are going to mark ourselves as soft and hard enables in
>  	 * order to be able to take interrupts while asleep. We inform lockdep
> @@ -44,9 +46,12 @@ _GLOBAL(book3e_idle)
>  	stdu    r1,-128(r1)
>  	bl	.trace_hardirqs_on
>  #endif
> +
> +#ifdef CONFIG_PPC_LAZY_EE
>  	li	r0,1
>  	stb	r0,PACASOFTIRQEN(r13)
>  	stb	r0,PACAHARDIRQEN(r13)
> +#endif
>  	
>  	/* Interrupts will make use return to LR, so get something we want
>  	 * in there
> @@ -56,10 +61,12 @@ _GLOBAL(book3e_idle)
>  	/* Hard disable interrupts again */
>  	wrteei	0
>  
> +#ifdef CONFIG_PPC_LAZY_EE
>  	/* Mark them off again in the PACA as well */
>  	li	r0,0
>  	stb	r0,PACASOFTIRQEN(r13)
>  	stb	r0,PACAHARDIRQEN(r13)
> +#endif
>  
>  	/* Tell lockdep about it */
>  #ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 701d4ac..e2d1784 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -99,6 +99,8 @@ EXPORT_SYMBOL(irq_desc);
>  
>  int distribute_irqs = 1;
>  
> +#ifdef CONFIG_PPC_LAZY_EE
> +
>  static inline notrace unsigned long get_hard_enabled(void)
>  {
>  	unsigned long enabled;
> @@ -193,6 +195,9 @@ notrace void arch_local_irq_restore(unsigned long en)
>  	__hard_irq_enable();
>  }
>  EXPORT_SYMBOL(arch_local_irq_restore);
> +
> +#endif /* CONFIG_PPC_LAZY_EE */
> +
>  #endif /* CONFIG_PPC64 */
>  
>  int arch_show_interrupts(struct seq_file *p, int prec)
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 4cb8f1e..06f5b19 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -233,8 +233,10 @@ void __init early_setup(unsigned long dt_ptr)
>  #ifdef CONFIG_SMP
>  void early_setup_secondary(void)
>  {
> +#ifdef CONFIG_PPC_LAZY_EE
>  	/* Mark interrupts enabled in PACA */
>  	get_paca()->soft_enabled = 0;
> +#endif
>  
>  	/* Initialize the hash table or TLB handling */
>  	early_init_mmu_secondary();
