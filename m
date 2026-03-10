Return-Path: <linuxppc-dev+bounces-17950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36EEFCD9F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:00:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVTrm6s6Wz3bjb;
	Tue, 10 Mar 2026 21:00:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136808;
	cv=none; b=XznbDyGhJd04JngcUTzi0Ll8tyOzgoaVepTkvEIvTHXKvLnOaTX5Kr8NeSn40EQrolWVNsGGUISlR32739x+1BfAoqfAOdAYPymm37tZlsNOiJvyKvyl2QES/jAJR1u6nZ/HvA5rU4Qz5s/ZXYUzOdP3etJy/c+GHhaYYYhWzNd5iJnYLWnzQXNUj3MZT/bhhDd2XvWb31hRt3szSJtnQ6MmZpen+04AIeL91G/kRuSulG/01kM87d2NTCvsDJAtli1vtDwfKvGxBWUOvEvyD8QERchD7pvlH8A7MMuO9lPGHEEuxaa3302Y34FRPp8tWi4rinqLdgxjLfpPpPmqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136808; c=relaxed/relaxed;
	bh=Q8IvD5GreuJS/iKDuFI/M9LC8D+kd+TO+zxtNFuHVz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gmr4DoqrWkgrUWDp5GkRiEYSMX/kdPovPSYyFbZeECLdGZUm4hKafUEHrQR/YIjMMXwm7fvM9KIlw0A9KKzxmU+FtAt1DJFF9Thra1JvhX4n4RsdMWSWej6YnzdrWT2f47EiR9ixrKMyNaj1DhXZfbSXLaQ+VsyybH+8CU3w5c1Yid+4i30WIRskXti+Ofzztq9lx2L0ctYJGImb060pVeDVUVIUr46mLBbvTrqSotUN/QebzifaHb2LjPvXRQfAQkJ2QCiYYlwc4/oNFeYl/MVg4Ny5Ojr/F92WU3W37MMDaU2qOiZ2+CcmjUjT21RKsB0KqZW8TKlSPWWmDOZfYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bB+A3wnb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bB+A3wnb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTrm2VKFz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:00:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E75040906;
	Tue, 10 Mar 2026 10:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086E4C19423;
	Tue, 10 Mar 2026 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136806;
	bh=Z3g1N6sf3bDlp1zF2VqM+eQ/mXEmXlRJzqFQA/N5JFo=;
	h=From:To:Cc:Subject:Date:From;
	b=bB+A3wnbkljvfrg1H7+WpSiY7l1aBNaRqCwoqCgac/vjvTuYjrhEGuNGIiupOWHAM
	 VA0cUl/Zl1f00R+rGL4+zHLVoZSgpmOO3qlImKrcxy5RdUuoJoTmp57cIcUWUvzuHE
	 mGBz5WPmyfxF/24G3fuEbfynMes23JPQDIZERju0cQawckI+sUavP+Y4C3w5IDbzEB
	 U8riW3sDoqC4V1aezoyFl8ZOqwKVaY4XXQcq08oCIBYXWYTprAgHUBsW2uNKU8ChCx
	 DgZAgk0i1VbxafqGy3Yq7yTp36kFyNnt+3MkjUBLq+koFFJaRfIpa7i0HaVSj58KNu
	 2neSizNGNV4ow==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/futex: Use masked user access
Date: Tue, 10 Mar 2026 10:59:58 +0100
Message-ID: <e29f6a5c14e5938df68d94bfac6b2f762fb922aa.1773136636.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=chleroy@kernel.org; h=from:subject:message-id; bh=Z3g1N6sf3bDlp1zF2VqM+eQ/mXEmXlRJzqFQA/N5JFo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSufz1f++0q7auiRYlPc3ctavfeverV+b3bnzXN+htl4 Vp85uGrbx2lLAxiXAyyYoosx/9z75rR9SU1f+oufZg5rEwgQxi4OAVgItpJDP9jmi55zA/jY+nt 2xin/uMVR/F9hh3TkgJLnpS3hOukH3Vh+F++PtZ0soySk8ChWvFlmTdsbRq3C87ZUNz4YIqMQt2 XaB4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Use masked user access in arch_futex_atomic_op_inuser()

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/include/asm/futex.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index b3001f8b2c1e..8cf3b2e97e17 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -33,8 +33,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
-	if (!user_access_begin(uaddr, sizeof(u32)))
-		return -EFAULT;
+	uaddr = masked_user_access_begin(uaddr);
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -69,8 +68,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	int ret = 0;
 	u32 prev;
 
-	if (!user_access_begin(uaddr, sizeof(u32)))
-		return -EFAULT;
+	uaddr = masked_user_access_begin(uaddr);
 
         __asm__ __volatile__ (
         PPC_ATOMIC_ENTRY_BARRIER
-- 
2.49.0


