Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 67D291A0031
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 08:55:25 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org
Subject: [PATCH 2/3] sched / idle: Call default_idle_call() from
 cpuidle_enter_state()
Date: Sun, 10 May 2015 01:18:46 +0200
Message-ID: <7884557.lRUSRr1Rsc@vostro.rjw.lan>
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

The check of the cpuidle_enter() return value against -EBUSY
made in call_cpuidle() will not be necessary any more if
cpuidle_enter_state() calls default_idle_call() directly when it
is about to return -EBUSY, so make that happen and eliminate the
check.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    4 +++-
 include/linux/cpuidle.h   |    1 +
 kernel/sched/idle.c       |   20 +++++++-------------
 3 files changed, 11 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -167,8 +167,10 @@ int cpuidle_enter_state(struct cpuidle_d
 	 * local timer will be shut down.  If a local timer is used from another
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
-	if (broadcast && tick_broadcast_enter())
+	if (broadcast && tick_broadcast_enter()) {
+		default_idle_call();
 		return -EBUSY;
+	}
 
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -76,12 +76,13 @@ void __weak arch_cpu_idle(void)
 	local_irq_enable();
 }
 
-static void default_idle_call(void)
+/**
+ * default_idle_call - Default CPU idle routine.
+ *
+ * To use when the cpuidle framework cannot be used.
+ */
+void default_idle_call(void)
 {
-	/*
-	 * We can't use the cpuidle framework, let's use the default idle
-	 * routine.
-	 */
 	if (current_clr_polling_and_test())
 		local_irq_enable();
 	else
@@ -91,8 +92,6 @@ static void default_idle_call(void)
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      int next_state)
 {
-	int entered_state;
-
 	/* Fall back to the default arch idle method on errors. */
 	if (next_state < 0) {
 		default_idle_call();
@@ -114,12 +113,7 @@ static int call_cpuidle(struct cpuidle_d
 	 * This function will block until an interrupt occurs and will take
 	 * care of re-enabling the local interrupts
 	 */
-	entered_state = cpuidle_enter(drv, dev, next_state);
-
-	if (entered_state == -EBUSY)
-		default_idle_call();
-
-	return entered_state;
+	return cpuidle_enter(drv, dev, next_state);
 }
 
 /**
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -202,6 +202,7 @@ static inline struct cpuidle_driver *cpu
 
 /* kernel/sched/idle.c */
 extern void sched_idle_set_state(struct cpuidle_state *idle_state);
+extern void default_idle_call(void);
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomic_t *a);
