Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB1BC433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 10:46:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FCC64FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 10:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FCC64FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F09280f1Bz3dF0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 21:46:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=WTi4qLCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=WTi4qLCF; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F08yF1VHRz3bpJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 21:43:01 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id j6so16737014plx.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kwJwyKigcGU4GvFEUA7iAkQlkVM/3B1gkBWbTht0RCc=;
 b=WTi4qLCF5SxhEYoj8X8vWIPivYjMIS2jD6YEngXyPrZqjtOxnCxuJdplypSPxndKjy
 S3rMYzRkn2CHG/sRz03YtMcEXkuu9p3yjDWjgAvVhUOp8eYzTJirt0nLYAAEc3zHZSyd
 OYjYGe/tAqCxKB97rDoad/cpgCPze7Oqccp3he3VOGPHjja01+HPoUkGBYjpIEGdXRjn
 /NIKJMO+eRNNaeh3Pkt17yBUzuTE/etphPmbBdqU2ckiY2w8uK5E5JfYC95uX+lfcJYS
 hBcYkY5b/6VF+UAp5aYt6OBaCvGF2DER6NYuB2khaBIyI5U2EwZGpN/sHp8TVX0PabCz
 vhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kwJwyKigcGU4GvFEUA7iAkQlkVM/3B1gkBWbTht0RCc=;
 b=RbUfUsaoyyDOV+DTUMRr2pB4uH5TnXdi8JLtMVPp2MiXM+0zsWHXyoIosoPZLOQaKb
 poFeez4xwjQT9hpleNHG5+G29aGLK8EHeb+EjYBduajnzk0ar+j1sG7yyNx4nhaqNDPf
 ePkgGXBLQL3BbRjIb2JJCoXIZ3mxk7pJxRrKWbKuXF9//vGOPJqdnDdp47l5AocLrUiD
 qlzhcxxuegF2W7Qx29xSqBccCq8nWNGHSY64ETJccHUZWHnoVxEetuqSSJlfeWW7sb0d
 y7IZgHFb6mSe/6LE/67+MTGzR1zUY6V67LoBlasBAlZb/2p29gxLZvnR3X9H8EbAROnG
 FOzQ==
X-Gm-Message-State: AOAM531s8cwhdcktSOKUmDpD2DIw4leXRxAW15N6ZlAOtfX+w8Sxe3Fr
 jURAdPChYvqs2un4loqmu7tuPWBsz6I=
X-Google-Smtp-Source: ABdhPJx2bvC7UbJ0f37vRZuPwC61NJwEoxVMRmqKiVeBaVay1gd4V6dqmh3Y0kJpdpzwTxat8i4sFQ==
X-Received: by 2002:a17:90a:840a:: with SMTP id
 j10mr4037419pjn.97.1615891379240; 
 Tue, 16 Mar 2021 03:42:59 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id
 r30sm15828489pgu.86.2021.03.16.03.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 03:42:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/11] powerpc/64e/interrupt: handle bad_page_fault in C
Date: Tue, 16 Mar 2021 20:42:02 +1000
Message-Id: <20210316104206.407354-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210316104206.407354-1-npiggin@gmail.com>
References: <20210316104206.407354-1-npiggin@gmail.com>
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
Cc: Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With non-volatile registers saved on interrupt, bad_page_fault
can now be called by do_page_fault.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 6 ------
 arch/powerpc/mm/fault.c              | 5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 3c222a97f023..7c3654b0d0f4 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -937,12 +937,6 @@ storage_fault_common:
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
 	bl	do_page_fault
-	cmpdi	r3,0
-	bne-	1f
-	b	interrupt_return
-	mr	r4,r3
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	__bad_page_fault
 	b	interrupt_return
 
 /*
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2e54bac99a22..44833660b21d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -552,12 +552,9 @@ static long __do_page_fault(struct pt_regs *regs)
 	if (likely(entry)) {
 		instruction_pointer_set(regs, extable_fixup(entry));
 		return 0;
-	} else if (!IS_ENABLED(CONFIG_PPC_BOOK3E_64)) {
+	} else {
 		__bad_page_fault(regs, err);
 		return 0;
-	} else {
-		/* 32 and 64e handle the bad page fault in asm */
-		return err;
 	}
 }
 NOKPROBE_SYMBOL(__do_page_fault);
-- 
2.23.0

