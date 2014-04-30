Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA0EB1400E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 11:39:19 +1000 (EST)
Message-ID: <1398821948.24575.161.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 2/2] fsl/mpic_timer: make mpic_timer to support deep
 sleep feature
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 29 Apr 2014 20:39:08 -0500
In-Reply-To: <1398319939-36348-1-git-send-email-dongsheng.wang@freescale.com>
References: <1398319939-36348-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-04-24 at 14:12 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> At T104x platfrom the timer clock will be changed from platform_clock
> to sys_ref_clock when system going to deep sleep.
> 
> So before system going to deep sleep, we need to change time to adapt
> to the new frequency that is sys_ref_clock. And after resume from deep
> sleep, restore the time that based on platform_clock.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v2*
> Remove some unnecessary warning message.
> Remove "switch_freq_flag", it's unnecessary.
> 
> Modify the description of the patch.

The patch needs better code comments throughout to explain the flow of
what's happening.  Note that doesn't mean "more comments", but clearer
and more useful comments.

> diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
> index 9d9b062..71ad368 100644
> --- a/arch/powerpc/sysdev/mpic_timer.c
> +++ b/arch/powerpc/sysdev/mpic_timer.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -26,7 +27,9 @@
>  #include <sysdev/fsl_soc.h>
>  #include <asm/io.h>
>  
> +#include <asm/mpc85xx.h>
>  #include <asm/mpic_timer.h>
> +#include <asm/pm.h>
>  
>  #d	efine FSL_GLOBAL_TIMER		0x1
>  
> @@ -72,6 +75,8 @@ struct timer_group_priv {
>  	struct mpic_timer		timer[TIMERS_PER_GROUP];
>  	struct list_head		node;
>  	unsigned int			timerfreq;
> +	unsigned int			suspended_timerfreq;
> +	unsigned int			resume_timerfreq;
>  	unsigned int			idle;
>  	unsigned int			flags;
>  	spinlock_t			lock;
> @@ -423,6 +428,33 @@ struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
>  }
>  EXPORT_SYMBOL(mpic_request_timer);
>  
> +static void timer_group_get_suspended_freq(struct timer_group_priv *priv)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-clockgen-2.0");
> +	if (!np)
> +		return;
> +
> +	of_property_read_u32(np, "clock-frequency", &priv->suspended_timerfreq);
> +	of_node_put(np);
> +
> +	if (!priv->suspended_timerfreq)
> +		pr_warn("Mpic timer will not be accurate during deep sleep.\n");
> +}
> +
> +static int need_to_switch_freq(void)

/*
 * Returns true if the timers operate on a special frequency
 * when the system is suspended.
 */
static bool has_suspend_freq(void)

> @@ -437,6 +469,13 @@ static int timer_group_get_freq(struct device_node *np,
>  					&priv->timerfreq);
>  			of_node_put(dn);
>  		}
> +
> +		/*
> +		 * For deep sleep, if system goes to deep sleep,
> +		 * timer freq will be changed.
> +		 */

"For deep sleep" is redundant here.

> +		if (need_to_switch_freq())
> +			timer_group_get_suspended_freq(priv);
>  	}
>  
>  	if (priv->timerfreq <= 0)
> @@ -445,6 +484,7 @@ static int timer_group_get_freq(struct device_node *np,
>  	if (priv->flags & FSL_GLOBAL_TIMER) {
>  		div = (1 << (MPIC_TIMER_TCR_CLKDIV >> 8)) * 8;
>  		priv->timerfreq /= div;
> +		priv->suspended_timerfreq /= div;
>  	}
>  
>  	return 0;
> @@ -564,14 +604,182 @@ out:
>  	kfree(priv);
>  }
>  
> +static void mpic_reset_time(struct mpic_timer *handle, struct timeval *bcr_time,
> +				struct timeval *ccr_time)
> +{
> +	struct timer_group_priv *priv = container_of(handle,
> +			struct timer_group_priv, timer[handle->num]);
> +
> +	u64 ccr_ticks = 0;
> +	u64 bcr_ticks = 0;
> +
> +	/* switch bcr time */
> +	convert_time_to_ticks(priv, bcr_time, &bcr_ticks);
> +
> +	/* switch ccr time */
> +	convert_time_to_ticks(priv, ccr_time, &ccr_ticks);

Redundant comments.

> +	if (handle->cascade_handle) {
> +		u32 tmp_ticks;
> +		u32 rem_ticks;
> +
> +		/* reset ccr ticks to bcr */
> +		tmp_ticks = div_u64_rem(ccr_ticks, MAX_TICKS_CASCADE,
> +					&rem_ticks)
> +		out_be32(&priv->regs[handle->num].gtbcr,
> +			tmp_ticks | TIMER_STOP);
> +		out_be32(&priv->regs[handle->num - 1].gtbcr, rem_ticks);

The comment should explain why you're doing this -- that the hardware
copies bcr to ccr whenever TIMER_STOP is cleared.

> +		/* start timer */
> +		clrbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
> +
> +		/* reset bcr */
> +		tmp_ticks = div_u64_rem(bcr_ticks, MAX_TICKS_CASCADE,
> +					&rem_ticks);
> +		out_be32(&priv->regs[handle->num].gtbcr,
> +			tmp_ticks & ~TIMER_STOP);
> +		out_be32(&priv->regs[handle->num - 1].gtbcr, rem_ticks);

Depending on the clock frequency it may be possible that bcr will be
copied again to ccr before the real bcr is written, if the old ccr was
very small.  This could result in two timer expirations where one was
expected.

It also looks like we start using the new timer counts before we
actually enter deep sleep, so the timeout could end up being shorter
than expected.

I'm not sure there's much we can do about either of these given the
hardware design, but it should at least be noted in a comment.

> +	} else {
> +		/* reset ccr ticks to bcr */
> +		out_be32(&priv->regs[handle->num].gtbcr,
> +			ccr_ticks | TIMER_STOP);
> +		/* start timer */
> +		clrbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
> +		/* reset bcr */
> +		out_be32(&priv->regs[handle->num].gtbcr,
> +			bcr_ticks & ~TIMER_STOP);
> +	}
> +}
> +
> +static void do_switch_time(struct mpic_timer *handle, unsigned int new_freq)

