Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBE1C2C046D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:42:14 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:09:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 20D1B1258051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:12:55 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICg6Jg27525352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:12:06 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICg4kl020588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:42:08 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 13/46] sched/migration: Use raw_spin_lock/unlock since
 interrupts are already disabled
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:10:06 +0530
Message-ID: <20130218124006.26245.88872.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need not use the raw_spin_lock_irqsave/restore primitives because
all CPU_DYING notifiers run with interrupts disabled. So just use
raw_spin_lock/unlock.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ead8af6..71741d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4870,9 +4870,7 @@ static void calc_load_migrate(struct rq *rq)
  * Migrate all tasks from the rq, sleeping tasks will be migrated by
  * try_to_wake_up()->select_task_rq().
  *
- * Called with rq->lock held even though we'er in stop_machine() and
- * there's no concurrency possible, we hold the required locks anyway
- * because of lock validation efforts.
+ * Called with rq->lock held.
  */
 static void migrate_tasks(unsigned int dead_cpu)
 {
@@ -4884,8 +4882,8 @@ static void migrate_tasks(unsigned int dead_cpu)
 	 * Fudge the rq selection such that the below task selection loop
 	 * doesn't get stuck on the currently eligible stop task.
 	 *
-	 * We're currently inside stop_machine() and the rq is either stuck
-	 * in the stop_machine_cpu_stop() loop, or we're executing this code,
+	 * We're currently inside stop_one_cpu() and the rq is either stuck
+	 * in the cpu_stopper_thread(), or we're executing this code,
 	 * either way we should never end up calling schedule() until we're
 	 * done here.
 	 */
@@ -5154,14 +5152,14 @@ migration_call(struct notifier_block *nfb, unsigned long action, void *hcpu)
 	case CPU_DYING:
 		sched_ttwu_pending();
 		/* Update our root-domain */
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_lock(&rq->lock); /* Interrupts already disabled */
 		if (rq->rd) {
 			BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 			set_rq_offline(rq);
 		}
 		migrate_tasks(cpu);
 		BUG_ON(rq->nr_running != 1); /* the migration thread */
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_unlock(&rq->lock);
 		break;
 
 	case CPU_DEAD:
