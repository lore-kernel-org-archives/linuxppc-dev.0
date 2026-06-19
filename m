Return-Path: <linuxppc-dev+bounces-22816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538B5CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 10:58:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghZN04GdVz2ykX;
	Fri, 19 Jun 2026 20:58:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781866736;
	cv=none; b=NcRvHy0XUYys3Uz9Ig7mOQIGl4ZUH8lGiSnsG/HjUCg4Pf69Sadj5v80VvdcYvFLz/fVl36CSN6GziYt08YgiMUudGAenj+5uOnss5yYKRBZIxOpDThDPZgHTepFpUFL8Y9en2khQZp0v8MumJX2WrWkwiNcDCuqTOkcTBoNvcff1G0h8ee3tDYP9P96/ejFBj7oHyCl14Sj1i7Lwysyxk/G6Oe56tHhhiIrp425yikQfEEK14e9ofc/R4fVYZfXRI9EktFn0RQecUGiClCbOzAyt7pKNawYOK63NzmpkSXIV2wpetrlujKHdAjCkSuq75vi/VWnXXYOopiE1/vmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781866736; c=relaxed/relaxed;
	bh=rD31m4Qs59Qmv4H3LMWHy/VYnako/8tMZjRtnD0xiwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFu2Kqcc18OCD19+XXxgiI5kYUNmLcjJBnNx15XDBklLL8YtNjBoQ0cy85/uBKFHrDFCPGro+DmW6ZWn3WGo95z/qqkO+Kewm7oeyCBCHyyN8wCcDQWp8/m0jPsZMlxA1XpL8HUbBCJsgyKgaftRjfgnY9Lcs7PlCNfEk2EexpwZq4e93MrXV0DIO7+I6zwOBkEd/wabxqNc8eNIFovnujmwKB+75CkL77zC/IkaEPfVNF606CyPvaTxAAVqV96dPPtAB03pY41sejVSkxSryFFIxQxNCykBnVq36aOEBHfb6Mj79iAaxtG0/LSD4c6Doc7FSgT76V2F4Tfs1BKy+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6/+75id; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6/+75id;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghZMz4ygjz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 20:58:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6061B43F33;
	Fri, 19 Jun 2026 10:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADD1F000E9;
	Fri, 19 Jun 2026 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781866733;
	bh=rD31m4Qs59Qmv4H3LMWHy/VYnako/8tMZjRtnD0xiwk=;
	h=From:To:Cc:Subject:Date;
	b=Y6/+75id+KUWtTYBQuM+vJqvc+xpqhGGEUgc0QzPUekdwuS/k8zqWG8yLbMMNLuzv
	 DfYLPUiig7kNmcAc69Nwn31+UHNwzrNLFTx7eNK2eVGPBbCaElq/qXlGAx2W7LhTXC
	 WLiP0fN6VG4oo3pjwpROuFPVShnatxUq15SfqcRCvG13nJFVoEsw7q6tE5iVr+xU85
	 j+A1rn9bs11ICunz0PkX/ZiG7ai154EXrhGF3CUNYysfb5MHvFs2xQjdj4q2DqKSmC
	 nTsTvaR7b0OZByshFUoM8+APHpSg9608e9CFgj7Fbn2vPWl8G1TaAN9FDoo+EoCTci
	 1oqDP0r8MguBA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32: Use HAVE_PREEMPT_DYNAMIC_CALL instead of HAVE_PREEMPT_DYNAMIC_KEY
Date: Fri, 19 Jun 2026 12:58:37 +0200
Message-ID: <d26da63caddc52de7894c763304ec7ecb23909a8.1781866685.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=chleroy@kernel.org; h=from:subject:message-id; bh=69xBchycAFwQSc+zlSwli5sSblcu4WdIBiSAdgz4IHc=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSZKjxIOOF0y+1W85NfU6/V9Kltzrc61N3pXmyyaZmxn PjpK6v0O0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE6u0YGTqtp787tPRaxwHr oHJlsZ4fYfdqVUoXyEj0cNrIaa+1kGD4HxrnsLkvSVtBsMqMp2D55V03LzaXzu7bY3xywaxNopE R7AA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

powerpc/32 has HAVE_STATIC_CALL_INLINE, so
HAVE_PREEMPT_DYNAMIC_CALL has to be selected instead of
HAVE_PREEMPT_DYNAMIC_KEY for less overhead.

Fixes: 6ad7751537e8 ("powerpc: enable dynamic preemption")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 81642206f7de..7475907cef5b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -281,7 +281,8 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_PREEMPT_DYNAMIC_KEY
+	select HAVE_PREEMPT_DYNAMIC_CALL	if PPC32
+	select HAVE_PREEMPT_DYNAMIC_KEY		if PPC64
 	select HAVE_RETHOOK			if KPROBES
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
-- 
2.54.0


