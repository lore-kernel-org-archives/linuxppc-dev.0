Return-Path: <ego@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPFVH5pl3zDqHQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 01:14:47 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 7 Jun 2016 09:14:42 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the beginning
 of CPU_ONLINE
Date: Tue,  7 Jun 2016 20:44:02 +0530
Message-Id: <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
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

Currently in the CPU_ONLINE workqueue handler, the
restore_unbound_workers_cpumask() will never call
set_cpus_allowed_ptr() for a newly created unbound worker thread.

This is because the function which creates a new unbound worker thread
when the first CPU in the node comes online [wq_update_unbound_numa()]
is invoked after the call to restore_unbound_workers_cpumask(). Thus
the affinity is never set for this worker thread when the first CPU in
the node comes online.

Furthermore, due to an optimization in
restore_unbound_workers_cpumask(), set_cpus_allowed_ptr() is not
called when subsequent CPUs in the node come online since it assumes
that the affinity would have been set when the first CPU has come
online.

This patch fixes this issue by invoking wq_update_unbound_numa()
before the calling restore_unbound_workers_cpumask().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 kernel/workqueue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e1c0e99..e412794 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4638,6 +4638,10 @@ static int workqueue_cpu_up_callback(struct notifier_block *nfb,
 	case CPU_ONLINE:
 		mutex_lock(&wq_pool_mutex);
 
+		/* update NUMA affinity of unbound workqueues */
+		list_for_each_entry(wq, &workqueues, list)
+			wq_update_unbound_numa(wq, cpu, true);
+
 		for_each_pool(pool, pi) {
 			mutex_lock(&pool->attach_mutex);
 
@@ -4649,10 +4653,6 @@ static int workqueue_cpu_up_callback(struct notifier_block *nfb,
 			mutex_unlock(&pool->attach_mutex);
 		}
 
-		/* update NUMA affinity of unbound workqueues */
-		list_for_each_entry(wq, &workqueues, list)
-			wq_update_unbound_numa(wq, cpu, true);
-
 		mutex_unlock(&wq_pool_mutex);
 		break;
 	}
-- 
1.9.3
