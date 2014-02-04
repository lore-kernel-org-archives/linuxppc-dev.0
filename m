Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E30A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 21:18:25 +1100 (EST)
Date: Tue, 4 Feb 2014 11:18:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/2] tick/cpuidle: Initialize hrtimer mode of broadcast
In-Reply-To: <20140124065820.17564.83076.stgit@preeti>
Message-ID: <alpine.DEB.2.02.1402041101330.24986@ionos.tec.linutronix.de>
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
 <20140124065820.17564.83076.stgit@preeti>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 agraf@suse.de, paul.gortmaker@windriver.com, paulus@samba.org,
 mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com,
 rafael.j.wysocki@intel.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +++ b/kernel/time/tick-broadcast-hrtimer.c
> +/*
> + * This is called from the guts of the broadcast code when the cpu
> + * which is about to enter idle has the earliest broadcast timer event.
> + */
> +static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
> +{
> +	ktime_t now, interval;
> +	/*
> +	 * We try to cancel the timer first. If the callback is on
> +	 * flight on some other cpu then we let it handle it. If we
> +	 * were able to cancel the timer nothing can rearm it as we
> +	 * own broadcast_lock.
> +	 *
> +	 * However if we are called from the hrtimer interrupt handler
> +	 * itself, reprogram it.
> +	 */
> +	if (hrtimer_try_to_cancel(&bctimer) >= 0) {
> +		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED);
> +		/* Bind the "device" to the cpu */
> +		bc->bound_on = smp_processor_id();
> +	} else if (bc->bound_on == smp_processor_id()) {

This part really wants a proper comment. It took me a while to figure
out why this is correct and what the call chain is.


> +		now = ktime_get();
> +		interval = ktime_sub(expires, now);
> +		hrtimer_forward_now(&bctimer, interval);

We are in the event handler called from bc_handler() and expires is
absolute time. So what's wrong with calling
hrtimer_set_expires(&bctimer, expires)?

> +static enum hrtimer_restart bc_handler(struct hrtimer *t)
> +{
> +	ce_broadcast_hrtimer.event_handler(&ce_broadcast_hrtimer);
> +	return HRTIMER_RESTART;

We probably want to check whether the timer needs to be restarted at
all.

	if (ce_broadcast_timer.next_event.tv64 == KTIME_MAX)
	   return HRTIMER_NORESTART;

	return HRTIMER_RESTART;

Hmm?

Thanks,

	tglx
