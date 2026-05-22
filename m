Return-Path: <linuxppc-dev+bounces-21382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08759CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:57:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKM27Klz3btm;
	Fri, 22 May 2026 19:56:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443815;
	cv=none; b=GZ6GWlReIn0rNnaKxB5jfjq2F4o549lssCYK9CiiVeA4gEACWa0a20BHLOBoublD3n/T7RpYArdtG9ZMpIx6WS2Y+QQesWOL8ifMRngqCqeQuadUiztOBJl4FIHuWxyOTHY+RPcy4t6MLi4vPd+YitbOpkptsF/Uzdc8Kx73hil+jtgcT0m+RUoRLonnWCB+CEXPsSGsmrlRnTYcPo9s5R1CK5nhFuqMmsZAFc+KxGVINfDAgvtMySMc6UsBq6qTsJnQEmYOWRNJrg05rUCObHylSjpf5hC06/qLMgOaCjFZhmC3yN3stLRxbQ+t8wwCi4vAEBQE/Etd7uTNg82M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443815; c=relaxed/relaxed;
	bh=CdobDuTOgoolQVkszSDKLRqhHkRLaU01XRBQ3D9Mjb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW/PjROUrplZ1oO1eq9x/TbP1utJRIiOdhXCPqduSGiGdNRvePRSslyOWFQWPPGKIrn8GB1MzZ0vnx52RkqrF4qY3rKA0aN+UlcxVcduewURpLfEtgV1zvbQGr/hKu83MVRluz6qFgoXpKXvE3MNM7gqVseVh55o2OPMsPky4tkOfFjVoOoVS3Kh4ttT6IAt9DhQE2V3Yx0hhxfRZFyWPzyR31hl/AUfqe9sKfJUvfsBPCuMN8TYnfOVn5n8b8gQKRb6yuAE4BFYUp74edQJgBcZfGovZWPNnbAz/oyqHihFcjXp6BaSXUfkUKTJgblg/sj7iM6zQa2Niq5llJsb+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juefcFJ4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juefcFJ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKK6s3jz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D54E960172;
	Fri, 22 May 2026 09:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDAA1F00A3E;
	Fri, 22 May 2026 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443811;
	bh=CdobDuTOgoolQVkszSDKLRqhHkRLaU01XRBQ3D9Mjb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=juefcFJ4bFlo8QZ7FNxJNiejm93GsvrXCg1TNQD1hAuE+y1FKJpAQoMvvxCRivbEG
	 hdgPB4fbp5jD7aenObJW8g7Hk+q55Ur/xHf24c2vAl4LhJq8+qeVfp81zXe1QzzhSK
	 JdnOjTgzZDwIc2pvghim70C9WDU9ICY/LTLFSfyRVZK1NiIzhURdJ7ee9SDyZxaO3C
	 fkDyLRgGC7zIItQ5e9NJRQt4Ol2xbslmqx4LGVBIYKaUm0NyzRmKuvbNlBj63T8G3N
	 Ly82hDjNWwgL3Y6hBB90HHxgsRJJRa/YlcKG38vk2bkkYSu46DnGHTF6GdjCSuT3ZD
	 Jex2zxw4BgBZg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 5/8] powerpc/signal: Include the new stack frame inside the user access block
Date: Fri, 22 May 2026 11:56:05 +0200
Message-ID: <287fc000d2f51fde862db0db643801c0ff22cfb7.1779441786.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6733; i=chleroy@kernel.org; h=from:subject:message-id; bh=Sv4X8VTWrdN2udw9liQNQS0v17NX1w7EdMh1y0n3YiI=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNj9kHp1pe6KY2VMntFlFxFx3eub/nzT/rW4dvqp/ WHvLtcv6ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATsRFj+O964lSV4bMTdoI+ jY/bF//vuXW1huOF7KI2tSSJ81/9InoZ/vDvW5fR8OWMsX5NWGbW8315kqzMgfb3P65a7eyX1MZ 4jRUA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Include the new stack frame inside the user access block and set it up
using unsafe_put_user().

On an mpc 8321 (book3s/32) the improvment is about 4% on a process
sending a signal to itself.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_32.c | 28 ++++++++++++----------------
 arch/powerpc/kernel/signal_64.c | 13 ++++++-------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index f5d5139a1426..6b1fbd95b07d 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -730,7 +730,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		       struct task_struct *tsk)
 {
 	struct rt_sigframe __user *frame;
-	unsigned long newsp = 0;
+	unsigned long __user *newsp;
 	unsigned long tramp;
 	struct pt_regs *regs = tsk->thread.regs;
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
@@ -738,12 +738,13 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
+	newsp = (unsigned long __user *)((unsigned long)frame - (__SIGNAL_FRAMESIZE + 16));
 	if (MSR_TM_ACTIVE(msr))
 		prepare_save_tm_user_regs();
 	else
 		prepare_save_user_regs(1);
 
-	scoped_user_rw_access(frame, badframe) {
+	scoped_user_rw_access_size(newsp, __SIGNAL_FRAMESIZE + 16 + sizeof(*frame), badframe) {
 		struct mcontext __user *mctx;
 		struct mcontext __user *tm_mctx = NULL;
 
@@ -784,6 +785,9 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 			asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 		}
 		unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, badframe);
+
+		/* create a stack frame for the caller of the handler */
+		unsafe_put_user(regs->gpr[1], newsp, badframe);
 	}
 
 	if (copy_siginfo_to_user(&frame->info, &ksig->info))
