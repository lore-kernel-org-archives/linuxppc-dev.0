Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsFkX5MfLzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 05:49:56 +1000 (AEST)
Message-Id: <20170912194147.862865570@linutronix.de>
Date: Tue, 12 Sep 2017 21:37:16 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [patch V2 22/29] lockup_detector: Make watchdog_nmi_reconfigure() two
 stage
References: <20170912193654.321505854@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Both the perf reconfiguration and the powerpc watchdog_nmi_reconfigure()
need to be done in two steps.

     1) Stop all NMIs
     2) Read the new parameters and start NMIs

Right now watchdog_nmi_reconfigure() is a combination of both. To allow a
clean reconfiguration add a 'run' argument and split the functionality in
powerpc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170831073054.740462115@linutronix.de

---
 arch/powerpc/kernel/watchdog.c |   17 +++++++++--------
 include/linux/nmi.h            |    2 ++
 kernel/watchdog.c              |   31 ++++++++++++++++++++++---------
 3 files changed, 33 insertions(+), 17 deletions(-)

--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -355,17 +355,18 @@ static void watchdog_calc_timeouts(void)
 	wd_timer_period_ms = watchdog_thresh * 1000 * 2 / 5;
 }
 
-void watchdog_nmi_reconfigure(void)
+void watchdog_nmi_reconfigure(bool run)
 {
 	int cpu;
 
-	watchdog_calc_timeouts();
-
-	for_each_cpu(cpu, &wd_cpus_enabled)
-		stop_wd_on_cpu(cpu);
-
-	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
-		start_wd_on_cpu(cpu);
+	if (!run) {
+		for_each_cpu(cpu, &wd_cpus_enabled)
+			stop_wd_on_cpu(cpu);
+	} else {
+		watchdog_calc_timeouts();
+		for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
+			start_wd_on_cpu(cpu);
+	}
 }
 
 /*
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -103,6 +103,8 @@ static inline void arch_touch_nmi_watchd
 #endif
 #endif
 
+void watchdog_nmi_reconfigure(bool run);
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  *
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -112,17 +112,25 @@ void __weak watchdog_nmi_disable(unsigne
 	hardlockup_detector_perf_disable();
 }
 
-/*
- * watchdog_nmi_reconfigure can be implemented to be notified after any
- * watchdog configuration change. The arch hardlockup watchdog should
- * respond to the following variables:
+/**
+ * watchdog_nmi_reconfigure - Optional function to reconfigure NMI watchdogs
+ * @run:	If false stop the watchdogs on all enabled CPUs
+ *		If true start the watchdogs on all enabled CPUs
+ *
+ * The core call order is:
+ * watchdog_nmi_reconfigure(false);
+ * update_variables();
+ * watchdog_nmi_reconfigure(true);
+ *
+ * The second call which starts the watchdogs again guarantees that the
+ * following variables are stable across the call.
  * - watchdog_enabled
  * - watchdog_thresh
  * - watchdog_cpumask
- * - sysctl_hardlockup_all_cpu_backtrace
- * - hardlockup_panic
+ *
+ * After the call the variables can be changed again.
  */
-void __weak watchdog_nmi_reconfigure(void) { }
+void __weak watchdog_nmi_reconfigure(bool run) { }
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
@@ -515,10 +523,12 @@ static void softlockup_unpark_threads(vo
 
 static void softlockup_reconfigure_threads(bool enabled)
 {
+	watchdog_nmi_reconfigure(false);
 	softlockup_park_all_threads();
 	set_sample_period();
 	if (enabled)
 		softlockup_unpark_threads();
+	watchdog_nmi_reconfigure(true);
 }
 
 /*
@@ -559,7 +569,11 @@ static inline void watchdog_unpark_threa
 static inline int watchdog_enable_all_cpus(void) { return 0; }
 static inline void watchdog_disable_all_cpus(void) { }
 static inline void softlockup_init_threads(void) { }
-static inline void softlockup_reconfigure_threads(bool enabled) { }
+static void softlockup_reconfigure_threads(bool enabled)
+{
+	watchdog_nmi_reconfigure(false);
+	watchdog_nmi_reconfigure(true);
+}
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
 static void __lockup_detector_cleanup(void)
@@ -599,7 +613,6 @@ static void proc_watchdog_update(void)
 	/* Remove impossible cpus to keep sysctl output clean. */
 	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
 	softlockup_reconfigure_threads(watchdog_enabled && watchdog_thresh);
-	watchdog_nmi_reconfigure();
 }
 
 /*
