Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E4C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:49:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34F02146E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34F02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVmB4sxXzDqWB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:49:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSYY4czJzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:09:53 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7107B3C2CFC;
 Thu,  7 Feb 2019 19:09:51 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 518E761146;
 Thu,  7 Feb 2019 19:09:49 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 14/22] locking/rwsem: Add more rwsem owner access helpers
Date: Thu,  7 Feb 2019 14:07:18 -0500
Message-Id: <1549566446-27967-15-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 07 Feb 2019 19:09:52 +0000 (UTC)
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

Before combining owner and count, we are adding two new helpers for
accessing the owner value in the rwsem.

 1) struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 2) bool is_rwsem_reader_owned(struct rw_semaphore *sem)

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 11 ++++++-----
 kernel/locking/rwsem-xadd.h | 32 ++++++++++++++++++++++++++------
 kernel/locking/rwsem.c      |  3 +--
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 5f74bae..719d390 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -277,7 +277,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		return false;
 
 	rcu_read_lock();
-	owner = READ_ONCE(sem->owner);
+	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
 		      owner_on_cpu(owner);
@@ -291,13 +291,13 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
  */
 static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
-	struct task_struct *owner = READ_ONCE(sem->owner);
+	struct task_struct *owner = rwsem_get_owner(sem);
 
 	if (!is_rwsem_owner_spinnable(owner))
 		return false;
 
 	rcu_read_lock();
-	while (owner && (READ_ONCE(sem->owner) == owner)) {
+	while (owner && (rwsem_get_owner(sem) == owner)) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -323,7 +323,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 	 * If there is a new owner or the owner is not set, we continue
 	 * spinning.
 	 */
-	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
+	return is_rwsem_owner_spinnable(rwsem_get_owner(sem));
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
@@ -361,7 +361,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * we're an RT task that will live-lock because we won't let
 		 * the owner complete.
 		 */
-		if (!sem->owner && (need_resched() || rt_task(current)))
+		if (!rwsem_get_owner(sem) &&
+		   (need_resched() || rt_task(current)))
 			break;
 
 		/*
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index 6d4890d..277a134 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -83,6 +83,11 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 	WRITE_ONCE(sem->owner, NULL);
 }
 
+static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+{
+	return READ_ONCE(sem->owner);
+}
+
 /*
  * The task_struct pointer of the last owning reader will be left in
  * the owner field.
@@ -116,6 +121,23 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 }
 
 /*
+ * Return true if the rwsem is owned by a reader.
+ */
+static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+{
+#ifdef CONFIG_DEBUG_RWSEMS
+	/*
+	 * Check the count to see if it is write-locked.
+	 */
+	long count = atomic_long_read(&sem->count);
+
+	if (count & RWSEM_WRITER_MASK)
+		return false;
+#endif
+	return (unsigned long)sem->owner & RWSEM_READER_OWNED;
+}
+
+/*
  * Return true if rwsem is owned by an anonymous writer or readers.
  */
 static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
@@ -135,6 +157,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
 						   | RWSEM_ANONYMOUSLY_OWNED;
+
 	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
 				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
@@ -181,8 +204,7 @@ static inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_failed(sem);
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -194,8 +216,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -254,8 +275,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index bdfca7c..79fa6e4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -203,8 +203,7 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	__up_read(sem);
 }
 
-- 
1.8.3.1

