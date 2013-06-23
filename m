Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E0762C09A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:26 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:09:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A4C4CE0054
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:13:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDiX1P16777314
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:14:33 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDiJje004555
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 13:44:21 GMT
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 14/45] sched/rt: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:11:07 +0530
Message-ID: <20130623134103.19094.5606.stgit@srivatsabhat.in.ibm.com>
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

 kernel/sched/rt.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 01970c8..03d9f38 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -6,6 +6,7 @@
 #include "sched.h"
 
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 int sched_rr_timeslice = RR_TIMESLICE;
 
@@ -28,7 +29,9 @@ static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		get_online_cpus_atomic();
 		idle = do_sched_rt_period_timer(rt_b, overrun);
+		put_online_cpus_atomic();
 	}
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
@@ -547,6 +550,7 @@ static int do_balance_runtime(struct rt_rq *rt_rq)
 	int i, weight, more = 0;
 	u64 rt_period;
 
+	get_online_cpus_atomic();
 	weight = cpumask_weight(rd->span);
 
 	raw_spin_lock(&rt_b->rt_runtime_lock);
@@ -588,6 +592,7 @@ next:
 		raw_spin_unlock(&iter->rt_runtime_lock);
 	}
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
+	put_online_cpus_atomic();
 
 	return more;
 }
@@ -1168,6 +1173,10 @@ static void yield_task_rt(struct rq *rq)
 #ifdef CONFIG_SMP
 static int find_lowest_rq(struct task_struct *task);
 
+/*
+ * Must be called within get/put_online_cpus_atomic(), to prevent CPUs
+ * from going offline from under us.
+ */
 static int
 select_task_rq_rt(struct task_struct *p, int sd_flag, int flags)
 {
@@ -1561,6 +1570,8 @@ retry:
 		return 0;
 	}
 
+	get_online_cpus_atomic();
+
 	/* We might release rq lock */
 	get_task_struct(next_task);
 
@@ -1611,6 +1622,7 @@ retry:
 out:
 	put_task_struct(next_task);
 
+	put_online_cpus_atomic();
 	return ret;
 }
 
@@ -1630,6 +1642,7 @@ static int pull_rt_task(struct rq *this_rq)
 	if (likely(!rt_overloaded(this_rq)))
 		return 0;
 
+	get_online_cpus_atomic();
 	for_each_cpu(cpu, this_rq->rd->rto_mask) {
 		if (this_cpu == cpu)
 			continue;
@@ -1695,6 +1708,7 @@ skip:
 		double_unlock_balance(this_rq, src_rq);
 	}
 
+	put_online_cpus_atomic();
 	return ret;
 }
 
