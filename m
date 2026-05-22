Return-Path: <linuxppc-dev+bounces-21380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C515CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKG0WDXz3brl;
	Fri, 22 May 2026 19:56:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443809;
	cv=none; b=CrQM75t9MI2eAw0MhkQx/M/bSd3/y0GGoX0U1/Qp8PxtRsheMa8JRCG1qS13gZAPCB7kIgueLiCJEhjXiG8ZJBnqBadHTvAQHOlxdA4cd+sQHPX6d+5trYL6RKVHLNsF3t/erE9juB0jsdwmZWlVsonSgJ9M66AonMfhbgErNeeZpjnMSlfVVobflWZwKOwK1sfk95LvdkpLCRc0Nv9r7bfrtPN0d+YxFouZQ36EsU3s3haR1cDmnzMj0z28OhBME+B/RRBi5wsARHNMIB+X10+76Xmx7Xn7zQcLjc0p36iLmukVldKjDGVnIRVbrEMwDm6jS309xhfkpC2RrTFAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443809; c=relaxed/relaxed;
	bh=I62BTjgwegdEBrRMDa3/7GAx+tB373Hahc+eIo9iR+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSs8tAEoPXKJnRaB2O6RiwKW5aoTHGoPI0EmTdR45AAcb2CdxmIvhT48pXcl9lmn25hkQCMVEvd6vaCFH2hrKRcbVTFQ9yeJ3P+U1LAzpS5fxobveHtA8Rr2eSNnJVi082XOTsQHUVkSg72C8yYR5tuPGEnwEe1nIBrnjXgz1J4U0u8PJywhM2LcPfZf4IUKxUHjjCMzVAZbBgiBBXnmQaYKYLcB8A9v2/JuNAYp0rfSyxfvLWZFAt8egKlkKXNXnHBMZNguH75h1whaSYfHBqvd3afltxDyNRpTUwyVSIHSEzqdP84i3Ei07QYPwKf++mNysTFErOYbas6HXn/VdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgZIGngG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgZIGngG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKD6VBMz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 43A8141895;
	Fri, 22 May 2026 09:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B91F00A3E;
	Fri, 22 May 2026 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443807;
	bh=I62BTjgwegdEBrRMDa3/7GAx+tB373Hahc+eIo9iR+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgZIGngGxOdzJ3x2/nVOdBOhLtJqHNnRsuRT6U3sY5FJ9K+cuLOTPZeIxjDXzG5Nn
	 BuFByJPS30dubfxvx3PvHCFJq0nrxPGO1EVuMW4ekNXo3ngpI36nIGcSiBIa4dy7iW
	 yfD1WsoRkR9PfTcSQbfXGG3cGcC4Oglptv9fr7MfymSD+cW/H+LqjdqKXf6kEzmNf0
	 QBHoOjmHxQYZ05okYYWVOUEG/NANYPkwiqWaKKC50y9uK0VfhNC8Y+tJ1jOQhy/ZEj
	 EklUcdcp8ByTyEeZXM4sQVmzdxeUJrt/EozaRdNv+hGmpW+tAQpRvlNth/UBG0i7eE
	 h+6/dQhHyzK5w==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/8] powerpc/signal64: Convert to scoped user access
Date: Fri, 22 May 2026 11:56:03 +0200
Message-ID: <adca4321909cd64725ce92bdb45250a48aa116e0.1779441786.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779441786.git.chleroy@kernel.org>
References: <cover.1779441786.git.chleroy@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5583; i=chleroy@kernel.org; h=from:subject:message-id; bh=C5JhuyEfp54V0XGnJp4rC0v3uRomMit7scuJT0Im8VA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNiZvDHsvsOWEDPBP3XyHtvT/AsLL7ueNX15/ob+0 5DZCbOzOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEcoMZGc5pVPzRqW76c3ej saDROWe3KN23HkF/5nEzpv5pC2Wf9JWR4cf32brr4ks6/p5+2JPy7r3Q37M+h/s9fronP7c0l7l 6nQMA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Convert signal64 functions to scoped user access.

Scoped user access also make the code simpler.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_64.c | 81 +++++++++++++--------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 3849af21e1d8..ee8166fd83dc 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -683,15 +683,12 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 
 	if (old_ctx != NULL) {
 		prepare_setup_sigcontext(current);
-		if (!user_write_access_begin(old_ctx, ctx_size))
-			return -EFAULT;
-
-		unsafe_setup_sigcontext(&old_ctx->uc_mcontext, current, 0, NULL,
-					0, ctx_has_vsx_region, efault_out);
-		unsafe_copy_to_user(&old_ctx->uc_sigmask, &current->blocked,
-				    sizeof(sigset_t), efault_out);
-
-		user_write_access_end();
+		scoped_user_write_access_size(old_ctx, ctx_size, efault_out) {
+			unsafe_setup_sigcontext(&old_ctx->uc_mcontext, current, 0, NULL,
+						0, ctx_has_vsx_region, efault_out);
+			unsafe_copy_to_user(&old_ctx->uc_sigmask, &current->blocked,
+					    sizeof(sigset_t), efault_out);
+		}
 	}
 	if (new_ctx == NULL)
 		return 0;
