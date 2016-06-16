Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVtrY5sllzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 05:35:09 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id d137so621934ywe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 12:35:09 -0700 (PDT)
Date: Thu, 16 Jun 2016 15:35:04 -0400
From: Tejun Heo <htejun@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com
Subject: Re: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the
 beginning of CPU_ONLINE
Message-ID: <20160616193504.GB3262@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
 <20160615155350.GB24102@mtj.duckdns.org>
 <20160615192844.GA20301@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615192844.GA20301@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

So, the issue of the initial worker not having its affinity set
correctly wasn't caused by the order of the operations.  Reordering
just made set_cpus_allowed tried one more time late enough so that it
hides the race condition most of the time.  The problem is that
CPU_ONLINE callbacks are called while the cpu being onlined is online
but not active and select_fallback_rq() only considers active cpus, so
if a kthread gets scheduled in the meantime and it doesn't have any
cpu which is active in its allowed mask, it's allowed mask gets reset
to cpu_possible_mask.

Would something like the following make sense?

Thanks.
------ 8< ------
Subject: [PATCH] sched: allow kthreads to fallback to online && !active cpus

During CPU hotplug, CPU_ONLINE callbacks are run while the CPU is
online but not active.  A CPU_ONLINE callback may create or bind a
kthread so that its cpus_allowed mask only allows the CPU which is
being brought online.  The kthread may start executing before the CPU
is made active and can end up in select_fallback_rq().

In such cases, the expected behavior is selecting the CPU which is
coming online; however, because select_fallback_rq() only chooses from
active CPUs, it determines that the task doesn't have any viable CPU
in its allowed mask and ends up overriding it to cpu_possible_mask.

CPU_ONLINE callbacks should be able to put kthreads on the CPU which
is coming online.  Update select_fallback_rq() so that it follows
cpu_online() rather than cpu_active() for kthreads.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
---
 kernel/sched/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 017d539..a12e3db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1536,7 +1536,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 	for (;;) {
 		/* Any allowed, online CPU? */
 		for_each_cpu(dest_cpu, tsk_cpus_allowed(p)) {
-			if (!cpu_active(dest_cpu))
+			if (!(p->flags & PF_KTHREAD) && !cpu_active(dest_cpu))
+				continue;
+			if (!cpu_online(dest_cpu))
 				continue;
 			goto out;
 		}
