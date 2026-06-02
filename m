Return-Path: <linuxppc-dev+bounces-21858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6E1C5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4FX6Xyqz2xLm;
	Tue, 02 Jun 2026 18:46:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390016;
	cv=none; b=Qka/UhrscCJqWI4nd7q951yvvYzp7iDNicRtwq2pa/6DGw7C1+36hFkjC7fyxkLXs2kI+EoLhrJ/sod7qzB5aojD2DaloRQDB/dT8PDjUN/KYvTEcnFshblDeIgaKU2CWS7BauhRe+yBsx81HseGUGsQboEhOmNA47NOq5T1XVcwIEShkpAljod0HA4YGVM+HXNEnBHdCmrD2B82l4wRNE+06gMgk0feSIy7I46E0IvBF61RXoyZX9RTyCSLcI36mRk952sJY4oL0F1N1AvmkXuA+7j4A7nd2bQH+kciqUWWZb6lSoOnB6Xs1s2GfCMZRhKstv8P06I8lRzvMIYyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390016; c=relaxed/relaxed;
	bh=wEIia4owzoHXAM5Q1QiHWFkRbAEC+rQaMKj1YQisyR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euQBPQ83lrurB0wZNeJfKZwGodQ/kH6JNJHxZS7iQgsgVF2ZxvKog2W8fx2v/4ZDPZOWUpMbaD5SQiZfFn7du4APNO5GGcpRiy4Nvcokv6W4EsLfNbNkBBAGAaTCDFOWCSor8kZiMNIxYn2IX9PUsXOQyV9XMjByGShY+G5nVJAzD+acUmgFfONnkbfU87eJbTv3tCPXqndYj5FaZk5S/JK2viduakwmxErZWvH4Tu70LNyy8IvuYpOcsuR6jZRS8p3TMk6qyDz1iulNBkcEPkBa2SBj3ht9XdpyT+5l8uaX18dwWzPxwXApPgOFkAglwcs4CGjF4toCkSJd2MAU+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=af5nuutZ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=af5nuutZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4FX2VhDz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:46:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F49D437C8;
	Tue,  2 Jun 2026 08:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD31F00893;
	Tue,  2 Jun 2026 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390014;
	bh=wEIia4owzoHXAM5Q1QiHWFkRbAEC+rQaMKj1YQisyR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=af5nuutZ4ehhaAE98FT7ZzpFCifrcNB2J+b8i1fQyxybDE/z69S96sBtjBGsmrgMs
	 4lRukFZtE4/cVPtyzUaLy1fk6w295u6zDYruGwsYuAg7uWumov334Su1qSSxNG62dr
	 M/OdrfCkQHyQl/VBi0B5S9fZunQfeaRjTP2E/2tuomxcHDCXy+wwqciEIxnyZkdEX7
	 wS+nq/0B4WzZfZsJo/kH1/ZfU8CPIIfEqXa7yQIbT9FyiBwm3Yq1DwFGCnnjdyd7xR
	 VV8rGHNBe0N2DioKLSFvoTJGnFPO34D9C4pZl4CWXG/pUh6AdpSgv8MP0mRbDjUdj1
	 VoGTTbsMd9M1w==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/8] powerpc/signal64: Untangle setup_tm_sigcontexts() and user_access_begin()
Date: Tue,  2 Jun 2026 10:46:31 +0200
Message-ID: <3273e04aedba47f9196edf3ef59f38e7ceaabdb9.1780389863.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=chleroy@kernel.org; h=from:subject:message-id; bh=nyPy/c43MhBW1KA2zDfA5Z3s1fWNtAUmFemUa0E/v/E=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzciduenz0qyvoUkSBy+LNr4S468MOK59PfWwzLRZo lP2zV6S0lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAm8n8Jw/9io9TzL3V2cihY KafVvmjK11mc0ma2O+PmuYvfX2yJ+K/KyPD2lf7u5ih1vb8PPjXOvJz3o/jTPu1TtwvTE67zmzA p17IBAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Call setup_tm_sigcontexts() before opening user access to avoid
having to close and open again.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2: Add a stub setup_tm_sigcontexts() for when CONFIG_PPC_TRANSACTIONAL_MEM is not set
---
 arch/powerpc/kernel/signal_64.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 86bb5bb4c143..9b4cd0bbf4a7 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -203,8 +203,7 @@ static long notrace __unsafe_setup_sigcontext(struct sigcontext __user *sc,
  * examine the transactional registers in the 2nd sigcontext to determine the
  * real origin of the signal.
  */
-static long setup_tm_sigcontexts(struct sigcontext __user *sc,
-				 struct sigcontext __user *tm_sc,
+static long setup_tm_sigcontexts(struct rt_sigframe __user *frame,
 				 struct task_struct *tsk,
 				 int signr, sigset_t *set, unsigned long handler,
 				 unsigned long msr)
@@ -217,6 +216,8 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * Userland shall check AT_HWCAP to know wether it can rely on the
 	 * v_regs pointer or not.
 	 */
+	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
+	struct sigcontext __user *tm_sc = &frame->uc_transact.uc_mcontext;
 #ifdef CONFIG_ALTIVEC
 	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
 	elf_vrreg_t __user *tm_v_regs = sigcontext_vmx_regs(tm_sc);
@@ -325,6 +326,15 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
 	return err;
 }
+#else
+static long setup_tm_sigcontexts(struct rt_sigframe __user *frame,
+				 struct task_struct *tsk,
+				 int signr, sigset_t *set, unsigned long handler,
+				 unsigned long msr)
+{
+	BUILD_BUG();
+	return -EINVAL;
+}
 #endif
 
 /*
@@ -872,6 +882,9 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	 */
 	if (!MSR_TM_ACTIVE(msr))
 		prepare_setup_sigcontext(tsk);
+	else
+		err |= setup_tm_sigcontexts(frame, tsk, ksig->sig, NULL,
+					    (unsigned long)ksig->ka.sa.sa_handler, msr);
 
 	if (!user_write_access_begin(frame, sizeof(*frame)))
 		goto badframe;
@@ -889,19 +902,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		 * ucontext_t (for transactional state) with its uc_link ptr.
 		 */
 		unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link, badframe_block);
-
-		user_write_access_end();
-
-		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
-					    &frame->uc_transact.uc_mcontext,
-					    tsk, ksig->sig, NULL,
-					    (unsigned long)ksig->ka.sa.sa_handler,
-					    msr);
-
-		if (!user_write_access_begin(&frame->uc.uc_sigmask,
-					     sizeof(frame->uc.uc_sigmask)))
-			goto badframe;
-
 #endif
 	} else {
 		unsafe_put_user(0, &frame->uc.uc_link, badframe_block);
-- 
2.54.0