timer_set_freq()

> +{
> +	struct timer_group_priv *priv = container_of(handle,
> +			struct timer_group_priv, timer[handle->num]);
> +	struct timeval ccr_time;
> +	struct timeval bcr_time;
> +	unsigned int timerfreq;
> +	u32 test_stop;
> +	u64 ticks;
> +
> +	test_stop = in_be32(&priv->regs[handle->num].gtbcr);
> +	test_stop &= TIMER_STOP;
> +	if (test_stop)
> +		return;

	if (in_be32(&priv->regs[handle->num].gtbcr) & TIMER_STOP)
		return;

> +	/* stop timer, prepare reset time */
> +	setbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);

"stop timer" is redundant.
What does "prepare reset time" mean here?

> +	/* get bcr time */

I can see that it reads "bcr".  "Get base time" would at least remind
the reader what bcr stands for.

> +	if (handle->cascade_handle) {
> +		u32 tmp_ticks;
> +
> +		tmp_ticks = in_be32(&priv->regs[handle->num].gtbcr);
> +		tmp_ticks &= ~TIMER_STOP;
> +		ticks = ((u64)tmp_ticks & UINT_MAX) * (u64)MAX_TICKS_CASCADE;

What does this "& UINT_MAX" accomplish?

> +		tmp_ticks = in_be32(&priv->regs[handle->num - 1].gtbcr);
> +		ticks += tmp_ticks;
> +	} else {
> +		ticks = in_be32(&priv->regs[handle->num].gtbcr);
> +		ticks &= ~TIMER_STOP;
> +	}
> +	convert_ticks_to_time(priv, ticks, &bcr_time);

It would be cleaner to calculate the suspend-freq base count when
configuring the timer, rather than try to work backwards from the
register values.

> +	/* get ccr time */
> +	mpic_get_remain_time(handle, &ccr_time);

> +	/* recalculate timer time */
> +	timerfreq = priv->timerfreq;
> +	priv->timerfreq = new_freq;
> +	mpic_reset_time(handle, &bcr_time, &ccr_time);
> +	priv->timerfreq = timerfreq;
> +}
> +
> +static void switch_group_timer(struct timer_group_priv *priv,
> +				unsigned int new_freq)

timer_group_set_freq()

> +{
> +	int i, num;
> +
> +	for (i = 0; i < TIMERS_PER_GROUP; i++) {
> +		num = TIMERS_PER_GROUP - 1 - i;
> +		/* cascade */
> +		if ((i + 1) < TIMERS_PER_GROUP &&
> +				priv->timer[num].cascade_handle) {

This comment is redundant -- "cascade" is already in "cascade_handle".

How about a comment explaining how you handle cascaded interrupts?

> +			do_switch_time(&priv->timer[num], new_freq);
> +			i++;
> +			continue;
> +		}

Are you sure it works to convert each timer of a cascade separately?

How is this different from letting the main loop do it, other than that
you don't test idle?  The do_switch_time() call is identical, the
increminting of i is identical...

I think you meant to call do_switch_time() on only one of the halves of
the cascade (I'm not sure which one) and skip the other, but that's not
what the code does.

> +		if (!test_bit(i, (unsigned long *)&priv->idle))
> +			do_switch_time(&priv->timer[num], new_freq);

That cast is broken.  If test_bit() wants a long, you need to provide an
actual long.  On 64-bit this code will be looking at "flags" rather than
"idle".

Is testing idle even necessary, or would TIMER_STOP do the job?

> +	}
> +}
> +
> +static int mpic_timer_suspend(void)
> +{
> +	struct timer_group_priv *priv;
> +	suspend_state_t pm_state;
> +
> +	pm_state = pm_suspend_state();
> +
> +	list_for_each_entry(priv, &timer_group_list, node) {
> +		/* timer not be used */
> +		if (priv->idle == 0xf)
> +			continue;

"The timer isn't used"

> +		switch (pm_state) {
> +		case PM_SUSPEND_STANDBY:
> +			break;

Unnecessary

> +		case PM_SUSPEND_MEM:
> +			if (!priv->suspended_timerfreq)
> +				continue;
> +
> +			/* will switch timers, a set of timer */
> +			switch_group_timer(priv, priv->suspended_timerfreq);

What does "a set of timer" mean here?  If you mean that it operates on a
timer group, please use the same terminology as elsewhere (plus it's
implied by the name of the function).

"will switch timers" is implied by the name of the function.  Comments
should explain things, not just restate them.

> +			/* Software: switch timerfreq to suspended freq */

What does "Software:" mean here?

> +			priv->resume_timerfreq = priv->timerfreq;
> +			priv->timerfreq = priv->suspended_timerfreq;

Why doesn't "switch_group_timer" handle this?

> +			break;
> +		default:
> +			break;

Unnecessary default

There's no need for a switch at all -- there's only one case in which
you're ever going to do anything here.

-Scott
