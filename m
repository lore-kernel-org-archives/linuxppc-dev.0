Return-Path: <linuxppc-dev+bounces-21859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC52CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4Fc39VSz3bqh;
	Tue, 02 Jun 2026 18:47:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390020;
	cv=none; b=TChAcRDHdOo2MwRUNoXMrImBsxPQN2VDQGTdzytzb19VRy9D6oZ+ffAerwfkxqTrGH2S5PFXGdDUDjvA35KlI8mmODhvMWjZ/ObVxAcJdsBDvp57w8jKJGSLIE+9k0EXAdPX1aRE02p+2sN0hBDM/CqUCjUGZNGlxIQChWk9K9lzp2XNpOfglpk/Gt/NEN3sixV2NFIMZ/ljbAMW7nOmWNFeKmQleIEr8SMmLuHznn29LFlTCbZ9kWT1Hnev/qbY35SoZHGT81sF23/xety6HLfr0FULFuuuZioT2AA/UeGtbEVaSqHTBf722VFn959wVEXMEQxGjwv/Bram7yS0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390020; c=relaxed/relaxed;
	bh=wGSAVChKX7kDKb9uSv3bGyNaq2eKRQOosLSzz0S4tzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHbxFEinFWwLHvkD14zb4y0r8Fv9FwpBX1+GSn+zafZuAkrpQFBnU5ZcFFKDy/YKCKivE6VJwh3uqvlrbDkqNQzcsMhmakZE+pjza67GlVI1gdBVjdDIN3RYORyCvbmU2NoLZOZu+eyoshkHkPiD8OUQbQWzc3II0DbDorfcMwfHc6mxTVMVw1enV3VfvU77mkg9ZCY6l9deRfAsZogFmGfmPBKOsrW6dE4huKfFxiYspbo3xsvrbqtC9bTqRiu1MfN1HLmQOh5FN21Gp5ewS8FZuojdxblJr4K1P2u7U4SXdFe7PjgW8X2UUn/hIccEbRezQc9q9rc84V51TdOIQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orUCBSAk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orUCBSAk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4Fb3SYsz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:46:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D37C445DC;
	Tue,  2 Jun 2026 08:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABA11F00898;
	Tue,  2 Jun 2026 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390017;
	bh=wGSAVChKX7kDKb9uSv3bGyNaq2eKRQOosLSzz0S4tzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orUCBSAkntoeaANeMHX7thmAPPStf5fPxc9ERuGY8gWwhtGxlaaIF1O3UzDYkxc3W
	 1lLmXutHXdo1as+TB/5qdD7W8Umia9kDfjOzZzCtszrwzDw6PjdeiiVDZIMuwTPQRK
	 B5VVGf2l8R1pm3o7nNKdvVqzusZ4q2Kwm2LGPe4sx0yf8B9tgTud0f9ymzzyGBOMnp
	 /m8JTMe3iAq5vVQwVYZV19avjJtVS0ETknQGXABXIibbLFHvIoUiwvVkRInmVHDegP
	 IXPBlGSOVFH2nbb7BYXAbfd5HVXwf5f+QhDnR4hr4RlJL2hqdrzX5B8CZ/B/ISW1Dl
	 rG09uLHfjCkdg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/8] powerpc/signal64: Convert to scoped user access
Date: Tue,  2 Jun 2026 10:46:32 +0200
Message-ID: <5a4104a540b6cfa70fb12d06390e411a6dcd87ef.1780389863.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780389863.git.chleroy@kernel.org>
References: <cover.1780389863.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5674; i=chleroy@kernel.org; h=from:subject:message-id; bh=OpFmrb3bSYZS9X19MBN/xU9riD52+8hcb0/eLT/XCyo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcjVOHZg9WqdfEvLXeEnlzFMb1k74VqT3Uq7b3Myz W7MV5xf31HKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmUtjF8N835NXWB4FJ0xdU dhz5L+UQ1PDywCZj+QdxptceT9P1/a/AyDBn0+L9C1YtnZqsFjennisngSUqa//v1Fe8PdUlfGH XU9kB
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
index 9b4cd0bbf4a7..4ff8ad5d60d0 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -693,15 +693,12 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 
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
@@ -727,14 +724,12 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
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
@@ -742,7 +737,6 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	return 0;
 
 efault_out:
-	user_write_access_end();
 	return -EFAULT;
 }
 
@@ -825,6 +819,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	} else {
+		struct sigcontext __user *uc_mcontext = &uc->uc_mcontext;
 		/*
 		 * Fall through, for non-TM restore
 		 *
@@ -839,13 +834,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
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
@@ -855,8 +845,6 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	return 0;
 
-badframe_block:
-	user_read_access_end();
 badframe:
 	signal_fault(current, regs, "rt_sigreturn", uc);
 
@@ -886,32 +874,29 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		err |= setup_tm_sigcontexts(frame, tsk, ksig->sig, NULL,
 					    (unsigned long)ksig->ka.sa.sa_handler, msr);
 
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
@@ -968,8 +953,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 	return 0;
 
-badframe_block:
-	user_write_access_end();
 badframe:
 	signal_fault(current, regs, "handle_rt_signal64", frame);
 
-- 
2.54.0


