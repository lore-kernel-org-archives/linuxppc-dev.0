Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 672CB1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 08:55:25 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org
Subject: [PATCH 1/3] sched / idle: Call idle_set_state() from
 cpuidle_enter_state()
Date: Sun, 10 May 2015 01:18:03 +0200
Message-ID: <2077088.K8HIhfzNYK@vostro.rjw.lan>
In-Reply-To: <8965830.CMQzZzsqm0@vostro.rjw.lan>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <3161640.llJtBoKCBr@vostro.rjw.lan> <8965830.CMQzZzsqm0@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a wrapper function around idle_set_state() called
sched_idle_set_state() that will pass this_rq() to it as the
first argument and make cpuidle_enter_state() call the new
function before and after entering the target state.

At the same time, remove direct invocations of idle_set_state()
from call_cpuidle().

This will allow the invocation of default_idle_call() to be
moved from call_cpuidle() to cpuidle_enter_state() safely
and call_cpuidle() to be simplified a bit as a result.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    6 ++++++
 include/linux/cpuidle.h   |    3 +++
 kernel/sched/idle.c       |   15 +++++++++------
 3 files changed, 18 insertions(+), 6 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -15,6 +15,15 @@
 
 #include "sched.h"
 
+/**
+ * sched_idle_set_state - Record idle state for the current CPU.
+ * @idle_state: State to record.
+ */
+void sched_idle_set_state(struct cpuidle_state *idle_state)
+{
+	idle_set_state(this_rq(), idle_state);
+}
+
 static int __read_mostly cpu_idle_force_poll;
 
 void cpu_idle_poll_ctrl(bool enable)
@@ -100,9 +109,6 @@ static int call_cpuidle(struct cpuidle_d
 		return -EBUSY;
 	}
 
-	/* Take note of the planned idle state. */
-	idle_set_state(this_rq(), &drv->states[next_state]);
-
 	/*
 	 * Enter the idle state previously returned by the governor decision.
 	 * This function will block until an interrupt occurs and will take
@@ -110,9 +116,6 @@ static int call_cpuidle(struct cpuidle_d
 	 */
 	entered_state = cpuidle_enter(drv, dev, next_state);
 
-	/* The cpu is no longer idle or about to enter idle. */
-	idle_set_state(this_rq(), NULL);
-
 	if (entered_state == -EBUSY)
 		default_idle_call();
 
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -170,6 +170,9 @@ int cpuidle_enter_state(struct cpuidle_d
 	if (broadcast && tick_broadcast_enter())
 		return -EBUSY;
 
+	/* Take note of the planned idle state. */
+	sched_idle_set_state(target_state);
+
 	trace_cpu_idle_rcuidle(index, dev->cpu);
 	time_start = ktime_get();
 
@@ -178,6 +181,9 @@ int cpuidle_enter_state(struct cpuidle_d
 	time_end = ktime_get();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
+	/* The cpu is no longer idle or about to enter idle. */
+	sched_idle_set_state(NULL);
+
 	if (broadcast) {
 		if (WARN_ON_ONCE(!irqs_disabled()))
 			local_irq_disable();
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -200,6 +200,9 @@ static inline struct cpuidle_driver *cpu
 	struct cpuidle_device *dev) {return NULL; }
 #endif
 
+/* kernel/sched/idle.c */
+extern void sched_idle_set_state(struct cpuidle_state *idle_state);
+
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomic_t *a);
 #else
