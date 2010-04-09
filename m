Return-Path: <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 09 Apr 2010 16:21:19 +1000
Subject: [PATCH 5/5] sched: make fix_small_imbalance work with asymmetric
	packing
In-Reply-To: <1270794078.794237.347827867455.qpush@pale>
Message-Id: <20100409062119.10AC5CBB6D@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the asymmetric packing infrastructure, fix_small_imbalance is
causing idle higher threads to pull tasks off lower threads.  

This is being caused by an off-by-one error.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
I'm not sure this is the right fix but without it, higher threads pull
tasks off the lower threads, then the packing pulls it back down, etc
etc and tasks bounce around constantly.

---

 kernel/sched_fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-ozlabs/kernel/sched_fair.c
===================================================================
--- linux-2.6-ozlabs.orig/kernel/sched_fair.c
+++ linux-2.6-ozlabs/kernel/sched_fair.c
@@ -2652,7 +2652,7 @@ static inline void fix_small_imbalance(s
 						 * SCHED_LOAD_SCALE;
 	scaled_busy_load_per_task /= sds->busiest->cpu_power;
 
-	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >=
+	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >
 			(scaled_busy_load_per_task * imbn)) {
 		*imbalance = sds->busiest_load_per_task;
 		return;
