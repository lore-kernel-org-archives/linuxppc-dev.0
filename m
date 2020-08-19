Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0A1C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD3C2067C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YXmaHOrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD3C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWWLH3tdvzDqq8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 12:04:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWW9y3YTrzDqsv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 11:57:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YXmaHOrg; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BWW9x6HWYz9sPf; Wed, 19 Aug 2020 11:57:09 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BWW9x48lGz9sTY; Wed, 19 Aug 2020 11:57:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597802229;
 bh=W+E2Aj7Dr17xacRHKC234FwwSf4fRhgg5lsYKtNYXhg=;
 h=From:To:Subject:Date:From;
 b=YXmaHOrgD65L5VRdqmTkCS1JxKjlzLiNlFEmKIB2mtgRtKgV9eEIAWa0jBTAiWdVG
 CGTAeFG94MxuD7GfTDjaUuBM4V/9PBKhuMgSqv4LKmGJOyA32xqr/HP9iaKd/Oa98+
 mZIadNa4CxP0+NZWgwvUoy2SD5j5fkyWpMfxesjP1G5z6vnEqt2+yKM7Kpi1JwHOn0
 InuC74/ZeFJjWtBg6dHz+xhz9cqQnR1kOYayhOMFlzEn6z6m/Q+m9PjDQn7lnn1C2A
 AyMXzGmenMl+mQt9IJ6ciJkNMGl7FanBDs7i7Jf/qes31RP2ncMjPS36tslHu6xTRA
 Xw3PxeEhrCNqw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Remove unused generic_secondary_thread_init()
Date: Wed, 19 Aug 2020 11:57:04 +1000
Message-Id: <20200819015704.1976364-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The last caller was removed in 2014 in commit fb5a515704d7 ("powerpc:
Remove platforms/wsp and associated pieces").

As Jordan noticed even though there are no callers, the code above in
fsl_secondary_thread_init() falls through into
generic_secondary_thread_init(). So we can remove the _GLOBAL but not
the body of the function.

However because fsl_secondary_thread_init() is inside #ifdef
CONFIG_PPC_BOOK3E, we can never reach the body of
generic_secondary_thread_init() unless CONFIG_PPC_BOOK3E is enabled,
so we can wrap the whole thing in a single #ifdef.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v2: Remove the symbol but not the body.
---
 arch/powerpc/include/asm/smp.h | 1 -
 arch/powerpc/kernel/head_64.S  | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 0d00faf8f119..c074bff1ec30 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -245,7 +245,6 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
  * 64-bit but defining them all here doesn't harm
  */
 extern void generic_secondary_smp_init(void);
-extern void generic_secondary_thread_init(void);
 extern unsigned long __secondary_hold_spinloop;
 extern unsigned long __secondary_hold_acknowledge;
 extern char __secondary_hold;
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 0e05a9a47a4b..1510b2a56669 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -300,9 +300,6 @@ _GLOBAL(fsl_secondary_thread_init)
 	rlwimi	r3, r3, 30, 2, 30
 	mtspr	SPRN_PIR, r3
 1:
-#endif
-
-_GLOBAL(generic_secondary_thread_init)
 	mr	r24,r3
 
 	/* turn on 64-bit mode */
@@ -312,13 +309,13 @@ _GLOBAL(generic_secondary_thread_init)
 	bl	relative_toc
 	tovirt(r2,r2)
 
-#ifdef CONFIG_PPC_BOOK3E
 	/* Book3E initialization */
 	mr	r3,r24
 	bl	book3e_secondary_thread_init
-#endif
 	b	generic_secondary_common_init
 
+#endif /* CONFIG_PPC_BOOK3E */
+
 /*
  * On pSeries and most other platforms, secondary processors spin
  * in the following code.
-- 
2.25.1

