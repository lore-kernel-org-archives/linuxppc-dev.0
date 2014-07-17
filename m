Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A7E21A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 09:10:11 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 17:10:09 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0D6A11FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 17:10:06 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6HL6QOd10027266
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 23:06:26 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6HNA5tJ023522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 17:10:06 -0600
Date: Thu, 17 Jul 2014 16:09:58 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC 1/2] workqueue: use the nearest NUMA node, not the local one
Message-ID: <20140717230958.GB32660@linux.vnet.ibm.com>
References: <20140717230923.GA32660@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140717230923.GA32660@linux.vnet.ibm.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Jiang Liu <jiang.liu@linux.intel.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the presence of memoryless nodes, the workqueue code incorrectly uses
cpu_to_node() to determine what node to prefer memory allocations come
from. cpu_to_mem() should be used instead, which will use the nearest
NUMA node with memory.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 35974ac..0bba022 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3547,7 +3547,12 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 		for_each_node(node) {
 			if (cpumask_subset(pool->attrs->cpumask,
 					   wq_numa_possible_cpumask[node])) {
-				pool->node = node;
+				/*
+				 * We could use local_memory_node(node) here,
+				 * but it is expensive and the following caches
+				 * the same value.
+				 */
+				pool->node = cpu_to_mem(cpumask_first(pool->attrs->cpumask));
 				break;
 			}
 		}
@@ -4921,7 +4926,7 @@ static int __init init_workqueues(void)
 			pool->cpu = cpu;
 			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
 			pool->attrs->nice = std_nice[i++];
-			pool->node = cpu_to_node(cpu);
+			pool->node = cpu_to_mem(cpu);
 
 			/* alloc pool ID */
 			mutex_lock(&wq_pool_mutex);
