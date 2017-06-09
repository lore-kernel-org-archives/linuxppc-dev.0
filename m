Return-Path: <fweisbec@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkjLv00vSzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 23:09:58 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id v104so6727747wrb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Jun 2017 06:09:58 -0700 (PDT)
Date: Fri, 9 Jun 2017 15:09:52 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [BUG][next-20170606][bisected 411fe24e6b] WARNING: CPU: 10 PID:
 0 at kernel/time/tick-sched.c:791
Message-ID: <20170609130950.GB2699@lerouge>
References: <1496820413.15415.10.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496820413.15415.10.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 07, 2017 at 12:56:53PM +0530, Abdul Haleem wrote:
> Hi,
> 
> Test: Trinity (https://github.com/kernelslacker/trinity)
> Machine : Power 8 PowerVM LPAR
> Kernel : 4.12.0-rc4-next-20170606
> gcc : version 5.2.1
> config : attached
> 
> With commit (411fe24e6b : nohz: Fix collision between tick and other
> hrtimers), a WARNING is seen while running trinity syscall fuzzer
> 
> In file kernel/time/tick-sched.c at line 791, a WARN_ON_ONCE is being
> triggered from tick_nohz_stop_sched_tick function.
> 
>     /* Skip reprogram of event if its not changed */
>     if (ts->tick_stopped && (expires == ts->next_tick)) {
>         /* Sanity check: make sure clockevent is actually programmed */
>         if (likely(dev->next_event <= ts->next_tick))
>             goto out;
> 
>         WARN_ON_ONCE(1);
>         printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
>                 basemono, ts->next_tick, dev->next_event,
>                 hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_timer));
>     }
> 
> Trace logs:
> [22934.302780] ------------[ cut here ]------------
> [22934.302787] WARNING: CPU: 10 PID: 0 at kernel/time/tick-sched.c:791
> __tick_nohz_idle_enter+0x2e8/0x570

Hi Abdul,

Thanks for reporting. I've cooked a fix, any chance you could test it?

--
>From f80041b5209aaf9d02ac25a29a248d0f214ba19f Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 8 Jun 2017 16:32:58 +0200
Subject: [PATCH] nohz: Fix spurious warning when hrtimer and clocksource get
 out of sync

The sanity check ensuring that the tick expiry cache (ts->next_tick)
is actually in sync with the hardware clock (dev->next_event) makes the
wrong assumption that the clock can't be programmed later than the
hrtimer deadline.

In fact the clock hardware can be programmed later on some conditions
such as:

    * The hrtimer deadline is already in the past.
    * The hrtimer deadline is earlier than the minimum delay supported
      by the hardware.

Such conditions can be met when we program the tick, for example if the
last jiffies update hasn't been seen by the current CPU yet, we may
program the hrtimer to a deadline that is earlier than ktime_get()
because last_jiffies_update is our timestamp base to compute the next
tick.

As a result, we can randomly observe such warning:

	WARNING: CPU: 5 PID: 0 at kernel/time/tick-sched.c:794 tick_nohz_stop_sched_tick kernel/time/tick-sched.c:791 [inline]
	Call Trace:
	 tick_nohz_irq_exit
	 tick_irq_exit
	 irq_exit
	 exiting_irq
	 smp_call_function_interrupt
	 smp_call_function_single_interrupt
	 call_function_single_interrupt

Therefore, let's rather make sure that the tick expiry cache is sync'ed
with the tick hrtimer deadline, against which it is not supposed to
drift away. The clock hardware instead has its own will and can't be
used as a reliable comparison point.

Reported-by: Sasha Levin <alexander.levin@verizon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: James Hartsock <hartsjc@redhat.com>
Cc: Tim Wright <tim@binbash.co.uk>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
 kernel/time/tick-sched.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9d31f1e..83c788e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -768,7 +768,8 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
-		if (likely(dev->next_event <= ts->next_tick))
+		if (tick == KTIME_MAX ||
+		    ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			goto out;
 
 		WARN_ON_ONCE(1);
@@ -806,8 +807,10 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 		goto out;
 	}
 
+	hrtimer_set_expires(&ts->sched_timer, tick);
+
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
-		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
 	else
 		tick_program_event(tick, 1);
 out:
-- 
2.7.4
