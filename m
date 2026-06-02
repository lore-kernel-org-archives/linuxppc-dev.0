Return-Path: <linuxppc-dev+bounces-21861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8EBCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4Fh51TZz2xdh;
	Tue, 02 Jun 2026 18:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390024;
	cv=none; b=kYIhtEhxAMUrjZkxu6XUmDBCU9ylzjxzgc27NpUNtAuow5FFJ4zhkeIl4sI2vV7SR9WxWldZFTf8VvbG0rXprC6rWeB+gNSINU7zXbQmreLAVt8RK9yQhiK29gOBFKeQGVuU3XVC92lPOoiXFRTlAgySmUTsm1NBI/WzhiRPbcJPQI7N5YHOSCzmx3sQRcQJp6JZGWp5zNiRemxqseGrLrC5XlJ/CIeZ6zdLwusrlIdtaL/8X69rlVo0u5p0HMNP6mUZRAKj07Pclw48yLiM40WJG4bSNgsLystHxqLJitIhpip74SmQ4Tsoi1mMWkvJrjmqG2GbloMIC0vCC8AznA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390024; c=relaxed/relaxed;
	bh=pIqCsuLLewsksHrVdB7iGloQkWquv0tm2KHbomaht3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1u1ZQLpEVrINLX1I0vk5/ksUq+hTsLzc/8N1GWi0vjKf3C6kmR0AwNBwYLvCdxE2cvdvjzUh6U05/msVJoAndG80pNBlYQigLwW/OyBsZIiiW/OR36G0vF7VIE+K3V6YUXM/QkLrrBB/RxpvPwQoctoq4kzGDD5Uvau4MIQ/9AX4K+Fo+ugEt4WzIzEFDvarlouioF8+8hy7wREAXGuG9panmNdd/C3X8nt+q53qA34vCQ6Po4+X+FMVLL/8y1YVJwNHH5spEngVaHBkuVuehCLqUZtBmkfiwVxCvLluY/p2xIbkbsvLpMClc7WJ4K6aT+XGdJVhx1hcBRnf/t7pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFPpvLNt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFPpvLNt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4Fg73TXz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:47:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 43EA1441BE;
	Tue,  2 Jun 2026 08:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF1E1F00899;
	Tue,  2 Jun 2026 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390022;
	bh=pIqCsuLLewsksHrVdB7iGloQkWquv0tm2KHbomaht3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eFPpvLNthEGvphD2HSQffo4Y81BDPZE9rC2ebusV/9Nit3Xepu3OYYlWiMk6/STV1
	 LY93tegpc5ZkBci5n+2Y39AODjlFe+ufnEQdwQXdEWv87KmF4xSKU/3zMxVX+mS+Xv
	 Wfmfuq5AHIoGYqV5kzn1HxDchMh0SelLSRMUohidJnOjBFqcy5oNKGxT+ZIJxMW84t
	 YQxHwExO3WPT4sDJOTLSlVuEY/2EdRG7ZPrk9g+3HVwcoWqAEimBO+EsMOuarKaS6O
	 TtIBawjJ/1+BsbtBtJCkH9iQgHPrceHGgJP04tioLvgxxZlYEw66CBjqjEKQFwS0YL
	 u5m2VNuHb8Iew==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/8] powerpc/signal: Include the new stack frame inside the user access block
Date: Tue,  2 Jun 2026 10:46:34 +0200
Message-ID: <16242a61b12f2920ba4eba7a705272a6e475bede.1780389863.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6824; i=chleroy@kernel.org; h=from:subject:message-id; bh=R4q9+C6lESokrWVF7HF59GXu7c8YM08ZU6LfSFgcbic=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcjlamY2y//BJ5Kxf7PcbWEhuXilCScuy7bf4JHbe 5j7oIJcRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZhIlTIjw/pN2wK37hZX2rnv VqX9E84HnnsWnvVY0Oh97o3pbtmpfqwM/wO7uBemL8p49+LcOZ+DWsFPi+bU7BY8yWKdekbPoe/ /FF4A
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
index d23a980b32a8..19f320218ed1 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -856,13 +856,14 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
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
@@ -874,7 +875,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		err |= setup_tm_sigcontexts(frame, tsk, ksig->sig, NULL,
 					    (unsigned long)ksig->ka.sa.sa_handler, msr);
 
-	scoped_user_write_access(frame, badframe) {
+	scoped_user_write_access_size(newsp, __SIGNAL_FRAMESIZE + sizeof(*frame), badframe) {
 		unsafe_put_user(&frame->info, &frame->pinfo, badframe);
 		unsafe_put_user(&frame->uc, &frame->puc, badframe);
 
@@ -896,6 +897,8 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		}
 
 		unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe);
+		/* Allocate a dummy caller frame for the signal handler. */
+		unsafe_put_user(regs->gpr[1], newsp, badframe);
 	}
 
 	/* Save the siginfo outside of the unsafe block. */
@@ -915,10 +918,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		regs_set_return_ip(regs, (unsigned long) &frame->tramp[0]);
 	}
 
-	/* Allocate a dummy caller frame for the signal handler. */
-	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
-	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
-
 	/* Set up "regs" so we "return" to the signal handler. */
 	if (is_elf2_task()) {
 		regs->ctr = (unsigned long) ksig->ka.sa.sa_handler;
@@ -940,7 +939,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 	/* enter the signal handler in native-endian mode */
 	regs_set_return_msr(regs, (regs->msr & ~MSR_LE) | (MSR_KERNEL & MSR_LE));
-	regs->gpr[1] = newsp;
+	regs->gpr[1] = (unsigned long)newsp;
 	regs->gpr[3] = ksig->sig;
 	regs->result = 0;
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-- 
2.54.0


