Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B438C2C0308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:58:49 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:52:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 752BB3578045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:58:47 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJwc584391392
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:58:38 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RJwjar029443
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:58:46 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 16/45] rcu: Use cpu_is_offline_nocheck() to avoid
 false-positive warnings
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:25:17 +0530
Message-ID: <20130627195517.29830.64108.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In RCU code, rcu_implicit_dynticks_qs() checks if a CPU is offline,
while being protected by a spinlock. At first, it appears as if we need to
use the get/put_online_cpus_atomic() APIs to properly synchronize with CPU
hotplug, once we get rid of stop_machine(). However, RCU has adequate
synchronization with CPU hotplug, making that unnecessary. But since the
locking details are non-trivial, it is hard to teach this to the rudimentary
hotplug locking validator.

So use the _nocheck() variants of the cpu accessor functions to prevent false-
positive warnings from the CPU hotplug debug code. Also, add a comment
explaining the hotplug synchronization design used in RCU, so that its easy
to see why it is justified to use the _nocheck() variants.

Cc: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/rcutree.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index cf3adc6..ced28a45 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -794,7 +794,17 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (ULONG_CMP_GE(rdp->rsp->gp_start + 2, jiffies))
 		return 0;  /* Grace period is not old enough. */
 	barrier();
-	if (cpu_is_offline(rdp->cpu)) {
+
+	/*
+	 * It is safe to use the _nocheck() version of cpu_is_offline() here
+	 * (to avoid false-positive warnings from CPU hotplug debug code),
+	 * because:
+	 * 1. rcu_gp_init() holds off CPU hotplug operations during grace
+	 *    period initialization.
+	 * 2. The current grace period has not ended yet.
+	 * So it is safe to sample the offline state without synchronization.
+	 */
+	if (cpu_is_offline_nocheck(rdp->cpu)) {
 		trace_rcu_fqs(rdp->rsp->name, rdp->gpnum, rdp->cpu, "ofl");
 		rdp->offline_fqs++;
 		return 1;
