Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC7C04AB4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 01:39:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F09E2084F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 01:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F09E2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=git.icu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453cff41M0zDqN3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 11:39:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=git.icu
 (client-ip=163.172.180.134; helo=git.icu; envelope-from=shawn@git.icu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=git.icu
Received: from git.icu (git.icu [163.172.180.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453ccc060LzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 11:37:36 +1000 (AEST)
Received: from localhost.localdomain (minicloud.parqtec.unicamp.br
 [143.106.167.126]) by git.icu (Postfix) with ESMTPSA id 993B82206D1;
 Wed, 15 May 2019 01:37:31 +0000 (UTC)
From: Shawn Landden <shawn@git.icu>
To: 
Subject: [v4 PATCH 1/2] [PowerPC] Add simd.h implementation
Date: Tue, 14 May 2019 22:37:24 -0300
Message-Id: <20190515013725.2198-1-shawn@git.icu>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190513005104.20140-1-shawn@git.icu>
References: <20190513005104.20140-1-shawn@git.icu>
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
Cc: Paul Mackerras <paulus@samba.org>, Shawn Landden <shawn@git.icu>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Based off the x86 one.

WireGuard really wants to be able to do SIMD in interrupts,
so it can accelerate its in-bound path.

Signed-off-by: Shawn Landden <shawn@git.icu>
---
 arch/powerpc/include/asm/simd.h | 17 +++++++++++++++++
 arch/powerpc/kernel/process.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 arch/powerpc/include/asm/simd.h

diff --git a/arch/powerpc/include/asm/simd.h b/arch/powerpc/include/asm/simd.h
new file mode 100644
index 000000000..2fe26f258
--- /dev/null
+++ b/arch/powerpc/include/asm/simd.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * may_use_simd - whether it is allowable at this time to issue SIMD
+ *                instructions or access the SIMD register file
+ *
+ * It's always ok in process context (ie "not interrupt")
+ * but it is sometimes ok even from an irq.
+ */
+#ifdef CONFIG_PPC_FPU
+extern bool may_use_simd(void);
+#else
+static inline bool may_use_simd(void)
+{
+	return false;
+}
+#endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index dd9e0d538..ef534831f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -345,6 +345,36 @@ static int restore_altivec(struct task_struct *tsk)
 	}
 	return 0;
 }
+
+/*
+ * Were we in user mode when we were
+ * interrupted?
+ *
+ * Doing kernel_altivec/vsx_begin/end() is ok if we are running
+ * in an interrupt context from user mode - we'll just
+ * save the FPU state as required.
+ */
+static bool interrupted_user_mode(void)
+{
+	struct pt_regs *regs = get_irq_regs();
+
+	return regs && user_mode(regs);
+}
+
+/*
+ * Can we use FPU in kernel mode with the
+ * whole "kernel_fpu/altivec/vsx_begin/end()" sequence?
+ *
+ * It's always ok in process context (ie "not interrupt")
+ * but it is sometimes ok even from an irq.
+ */
+bool may_use_simd(void)
+{
+	return !in_interrupt() ||
+		interrupted_user_mode();
+}
+EXPORT_SYMBOL(may_use_simd);
+
 #else
 #define loadvec(thr) 0
 static inline int restore_altivec(struct task_struct *tsk) { return 0; }
-- 
2.21.0.1020.gf2820cf01a

