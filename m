Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2E571A1CF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 17:36:10 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 8 May 2015 01:36:08 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BC27C19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 01:27:08 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t487Zdd529818952
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 00:35:39 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t487a4CU011626
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 01:36:04 -0600
Subject: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure gracefully
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com,
 daniel.lezcano@linaro.org
Date: Fri, 08 May 2015 13:05:32 +0530
Message-ID: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a CPU has to enter an idle state where tick stops, it makes a call
to tick_broadcast_enter(). The call will fail if this CPU is the
broadcast CPU. Today, under such a circumstance, the arch cpuidle code
handles this CPU.  This is not convincing because not only do we not
know what the arch cpuidle code does, but we also do not account for the
idle state residency time and usage of such a CPU.

This scenario can be handled better by simply choosing an idle state
where in ticks do not stop. To accommodate this change move the setting
of runqueue idle state from the core to the cpuidle driver, else the
rq->idle_state will be set wrong.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from V2: https://lkml.org/lkml/2015/5/7/78
Introduce a function in cpuidle core to select an idle state where ticks do not
stop rather than going through the governors.

Changes from V1: https://lkml.org/lkml/2015/5/7/24
Rebased on the latest linux-pm/bleeding-edge branch

 drivers/cpuidle/cpuidle.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/sched.h     |   16 ++++++++++++++++
 kernel/sched/core.c       |   17 +++++++++++++++++
 kernel/sched/fair.c       |    2 +-
 kernel/sched/idle.c       |    6 ------
 kernel/sched/sched.h      |   24 ------------------------
 6 files changed, 77 insertions(+), 33 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8c24f95..d1af760 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/tick.h>
+#include <linux/sched.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -146,6 +147,36 @@ int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	return index;
 }
 
+/*
+ * find_tick_valid_state - select a state where tick does not stop
+ * @dev: cpuidle device for this cpu
+ * @drv: cpuidle driver for this cpu
+ */
+static int find_tick_valid_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv)
+{
+	int i, ret = -1;
+
+	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		/*
+		 * We do not explicitly check for latency requirement
+		 * since it is safe to assume that only shallower idle
+		 * states will have the CPUIDLE_FLAG_TIMER_STOP bit
+		 * cleared and they will invariably meet the latency
+		 * requirement.
+		 */
+		if (s->disabled || su->disable ||
+			(s->flags & CPUIDLE_FLAG_TIMER_STOP))
+			continue;
+
+		ret = i;
+	}
+	return ret;
+}
+
 /**
  * cpuidle_enter_state - enter the state and update stats
  * @dev: cpuidle device for this cpu
@@ -168,10 +199,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
 	if (broadcast && tick_broadcast_enter()) {
-		default_idle_call();
-		return -EBUSY;
+		index = find_tick_valid_state(dev, drv);
+		if (index < 0) {
+			default_idle_call();
+			return -EBUSY;
+		}
+		target_state = &drv->states[index];
 	}
 
+	/* Take note of the planned idle state. */
+	idle_set_state(smp_processor_id(), target_state);
+
 	trace_cpu_idle_rcuidle(index, dev->cpu);
 	time_start = ktime_get();
 
@@ -180,6 +218,9 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	time_end = ktime_get();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
+	/* The cpu is no longer idle or about to enter idle. */
+	idle_set_state(smp_processor_id(), NULL);
+
 	if (broadcast) {
 		if (WARN_ON_ONCE(!irqs_disabled()))
 			local_irq_disable();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 26a2e61..fef8359 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -45,6 +45,7 @@ struct sched_param {
 #include <linux/rcupdate.h>
 #include <linux/rculist.h>
 #include <linux/rtmutex.h>
+#include <linux/cpuidle.h>
 
 #include <linux/time.h>
 #include <linux/param.h>
@@ -893,6 +894,21 @@ enum cpu_idle_type {
 	CPU_MAX_IDLE_TYPES
 };
 
+#ifdef CONFIG_CPU_IDLE
+extern void idle_set_state(int cpu, struct cpuidle_state *idle_state);
+extern struct cpuidle_state *idle_get_state(int cpu);
+#else
+static inline void idle_set_state(int cpu,
+				  struct cpuidle_state *idle_state)
+{
+}
+
+static inline struct cpuidle_state *idle_get_state(int cpu)
+{
+	return NULL;
+}
+#endif
+
 /*
  * Increase resolution of cpu_capacity calculations
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe22f75..8e1cc50 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3216,6 +3216,23 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+#ifdef CONFIG_CPU_IDLE
+void idle_set_state(int cpu, struct cpuidle_state *idle_state)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	rq->idle_state = idle_state;
+}
+
+struct cpuidle_state *idle_get_state(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	WARN_ON(!rcu_read_lock_held());
+	return rq->idle_state;
+}
+#endif /* CONFIG_CPU_IDLE */
+
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ffeaa41..211ef9a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4709,7 +4709,7 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
 		if (idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
-			struct cpuidle_state *idle = idle_get_state(rq);
+			struct cpuidle_state *idle = idle_get_state(i);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
 				 * We give priority to a CPU whose idle state
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5933d06..04af46f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -101,9 +101,6 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		return -EBUSY;
 	}
 
-	/* Take note of the planned idle state. */
-	idle_set_state(this_rq(), &drv->states[next_state]);
-
 	/*
 	 * Enter the idle state previously returned by the governor decision.
 	 * This function will block until an interrupt occurs and will take
@@ -111,9 +108,6 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 */
 	entered_state = cpuidle_enter(drv, dev, next_state);
 
-	/* The cpu is no longer idle or about to enter idle. */
-	idle_set_state(this_rq(), NULL);
-
 	return entered_state;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e0e1299..2c56caa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1253,30 +1253,6 @@ static inline void idle_exit_fair(struct rq *rq) { }
 
 #endif
 
-#ifdef CONFIG_CPU_IDLE
-static inline void idle_set_state(struct rq *rq,
-				  struct cpuidle_state *idle_state)
-{
-	rq->idle_state = idle_state;
-}
-
-static inline struct cpuidle_state *idle_get_state(struct rq *rq)
-{
-	WARN_ON(!rcu_read_lock_held());
-	return rq->idle_state;
-}
-#else
-static inline void idle_set_state(struct rq *rq,
-				  struct cpuidle_state *idle_state)
-{
-}
-
-static inline struct cpuidle_state *idle_get_state(struct rq *rq)
-{
-	return NULL;
-}
-#endif
-
 extern void sysrq_sched_debug_show(void);
 extern void sched_init_granularity(void);
 extern void update_max_interval(void);
