Return-Path: <linuxppc-dev+bounces-21864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BA5C5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4Fr5dLvz3byZ;
	Tue, 02 Jun 2026 18:47:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390032;
	cv=none; b=Ezo9LOvA5QhXlaHoMfC/uD0ZHYlr39YUFMHNTXwnzpVYacBYlDrdjfYpExcDABTwgGOhBS3LW7ZbsVk0w4NB5wH6qpk9DiTBJaIUN+YvEXxyzPrgrHiOtr6qfxK9Ua3oZit3F1ajEM4+f0OYkFpyNDqtqVELw0QGDfQfNg8rPJ/wwRQIHTkigpEzM6cgc2VA0p34CiBuTjJr0QTN685ZazGXHVLKXM1G2e4Y9k6iojGigjj4lJtyVhcKRrwtOVc7ppYD5NPA53Aci7vea9xygSYHJ8dlmI0YL2o9o9OGMuPiAjXQbTZf7CoN2sbCXS5njbyGQ4Wi/G2fuTUA/ol0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390032; c=relaxed/relaxed;
	bh=hB8KcKOOaDxrq0X6EkuXwqEZ/uT4eAU964Z3866+uHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9C8zVWENsyl32GeSnWcwmMGhKgi25C8LgxiLY38Ef8BQ/8nTXOEXawAvwKKHySIQtrs5s3QZYdz/xPVNWCF9hsk4Km0O9IxOcVWVfE1rdkBy41XB3hNtsiRQLlYv+0n/5NlAKWYxvCiH5wOwy9zktbgqY7A0YNI3Wyv2kNL19XvEaRGxRcHmaXKMeldhwRV7RLqvT7Ghj1kyJ0gg6RAi39AeQLx9ly+hrtaovd0bCYiI9JqLSXIwVBoVX5YDjy4cZgLG4WiAwSUUmWUw3NTHkXvyBuYKmTuXbw7lFPLUtxvKg7lF28NQEv0I99zL+cW9KRr27LakLqXluEWR+W4RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9jsKhni; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9jsKhni;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4Fq6xRNz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:47:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DCCC60123;
	Tue,  2 Jun 2026 08:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BEA1F00899;
	Tue,  2 Jun 2026 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390029;
	bh=hB8KcKOOaDxrq0X6EkuXwqEZ/uT4eAU964Z3866+uHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9jsKhni8d/dKEGeCmkJJhfDcV9bDJjQUqVNPDAD6CXtVLa5GCek4977YI4JpMEa8
	 7BnWwaXSrY8OX/mJTA6X2lLJ30+WjNiJvSdNZTg25Ni52EutbfCDv+srNa2Op6Opnn
	 cbH4O1gpChXs18k5WSfXY16mjrOOT8m/2wJMDXqo4PS4SbHMTQwBI2y3p74V5Ys8Cz
	 /MrDA7vHJcr5xYnaP1eMPehM+2Q7UjmekTtQ7IOnoM7tBxt4z6xxwuns9Lu9cg1++1
	 FeTmOxektzGfWwTsK9yUVgJx05jh+cSFkSxBhxxonVdVcSevNh0KfCDXcaMim97LU8
	 2eW8mtYNZ3dGA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 8/8] powerpc/signal: Use unsafe_copy_siginfo_to_user()
Date: Tue,  2 Jun 2026 10:46:37 +0200
Message-ID: <250c80bb6155b625d0625459234caa17794b12c0.1780389863.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=chleroy@kernel.org; h=from:subject:message-id; bh=ixKhjvehlfnvFNRHYvNkVWnFjQVOC0Kh+ZCiRKQI12c=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcgrf94lGfyhJ3I7c4TL6xdqVibZEiLTmpZvn/C4r HSTwIqkjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCR9P0M/xP/WV2dc7Nv5YzK Kuv1bCvO/3whamfazG3Sppz2cx971Q6G/2HzSibvTj25w0irjPNd27cH30KY2m5NKjrTuC16n/7 0AH4A
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
index 19f320218ed1..e85c430305a1 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -897,14 +897,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
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


