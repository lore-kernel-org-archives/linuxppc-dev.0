Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9551FC433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 14:32:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D9E60FF0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 14:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9E60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9TLB374qz3c6C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 01:32:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LFUJQ+P1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=guoren@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LFUJQ+P1; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9TKT0HGkz3bnX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 01:31:56 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE45660FF1;
 Wed, 31 Mar 2021 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617201114;
 bh=ZlgshpaCoA6zGi17OQe5KtXtUjgmxHsHhFE58+U5sOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LFUJQ+P1xzQmaWQX8Swd0sEBGp6ODLnJGpzRzYpYmHK8ilk5c7PQAsgb4tqXDyJn4
 C8rYJIkzX5VwZ6DSngDJkzHCIPfe6zBDSfkXd3axY2xtONndhSnaMRJbEBI2nh3QN+
 FlBTndTouquw7fxhbY/3+9mmhXJHVVPYqIOz367B3GbxZJ9sD6fKUW6qcC0nc5Vmh7
 DsDqlI0e38DpWOpASf1pHsgfg2hPt7gwSaexx+iGLJVpymN7V8K6NzB6/pGOW4KqMG
 x6Sn6wZUrDToJQbAaynuurLgXGrc7YkieAd2kd5v4yOGIUWGWPDartHFmFTMyEvaSM
 05tSWZo4NrEww==
From: guoren@kernel.org
To: guoren@kernel.org
Subject: [PATCH v6 1/9] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date: Wed, 31 Mar 2021 14:30:32 +0000
Message-Id: <1617201040-83905-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617201040-83905-1-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
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
 Guo Ren <guoren@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 openrisc@lists.librecores.org, Anup Patel <anup@brainfault.org>,
 sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Guo Ren <guoren@linux.alibaba.com>

Some architectures don't have sub-word swap atomic instruction,
they only have the full word's one.

The sub-word swap only improve the performance when:
NR_CPUS < 16K
 *  0- 7: locked byte
 *     8: pending
 *  9-15: not used
 * 16-17: tail index
 * 18-31: tail cpu (+1)

The 9-15 bits are wasted to use xchg16 in xchg_tail.

Please let architecture select xchg16/xchg32 to implement
xchg_tail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anup Patel <anup@brainfault.org>
---
 kernel/Kconfig.locks       |  3 +++
 kernel/locking/qspinlock.c | 46 +++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..d02f1261f73f 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -239,6 +239,9 @@ config LOCK_SPIN_ON_OWNER
 config ARCH_USE_QUEUED_SPINLOCKS
 	bool
 
+config ARCH_USE_QUEUED_SPINLOCKS_XCHG32
+	bool
+
 config QUEUED_SPINLOCKS
 	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
 	depends on SMP
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..4bfaa969bd15 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
-/*
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail), which heads an address dependency
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	/*
-	 * We can use relaxed semantics since the caller ensures that the
-	 * MCS node is properly initialized before updating the tail.
-	 */
-	return (u32)xchg_relaxed(&lock->tail,
-				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
-}
-
 #else /* _Q_PENDING_BITS == 8 */
 
 /**
@@ -206,6 +186,30 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
 	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
 }
+#endif /* _Q_PENDING_BITS == 8 */
+
+#if _Q_PENDING_BITS == 8 && !defined(CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32)
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail), which heads an address dependency
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else
 
 /**
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
@@ -236,7 +240,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	}
 	return old;
 }
-#endif /* _Q_PENDING_BITS == 8 */
+#endif
 
 /**
  * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
-- 
2.17.1

