Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com
 [IPv6:2a00:1450:400c:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34A441A08D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 23:12:54 +1100 (AEDT)
Received: by wgoe14 with SMTP id e14so83061367wgo.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2015 05:12:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 2 Apr 2015 14:12:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
Message-ID: <20150402121247.GA18104@gmail.com>
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com>
 <20150402120256.GV23123@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402120256.GV23123@twins.programming.kicks-ass.net>
Cc: nicolas.pitre@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 02, 2015 at 12:42:27PM +0200, Ingo Molnar wrote:
> > So why not use a suitable CPU_DOWN* notifier for this, instead of open 
> > coding it all into a random place in the hotplug machinery?
> 
> Because notifiers are crap? ;-) [...]

No doubt - but I didn't feel this poorly named random call into the 
hotplug code, with no comments was any better.

> [...] Its entirely impossible to figure out what's happening to core 
> code in hotplug. You need to go chase down and random order notifier 
> things.
> 
> I'm planning on taking out many of the core hotplug notifiers and 
> hard coding their callbacks into the hotplug code.

That's very welcome news - but please also lets put in place a proper 
namespace for all these callbacks, to make them easy to find and 
change: hotplug_cpu__*() or so, which in this case would turn into 
hotplug_cpu__tick_pull() or so?

> That way at least its clear wtf happens when.

Okay. I'll resurrect the fix with a hotplug_cpu__tick_pull() name - 
agreed?

> > Also, I improved the changelog (attached below), but decided 
> > against applying it until these questions are cleared - please use 
> > that for future versions of this patch.
> 
> 
> > Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
> 
> You forgot to fix the Fixes line ;-)
> 
> My copy has:
> 
>  Fixes: 5d1638acb9f6 ("tick: Introduce hrtimer based broadcast")

Hm, not sure how that got lost - my git-log of the patch ported on top 
of timers/core still has it:

==========================>
>From 413fbf5193b330c5f478ef7aaeaaee08907a993e Mon Sep 17 00:00:00 2001
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 14:59:19 +0530
Subject: [PATCH] clockevents: Fix cpu_down() race for hrtimer based broadcasting

It was found when doing a hotplug stress test on POWER, that the
machine either hit softlockups or rcu_sched stall warnings.  The
issue was traced to commit:

  7cba160ad789 ("powernv/cpuidle: Redesign idle states management")

which exposed the cpu_down() race with hrtimer based broadcast mode:

  5d1638acb9f6 ("tick: Introduce hrtimer based broadcast")

The race is the following:

Assume CPU1 is the CPU which holds the hrtimer broadcasting duty
before it is taken down.

	CPU0					CPU1

	cpu_down()				take_cpu_down()
						disable_interrupts()

	cpu_die()

	while (CPU1 != CPU_DEAD) {
		msleep(100);
		switch_to_idle();
		stop_cpu_timer();
		schedule_broadcast();
	}

	tick_cleanup_cpu_dead()
		take_over_broadcast()

So after CPU1 disabled interrupts it cannot handle the broadcast
hrtimer anymore, so CPU0 will be stuck forever.

Fix this by explicitly taking over broadcast duty before cpu_die().

This is a temporary workaround. What we really want is a callback
in the clockevent device which allows us to do that from the dying
CPU by pushing the hrtimer onto a different cpu. That might involve
an IPI and is definitely more complex than this immediate fix.

Changelog was picked up from:

    https://lkml.org/lkml/2015/2/16/213

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au
Cc: nicolas.pitre@linaro.org
Cc: peterz@infradead.org
Cc: rjw@rjwysocki.net
Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
Link: http://lkml.kernel.org/r/20150330092410.24979.59887.stgit@preeti.in.ibm.com
[ Merged it to the latest timer tree, tidied up the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cpu.c                 |  2 ++
 kernel/time/tick-broadcast.c | 19 +++++++++++--------
 kernel/time/tick-internal.h  |  2 ++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1972b161c61e..f9ca351a404a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/suspend.h>
 #include <linux/lockdep.h>
+#include <linux/tick.h>
 #include <trace/events/power.h>
 
 #include "smpboot.h"
@@ -411,6 +412,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 	while (!idle_cpu(cpu))
 		cpu_relax();
 
+	tick_takeover(cpu);
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
 
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 19cfb381faa9..81174cd9a29c 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -680,14 +680,19 @@ static void broadcast_shutdown_local(struct clock_event_device *bc,
 	clockevents_set_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 }
 
-static void broadcast_move_bc(int deadcpu)
+void tick_takeover(int deadcpu)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc;
+	unsigned long flags;
 
-	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
-		return;
-	/* This moves the broadcast assignment to this cpu */
-	clockevents_program_event(bc, bc->next_event, 1);
+	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
+	bc = tick_broadcast_device.evtdev;
+
+	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
+		/* This moves the broadcast assignment to this CPU: */
+		clockevents_program_event(bc, bc->next_event, 1);
+	}
+	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
 /*
@@ -924,8 +929,6 @@ void tick_shutdown_broadcast_oneshot(unsigned int *cpup)
 	cpumask_clear_cpu(cpu, tick_broadcast_pending_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_force_mask);
 
-	broadcast_move_bc(cpu);
-
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index b6ba0a44e740..d0794a21ab44 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -126,6 +126,7 @@ extern int tick_broadcast_oneshot_active(void);
 extern void tick_check_oneshot_broadcast_this_cpu(void);
 bool tick_broadcast_oneshot_available(void);
 extern struct cpumask *tick_get_broadcast_oneshot_mask(void);
+extern void tick_takeover(int deadcpu);
 #else /* !(BROADCAST && ONESHOT): */
 static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
 static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
@@ -134,6 +135,7 @@ static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
 static inline int tick_broadcast_oneshot_active(void) { return 0; }
 static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
+static inline void tick_takeover(int deadcpu) { }
 #endif /* !(BROADCAST && ONESHOT) */
 
 /* NO_HZ_FULL internal */
