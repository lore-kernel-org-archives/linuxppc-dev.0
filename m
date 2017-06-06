Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whtqN0M7DzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 00:09:51 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v56E8lkA007128
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Jun 2017 10:09:44 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awp6bs2yc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 10:09:44 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 6 Jun 2017 10:09:44 -0400
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann from Kernel Team <mbringm@us.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v2] workqueue: Fix edge cases for calc of pool's cpumask
Date: Tue, 6 Jun 2017 09:09:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <735de0b9-13bb-e245-397c-2d12ca03f833@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On NUMA systems with dynamic processors, the content of the cpumask
may change over time.  As new processors are added via DLPAR operations,
workqueues are created for them.  Depending upon the order in which CPUs
are added/removed, we may run into problems with the content of the
cpumask used by the workqueues.  This patch deals with situations where
the online cpumask for a node is a proper superset of possible cpumask
for the node.  It also deals with edge cases where the order in which
CPUs are removed/added from the online cpumask may leave the set for a
node empty, and require execution by CPUs on another node.

In these and other cases, the patch attempts to ensure that a valid,
usable cpumask is used to set up newly created pools for workqueues.

Signed-off-by: Tejun Heo <tj@kernel.org> & Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V2:
  -- Merge in additional logic fixes provided by Tejun Heo.
  -- Revise safety check added to get_unbound_pool to trigger only
     in the event of a dangerously invalid cpumask attribute.
---
 kernel/workqueue.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c74bf39..460de61 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3366,6 +3366,9 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 	copy_workqueue_attrs(pool->attrs, attrs);
 	pool->node = target_node;
 
+	if (!cpumask_weight(pool->attrs->cpumask))
+		cpumask_copy(pool->attrs->cpumask, cpumask_of(smp_processor_id()));
+
 	/*
 	 * no_numa isn't a worker_pool attribute, always clear it.  See
 	 * 'struct workqueue_attrs' comments for detail.
@@ -3559,13 +3562,13 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  * stable.
  *
  * Return: %true if the resulting @cpumask is different from @attrs->cpumask,
- * %false if equal.
+ * %false if equal.  On %false return, the content of @cpumask is undefined.
  */
 static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
 				 int cpu_going_down, cpumask_t *cpumask)
 {
 	if (!wq_numa_enabled || attrs->no_numa)
-		goto use_dfl;
+		return false;
 
 	/* does @node have any online CPUs @attrs wants? */
 	cpumask_and(cpumask, cpumask_of_node(node), attrs->cpumask);
@@ -3573,15 +3576,13 @@ static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
 		cpumask_clear_cpu(cpu_going_down, cpumask);
 
 	if (cpumask_empty(cpumask))
-		goto use_dfl;
+		return false;
 
 	/* yeap, return possible CPUs in @node that @attrs wants */
 	cpumask_and(cpumask, attrs->cpumask, wq_numa_possible_cpumask[node]);
-	return !cpumask_equal(cpumask, attrs->cpumask);
 
-use_dfl:
-	cpumask_copy(cpumask, attrs->cpumask);
-	return false;
+	return !cpumask_empty(cpumask) &&
+		!cpumask_equal(cpumask, attrs->cpumask);
 }
 
 /* install @pwq into @wq's numa_pwq_tbl[] for @node and return the old pwq */
