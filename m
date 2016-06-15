Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV4Bg5y1czDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:32:59 +1000 (AEST)
Date: Wed, 15 Jun 2016 13:32:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160615113249.GH30909@twins.programming.kicks-ass.net>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615101936.GA31671@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2016 at 03:49:36PM +0530, Gautham R Shenoy wrote:

> Also, with the first patch in the series (which ensures that
> restore_unbound_workers are called *after* the new workers for the
> newly onlined CPUs are created) and without this one, you can
> reproduce this WARN_ON on both x86 and PPC by offlining all the CPUs
> of a node and bringing just one of them online.

Ah good.

> I am not sure about that. The workqueue creates unbound workers for a
> node via wq_update_unbound_numa() whenever the first CPU of every node
> comes online. So that seems legitimate. It then tries to affine these
> workers to the cpumask of that node. Again this seems right. As an
> optimization, it does this only when the first CPU of the node comes
> online. Since this online CPU is not yet active, and since
> nr_cpus_allowed > 1, we will hit the WARN_ON().

So I had another look and isn't the below a much simpler solution?

It seems to work on my x86 with:

  for i in /sys/devices/system/cpu/cpu*/online ; do echo 0 > $i ; done
  for i in /sys/devices/system/cpu/cpu*/online ; do echo 1 > $i ; done

without complaint.

---
 kernel/workqueue.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e1c0e99..09c9160 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4600,15 +4600,11 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
 		return;
 
-	/* is @cpu the only online CPU? */
 	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
-	if (cpumask_weight(&cpumask) != 1)
-		return;
 
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
 }
 
 /*
@@ -4638,6 +4634,10 @@ static int workqueue_cpu_up_callback(struct notifier_block *nfb,
 	case CPU_ONLINE:
 		mutex_lock(&wq_pool_mutex);
 
+		/* update NUMA affinity of unbound workqueues */
+		list_for_each_entry(wq, &workqueues, list)
+			wq_update_unbound_numa(wq, cpu, true);
+
 		for_each_pool(pool, pi) {
 			mutex_lock(&pool->attach_mutex);
 
@@ -4649,10 +4649,6 @@ static int workqueue_cpu_up_callback(struct notifier_block *nfb,
 			mutex_unlock(&pool->attach_mutex);
 		}
 
-		/* update NUMA affinity of unbound workqueues */
-		list_for_each_entry(wq, &workqueues, list)
-			wq_update_unbound_numa(wq, cpu, true);
-
 		mutex_unlock(&wq_pool_mutex);
 		break;
 	}