@@ -795,13 +799,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	tsk->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
 #endif
 
-	/* create a stack frame for the caller of the handler */
-	newsp = ((unsigned long)frame) - (__SIGNAL_FRAMESIZE + 16);
-	if (put_user(regs->gpr[1], (u32 __user *)newsp))
-		goto badframe;
-
 	/* Fill registers for signal handler */
-	regs->gpr[1] = newsp;
+	regs->gpr[1] = (unsigned long)newsp;
 	regs->gpr[3] = ksig->sig;
 	regs->gpr[4] = (unsigned long)&frame->info;
 	regs->gpr[5] = (unsigned long)&frame->uc;
@@ -826,7 +825,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 {
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
-	unsigned long newsp = 0;
+	unsigned long __user *newsp;
 	unsigned long tramp;
 	struct pt_regs *regs = tsk->thread.regs;
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
@@ -834,12 +833,13 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
+	newsp = (unsigned long __user *)((unsigned long)frame - __SIGNAL_FRAMESIZE);
 	if (MSR_TM_ACTIVE(msr))
 		prepare_save_tm_user_regs();
 	else
 		prepare_save_user_regs(1);
 
-	scoped_user_rw_access(frame, badframe) {
+	scoped_user_rw_access_size(newsp, __SIGNAL_FRAMESIZE + sizeof(*frame), badframe) {
 		struct mcontext __user *mctx;
 		struct mcontext __user *tm_mctx = NULL;
 
@@ -876,6 +876,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 			unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], badframe);
 			asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 		}
+		unsafe_put_user(regs->gpr[1], newsp, badframe);
 	}
 
 	regs->link = tramp;
@@ -884,12 +885,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	tsk->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
 #endif
 
-	/* create a stack frame for the caller of the handler */
-	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
-	if (put_user(regs->gpr[1], (u32 __user *)newsp))
-		goto badframe;
-
-	regs->gpr[1] = newsp;
+	regs->gpr[1] = (unsigned long)newsp;
 	regs->gpr[3] = ksig->sig;
 	regs->gpr[4] = (unsigned long) sc;
 	regs_set_return_ip(regs, (unsigned long) ksig->ka.sa.sa_handler);
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index bf7fc579d572..67de29cf581a 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -846,13 +846,14 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		struct task_struct *tsk)
 {
 	struct rt_sigframe __user *frame;
-	unsigned long newsp = 0;
+	unsigned long __user *newsp;
 	long err = 0;
 	struct pt_regs *regs = tsk->thread.regs;
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
 	unsigned long msr = regs->msr;
 
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 0);
+	newsp = (unsigned long __user *)((unsigned long)frame - __SIGNAL_FRAMESIZE);
 
 	/*
 	 * This only applies when calling unsafe_setup_sigcontext() and must be
@@ -870,7 +871,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 					    msr);
 
 #endif
-	scoped_user_write_access(frame, badframe) {
+	scoped_user_write_access_size(newsp, __SIGNAL_FRAMESIZE + sizeof(*frame), badframe) {
 		unsafe_put_user(&frame->info, &frame->pinfo, badframe);
 		unsafe_put_user(&frame->uc, &frame->puc, badframe);
 
@@ -892,6 +893,8 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		}
 
 		unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe);
+		/* Allocate a dummy caller frame for the signal handler. */
+		unsafe_put_user(regs->gpr[1], newsp, badframe);
 	}
 
 	/* Save the siginfo outside of the unsafe block. */
@@ -911,10 +914,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		regs_set_return_ip(regs, (unsigned long) &frame->tramp[0]);
 	}
 
-	/* Allocate a dummy caller frame for the signal handler. */
-	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
-	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
-
 	/* Set up "regs" so we "return" to the signal handler. */
 	if (is_elf2_task()) {
 		regs->ctr = (unsigned long) ksig->ka.sa.sa_handler;
@@ -936,7 +935,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 	/* enter the signal handler in native-endian mode */
 	regs_set_return_msr(regs, (regs->msr & ~MSR_LE) | (MSR_KERNEL & MSR_LE));
-	regs->gpr[1] = newsp;
+	regs->gpr[1] = (unsigned long)newsp;
 	regs->gpr[3] = ksig->sig;
 	regs->result = 0;
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-- 
2.54.0


