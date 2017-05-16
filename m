Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRwgr1BlCzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 21:48:24 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] timers: remove the fn and data arguments to call_timer_fn
Date: Tue, 16 May 2017 13:48:04 +0200
Message-Id: <20170516114812.10660-2-hch@lst.de>
In-Reply-To: <20170516114812.10660-1-hch@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And just move the dereferences inline, given that the timer gets
passed as an argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/time/timer.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 152a706ef8b8..c7978fcdbbea 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1240,8 +1240,7 @@ int del_timer_sync(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 
-static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
-			  unsigned long data)
+static void call_timer_fn(struct timer_list *timer)
 {
 	int count = preempt_count();
 
@@ -1265,14 +1264,14 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	lock_map_acquire(&lockdep_map);
 
 	trace_timer_expire_entry(timer);
-	fn(data);
+	timer->function(timer->data);
 	trace_timer_expire_exit(timer);
 
 	lock_map_release(&lockdep_map);
 
 	if (count != preempt_count()) {
 		WARN_ONCE(1, "timer: %pF preempt leak: %08x -> %08x\n",
-			  fn, count, preempt_count());
+			  timer->function, count, preempt_count());
 		/*
 		 * Restore the preempt count. That gives us a decent
 		 * chance to survive and extract information. If the
@@ -1287,24 +1286,19 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 {
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
-		void (*fn)(unsigned long);
-		unsigned long data;
 
 		timer = hlist_entry(head->first, struct timer_list, entry);
 
 		base->running_timer = timer;
 		detach_timer(timer, true);
 
-		fn = timer->function;
-		data = timer->data;
-
 		if (timer->flags & TIMER_IRQSAFE) {
 			spin_unlock(&base->lock);
-			call_timer_fn(timer, fn, data);
+			call_timer_fn(timer);
 			spin_lock(&base->lock);
 		} else {
 			spin_unlock_irq(&base->lock);
-			call_timer_fn(timer, fn, data);
+			call_timer_fn(timer);
 			spin_lock_irq(&base->lock);
 		}
 	}
-- 
2.11.0
