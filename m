Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVjmM4WB2zDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 22:45:55 +1000 (AEST)
Date: Thu, 16 Jun 2016 14:45:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <htejun@gmail.com>, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160616124548.GE30921@twins.programming.kicks-ass.net>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
 <20160615131415.GI30909@twins.programming.kicks-ass.net>
 <20160615160112.GC24102@mtj.duckdns.org>
 <1466079084.19127.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466079084.19127.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 10:11:24PM +1000, Michael Ellerman wrote:
> Peterz do you want to send a SOB'ed patch, or can we take what you posted and
> add your SOB?

So I took Ego's first patch, so as to not steal his credits take that
one and then see below.

---
Subject: workqueue: Fix setting affinity of unbound worker threads
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jun 16 14:38:42 CEST 2016

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

This patch fixes this by limiting the mask to the intersection of
the pool affinity and online CPUs.

Changelog-cribbed-from: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/workqueue.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4600,15 +4600,11 @@ static void restore_unbound_workers_cpum
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
