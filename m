Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D006C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 02:00:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C0C64F86
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 02:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0C64F86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dvdht2K83z3dJm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 13:00:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=stgolabs.net (client-ip=195.135.220.15; helo=mx2.suse.de;
 envelope-from=dave@stgolabs.net; receiver=<UNKNOWN>)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dvdh735Qnz30Jp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Mar 2021 13:00:05 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1017CAC54;
 Tue,  9 Mar 2021 02:00:03 +0000 (UTC)
From: Davidlohr Bueso <dave@stgolabs.net>
To: npiggin@gmail.com
Subject: [PATCH 1/3] powerpc/spinlock: Define smp_mb__after_spinlock only once
Date: Mon,  8 Mar 2021 17:59:48 -0800
Message-Id: <20210309015950.27688-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309015950.27688-1-dave@stgolabs.net>
References: <20210309015950.27688-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 paulus@samba.org, longman@redhat.com, will@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Instead of both queued and simple spinlocks doing it. Move
it into the arch's spinlock.h.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/powerpc/include/asm/qspinlock.h       | 2 --
 arch/powerpc/include/asm/simple_spinlock.h | 3 ---
 arch/powerpc/include/asm/spinlock.h        | 3 +++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index b752d34517b3..3ce1a0bee4fe 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -44,8 +44,6 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 }
 #define queued_spin_lock queued_spin_lock
 
-#define smp_mb__after_spinlock()   smp_mb()
-
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
index 9c3c30534333..3e87258f73b1 100644
--- a/arch/powerpc/include/asm/simple_spinlock.h
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -282,7 +282,4 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 #define arch_read_relax(lock)	rw_yield(lock)
 #define arch_write_relax(lock)	rw_yield(lock)
 
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()   smp_mb()
-
 #endif /* _ASM_POWERPC_SIMPLE_SPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 6ec72282888d..bd75872a6334 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -10,6 +10,9 @@
 #include <asm/simple_spinlock.h>
 #endif
 
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
 #ifndef CONFIG_PARAVIRT_SPINLOCKS
 static inline void pv_spinlocks_init(void) { }
 #endif
-- 
2.26.2

