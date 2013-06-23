Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D5BD2C0685
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:06 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:07:11 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E74B93940053
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:14:01 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDhvD321692500
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:13:57 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDi0qD010607
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:01 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 12/45] sched/fair: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:10:47 +0530
Message-ID: <20130623134043.19094.8381.stgit@srivatsabhat.in.ibm.com>
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

 kernel/sched/fair.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c0ac2c3..88f056e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3338,7 +3338,8 @@ done:
  *
  * Returns the target CPU number, or the same CPU if no balancing is needed.
  *
- * preempt must be disabled.
+ * Must be called within get/put_online_cpus_atomic(), to prevent CPUs
+ * from going offline from under us.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int sd_flag, int wake_flags)
@@ -5267,6 +5268,8 @@ void idle_balance(int this_cpu, struct rq *this_rq)
 	raw_spin_unlock(&this_rq->lock);
 
 	update_blocked_averages(this_cpu);
+
+	get_online_cpus_atomic();
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		unsigned long interval;
@@ -5290,6 +5293,7 @@ void idle_balance(int this_cpu, struct rq *this_rq)
 		}
 	}
 	rcu_read_unlock();
+	put_online_cpus_atomic();
 
 	raw_spin_lock(&this_rq->lock);
 
@@ -5316,6 +5320,7 @@ static int active_load_balance_cpu_stop(void *data)
 	struct rq *target_rq = cpu_rq(target_cpu);
 	struct sched_domain *sd;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irq(&busiest_rq->lock);
 
 	/* make sure the requested cpu hasn't gone down in the meantime */
@@ -5367,6 +5372,7 @@ static int active_load_balance_cpu_stop(void *data)
 out_unlock:
 	busiest_rq->active_balance = 0;
 	raw_spin_unlock_irq(&busiest_rq->lock);
+	put_online_cpus_atomic();
 	return 0;
 }
 
@@ -5527,6 +5533,7 @@ static void rebalance_domains(int cpu, enum cpu_idle_type idle)
 
 	update_blocked_averages(cpu);
 
+	get_online_cpus_atomic();
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -5575,6 +5582,7 @@ out:
 			break;
 	}
 	rcu_read_unlock();
+	put_online_cpus_atomic();
 
 	/*
 	 * next_balance will be updated only when there is a need.
@@ -5706,6 +5714,7 @@ static void run_rebalance_domains(struct softirq_action *h)
 	enum cpu_idle_type idle = this_rq->idle_balance ?
 						CPU_IDLE : CPU_NOT_IDLE;
 
+	get_online_cpus_atomic();
 	rebalance_domains(this_cpu, idle);
 
 	/*
@@ -5714,6 +5723,7 @@ static void run_rebalance_domains(struct softirq_action *h)
 	 * stopped.
 	 */
 	nohz_idle_balance(this_cpu, idle);
+	put_online_cpus_atomic();
 }
 
 static inline int on_null_domain(int cpu)
@@ -5731,8 +5741,10 @@ void trigger_load_balance(struct rq *rq, int cpu)
 	    likely(!on_null_domain(cpu)))
 		raise_softirq(SCHED_SOFTIRQ);
 #ifdef CONFIG_NO_HZ_COMMON
+	get_online_cpus_atomic();
 	if (nohz_kick_needed(rq, cpu) && likely(!on_null_domain(cpu)))
 		nohz_balancer_kick(cpu);
+	put_online_cpus_atomic();
 #endif
 }
 
