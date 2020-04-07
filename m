Return-Path: <SRS0=EQUS=5X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA444C2BA16
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 05:36:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CEE206F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 05:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBf/rKNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CEE206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48xGPP05k3zDr2r
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rBf/rKNZ; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48xG0P5mLnzDqwW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 15:18:45 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id g9so263493pjp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 22:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nl437sNO9gLL74V/kqg7OkhBKl6Fq4kmvlP9ZCPnhp4=;
 b=rBf/rKNZwWHfIVBThjUFuNhvuS8y6ui1dTuIqfBCXf7PYYTVYsvkbZEJIgOHQginPQ
 nJKr+yj9W7zANgLnh0bmy7UDVUBv4mibgywSt/qVMKWXueHmbkWHeDOvbVpcH3yL62SJ
 unI4CybwBvxVTFIV0CdZaSL0iRs2WYbVVh5mEDCLetsGM8QESMANNai1Zr4eOgSg5wcX
 8lHH/fnwX8jt04S3iDMKI+4Hu/tfGACT5CzhIxgv3rx02Ao5vRPjWPk3kDYq8yc03g1I
 /Lozc0C8aWO1Fa5Pw10cAIFEkN7+CuEwKqzEtOI3/N5AJhCx5jUxDdDdy4rrmLGenlZT
 qTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nl437sNO9gLL74V/kqg7OkhBKl6Fq4kmvlP9ZCPnhp4=;
 b=mzl1Hickwep03t+uGH8GOqTIdXNUid/gukDwmFk2yjhvLZogzCV82hP9/7DvfPqH8t
 sk/YkG6Pa13sJBnjAQqHAiDylc73iT6pCr4TKr1nu71MCMtQCV2C92EHS2l8urG3B8kA
 G+7C1IzJuJpS5+ipBYtjW/SSDEoVQnqvQXaUMvO5lzZtoEFawFRHvoX6gezZSuLfMGYa
 oibjIa/JWIEmcJGGejJParshRpYqINx2K1CSswHQeACjvLXb/+Gdh0NrhfK12wbR1+VM
 MOGjUrnL7C1a/DmGMBcp0/m8tcuEI8O/yehIPUGfNoQHJiQmLcmrEI2ZbWXRi8t5DQMy
 vf3g==
X-Gm-Message-State: AGi0PuYuNJJRxX3Fo6bOwcfxfNjR7vwbaPcfJj00NP5WWT9eDqdimUuo
 wSJ0mrJ4/sJAv0Jn1QwuOhx8fTm0
X-Google-Smtp-Source: APiQypKwBHsxEiRNnzsly1hO3J6FEwJVjoKUlk+EteYL088oU3zZQmM9/zGjr40DGsd3YwNcAkvfJQ==
X-Received: by 2002:a17:902:7896:: with SMTP id
 q22mr733654pll.75.1586236723085; 
 Mon, 06 Apr 2020 22:18:43 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id y17sm12866486pfl.104.2020.04.06.22.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 22:18:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 09/15] powerpc/pseries: limit machine check stack to 4GB
Date: Tue,  7 Apr 2020 15:16:30 +1000
Message-Id: <20200407051636.648369-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200407051636.648369-1-npiggin@gmail.com>
References: <20200407051636.648369-1-npiggin@gmail.com>
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This allows rtas_args to be put on the machine check stack, which
avoids a lot of complications with re-entrancy deadlocks.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 438a9befce41..defe05b6b7a9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -709,7 +709,7 @@ void __init exc_lvl_early_init(void)
  */
 void __init emergency_stack_init(void)
 {
-	u64 limit;
+	u64 limit, mce_limit;
 	unsigned int i;
 
 	/*
@@ -726,7 +726,16 @@ void __init emergency_stack_init(void)
 	 * initialized in kernel/irq.c. These are initialized here in order
 	 * to have emergency stacks available as early as possible.
 	 */
-	limit = min(ppc64_bolted_size(), ppc64_rma_size);
+	limit = mce_limit = min(ppc64_bolted_size(), ppc64_rma_size);
+
+	/*
+	 * Machine check on pseries calls rtas, but can't use the static
+	 * rtas_args due to a machine check hitting while the lock is held.
+	 * rtas args have to be under 4GB, so the machine check stack is
+	 * limited to 4GB so args can be put on stack.
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR) && mce_limit > SZ_4G)
+		mce_limit = SZ_4G;
 
 	for_each_possible_cpu(i) {
 		paca_ptrs[i]->emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
@@ -736,7 +745,7 @@ void __init emergency_stack_init(void)
 		paca_ptrs[i]->nmi_emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
-		paca_ptrs[i]->mc_emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
+		paca_ptrs[i]->mc_emergency_sp = alloc_stack(mce_limit, i) + THREAD_SIZE;
 #endif
 	}
 }
-- 
2.23.0

