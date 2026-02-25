Return-Path: <linuxppc-dev+bounces-17141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EE7EF5862
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 05:53:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLP0C6RVYz3dLg;
	Wed, 25 Feb 2026 16:53:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771998811;
	cv=none; b=Q4gt50FWNho0pSAxnKj37BP5SLxLVjdqVaW4uRflatoxQu8wD2XWZPGNxTDb0zHdZvQO+eA9e7L9p/Ixnz36J/BxxR73OmjeuOUNF6egsMOt/HbW/MxmhxG4KSIQaSdz7NKi1gyktHJMnrM3SF0BnVNkD2uPTS+Icn/L6BYlG024i7jKjKSlFhtiwpCZzSOJK3/+0sxe4GSjrmbq/5NkZvaKn9h2oBrPFbyxb2/mRsV7ov4Yj9TBleZgc4rNxkJ1inkRqXvhmL5VJyIu33g4DgCJ44P1oVApB4ohsKSkioPKyg7hOBJjjKxRF/GGc3VprHeggJuLM7L0nylxY3RaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771998811; c=relaxed/relaxed;
	bh=qnPReGM2hVkXdFXwiX9Q5RhhWvQxyaq+ojqJSXa56r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdeKgh3VOPSOr8ZD/qB/vXjdxGaqtu+FufopaWPPQEqWsrZXmQ8uwWZkZjwi3TRrlba/O11WBzEj0+zLN+riF9vpcdUsSEJdDqDBs9LZ4jZQkNdA4Ogsc29sy6l+WdPR+aObAA4RoIFIeseppgtWHcwij9y3IrWLPqefdvLvWUlFp5RSwTcjhJWBRTZNlM5rkGU2TaVo2eM4TA+LmeE7yxPhy79yTy5M5+5l0r3+Q/bFngngcKFhFLV3Cqu4N9r0p21HvDg5RlVDVywTaW8OluGKC8vZyPtg05E8pZvrYGG5pjwZuXWIJCPzYIWUjMpLCc7SsusGCHbcDBldUXkblg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CAf6gC+I; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CAf6gC+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLP0C2wbFz3dLH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 16:53:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qnPReGM2hVkXdFXwiX9Q5RhhWvQxyaq+ojqJSXa56r0=; b=CAf6gC+IZqAh5KiYHxvaEcEEoq
	eI+HS+xaXvCOc2xdgjL0OvOaDEfmK0uZNrHoX8hMpFicwCuzo2h6QEjRc8iLUqF13Z9DexPrtAKAs
	32/ReBzDobeHku2m8ZmCLkqsIt2ZwiGEtrOYaP/h3VralQDnMeF0K2ABrnGUKGIfSpRT0QxYo9QwZ
	nwr2mNc8w7AVMB0ILgJLopNyMPOdldNxFxD1ge0vDFYNDl5rOYSRcdTrxQETSBGXTwceSa5wa8DR/
	7Z9U0Dxwex4lMgide3Azh588OtsgoRT7b7XBrlr5ubVsTHH8oouEFJNIR2jQpRz/7yvtICCYqLC4g
	ePGEdwvw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv7px-00000003GQ4-2prf;
	Wed, 25 Feb 2026 05:53:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/ps3: spu.c: fix enum and Return kernel-doc warnings
Date: Tue, 24 Feb 2026 21:53:28 -0800
Message-ID: <20260225055328.249204-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
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

Fix enum and function return value kernel-doc warnings:

Warning: spu.c:36 Excess enum value '%spe_type_logical' description in 'spe_type'
Warning: spu.c:78 Excess enum value '%spe_ex_state_unexecutable' description in 'spe_ex_state'
Warning: spu.c:78 Excess enum value '%spe_ex_state_executable' description in 'spe_ex_state'
Warning: spu.c:78 Excess enum value '%spe_ex_state_executed' description in 'spe_ex_state'
Warning: spu.c:190 No description found for return value of 'setup_areas'

Fixes: de91a5342995 ("[POWERPC] ps3: add spu support")
Fixes: b47027795a22 ("powerpc/ps3: Fix ioremap of spu shadow regs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/ps3/spu.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-next-20251210.orig/arch/powerpc/platforms/ps3/spu.c
+++ linux-next-20251210/arch/powerpc/platforms/ps3/spu.c
@@ -26,7 +26,7 @@
 
 /**
  * enum spe_type - Type of spe to create.
- * @spe_type_logical: Standard logical spe.
+ * @SPE_TYPE_LOGICAL: Standard logical spe.
  *
  * For use with lv1_construct_logical_spe().  The current HV does not support
  * any types other than those listed.
@@ -64,9 +64,9 @@ struct spe_shadow {
 
 /**
  * enum spe_ex_state - Logical spe execution state.
- * @spe_ex_state_unexecutable: Uninitialized.
- * @spe_ex_state_executable: Enabled, not ready.
- * @spe_ex_state_executed: Ready for use.
+ * @SPE_EX_STATE_UNEXECUTABLE: Uninitialized.
+ * @SPE_EX_STATE_EXECUTABLE: Enabled, not ready.
+ * @SPE_EX_STATE_EXECUTED: Ready for use.
  *
  * The execution state (status) of the logical spe as reported in
  * struct spe_shadow:spe_execution_status.
@@ -185,6 +185,8 @@ static void spu_unmap(struct spu *spu)
  *
  * The current HV requires the spu shadow regs to be mapped with the
  * PTE page protection bits set as read-only.
+ *
+ * Returns: %0 on success or -errno on error.
  */
 
 static int __init setup_areas(struct spu *spu)

