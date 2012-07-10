Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] More fixes for lazy IRQ vs. idle
In-reply-to: <1341891538.2561.10.camel@pasglop>
References: <1341891538.2561.10.camel@pasglop>
Date: Tue, 10 Jul 2012 16:10:15 +1000
Message-ID: <21083.1341900615@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Looks like we still have issues with pSeries and Cell idle code
> vs. the lazy irq state. In fact, the reset fixes that went upstream
> are exposing the problem more by causing BUG_ON() to trigger (which
> this patch turns into a WARN_ON instead).

Do we need to cc stable for 3.4 or is this new stuff only effecting us
since the 3.5 merge window?

Mikey

> We need to be careful when using a variant of low power state that
> has the side effect of turning interrupts back on, to properly set
> all the SW & lazy state to look as if everything is enabled before
> we enter the low power state with MSR:EE off as we will return with
> MSR:EE on. If not, we have a discrepancy of state which can cause
> things to go very wrong later on.
> 
> This patch moves the logic into a helper and uses it from the
> pseries and cell idle code. The power4/970 idle code already got
> things right (in assembly even !) so I'm not touching it. The power7
> "bare metal" idle code is subtly different and correct. Remains PA6T
> and some hypervisor based Cell platforms which have questionable
> code in there, but they are mostly dead platforms so I'll fix them
> when I manage to get final answers from the respective maintainers
> about how the low power state actually works on them.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 6eb75b8..92224b7 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -125,6 +125,8 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
>  	return !regs->softe;
>  }
>  
> +extern bool prep_irq_for_idle(void);
> +
>  #else /* CONFIG_PPC64 */
>  
>  #define SET_MSR_EE(x)	mtmsr(x)
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 1b41502..5dc4a80 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -286,6 +286,52 @@ void notrace restore_interrupts(void)
>  		__hard_irq_enable();
>  }
>  
> +/*
> + * This is a helper to use when about to go into idle low-power
> + * when the latter has the side effect of re-enabling interrupts
> + * (such as calling H_CEDE under pHyp).
> + *
> + * You call this function with interrupts soft-disabled (this is
> + * already the case when ppc_md.power_save is called). The function
> + * will return whether to enter power save or just return.
> + *
> + * In the former case, it will have notified lockdep of interrupts
> + * being re-enabled and generally sanitized the lazy irq state,
> + * and in the latter case it will leave with interrupts hard
> + * disabled and marked as such, so the local_irq_restore() call
> + * in cpu_idle() will properly re-enable everything.
> + */
> +bool prep_irq_for_idle(void)
> +{
> +	/*
> +	 * First we need to hard disable to ensure no interrupt
> +	 * occurs before we effectively enter the low power state
> +	 */
> +	hard_irq_disable();
> +
> +	/*
> +	 * If anything happened while we were soft-disabled,
> +	 * we return now and do not enter the low power state.
> +	 */
> +	if (lazy_irq_pending())
> +		return false;
> +
> +	/* Tell lockdep we are about to re-enable */
> +	trace_hardirqs_on();
> +
> +	/*
> +	 * Mark interrupts as soft-enabled and clear the
> +	 * PACA_IRQ_HARD_DIS from the pending mask since we
> +	 * are about to hard enable as well as a side effect
> +	 * of entering the low power state.
> +	 */
> +	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
> +	local_paca->soft_enabled = 1;
> +
> +	/* Tell the caller to enter the low power state */
> +	return true;
> +}
> +
>  #endif /* CONFIG_PPC64 */
>  
>  int arch_show_interrupts(struct seq_file *p, int prec)
> diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
> index efdacc8..d17e98b 100644
> --- a/arch/powerpc/platforms/cell/pervasive.c
> +++ b/arch/powerpc/platforms/cell/pervasive.c
> @@ -42,11 +42,9 @@ static void cbe_power_save(void)
>  {
>  	unsigned long ctrl, thread_switch_control;
>  
> -	/*
> -	 * We need to hard disable interrupts, the local_irq_enable() done by
> -	 * our caller upon return will hard re-enable.
> -	 */
> -	hard_irq_disable();
> +	/* Ensure our interrupt state is properly tracked */
> +	if (!prep_irq_for_idle())
> +		return;
>  
>  	ctrl = mfspr(SPRN_CTRLF);
>  
> @@ -81,6 +79,9 @@ static void cbe_power_save(void)
>  	 */
>  	ctrl &= ~(CTRL_RUNLATCH | CTRL_TE);
>  	mtspr(SPRN_CTRLT, ctrl);
> +
> +	/* Re-enable interrupts in MSR */
> +	__hard_irq_enable();
>  }
>  
>  static int cbe_system_reset_exception(struct pt_regs *regs)
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index a97ef66..9b51ccf 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -100,15 +100,17 @@ out:
>  static void check_and_cede_processor(void)
>  {
>  	/*
> -	 * Interrupts are soft-disabled at this point,
> -	 * but not hard disabled. So an interrupt might have
> -	 * occurred before entering NAP, and would be potentially
> -	 * lost (edge events, decrementer events, etc...) unless
> -	 * we first hard disable then check.
> +	 * Ensure our interrupt state is properly tracked,
> +	 * also checks if no interrupt has occurred while we
> +	 * were soft-disabled
>  	 */
> -	hard_irq_disable();
> -	if (!lazy_irq_pending())
> +	if (prep_irq_for_idle()) {
>  		cede_processor();
> +#ifdef CONFIG_TRACE_IRQFLAG
> +		/* Ensure that H_CEDE returns with IRQs on */
> +		WARN_ON(!(mfmsr() & MSR_EE));
> +#endif
> +	}
>  }
>  
>  static int dedicated_cede_loop(struct cpuidle_device *dev,
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
