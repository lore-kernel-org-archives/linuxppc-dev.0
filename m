Return-Path: <linuxppc-dev+bounces-11691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965EDCA1012
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Sep 2025 21:12:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHFgB0Vcdz2y2B;
	Thu,  4 Sep 2025 07:12:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756933942;
	cv=none; b=dcVmbqeN3Kjgfiev1RJh0MOhtWjRSNjcFpL5sbo8GJe5ZEcPoOcUyccf/CpuRSyFt5WosscOYtFt7RUBXNPlurjYVqmPt0wIlyLGswOaJbPlqljOioporjbREjW7gyg5NogtVMSanfCPHW+m0B3fEjrt8Xlow5h0ZCS8J30DpVHVrZGj31UTj6Vfxa5J0oPXaECvU9MjRECsICPVwRAb5ySp14oEo+PT/TAyc+OtX/NkYfY4DPjBvKW9sJmOcgvkAovyo/a0re/i3zvpeXYYlTR+pvmc0ciwyNPAk4LAvOO3W1ZbgCktEj07HD0gANAFop2FXg0r1X8FmxbWAFCaew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756933942; c=relaxed/relaxed;
	bh=AgWq9PlyGgImuzA6TKS4Ke1+LBID/IyoCZ0dHzR7JUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQDVzg95TMQMh2xlXXGHyIJlD94N8Cn2yxpO0DWoqY17PlYN/j3qvBXPD48GlBjSi1Yxtqp891EwRMT9jPe2K8FxrWE4Mc7tYYBqaQ2B5325C76I+QNWTRywSev8tdemWobGHycI8gQ+Lnl15RdKxnRYu3OWtXwQEoCxW90VKKlmd8DOgLKVQbXGCRtQrmJNuJIvfIHbxul67z5Rrgb3dbqn32r9YcZNvP+rY30J8M18fQZEehvgDwdmA2Pveqr1Q/lbRLX7cANFc/xAQsnYOa+wyra3n/iRFy8QWWLbCQLKkPhCT/bDlR+Gtsou7evl6O9xNc8py01G8pZltJmzZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pDfX1pyV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pDfX1pyV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHFg86RH2z2xQ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2025 07:12:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0BF656013F;
	Wed,  3 Sep 2025 21:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9759C4CEE7;
	Wed,  3 Sep 2025 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756933938;
	bh=eXH68fi0oBBW92ujAVQNdxDN9cWmORKtrc5sa0RT+xY=;
	h=From:To:Cc:Subject:Date:From;
	b=pDfX1pyVIvamffnSmVZqbAiL3Nf/w8yayG9ux8TCC9bOhGvwSLoZx0SNtwOHoGnGS
	 zGkjJISSKMLsR10tw/R18HQXkcc9D78JU4wezCn44TlcuOhg27ADEvSlZehlOnD3U+
	 2hEEPbePAcdgRQ8XdeRHQH4qZ9fZ/EKqU726/DS4J++5yLlY/l79hv/IttIAJFx0GB
	 MnRhWVaf+Glb+LqweSmw08J4S2hLyTqBWC8nEq33vxNuiR/WzaD2h0IYWbgDjwuEnQ
	 7PtFvuTQa4+hHC4OJsmKdJlDN5s7+ROt8+ZeBhn7TvWeF1/4hH959pYvjgVQ3kNGVj
	 rXlzzzr1+Hm+A==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.4 only v2] powerpc: boot: Remove leading zero in label in udelay()
Date: Wed,  3 Sep 2025 14:11:58 -0700
Message-ID: <20250903211158.2844032-1-nathan@kernel.org>
X-Mailer: git-send-email 2.51.0
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
Content-Transfer-Encoding: 8bit

When building powerpc configurations in linux-5.4.y with binutils 2.43
or newer, there is an assembler error in arch/powerpc/boot/util.S:

  arch/powerpc/boot/util.S: Assembler messages:
  arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
  arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
  arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'

binutils 2.43 contains stricter parsing of certain labels [1], namely
that leading zeros are no longer allowed. The GNU assembler
documentation already somewhat forbade this construct:

  To define a local label, write a label of the form 'N:' (where N
  represents any non-negative integer).

Eliminate the leading zero in the label to fix the syntax error. This is
only needed in linux-5.4.y because commit 8b14e1dff067 ("powerpc: Remove
support for PowerPC 601") removed this code altogether in 5.10.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=226749d5a6ff0d5c607d6428d6c81e1e7e7a994b [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
v1 -> v2:
- Adjust commit message to make it clearer this construct was already
  incorrect under the existing GNU assembler documentation (Segher)

v1: https://lore.kernel.org/20250902235234.2046667-1-nathan@kernel.org/
---
 arch/powerpc/boot/util.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
index f11f0589a669..5ab2bc864e66 100644
--- a/arch/powerpc/boot/util.S
+++ b/arch/powerpc/boot/util.S
@@ -41,12 +41,12 @@ udelay:
 	srwi	r4,r4,16
 	cmpwi	0,r4,1		/* 601 ? */
 	bne	.Ludelay_not_601
-00:	li	r0,86	/* Instructions / microsecond? */
+0:	li	r0,86	/* Instructions / microsecond? */
 	mtctr	r0
 10:	addi	r0,r0,0 /* NOP */
 	bdnz	10b
 	subic.	r3,r3,1
-	bne	00b
+	bne	0b
 	blr
 
 .Ludelay_not_601:

base-commit: c25f780e491e4734eb27d65aa58e0909fd78ad9f
-- 
2.51.0


