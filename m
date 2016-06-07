Return-Path: <ego@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPFVM5v8XzDqYl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 01:14:51 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 7 Jun 2016 09:14:48 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a node
 with 1 online CPU
Date: Tue,  7 Jun 2016 20:44:03 +0530
Message-Id: <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1465311052.git.ego@linux.vnet.ibm.com>
References: <5756BE20.3040208@linux.vnet.ibm.com>
 <cover.1465311052.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1465311052.git.ego@linux.vnet.ibm.com>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit e9d867a67fd03ccc ("sched: Allow per-cpu kernel threads to
run on online && !active"), __set_cpus_allowed_ptr() expects that only
strict per-cpu kernel threads can have affinity to an online CPU which
is not yet active.

This assumption is currently broken in the CPU_ONLINE notification
handler for the workqueues where restore_unbound_workers_cpumask()
calls set_cpus_allowed_ptr() when the first cpu in the unbound
worker's pool->attr->cpumask comes online. Since
set_cpus_allowed_ptr() is called with pool->attr->cpumask in which
only one CPU is online which is not yet active, we get the following
WARN_ON during an CPU online operation.

------------[ cut here ]------------
WARNING: CPU: 40 PID: 248 at kernel/sched/core.c:1166
__set_cpus_allowed_ptr+0x228/0x2e0
Modules linked in:
CPU: 40 PID: 248 Comm: cpuhp/40 Not tainted 4.6.0-autotest+ #4
<..snip..>
Call Trace:
[c000000f273ff920] [c00000000010493c] __set_cpus_allowed_ptr+0x2cc/0x2e0 (unreliable)
[c000000f273ffac0] [c0000000000ed4b0] workqueue_cpu_up_callback+0x2c0/0x470
[c000000f273ffb70] [c0000000000f5c58] notifier_call_chain+0x98/0x100
[c000000f273ffbc0] [c0000000000c5ed0] __cpu_notify+0x70/0xe0
[c000000f273ffc00] [c0000000000c6028] notify_online+0x38/0x50
[c000000f273ffc30] [c0000000000c5214] cpuhp_invoke_callback+0x84/0x250
[c000000f273ffc90] [c0000000000c562c] cpuhp_up_callbacks+0x5c/0x120
[c000000f273ffce0] [c0000000000c64d4] cpuhp_thread_fun+0x184/0x1c0
[c000000f273ffd20] [c0000000000fa050] smpboot_thread_fn+0x290/0x2a0
[c000000f273ffd80] [c0000000000f45b0] kthread+0x110/0x130
[c000000f273ffe30] [c000000000009570] ret_from_kernel_thread+0x5c/0x6c
---[ end trace 00f1456578b2a3b2 ]---

This patch sets the affinity of the worker to
a) the only online CPU in the cpumask of the worker pool when it comes
   online.
b) the cpumask of the worker pool when the second CPU in the pool's
   cpumask comes online.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 kernel/workqueue.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e412794..1199f73 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4586,7 +4586,7 @@ static void rebind_workers(struct worker_pool *pool)
  *
  * An unbound pool may end up with a cpumask which doesn't have any online
  * CPUs.  When a worker of such pool get scheduled, the scheduler resets
- * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
+ * its cpus_allowed.  If @cpu is in @pool's cpumask which had at most one
  * online CPU before, cpus_allowed of all its workers should be restored.
  */
 static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
@@ -4600,15 +4600,26 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
 		return;
 
-	/* is @cpu the only online CPU? */
 	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
-	if (cpumask_weight(&cpumask) != 1)
+
+	/*
+	 * The affinity needs to be set
+	 * a) to @cpu when that is the only online CPU in
+	 *    pool->attrs->cpumask.
+	 * b) to pool->attrs->cpumask when exactly two CPUs in
+	 *    pool->attrs->cpumask are online. This affinity will be
+	 *    retained when subsequent CPUs come online.
+	 */
+	if (cpumask_weight(&cpumask) > 2)
 		return;
 
+	if (cpumask_weight(&cpumask) == 2)
+		cpumask_copy(&cpumask, pool->attrs->cpumask);
+
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
+						  &cpumask) < 0);
 }
 
 /*
-- 
1.9.3
