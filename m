Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E52C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 04:08:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DD964D92
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 04:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DD964D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DR6Qc5fKfzDrPs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 15:08:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=131.153.2.45;
 helo=h4.fbrelay.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
Received: from h4.fbrelay.privateemail.com (h4.fbrelay.privateemail.com
 [131.153.2.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DR6LG6rlfzDrdN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 15:04:38 +1100 (AEDT)
Received: from MTA-09-3.privateemail.com (mta-09.privateemail.com
 [198.54.127.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4797A8038F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2021 23:04:36 -0500 (EST)
Received: from MTA-09.privateemail.com (localhost [127.0.0.1])
 by MTA-09.privateemail.com (Postfix) with ESMTP id 159F060101
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2021 23:04:33 -0500 (EST)
Received: from oc8246131445.ibm.com (unknown [10.20.151.215])
 by MTA-09.privateemail.com (Postfix) with ESMTPA id DB7EB60102
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 04:04:32 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@codefail.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 10/10] powerpc/signal64: Use __get_user() to copy sigset_t
Date: Wed, 27 Jan 2021 22:04:24 -0600
Message-Id: <20210128040424.12720-11-cmr@codefail.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210128040424.12720-1-cmr@codefail.de>
References: <20210128040424.12720-1-cmr@codefail.de>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Usually sigset_t is exactly 8B which is a "trivial" size and does not
warrant using __copy_from_user(). Use __get_user() directly in
anticipation of future work to remove the trivial size optimizations
from __copy_from_user(). Calling __get_user() also results in a small
boost to signal handling throughput here.

Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
---
 arch/powerpc/kernel/signal_64.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 817b64e1e409..42fdc4a7ff72 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -97,6 +97,14 @@ static void prepare_setup_sigcontext(struct task_struct *tsk, int ctx_has_vsx_re
 #endif /* CONFIG_VSX */
 }
 
+static inline int get_user_sigset(sigset_t *dst, const sigset_t *src)
+{
+	if (sizeof(sigset_t) <= 8)
+		return __get_user(dst->sig[0], &src->sig[0]);
+	else
+		return __copy_from_user(dst, src, sizeof(sigset_t));
+}
+
 /*
  * Set up the sigcontext for the signal frame.
  */
@@ -701,8 +709,9 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 
-	if (__copy_from_user(&set, &new_ctx->uc_sigmask, sizeof(set)))
+	if (get_user_sigset(&set, &new_ctx->uc_sigmask))
 		do_exit(SIGSEGV);
+
 	set_current_blocked(&set);
 
 	if (!user_read_access_begin(new_ctx, ctx_size))
@@ -740,8 +749,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!access_ok(uc, sizeof(*uc)))
 		goto badframe;
 
-	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
+	if (get_user_sigset(&set, &uc->uc_sigmask))
 		goto badframe;
+
 	set_current_blocked(&set);
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-- 
2.26.1

