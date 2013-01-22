Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E52EE2C06B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:39:25 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 17:36:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 703412BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:39:20 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7RPtR63504542
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:27:26 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7dIWg009896
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:39:19 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 16/45] time/clocksource: Use get/put_online_cpus_atomic()
 to prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:07:19 +0530
Message-ID: <20130122073713.13822.11706.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from going
offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/time/clocksource.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c958338..1c8d735 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/cpu.h>
 
 void timecounter_init(struct timecounter *tc,
 		      const struct cyclecounter *cc,
@@ -320,11 +321,13 @@ static void clocksource_watchdog(unsigned long data)
 	 * Cycle through CPUs to check if the CPUs stay synchronized
 	 * to each other.
 	 */
+	get_online_cpus_atomic();
 	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
 	if (next_cpu >= nr_cpu_ids)
 		next_cpu = cpumask_first(cpu_online_mask);
 	watchdog_timer.expires += WATCHDOG_INTERVAL;
 	add_timer_on(&watchdog_timer, next_cpu);
+	put_online_cpus_atomic();
 out:
 	spin_unlock(&watchdog_lock);
 }
@@ -336,7 +339,9 @@ static inline void clocksource_start_watchdog(void)
 	init_timer(&watchdog_timer);
 	watchdog_timer.function = clocksource_watchdog;
 	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
+	get_online_cpus_atomic();
 	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
+	put_online_cpus_atomic();
 	watchdog_running = 1;
 }
 
