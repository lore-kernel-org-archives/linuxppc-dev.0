Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmPVy3Vj3zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 17:22:50 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5C7Jbb7050846
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 03:22:48 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b19bda9cq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 03:22:48 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 17:22:45 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5C7MgVm7930346
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 17:22:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5C7MXJo010256
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 17:22:33 +1000
Subject: Re: [BUG][next-20170606][bisected 411fe24e6b] WARNING: CPU: 10 PID:
 0 at kernel/time/tick-sched.c:791
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, tglx@linutronix.de, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Mon, 12 Jun 2017 12:52:29 +0530
In-Reply-To: <20170609130950.GB2699@lerouge>
References: <1496820413.15415.10.camel@abdul.in.ibm.com>
 <20170609130950.GB2699@lerouge>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1497252149.15415.16.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-09 at 15:09 +0200, Frederic Weisbecker wrote:
> On Wed, Jun 07, 2017 at 12:56:53PM +0530, Abdul Haleem wrote:
> > Hi,
> > 
> > Test: Trinity (https://github.com/kernelslacker/trinity)
> > Machine : Power 8 PowerVM LPAR
> > Kernel : 4.12.0-rc4-next-20170606
> > gcc : version 5.2.1
> > config : attached
> > 
> > With commit (411fe24e6b : nohz: Fix collision between tick and other
> > hrtimers), a WARNING is seen while running trinity syscall fuzzer
> > 
> > In file kernel/time/tick-sched.c at line 791, a WARN_ON_ONCE is being
> > triggered from tick_nohz_stop_sched_tick function.
> > 
> >     /* Skip reprogram of event if its not changed */
> >     if (ts->tick_stopped && (expires == ts->next_tick)) {
> >         /* Sanity check: make sure clockevent is actually programmed */
> >         if (likely(dev->next_event <= ts->next_tick))
> >             goto out;
> > 
> >         WARN_ON_ONCE(1);
> >         printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
> >                 basemono, ts->next_tick, dev->next_event,
> >                 hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_timer));
> >     }
> > 
> > Trace logs:
> > [22934.302780] ------------[ cut here ]------------
> > [22934.302787] WARNING: CPU: 10 PID: 0 at kernel/time/tick-sched.c:791
> > __tick_nohz_idle_enter+0x2e8/0x570
> 
> Hi Abdul,
> 
> Thanks for reporting. I've cooked a fix, any chance you could test it?

Hi Frederic,

Thanks for the fix. With given patch on 4.12.0-rc4-next-20170609, test
completed with no WARNINGS.

Reported-and-tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

> --
> From f80041b5209aaf9d02ac25a29a248d0f214ba19f Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Thu, 8 Jun 2017 16:32:58 +0200
> Subject: [PATCH] nohz: Fix spurious warning when hrtimer and clocksource get
>  out of sync
> 
> The sanity check ensuring that the tick expiry cache (ts->next_tick)
> is actually in sync with the hardware clock (dev->next_event) makes the
> wrong assumption that the clock can't be programmed later than the
> hrtimer deadline.
> 
> In fact the clock hardware can be programmed later on some conditions
> such as:
> 
>     * The hrtimer deadline is already in the past.
>     * The hrtimer deadline is earlier than the minimum delay supported
>       by the hardware.
> 
> Such conditions can be met when we program the tick, for example if the
> last jiffies update hasn't been seen by the current CPU yet, we may
> program the hrtimer to a deadline that is earlier than ktime_get()
> because last_jiffies_update is our timestamp base to compute the next
> tick.
> 
> As a result, we can randomly observe such warning:
> 
> 	WARNING: CPU: 5 PID: 0 at kernel/time/tick-sched.c:794 tick_nohz_stop_sched_tick kernel/time/tick-sched.c:791 [inline]
> 	Call Trace:
> 	 tick_nohz_irq_exit
> 	 tick_irq_exit
> 	 irq_exit
> 	 exiting_irq
> 	 smp_call_function_interrupt
> 	 smp_call_function_single_interrupt
> 	 call_function_single_interrupt
> 
> Therefore, let's rather make sure that the tick expiry cache is sync'ed
> with the tick hrtimer deadline, against which it is not supposed to
> drift away. The clock hardware instead has its own will and can't be
> used as a reliable comparison point.
> 
> Reported-by: Sasha Levin <alexander.levin@verizon.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: James Hartsock <hartsjc@redhat.com>
> Cc: Tim Wright <tim@binbash.co.uk>
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> ---
>  kernel/time/tick-sched.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 9d31f1e..83c788e 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -768,7 +768,8 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
>  	/* Skip reprogram of event if its not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */
> -		if (likely(dev->next_event <= ts->next_tick))
> +		if (tick == KTIME_MAX ||
> +		    ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
>  			goto out;
> 
>  		WARN_ON_ONCE(1);
> @@ -806,8 +807,10 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
>  		goto out;
>  	}
> 
> +	hrtimer_set_expires(&ts->sched_timer, tick);
> +
>  	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
> -		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
> +		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
>  	else
>  		tick_program_event(tick, 1);
>  out:


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
