Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 697C41A0E4E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 15:15:29 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 30 Jan 2015 21:15:27 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 53C8119D803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 21:06:35 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0V4FGD635586122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 21:15:24 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0V4EpI3010151
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 21:14:52 -0700
Subject: [PATCH V4] tick/hotplug: Handover time related duties before cpu
 offline
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de
Date: Sat, 31 Jan 2015 09:44:30 +0530
Message-ID: <20150131041342.17103.30020.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 michael@ellerman.id.au, anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These duties include do_timer to update jiffies and broadcast wakeups on those
platforms which do not have an external device to handle wakeup of cpus from deep
idle states. The handover of these duties is not robust against a cpu offline
operation today.

The do_timer duty is handed over in the CPU_DYING phase today to one of the online
cpus. This relies on the fact that *all* cpus participate in stop_machine phase.
But if this design is to change in the future, i.e. if all cpus are not
required to participate in stop_machine, the freshly nominated do_timer cpu
could be idle at the time of handover. In that case, unless its interrupted,
it will not wakeup to update jiffies and timekeeping will hang.

With regard to broadcast wakeups, today if the cpu handling broadcast of wakeups
goes offline, the job of broadcasting is handed over to another cpu in the CPU_DEAD
phase. The CPU_DEAD notifiers are run only after the offline cpu sets its state as
CPU_DEAD. Meanwhile, the kthread doing the offline is scheduled out while waiting for
this transition by queuing a timer. This is fatal because if the cpu on which
this kthread was running has no other work queued on it, it can re-enter deep
idle state, since it sees that a broadcast cpu still exists. However the broadcast
wakeup will never come since the cpu which was handling it is offline, and the cpu
on which the kthread doing the hotplug operation was running never wakes up to see
this because its in deep idle state.

Fix these issues by handing over the do_timer and broadcast wakeup duties just before
the offline cpu kills itself, to the cpu performing the hotplug operation. Since the
cpu performing the hotplug operation is up and running, it becomes aware of the handover
of do_timer duty and queues the broadcast timer upon itself so as to seamlessly
continue both these operations.

It fixes the bug reported here:
http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from V3: https://lkml.org/lkml/2015/1/20/236
1. Move handover of broadcast duty away from CPU_DYING phase to just before
the cpu kills itself.
2. Club the handover of timekeeping duty along with broadcast duty to make
timekeeping robust against hotplug.

 include/linux/tick.h         |    2 ++
 kernel/cpu.c                 |    4 ++++
 kernel/time/clockevents.c    |    4 ----
 kernel/time/tick-broadcast.c |    4 +---
 kernel/time/tick-common.c    |   12 +++++++++---
 kernel/time/tick-internal.h  |    3 ++-
 6 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index eda850c..6634be5 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -78,6 +78,7 @@ struct tick_sched {
 extern void __init tick_init(void);
 extern int tick_is_oneshot_available(void);
 extern struct tick_device *tick_get_device(int cpu);
+extern void tick_handover_tk(int hcpu);
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 extern int tick_init_highres(void);
@@ -120,6 +121,7 @@ static inline int tick_oneshot_mode_active(void) { return 0; }
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_cancel_sched_timer(int cpu) { }
+static inline void tick_handover_tk(int hcpu) {}
 static inline void tick_clock_notify(void) { }
 static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
 static inline void tick_irq_enter(void) { }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5d22023..329ec59 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/suspend.h>
 #include <linux/lockdep.h>
+#include <linux/tick.h>
 #include <trace/events/power.h>
 
 #include "smpboot.h"
@@ -421,6 +422,9 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 	while (!idle_cpu(cpu))
 		cpu_relax();
 
+	/* Handover timekeeping and broadcast duties to the current cpu */
+	tick_handover_tk(cpu);
+
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
 
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5544990..2b10b13 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -566,10 +566,6 @@ int clockevents_notify(unsigned long reason, void *arg)
 		ret = tick_broadcast_oneshot_control(reason);
 		break;
 
-	case CLOCK_EVT_NOTIFY_CPU_DYING:
-		tick_handover_do_timer(arg);
-		break;
-
 	case CLOCK_EVT_NOTIFY_SUSPEND:
 		tick_suspend();
 		tick_suspend_broadcast();
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 066f0ec..4f59ede 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -669,7 +669,7 @@ static void broadcast_shutdown_local(struct clock_event_device *bc,
 	clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
 }
 
-static void broadcast_move_bc(int deadcpu)
+void tick_handover_broadcast(int deadcpu)
 {
 	struct clock_event_device *bc = tick_broadcast_device.evtdev;
 
@@ -913,8 +913,6 @@ void tick_shutdown_broadcast_oneshot(unsigned int *cpup)
 	cpumask_clear_cpu(cpu, tick_broadcast_pending_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_force_mask);
 
-	broadcast_move_bc(cpu);
-
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7efeedf..0f66963 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -337,16 +337,22 @@ out_bc:
  *
  * Called with interrupts disabled.
  */
-void tick_handover_do_timer(int *cpup)
+static void tick_handover_do_timer(int hcpu)
 {
-	if (*cpup == tick_do_timer_cpu) {
-		int cpu = cpumask_first(cpu_online_mask);
+	if (hcpu == tick_do_timer_cpu) {
+		int cpu = smp_processor_id();
 
 		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
 			TICK_DO_TIMER_NONE;
 	}
 }
 
+void tick_handover_tk(int hcpu)
+{
+	tick_handover_do_timer(hcpu);
+	tick_handover_broadcast(hcpu);
+}
+
 /*
  * Shutdown an event device on a given cpu:
  *
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 366aeb4..03d6039 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -23,7 +23,6 @@ extern int tick_do_timer_cpu __read_mostly;
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
-extern void tick_handover_do_timer(int *cpup);
 extern void tick_shutdown(unsigned int *cpup);
 extern void tick_suspend(void);
 extern void tick_resume(void);
@@ -51,6 +50,7 @@ extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 extern int tick_broadcast_oneshot_control(unsigned long reason);
 extern void tick_broadcast_switch_to_oneshot(void);
 extern void tick_shutdown_broadcast_oneshot(unsigned int *cpup);
+extern void tick_handover_broadcast(int hcpu);
 extern int tick_resume_broadcast_oneshot(struct clock_event_device *bc);
 extern int tick_broadcast_oneshot_active(void);
 extern void tick_check_oneshot_broadcast_this_cpu(void);
@@ -63,6 +63,7 @@ static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
 static inline void tick_broadcast_switch_to_oneshot(void) { }
 static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
+static inline void tick_handover_broadcast(int hcpu) { }
 static inline int tick_broadcast_oneshot_active(void) { return 0; }
 static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return true; }
