Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8F3E2C08EE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:43:47 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:09:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CE75F1258051
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:12:43 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDhcjc28770520
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:13:38 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDhe3C001398
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:43:42 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 10/45] sched/core: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:10:27 +0530
Message-ID: <20130623134020.19094.59333.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, Ingo Molnar <mingo@redhat.com>,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 195658b..accd550 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1160,11 +1160,11 @@ void kick_process(struct task_struct *p)
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
@@ -1172,6 +1172,9 @@ EXPORT_SYMBOL_GPL(kick_process);
 #ifdef CONFIG_SMP
 /*
  * ->cpus_allowed is protected by both rq->lock and p->pi_lock
+ *
+ *  Must be called within get/put_online_cpus_atomic(), to prevent
+ *  CPUs from going offline from under us.
  */
 static int select_fallback_rq(int cpu, struct task_struct *p)
 {
@@ -1245,6 +1248,9 @@ out:
 
 /*
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_allowed is stable.
+ *
+ * Must be called within get/put_online_cpus_atomic(), to prevent
+ * CPUs from going offline from under us.
  */
 static inline
 int select_task_rq(struct task_struct *p, int sd_flags, int wake_flags)
@@ -1489,6 +1495,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	get_online_cpus_atomic();
+
 	smp_wmb();
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	if (!(p->state & state))
@@ -1531,6 +1539,7 @@ stat:
 out:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
+	put_online_cpus_atomic();
 	return success;
 }
 
@@ -1753,6 +1762,8 @@ void wake_up_new_task(struct task_struct *p)
 	unsigned long flags;
 	struct rq *rq;
 
+	get_online_cpus_atomic();
+
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 #ifdef CONFIG_SMP
 	/*
@@ -1773,6 +1784,8 @@ void wake_up_new_task(struct task_struct *p)
 		p->sched_class->task_woken(rq, p);
 #endif
 	task_rq_unlock(rq, p, &flags);
+
+	put_online_cpus_atomic();
 }
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
@@ -3886,6 +3899,8 @@ bool __sched yield_to(struct task_struct *p, bool preempt)
 	unsigned long flags;
 	int yielded = 0;
 
+	get_online_cpus_atomic();
+
 	local_irq_save(flags);
 	rq = this_rq();
 
@@ -3931,6 +3946,8 @@ out_unlock:
 out_irq:
 	local_irq_restore(flags);
 
+	put_online_cpus_atomic();
+
 	if (yielded > 0)
 		schedule();
 
@@ -4331,9 +4348,11 @@ static int migration_cpu_stop(void *data)
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
 
