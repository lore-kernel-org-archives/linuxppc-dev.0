Return-Path: <SRS0=eg2t=WC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C10C0650F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 02:59:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F37A20717
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 02:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F37A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462fW93LP0zDqTQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 12:59:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462fT94LglzDqWN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2019 12:58:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 462fT92lwyz8tbs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2019 12:58:05 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 462fT92QGXz9sNf; Tue,  6 Aug 2019 12:58:05 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=131.153.2.44; helo=h3.fbrelay.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from h3.fbrelay.privateemail.com (h3.fbrelay.privateemail.com
 [131.153.2.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 462fT84DCXz9sDB
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Aug 2019 12:58:03 +1000 (AEST)
Received: from MTA-10-4.privateemail.com (mta-10.privateemail.com
 [68.65.122.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4B0BB81587
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Aug 2019 22:58:00 -0400 (EDT)
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
 by MTA-10.privateemail.com (Postfix) with ESMTP id D19F360041;
 Mon,  5 Aug 2019 22:57:53 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.240])
 by MTA-10.privateemail.com (Postfix) with ESMTPA id 5C08960033;
 Tue,  6 Aug 2019 02:57:53 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/3] powerpc/spinlocks: Refactor SHARED_PROCESSOR
Date: Mon,  5 Aug 2019 22:01:10 -0500
Message-Id: <20190806030112.15232-2-cmr@informatik.wtf>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806030112.15232-1-cmr@informatik.wtf>
References: <20190806030112.15232-1-cmr@informatik.wtf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Determining if a processor is in shared processor mode is not a constant
so don't hide it behind a #define.

Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index a47f827bc5f1..dc5fcea1f006 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -101,15 +101,27 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 #if defined(CONFIG_PPC_SPLPAR)
 /* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
 extern void __spin_yield(arch_spinlock_t *lock);
 extern void __rw_yield(arch_rwlock_t *lock);
 #else /* SPLPAR */
 #define __spin_yield(x)	barrier()
 #define __rw_yield(x)	barrier()
-#define SHARED_PROCESSOR	0
 #endif
 
+static inline bool is_shared_processor(void)
+{
+/*
+ * LPPACA is only available on BOOK3S so guard anything LPPACA related to
+ * allow other platforms (which include this common header) to compile.
+ */
+#ifdef CONFIG_PPC_BOOK3S
+	return (IS_ENABLED(CONFIG_PPC_SPLPAR) &&
+		lppaca_shared_proc(local_paca->lppaca_ptr));
+#else
+	return false;
+#endif
+}
+
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	while (1) {
@@ -117,7 +129,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 			break;
 		do {
 			HMT_low();
-			if (SHARED_PROCESSOR)
+			if (is_shared_processor())
 				__spin_yield(lock);
 		} while (unlikely(lock->slock != 0));
 		HMT_medium();
@@ -136,7 +148,7 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 		local_irq_restore(flags);
 		do {
 			HMT_low();
-			if (SHARED_PROCESSOR)
+			if (is_shared_processor())
 				__spin_yield(lock);
 		} while (unlikely(lock->slock != 0));
 		HMT_medium();
@@ -226,7 +238,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 			break;
 		do {
 			HMT_low();
-			if (SHARED_PROCESSOR)
+			if (is_shared_processor())
 				__rw_yield(rw);
 		} while (unlikely(rw->lock < 0));
 		HMT_medium();
@@ -240,7 +252,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 			break;
 		do {
 			HMT_low();
-			if (SHARED_PROCESSOR)
+			if (is_shared_processor())
 				__rw_yield(rw);
 		} while (unlikely(rw->lock != 0));
 		HMT_medium();
-- 
2.22.0

