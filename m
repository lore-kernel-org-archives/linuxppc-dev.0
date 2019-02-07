Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68966C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:55:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11AE2175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11AE2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVvl4PZFzDqBP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:55:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSZ11r1YzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:10:17 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3FF8C0669A8;
 Thu,  7 Feb 2019 19:10:13 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1846D17A75;
 Thu,  7 Feb 2019 19:10:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 18/22] locking/rwsem: Make rwsem_spin_on_owner() return a
 tri-state value
Date: Thu,  7 Feb 2019 14:07:22 -0500
Message-Id: <1549566446-27967-19-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 07 Feb 2019 19:10:15 +0000 (UTC)
X-Mailman-Approved-At: Fri, 08 Feb 2019 07:26:13 +1100
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

This patch modifies rwsem_spin_on_owner() to return a tri-state value
to better reflect the state of lock holder which enables us to make a
better decision of what to do next.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 25 +++++++++++++++++++------
 kernel/locking/rwsem-xadd.h |  5 +++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 21d462f..0a29aac 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -305,14 +305,24 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }
 
 /*
- * Return true only if we can still spin on the owner field of the rwsem.
+ * Return the folowing three values depending on the lock owner state.
+ *   1	when owner changes and no reader is detected yet.
+ *   0	when owner changes and the new owner may be a reader.
+ *  -1	when optimistic spinning has to stop because either the owner stops
+ *	running, is unknown, or its timeslice has been used up.
  */
-static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
+enum owner_state {
+	OWNER_SPINNABLE = 1,
+	OWNER_READER = 0,
+	OWNER_NONSPINNABLE = -1,
+};
+
+static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = rwsem_get_owner(sem);
 
 	if (!is_rwsem_owner_spinnable(owner))
-		return false;
+		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
 	/*
@@ -337,7 +347,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		if (need_resched() || !owner_on_cpu(owner, sem)) {
 			rcu_read_unlock();
-			return false;
+			return OWNER_NONSPINNABLE;
 		}
 
 		cpu_relax();
@@ -348,7 +358,10 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 	 * If there is a new owner or the owner is not set, we continue
 	 * spinning.
 	 */
-	return is_rwsem_owner_spinnable(rwsem_get_owner(sem));
+	owner = rwsem_get_owner(sem);
+	if (!is_rwsem_owner_spinnable(owner))
+		return OWNER_NONSPINNABLE;
+	return is_rwsem_owner_reader(owner) ? OWNER_READER : OWNER_SPINNABLE;
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
@@ -371,7 +384,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem)) {
+	while (rwsem_spin_on_owner(sem) == OWNER_SPINNABLE) {
 		/*
 		 * Try to acquire the lock
 		 */
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index d54b5db..1de6f1e 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -200,6 +200,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
 }
 
+static inline bool is_rwsem_owner_reader(struct task_struct *owner)
+{
+	return (unsigned long)owner & RWSEM_READER_OWNED;
+}
+
 /*
  * Return true if the rwsem is owned by a reader.
  */
-- 
1.8.3.1

