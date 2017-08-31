Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjYwy0Ps1zDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 17:32:18 +1000 (AEST)
Message-Id: <20170831073054.740462115@linutronix.de>
Date: Thu, 31 Aug 2017 09:16:20 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [patch 22/29] lockup_detector: Make watchdog_nmi_reconfigure() two
 stage
References: <20170831071558.995235362@linutronix.de>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/watchdog.c |   17 +++++++++--------
 include/linux/nmi.h            |    2 ++
 kernel/watchdog.c              |   31 ++++++++++++++++++++++---------
 3 files changed, 33 insertions(+), 17 deletions(-)

--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -352,17 +352,18 @@ static void watchdog_calc_timeouts(void)
 	wd_timer_period_ms = watchdog_thresh * 1000 * 2 / 5;
 }
 
-void watchdog_nmi_reconfigure(void)
+void watchdog_nmi_reconfigure(bool stop)
 {
 	int cpu;
 
-	watchdog_calc_timeouts();
-
-	for_each_cpu(cpu, &wd_cpus_enabled)
-		stop_wd_on_cpu(cpu);
-
-	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
-		start_wd_on_cpu(cpu);
+	if (stop) {
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
@@ -105,17 +105,25 @@ static int __init hardlockup_all_cpu_bac
 int __weak watchdog_nmi_enable(unsigned int cpu) { return 0; }
 void __weak watchdog_nmi_disable(unsigned int cpu) { }
 
-/*
- * watchdog_nmi_reconfigure can be implemented to be notified after any
- * watchdog configuration change. The arch hardlockup watchdog should
- * respond to the following variables:
+/**
+ * watchdog_nmi_reconfigure - Optional function to reconfigure NMI watchdogs
+ * @stop:	If true stop the watchdogs on all enabled CPUs
+ *		If false start the watchdogs on all enabled CPUs
+ *
+ * The core call order is:
+ * watchdog_nmi_reconfigure(true);
+ * update_variables();
+ * watchdog_nmi_reconfigure(false);
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
+void __weak watchdog_nmi_reconfigure(bool stop) { }
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
@@ -509,10 +517,12 @@ static void softlockup_unpark_threads(vo
 
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
@@ -553,7 +563,11 @@ static inline void watchdog_unpark_threa
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
@@ -593,7 +607,6 @@ static void proc_watchdog_update(void)
 	/* Remove impossible cpus to keep sysctl output clean. */
 	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
 	softlockup_reconfigure_threads(watchdog_enabled && watchdog_thresh);
-	watchdog_nmi_reconfigure();
 }
 
 /*
