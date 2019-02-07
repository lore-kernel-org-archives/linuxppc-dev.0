Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C24C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:35:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BDA20663
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BDA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVS31BV4zDqS9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:35:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSXg4WV7zDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:09:07 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7044C10F85;
 Thu,  7 Feb 2019 19:09:05 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0DF061146;
 Thu,  7 Feb 2019 19:09:00 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 05/22] locking/rwsem: Move owner setting code from rwsem.c
 to rwsem.h
Date: Thu,  7 Feb 2019 14:07:09 -0500
Message-Id: <1549566446-27967-6-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 07 Feb 2019 19:09:05 +0000 (UTC)
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

The setting of owner field is specific to rwsem-xadd code, it is not needed
for rwsem-spinlock. This patch moves all the owner setting code closer
to the rwsem-xadd fast paths directly within rwsem.h file.

For __down_read() and __down_read_killable(), it is assumed that
rwsem will be marked as reader-owned when the functions return. That
is currently true except in the transient case that the waiter queue
just becomes empty. So a rwsem_set_reader_owned() call is added for
this case. The __rwsem_set_reader_owned() call in __rwsem_mark_wake()
is now necessary.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c |  6 +++---
 kernel/locking/rwsem.c      | 19 ++-----------------
 kernel/locking/rwsem.h      | 17 +++++++++++++++--
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 0d518b5..c213869 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -176,9 +176,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 			goto try_reader_grant;
 		}
 		/*
-		 * It is not really necessary to set it to reader-owned here,
-		 * but it gives the spinners an early indication that the
-		 * readers now have the lock.
+		 * Set it to reader-owned to give spinners an early
+		 * indication that readers now have the lock.
 		 */
 		__rwsem_set_reader_owned(sem, waiter->task);
 	}
@@ -441,6 +440,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		 */
 		if (atomic_long_read(&sem->count) >= 0) {
 			raw_spin_unlock_irq(&sem->wait_lock);
+			rwsem_set_reader_owned(sem);
 			return sem;
 		}
 		adjustment += RWSEM_WAITING_BIAS;
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e586f0d..59e5848 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -24,7 +24,6 @@ void __sched down_read(struct rw_semaphore *sem)
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
-	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read);
@@ -39,7 +38,6 @@ int __sched down_read_killable(struct rw_semaphore *sem)
 		return -EINTR;
 	}
 
-	rwsem_set_reader_owned(sem);
 	return 0;
 }
 
@@ -52,10 +50,8 @@ int down_read_trylock(struct rw_semaphore *sem)
 {
 	int ret = __down_read_trylock(sem);
 
-	if (ret == 1) {
+	if (ret == 1)
 		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
-		rwsem_set_reader_owned(sem);
-	}
 	return ret;
 }
 
@@ -70,7 +66,6 @@ void __sched down_write(struct rw_semaphore *sem)
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
-	rwsem_set_owner(sem);
 }
 
 EXPORT_SYMBOL(down_write);
@@ -88,7 +83,6 @@ int __sched down_write_killable(struct rw_semaphore *sem)
 		return -EINTR;
 	}
 
-	rwsem_set_owner(sem);
 	return 0;
 }
 
@@ -101,10 +95,8 @@ int down_write_trylock(struct rw_semaphore *sem)
 {
 	int ret = __down_write_trylock(sem);
 
-	if (ret == 1) {
+	if (ret == 1)
 		rwsem_acquire(&sem->dep_map, 0, 1, _RET_IP_);
-		rwsem_set_owner(sem);
-	}
 
 	return ret;
 }
@@ -119,7 +111,6 @@ void up_read(struct rw_semaphore *sem)
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 
-	rwsem_clear_reader_owned(sem);
 	__up_read(sem);
 }
 
@@ -133,7 +124,6 @@ void up_write(struct rw_semaphore *sem)
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
-	rwsem_clear_owner(sem);
 	__up_write(sem);
 }
 
@@ -147,7 +137,6 @@ void downgrade_write(struct rw_semaphore *sem)
 	lock_downgrade(&sem->dep_map, _RET_IP_);
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
-	rwsem_set_reader_owned(sem);
 	__downgrade_write(sem);
 }
 
@@ -161,7 +150,6 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
-	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read_nested);
@@ -172,7 +160,6 @@ void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 	rwsem_acquire_nest(&sem->dep_map, 0, 0, nest, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
-	rwsem_set_owner(sem);
 }
 
 EXPORT_SYMBOL(_down_write_nest_lock);
@@ -193,7 +180,6 @@ void down_write_nested(struct rw_semaphore *sem, int subclass)
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
-	rwsem_set_owner(sem);
 }
 
 EXPORT_SYMBOL(down_write_nested);
@@ -208,7 +194,6 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 		return -EINTR;
 	}
 
-	rwsem_set_owner(sem);
 	return 0;
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 067e265..f568391 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -161,6 +161,8 @@ static inline void __down_read(struct rw_semaphore *sem)
 {
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
 		rwsem_down_read_failed(sem);
+	else
+		rwsem_set_reader_owned(sem);
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
@@ -168,8 +170,9 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
+	} else {
+		rwsem_set_reader_owned(sem);
 	}
-
 	return 0;
 }
 
@@ -180,6 +183,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
 		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
 				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
+			rwsem_set_reader_owned(sem);
 			return 1;
 		}
 	}
@@ -197,6 +201,7 @@ static inline void __down_write(struct rw_semaphore *sem)
 					     &sem->count);
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		rwsem_down_write_failed(sem);
+	rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -208,6 +213,7 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
+	rwsem_set_owner(sem);
 	return 0;
 }
 
@@ -217,7 +223,11 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 
 	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
 		      RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
+	if (tmp == RWSEM_UNLOCKED_VALUE) {
+		rwsem_set_owner(sem);
+		return true;
+	}
+	return false;
 }
 
 /*
@@ -227,6 +237,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
 		rwsem_wake(sem);
@@ -237,6 +248,7 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
 						    &sem->count) < 0))
 		rwsem_wake(sem);
@@ -257,6 +269,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * write side. As such, rely on RELEASE semantics.
 	 */
 	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
+	rwsem_set_reader_owned(sem);
 	if (tmp < 0)
 		rwsem_downgrade_wake(sem);
 }
-- 
1.8.3.1

