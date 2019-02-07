Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B06C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:32:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A420220857
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVNh6DJCzDqTV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:32:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSXK6L5WzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:08:49 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6737737EE7;
 Thu,  7 Feb 2019 19:08:47 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 550C262FA3;
 Thu,  7 Feb 2019 19:08:45 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 03/22] locking/rwsem: Relocate rwsem_down_read_failed()
Date: Thu,  7 Feb 2019 14:07:07 -0500
Message-Id: <1549566446-27967-4-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 07 Feb 2019 19:08:48 +0000 (UTC)
X-Mailman-Approved-At: Fri, 08 Feb 2019 07:26:12 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The rwsem_down_read_failed*() functions were relocted from above the
optimistic spinning section to below that section. This enables the
reader functions to use optimisitic spinning in future patches. There
is no code change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index fbe9634..0d518b5 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -225,92 +225,6 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 }
 
 /*
- * Wait for the read lock to be granted
- */
-static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
-{
-	long count, adjustment = -RWSEM_ACTIVE_READ_BIAS;
-	struct rwsem_waiter waiter;
-	DEFINE_WAKE_Q(wake_q);
-
-	waiter.task = current;
-	waiter.type = RWSEM_WAITING_FOR_READ;
-
-	raw_spin_lock_irq(&sem->wait_lock);
-	if (list_empty(&sem->wait_list)) {
-		/*
-		 * In case the wait queue is empty and the lock isn't owned
-		 * by a writer, this reader can exit the slowpath and return
-		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
-		 * been set in the count.
-		 */
-		if (atomic_long_read(&sem->count) >= 0) {
-			raw_spin_unlock_irq(&sem->wait_lock);
-			return sem;
-		}
-		adjustment += RWSEM_WAITING_BIAS;
-	}
-	list_add_tail(&waiter.list, &sem->wait_list);
-
-	/* we're now waiting on the lock, but no longer actively locking */
-	count = atomic_long_add_return(adjustment, &sem->count);
-
-	/*
-	 * If there are no active locks, wake the front queued process(es).
-	 *
-	 * If there are no writers and we are first in the queue,
-	 * wake our own waiter to join the existing active readers !
-	 */
-	if (count == RWSEM_WAITING_BIAS ||
-	    (count > RWSEM_WAITING_BIAS &&
-	     adjustment != -RWSEM_ACTIVE_READ_BIAS))
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-
-	raw_spin_unlock_irq(&sem->wait_lock);
-	wake_up_q(&wake_q);
-
-	/* wait to be given the lock */
-	while (true) {
-		set_current_state(state);
-		if (!waiter.task)
-			break;
-		if (signal_pending_state(state, current)) {
-			raw_spin_lock_irq(&sem->wait_lock);
-			if (waiter.task)
-				goto out_nolock;
-			raw_spin_unlock_irq(&sem->wait_lock);
-			break;
-		}
-		schedule();
-	}
-
-	__set_current_state(TASK_RUNNING);
-	return sem;
-out_nolock:
-	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
-	raw_spin_unlock_irq(&sem->wait_lock);
-	__set_current_state(TASK_RUNNING);
-	return ERR_PTR(-EINTR);
-}
-
-__visible struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-EXPORT_SYMBOL(rwsem_down_read_failed);
-
-__visible struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
-}
-EXPORT_SYMBOL(rwsem_down_read_failed_killable);
-
-/*
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
@@ -505,6 +419,92 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 #endif
 
 /*
+ * Wait for the read lock to be granted
+ */
+static inline struct rw_semaphore __sched *
+__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
+{
+	long count, adjustment = -RWSEM_ACTIVE_READ_BIAS;
+	struct rwsem_waiter waiter;
+	DEFINE_WAKE_Q(wake_q);
+
+	waiter.task = current;
+	waiter.type = RWSEM_WAITING_FOR_READ;
+
+	raw_spin_lock_irq(&sem->wait_lock);
+	if (list_empty(&sem->wait_list)) {
+		/*
+		 * In case the wait queue is empty and the lock isn't owned
+		 * by a writer, this reader can exit the slowpath and return
+		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
+		 * been set in the count.
+		 */
+		if (atomic_long_read(&sem->count) >= 0) {
+			raw_spin_unlock_irq(&sem->wait_lock);
+			return sem;
+		}
+		adjustment += RWSEM_WAITING_BIAS;
+	}
+	list_add_tail(&waiter.list, &sem->wait_list);
+
+	/* we're now waiting on the lock, but no longer actively locking */
+	count = atomic_long_add_return(adjustment, &sem->count);
+
+	/*
+	 * If there are no active locks, wake the front queued process(es).
+	 *
+	 * If there are no writers and we are first in the queue,
+	 * wake our own waiter to join the existing active readers !
+	 */
+	if (count == RWSEM_WAITING_BIAS ||
+	    (count > RWSEM_WAITING_BIAS &&
+	     adjustment != -RWSEM_ACTIVE_READ_BIAS))
+		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+
+	raw_spin_unlock_irq(&sem->wait_lock);
+	wake_up_q(&wake_q);
+
+	/* wait to be given the lock */
+	while (true) {
+		set_current_state(state);
+		if (!waiter.task)
+			break;
+		if (signal_pending_state(state, current)) {
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter.task)
+				goto out_nolock;
+			raw_spin_unlock_irq(&sem->wait_lock);
+			break;
+		}
+		schedule();
+	}
+
+	__set_current_state(TASK_RUNNING);
+	return sem;
+out_nolock:
+	list_del(&waiter.list);
+	if (list_empty(&sem->wait_list))
+		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
+	raw_spin_unlock_irq(&sem->wait_lock);
+	__set_current_state(TASK_RUNNING);
+	return ERR_PTR(-EINTR);
+}
+
+__visible struct rw_semaphore * __sched
+rwsem_down_read_failed(struct rw_semaphore *sem)
+{
+	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
+}
+EXPORT_SYMBOL(rwsem_down_read_failed);
+
+__visible struct rw_semaphore * __sched
+rwsem_down_read_failed_killable(struct rw_semaphore *sem)
+{
+	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(rwsem_down_read_failed_killable);
+
+/*
  * Wait until we successfully acquire the write lock
  */
 static inline struct rw_semaphore *
-- 
1.8.3.1

