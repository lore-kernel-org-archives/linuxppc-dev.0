Return-Path: <SRS0=YiAJ=HX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60389C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 01:26:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55B6600CD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 01:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55B6600CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DjnhV43Prz3dMm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 12:26:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=68.65.122.27;
 helo=mta-07-4.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
Received: from MTA-07-4.privateemail.com (mta-07-4.privateemail.com
 [68.65.122.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Djnf418kSz30QB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2021 12:24:10 +1100 (AEDT)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 369EB60053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2021 20:24:09 -0500 (EST)
Received: from oc8246131445.ibm.com (unknown [10.20.151.213])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id 11F3660049
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2021 01:24:09 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@codefail.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 10/10] powerpc/signal: Use __get_user() to copy sigset_t
Date: Sat, 20 Feb 2021 19:24:01 -0600
Message-Id: <20210221012401.22328-11-cmr@codefail.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210221012401.22328-1-cmr@codefail.de>
References: <20210221012401.22328-1-cmr@codefail.de>
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
from __copy_from_user().

The ppc32 implementation of get_sigset_t() previously called
copy_from_user() which, unlike __copy_from_user(), calls access_ok().
Replacing this w/ __get_user() (no access_ok()) is fine here since both
callsites in signal_32.c are preceded by an earlier access_ok().

Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
---
 arch/powerpc/kernel/signal.h    | 7 +++++++
 arch/powerpc/kernel/signal_32.c | 2 +-
 arch/powerpc/kernel/signal_64.c | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index d8dd76b1dc94..1393876f3814 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -19,6 +19,13 @@ extern int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 			      struct task_struct *tsk);
 
+static inline int __get_user_sigset(sigset_t *dst, const sigset_t __user *src)
+{
+	BUILD_BUG_ON(sizeof(sigset_t) != sizeof(u64));
+
+	return __get_user(dst->sig[0], (u64 __user *)&src->sig[0]);
+}
+
 #ifdef CONFIG_VSX
 extern unsigned long copy_vsx_to_user(void __user *to,
 				      struct task_struct *task);
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 75ee918a120a..c505b444a613 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -144,7 +144,7 @@ static inline int restore_general_regs(struct pt_regs *regs,
 
 static inline int get_sigset_t(sigset_t *set, const sigset_t __user *uset)
 {
-	return copy_from_user(set, uset, sizeof(*uset));
+	return __get_user_sigset(set, uset);
 }
 
 #define to_user_ptr(p)		((unsigned long)(p))
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 3dd89f99e26f..dc5bac727a62 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -707,7 +707,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 
-	if (__copy_from_user(&set, &new_ctx->uc_sigmask, sizeof(set)))
+	if (__get_user_sigset(&set, &new_ctx->uc_sigmask))
 		do_exit(SIGSEGV);
 	set_current_blocked(&set);
 
@@ -746,7 +746,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!access_ok(uc, sizeof(*uc)))
 		goto badframe;
 
-	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
+	if (__get_user_sigset(&set, &uc->uc_sigmask))
 		goto badframe;
 	set_current_blocked(&set);
 
-- 
2.26.1

