Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 125892C02AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:42:05 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:10:06 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CEEE4394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:12:00 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICfuKe16056344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:11:57 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICfvAQ013463
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:42:00 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 12/46] sched/timer: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:10:01 +0530
Message-ID: <20130218124000.26245.20162.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |   24 +++++++++++++++++++++---
 kernel/sched/fair.c |    5 ++++-
 kernel/timer.c      |    2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 26058d0..ead8af6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1117,11 +1117,11 @@ void kick_process(struct task_struct *p)
 {
 	int cpu;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpu = task_cpu(p);
 	if ((cpu != smp_processor_id()) && task_curr(p))
 		smp_send_reschedule(cpu);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL_GPL(kick_process);
 #endif /* CONFIG_SMP */
@@ -1129,6 +1129,10 @@ EXPORT_SYMBOL_GPL(kick_process);
 #ifdef CONFIG_SMP
 /*
  * ->cpus_allowed is protected by both rq->lock and p->pi_lock
+ *
+ *  Must be called under get/put_online_cpus_atomic() or
+ *  equivalent, to avoid CPUs from going offline from underneath
+ *  us.
  */
 static int select_fallback_rq(int cpu, struct task_struct *p)
 {
@@ -1192,6 +1196,9 @@ out:
 
 /*
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_allowed is stable.
+ *
+ * Must be called under get/put_online_cpus_atomic(), to prevent
+ * CPUs from going offline from underneath us.
  */
 static inline
 int select_task_rq(struct task_struct *p, int sd_flags, int wake_flags)
@@ -1432,6 +1439,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	int cpu, success = 0;
 
 	smp_wmb();
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	if (!(p->state & state))
 		goto out;
@@ -1472,6 +1480,7 @@ stat:
 	ttwu_stat(p, cpu, wake_flags);
 out:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	put_online_cpus_atomic();
 
 	return success;
 }
@@ -1693,6 +1702,7 @@ void wake_up_new_task(struct task_struct *p)
 	unsigned long flags;
 	struct rq *rq;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 #ifdef CONFIG_SMP
 	/*
@@ -1713,6 +1723,7 @@ void wake_up_new_task(struct task_struct *p)
 		p->sched_class->task_woken(rq, p);
 #endif
 	task_rq_unlock(rq, p, &flags);
+	put_online_cpus_atomic();
 }
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
@@ -2610,6 +2621,7 @@ void sched_exec(void)
 	unsigned long flags;
 	int dest_cpu;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	dest_cpu = p->sched_class->select_task_rq(p, SD_BALANCE_EXEC, 0);
 	if (dest_cpu == smp_processor_id())
@@ -2619,11 +2631,13 @@ void sched_exec(void)
 		struct migration_arg arg = { p, dest_cpu };
 
 		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+		put_online_cpus_atomic();
 		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
 		return;
 	}
 unlock:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	put_online_cpus_atomic();
 }
 
 #endif
@@ -4373,6 +4387,7 @@ bool __sched yield_to(struct task_struct *p, bool preempt)
 	unsigned long flags;
 	bool yielded = 0;
 
+	get_online_cpus_atomic();
 	local_irq_save(flags);
 	rq = this_rq();
 
@@ -4400,13 +4415,14 @@ again:
 		 * Make p's CPU reschedule; pick_next_entity takes care of
 		 * fairness.
 		 */
-		if (preempt && rq != p_rq)
+		if (preempt && rq != p_rq && cpu_online(task_cpu(p)))
 			resched_task(p_rq->curr);
 	}
 
 out:
 	double_rq_unlock(rq, p_rq);
 	local_irq_restore(flags);
+	put_online_cpus_atomic();
 
 	if (yielded)
 		schedule();
@@ -4811,9 +4827,11 @@ static int migration_cpu_stop(void *data)
 	 * The original target cpu might have gone down and we might
 	 * be on another cpu but it doesn't matter.
 	 */
+	get_online_cpus_atomic();
 	local_irq_disable();
 	__migrate_task(arg->task, raw_smp_processor_id(), arg->dest_cpu);
 	local_irq_enable();
+	put_online_cpus_atomic();
 	return 0;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81fa536..c602d5c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5695,8 +5695,11 @@ void trigger_load_balance(struct rq *rq, int cpu)
 	    likely(!on_null_domain(cpu)))
 		raise_softirq(SCHED_SOFTIRQ);
 #ifdef CONFIG_NO_HZ
-	if (nohz_kick_needed(rq, cpu) && likely(!on_null_domain(cpu)))
+	if (nohz_kick_needed(rq, cpu) && likely(!on_null_domain(cpu))) {
+		get_online_cpus_atomic();
 		nohz_balancer_kick(cpu);
+		put_online_cpus_atomic();
+	}
 #endif
 }
 
diff --git a/kernel/timer.c b/kernel/timer.c
index 367d008..b1820e3 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -924,6 +924,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(timer_pending(timer) || !timer->function);
+	get_online_cpus_atomic();
 	spin_lock_irqsave(&base->lock, flags);
 	timer_set_base(timer, base);
 	debug_activate(timer, timer->expires);
@@ -938,6 +939,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 */
 	wake_up_idle_cpu(cpu);
 	spin_unlock_irqrestore(&base->lock, flags);
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
