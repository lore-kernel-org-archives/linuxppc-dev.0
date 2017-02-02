Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDl282VY3zDq5Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 02:55:12 +1100 (AEDT)
Date: Thu, 2 Feb 2017 16:55:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ross Zwisler <zwisler@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>, Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
Message-ID: <20170202155506.GX6515@twins.programming.kicks-ass.net>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
 <1485863317.4498.2.camel@gmx.de>
 <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 10:22:47AM -0700, Ross Zwisler wrote:
> On Tue, Jan 31, 2017 at 4:48 AM, Mike Galbraith <efault@gmx.de> wrote:
> > On Tue, 2017-01-31 at 16:30 +0530, Sachin Sant wrote:


Could some of you test this? It seems to cure things in my (very)
limited testing.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96e4ccc..b773821 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5609,7 +5609,7 @@ static void migrate_tasks(struct rq *dead_rq)
 {
 	struct rq *rq = dead_rq;
 	struct task_struct *next, *stop = rq->stop;
-	struct rq_flags rf, old_rf;
+	struct rq_flags rf;
 	int dest_cpu;
 
 	/*
@@ -5628,7 +5628,9 @@ static void migrate_tasks(struct rq *dead_rq)
 	 * class method both need to have an up-to-date
 	 * value of rq->clock[_task]
 	 */
+	rq_pin_lock(rq, &rf);
 	update_rq_clock(rq);
+	rq_unpin_lock(rq, &rf);
 
 	for (;;) {
 		/*
@@ -5641,7 +5643,7 @@ static void migrate_tasks(struct rq *dead_rq)
 		/*
 		 * pick_next_task assumes pinned rq->lock.
 		 */
-		rq_pin_lock(rq, &rf);
+		rq_repin_lock(rq, &rf);
 		next = pick_next_task(rq, &fake_task, &rf);
 		BUG_ON(!next);
 		next->sched_class->put_prev_task(rq, next);
@@ -5670,13 +5672,6 @@ static void migrate_tasks(struct rq *dead_rq)
 			continue;
 		}
 
-		/*
-		 * __migrate_task() may return with a different
-		 * rq->lock held and a new cookie in 'rf', but we need
-		 * to preserve rf::clock_update_flags for 'dead_rq'.
-		 */
-		old_rf = rf;
-
 		/* Find suitable destination for @next, with force if needed. */
 		dest_cpu = select_fallback_rq(dead_rq->cpu, next);
 
@@ -5685,7 +5680,6 @@ static void migrate_tasks(struct rq *dead_rq)
 			raw_spin_unlock(&rq->lock);
 			rq = dead_rq;
 			raw_spin_lock(&rq->lock);
-			rf = old_rf;
 		}
 		raw_spin_unlock(&next->pi_lock);
 	}
