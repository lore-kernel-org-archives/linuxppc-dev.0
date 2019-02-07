Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557FBC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:41:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB36220663
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB36220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVbS0hTGzDqDW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:41:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSYC6n9jzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:09:35 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCCF488E52;
 Thu,  7 Feb 2019 19:09:33 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1361693B;
 Thu,  7 Feb 2019 19:09:28 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 09/22] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
Date: Thu,  7 Feb 2019 14:07:13 -0500
Message-Id: <1549566446-27967-10-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 19:09:34 +0000 (UTC)
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

Currently, the DEBUG_RWSEMS_WARN_ON() macro just dumps a stack trace
when the rwsem isn't in the right state. It does not show the actual
states of the rwsem. This may not be that helpful in the debugging
process.

Enhance the DEBUG_RWSEMS_WARN_ON() macro to also show the current
content of the rwsem count and owner fields to give more information
about what is wrong with the rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.h | 19 ++++++++++++-------
 kernel/locking/rwsem.c      |  5 +++--
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index 77151c3..6d2478c 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -27,9 +27,13 @@
 #define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
 
 #ifdef CONFIG_DEBUG_RWSEMS
-# define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
+# define DEBUG_RWSEMS_WARN_ON(c, sem)				\
+	WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
+		#c, atomic_long_read(&(sem)->count),		\
+		(long)((sem)->owner), (long)current,		\
+		list_empty(&(sem)->wait_list) ? "" : "not ")
 #else
-# define DEBUG_RWSEMS_WARN_ON(c)
+# define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
 
 /*
@@ -168,7 +172,7 @@ static inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		rwsem_down_read_failed(sem);
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED));
+					RWSEM_READER_OWNED), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -180,7 +184,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED));
+					RWSEM_READER_OWNED), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -248,7 +252,8 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
+				sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
@@ -260,7 +265,7 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
 						    &sem->count) < 0))
@@ -281,7 +286,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
 	if (tmp < 0)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 598fc7c..bdfca7c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -17,7 +17,7 @@
 #include "rwsem-xadd.h"
 #else
 #define __rwsem_set_reader_owned(a, b)
-#define DEBUG_RWSEMS_WARN_ON(a)
+#define DEBUG_RWSEMS_WARN_ON(a, b)
 #endif
 
 /*
@@ -203,7 +203,8 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
+				sem);
 	__up_read(sem);
 }
 
-- 
1.8.3.1