@@ -717,14 +714,12 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	}
 	set_current_blocked(&set);
 
-	if (!user_read_access_begin(new_ctx, ctx_size))
-		return -EFAULT;
-	if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
-		user_read_access_end();
-		force_exit_sig(SIGSEGV);
-		return -EFAULT;
+	scoped_user_read_access_size(new_ctx, ctx_size, efault_out) {
+		if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
+			force_exit_sig(SIGSEGV);
+			return -EFAULT;
+		}
 	}
-	user_read_access_end();
 
 	/* This returns like rt_sigreturn */
 	set_thread_flag(TIF_RESTOREALL);
@@ -732,7 +727,6 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	return 0;
 
 efault_out:
-	user_write_access_end();
 	return -EFAULT;
 }
 
@@ -815,6 +809,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	} else {
+		struct sigcontext __user *uc_mcontext = &uc->uc_mcontext;
 		/*
 		 * Fall through, for non-TM restore
 		 *
@@ -829,13 +824,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
 		 */
 		regs_set_return_msr(current->thread.regs,
 				current->thread.regs->msr & ~MSR_TS_MASK);
-		if (!user_read_access_begin(&uc->uc_mcontext, sizeof(uc->uc_mcontext)))
-			goto badframe;
-
-		unsafe_restore_sigcontext(current, NULL, 1, &uc->uc_mcontext,
-					  badframe_block);
-
-		user_read_access_end();
+		scoped_user_read_access(uc_mcontext, badframe)
+			unsafe_restore_sigcontext(current, NULL, 1, uc_mcontext, badframe);
 	}
 
 	if (restore_altstack(&uc->uc_stack))
@@ -845,8 +835,6 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	return 0;
 
-badframe_block:
-	user_read_access_end();
 badframe:
 	signal_fault(current, regs, "rt_sigreturn", uc);
 
@@ -882,32 +870,29 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 					    msr);
 
 #endif
-	if (!user_write_access_begin(frame, sizeof(*frame)))
-		goto badframe;
+	scoped_user_write_access(frame, badframe) {
+		unsafe_put_user(&frame->info, &frame->pinfo, badframe);
+		unsafe_put_user(&frame->uc, &frame->puc, badframe);
 
-	unsafe_put_user(&frame->info, &frame->pinfo, badframe_block);
-	unsafe_put_user(&frame->uc, &frame->puc, badframe_block);
+		/* Create the ucontext.  */
+		unsafe_put_user(0, &frame->uc.uc_flags, badframe);
+		unsafe_save_altstack(&frame->uc.uc_stack, regs->gpr[1], badframe);
 
-	/* Create the ucontext.  */
-	unsafe_put_user(0, &frame->uc.uc_flags, badframe_block);
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->gpr[1], badframe_block);
-
-	if (MSR_TM_ACTIVE(msr)) {
+		if (MSR_TM_ACTIVE(msr)) {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-		/* The ucontext_t passed to userland points to the second
-		 * ucontext_t (for transactional state) with its uc_link ptr.
-		 */
-		unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link, badframe_block);
+			/* The ucontext_t passed to userland points to the second
+			 * ucontext_t (for transactional state) with its uc_link ptr.
+			 */
+			unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link, badframe);
 #endif
-	} else {
-		unsafe_put_user(0, &frame->uc.uc_link, badframe_block);
-		unsafe_setup_sigcontext(&frame->uc.uc_mcontext, tsk, ksig->sig,
-					NULL, (unsigned long)ksig->ka.sa.sa_handler,
-					1, badframe_block);
-	}
+		} else {
+			unsafe_put_user(0, &frame->uc.uc_link, badframe);
+			unsafe_setup_sigcontext(&frame->uc.uc_mcontext, tsk, ksig->sig, NULL,
+						(unsigned long)ksig->ka.sa.sa_handler, 1, badframe);
+		}
 
-	unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe_block);
-	user_write_access_end();
+		unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe);
+	}
 
 	/* Save the siginfo outside of the unsafe block. */
 	if (copy_siginfo_to_user(&frame->info, &ksig->info))
@@ -964,8 +949,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 	return 0;
 
-badframe_block:
-	user_write_access_end();
 badframe:
 	signal_fault(current, regs, "handle_rt_signal64", frame);
 
-- 
2.54.0


