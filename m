Return-Path: <linuxppc-dev+bounces-21385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D83CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:57:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKX48rnz2yC9;
	Fri, 22 May 2026 19:57:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443824;
	cv=none; b=CkSGTn4hW82kW5mZfW6oZGFK+kXg1+6NiZD0+8w9LDJoOk1odmV0U+INvQzk8OYPq/XXYiXQfVLusX3JhV74qhzp6nCjRbAOlk9uDgEaIGfl0p6bOcrWLV6koKTbf8M7cJU9Kk4Qka0O90INQBUnaHF2fMu5zhzHg/cP4QeUne+Ip9sQvbki5eV5Wvv1kG9zTkCT14GloAuBJi94y61+qxJ93JbKzgcpOCvRqby0CodGO/o1nEJXvASBk0QVBbrjs1DhvnFzt2XqvFeqrV1hk1KDQtWr1JNQUYKcZziFk5z/hbEFU8iPbD1pSjAyA8arAHYa2dZtCK2EXOga+sgxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443824; c=relaxed/relaxed;
	bh=/rlRShe3uK6rrgQZ4IrnyUDRenTqFqb/izOjWLnR3G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuxVORSRZuhNpyOIfQxrnPOe2nZpHcdamib1cMTHaSX7x5uuY4ZZ89eHBpHvGcYum/FhZlVShWYG5u3fXrg09f8KMDTgBV4tItcTpf/5VQ955l07r2DHZ70FAOkXW2M+Dnk44vk/vqTvzMFdOlqCfN2G9B3yfa3QGhNErrXX1IuTpNsWH0/hRbxES8MBVdZtLJx25zHAR0gUf0YmlcatRkoonkdSQKPxDWBbKuhzbTDI03VABEejA9iOCv0I+VjnHAOmf6D3jBapOguA5EigOxWaXuLcaen1WFnsqn3l6fwz1kTA5hfhtKtlAIBlbvgO7yCqLjyjz8/N5mDHndfqpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blaxcWEp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blaxcWEp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKV3Xfjz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:57:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A7BD60136;
	Fri, 22 May 2026 09:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793971F00A3D;
	Fri, 22 May 2026 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443818;
	bh=/rlRShe3uK6rrgQZ4IrnyUDRenTqFqb/izOjWLnR3G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=blaxcWEp8Alstxd06rVmlKQUcUEfXjfOvS3jgXpwpaE4e9xfGXyFa5HJ+dTS0Ftai
	 G9Kp9lqTiCbGeSfL0R7ILUI8TW0PTHpuiFpADsTx3Xp2sf9smT+Z0rVEQReYIO/J0W
	 DpcZbplzYDHfL1LKKtOyzbPYzCJNLrgJc0vD70XT6hapkiETHNzgeWeaK/iuMfn0qO
	 gILQ6ErbVRhVG887QcuGdHF1IziYJ/N9KLRY8vP/FeqbLMIEPX+PDoduF7vDWbnIaK
	 Pa0OT3OgqxRKL9Rz9vS61i5q+YCErQ2pd1OTg/V9rZcsUPhEXvyb8XAEG9bXJ8jlhV
	 gFyLAN9bIPMYA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 8/8] powerpc/signal: Use unsafe_copy_siginfo_to_user()
Date: Fri, 22 May 2026 11:56:08 +0200
Message-ID: <4a8b361c988655ab008ee2b205bfb0b246e16cc2.1779441786.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=chleroy@kernel.org; h=from:subject:message-id; bh=rIbxm+X12keZqdi4mG1S8vXGOqwRa/TOAViAMLqxvMw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNi3dT5aZGE+kZFFcu+dtINx/070nHmlf5Yx+cut1 pqWbQvjO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBExOwY/kffWfFwtX6Xa2lY ekV9cO1DG+k/K1suyjquKdHOXenf842R4ZJV6af7ydvNOU8mnVfM6trX513zx3qKxh2LaXtzMuX m8wAA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Use unsafe_copy_siginfo_to_user() in order to do the copy
within the user access block.

On an mpc 8321 (book3s/32) the improvment is about 5% on a process
sending a signal to itself.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_32.c | 18 +++++++++---------
 arch/powerpc/kernel/signal_64.c |  5 +----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 6b1fbd95b07d..99a3efa874eb 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -716,12 +716,6 @@ static long restore_tm_user_regs(struct pt_regs *regs, struct mcontext __user *s
 }
 #endif
 
-#ifdef CONFIG_PPC64
-
-#define copy_siginfo_to_user	copy_siginfo_to_user32
-
-#endif /* CONFIG_PPC64 */
-
 /*
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
@@ -735,6 +729,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	struct pt_regs *regs = tsk->thread.regs;
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
 	unsigned long msr = regs->msr;
+	compat_siginfo_t uinfo;
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
@@ -744,6 +739,9 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	else
 		prepare_save_user_regs(1);
 
+	if (IS_ENABLED(CONFIG_COMPAT))
+		copy_siginfo_to_external32(&uinfo, &ksig->info);
+
 	scoped_user_rw_access_size(newsp, __SIGNAL_FRAMESIZE + 16 + sizeof(*frame), badframe) {
 		struct mcontext __user *mctx;
 		struct mcontext __user *tm_mctx = NULL;
@@ -785,14 +783,16 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 			asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 		}
 		unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, badframe);
+		if (IS_ENABLED(CONFIG_COMPAT))
+			unsafe_copy_to_user(&frame->info, &uinfo, sizeof(frame->info), badframe);
+		else
+			unsafe_copy_siginfo_to_user((void __user *)&frame->info, &ksig->info,
+						    badframe);
 
 		/* create a stack frame for the caller of the handler */
 		unsafe_put_user(regs->gpr[1], newsp, badframe);
 	}
 
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	regs->link = tramp;
 
 #ifdef CONFIG_PPC_FPU_REGS
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 67de29cf581a..fa18ac43eb2a 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -893,14 +893,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		}
 
 		unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe);
+		unsafe_copy_siginfo_to_user(&frame->info, &ksig->info, badframe);
 		/* Allocate a dummy caller frame for the signal handler. */
 		unsafe_put_user(regs->gpr[1], newsp, badframe);
 	}
 
-	/* Save the siginfo outside of the unsafe block. */
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	/* Make sure signal handler doesn't get spurious FP exceptions */
 	tsk->thread.fp_state.fpscr = 0;
 
-- 
2.54.0


