Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 480E2DDFD5
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 07:33:08 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NLX3i8013459
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 17:33:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NLX3SO084798
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 15:33:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NLX22j008407
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 15:33:03 -0600
Date: Tue, 23 Oct 2007 16:33:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
Message-ID: <20071023163301.4857393e@weaponx.rchland.ibm.com>
In-Reply-To: <20071023212404.GA30942@loki.buserror.net>
References: <20071023212404.GA30942@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 23 Oct 2007 16:24:04 -0500
Scott Wood <scottwood@freescale.com> wrote:

> These hooks ensure that a decrementer interrupt is not pending when
> suspending; otherwise, problems may occur.  For example, with deep sleep
> on the 831x, a pending decrementer will cause a system freeze because the
> SoC thinks the decrementer interrupt would have woken the system, but the
> core must have interrupts disabled due to the setup required for deep
> sleep.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Please queue these patches for 2.6.25 if they do not offend.
> 
>  arch/powerpc/kernel/time.c    |   41 +++++++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/machdep.h |   13 +++++++++++++
>  2 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 9eb3284..5e2a39b 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -647,6 +647,47 @@ void wakeup_decrementer(void)
>  	set_dec(ticks);
>  }
> 
> +#ifdef CONFIG_SUSPEND
> +void generic_suspend_disable_irqs(void)
> +{
> +	preempt_disable();
> +
> +	/* Disable the decrementer, so that it doesn't interfere
> +	 * with suspending.
> +	 */
> +
> +	set_dec(0x7fffffff);
> +	hard_irq_disable();
> +	set_dec(0x7fffffff);
> +}
> +
> +void generic_suspend_enable_irqs(void)
> +{
> +	wakeup_decrementer();
> +
> +	local_irq_enable();
> +	preempt_enable();
> +}

Should these be static functions?  Seems so...

> +
> +/* Overrides the weak version in kernel/power/main.c */
> +void arch_suspend_disable_irqs(void)
> +{
> +	if (ppc_md.suspend_disable_irqs)
> +		ppc_md.suspend_disable_irqs();
> +	else
> +		generic_suspend_disable_irqs();
> +}
> +
> +/* Overrides the weak version in kernel/power/main.c */
> +void arch_suspend_enable_irqs(void)
> +{
> +	if (ppc_md.suspend_enable_irqs)
> +		ppc_md.suspend_enable_irqs();
> +	else
> +		generic_suspend_enable_irqs();
> +}
> +#endif
> +
>  #ifdef CONFIG_SMP
>  void __init smp_space_timers(unsigned int max_cpus)
>  {
> diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
> index 6968f43..15ba15a 100644
> --- a/include/asm-powerpc/machdep.h
> +++ b/include/asm-powerpc/machdep.h
> @@ -253,6 +253,16 @@ struct machdep_calls {
>  	 */
>  	void (*machine_kexec)(struct kimage *image);
>  #endif /* CONFIG_KEXEC */
> +
> +#ifdef CONFIG_SUSPEND
> +	/* These are called to disable and enable, respectively, IRQs when
> +	 * entering a suspend state.  If NULL, then the generic versions
> +	 * will be called.  The generic versions disable/enable the
> +	 * decrementer along with interrupts.
> +	 */
> +	void (*suspend_disable_irqs)(void);
> +	void (*suspend_enable_irqs)(void);
> +#endif
>  };
> 
>  extern void power4_idle(void);
> @@ -326,5 +336,8 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
>  		ppc_md.log_error(buf, err_type, fatal);
>  }
> 
> +void generic_suspend_disable_irqs(void);
> +void generic_suspend_enable_irqs(void);

And do they really need to be declared here?

josh
