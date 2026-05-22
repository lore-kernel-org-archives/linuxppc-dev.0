Return-Path: <linuxppc-dev+bounces-21378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FBACD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:56:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKD3Y6jz3bpL;
	Fri, 22 May 2026 19:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443808;
	cv=none; b=iAaPOcPyhrwHj6tjVdN680L2VG96yfIL5nvI/f6rcRXsajqLXbYXyTMyhM36v55GnFp3DWdTrqC6bCTEqHBTAt+RK1JsoKojQYagOle8I0f7s1Gd/0xDnuWqZlcTJyg878uYU8A53Gk6YuFy4YyH7eVzTt9Cr8BUfl3U3r/1xysXHFbXY5E+Q5lzIGa0ZTeU64JZUglwPShb4K8gcQInGTdXCTxufqbWPSJmxoLtG4H7Jbk8pnAv4Q2uf60xIBZeaIC+/ieUTGU4e4pFfKinGHREt41uEENL0HZENMEiEk95cHtN4j2+wTRzxejKYYpsHsMIV5qrpMM3kkZre8jwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443808; c=relaxed/relaxed;
	bh=PS+M11qxsK7pLF5VPFqgaibCX0XcuKhFH5IihJWdaY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PReGtxXlzmub8ZXaTOOuxRad8X5t/pUnURnxHISr2CTpHY5ZCrRDEZmgZXoWutVTHzBOpwuuZPrPBy6S6b5UU7Tg7ILPhKey7p3OpzH4MaC84RtLeqdRI01xL4gmqLt5851hN9/xuNuXdIFjepkHvcZMcuv51EPbOkXVxoxxY8iB1inwmIZpSuW/zZYPP/jUvGzjaRPnsBqF+Apf74WkBrQiqc3ggW7kxK1tLNGCYAEHDo5FZ2hmq+v5zg5036owJ2peFMTefofsCYY+O7xfoORx8Ol9/FXcfZyKgUw1S0ycKEnqLLGO+nSq8mt5tzsSXTc+z4z07IllVs6/FhcWFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kj6lTiSv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kj6lTiSv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKC21tlz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ED4B143B3B;
	Fri, 22 May 2026 09:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388591F000E9;
	Fri, 22 May 2026 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443804;
	bh=PS+M11qxsK7pLF5VPFqgaibCX0XcuKhFH5IihJWdaY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kj6lTiSveeDGvsRklW3EJORl7IkNohMN97x6WztN4Clsn87Ehipo81jvybhsDOzii
	 JMBw4YecyzlZ+5eeOW0AtHlBJymgoRl7gEQ4WW1Ut7H8wTJiqMCedC7HYrlrFr80OG
	 WJ5ggfvNRexBNdqVtDH7oizi2CVnMZHnGKuSG9/Pado3gU6ANilOsxUUAAfUROXwOq
	 UtqBgGaOvBTSKUP1Lq2QcgR0OtXTDKIfsrZbvvMrAfpQeX+CeZ6/xrMVvZYsKtEGxn
	 4l0Ya+tfQLYgpYi43rLHKuR5faiRbKiGAqLwxd7qX/xlQgbqtArN/n82PFgzyEXTmm
	 8JdR2tpy5giQw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/8] powerpc/signal64: Untangle setup_tm_sigcontexts() and user_access_begin()
Date: Fri, 22 May 2026 11:56:02 +0200
Message-ID: <7c83fe5a596514a02fde37da987a48d638d0d097.1779441786.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=chleroy@kernel.org; h=from:subject:message-id; bh=Icgb4f+mxemIv2zrP3yaLp1RI/4pQz56H5O4k1XMi/M=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNi5LT5ezLDXTnb26dvLuiYsOuJuvDM0W3je6gOC3 zmnd0h97ShlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATsVFjZFgfrJPHW6hc/qhR Od334o7VRftkvIRa3fgCplVa6K7UVGVkeCvk9+7Xs+lSMvnixyU2HRT7mc5cbX3uaXVnl3We3M+ j/AA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Call setup_tm_sigcontexts() before opening user access to avoid
having to close and open again.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_64.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 86bb5bb4c143..3849af21e1d8 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -873,6 +873,15 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	if (!MSR_TM_ACTIVE(msr))
 		prepare_setup_sigcontext(tsk);
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(msr))
+		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
+					    &frame->uc_transact.uc_mcontext,
+					    tsk, ksig->sig, NULL,
+					    (unsigned long)ksig->ka.sa.sa_handler,
+					    msr);
+
+#endif
 	if (!user_write_access_begin(frame, sizeof(*frame)))
 		goto badframe;
 
@@ -889,19 +898,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
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


