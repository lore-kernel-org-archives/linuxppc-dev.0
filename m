Return-Path: <SRS0=oKDD=HB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A01C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Jan 2021 13:54:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539B364DD8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Jan 2021 13:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539B364DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DSbKq2BHpzDrnp
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Jan 2021 00:54:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qMQo2/dq; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DSZLW6wnNzDrVB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2021 00:09:55 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id kx7so7232073pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2021 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P6Rg/OvcuORrJnj77VeKmQfxdobIRUXeNtbab+f2Lc8=;
 b=qMQo2/dqs1c3nARSqnLFWFui0P1V8XRrcI+UqU6yfivPii7ZCqLLCFK+29D1KhwOKy
 Okqmzjf7fG0wNHyvX6syG059aNQfzRj1jSQkTct5hr/ylMshxrLvXLXHkiQf4Sx76sDi
 59mfcNJJ0UWkeZ0ZrWqLNafVI3gV0Au85lnctJkzZOUorlMF62OqV2Wm7ImpUGydZN9U
 KIVcJY4d4IMFt82LU9kA03ndER2kpb1q3kKaMmMPO3TUe7vD/dwRtNbz7s1qq1kJt5Uo
 F9TihoFZzrDcXni5NddXJ7iFyprk5AxgLKOiqwzkUjY/ixovxgtBVkyIUZk9cy/sXIRg
 kYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P6Rg/OvcuORrJnj77VeKmQfxdobIRUXeNtbab+f2Lc8=;
 b=BP6ZH7dQ1n3Ptl5nSr8ZpdjRpHD3aMheTRR0CM+F7tvD/deBz0ZH5EyTe3Vet09TEh
 ErMbmGyaFboz49iooCaSQ2taSrQ5fH11SZ+G9Dhy3zZTarjaMqTuflbeMGsI/K7cu/fQ
 AUcO267MQ9aLIXeraYE0m9FOGSu+5RHwE0rak7gWHJwlRijSKYhiSEvnHOcBewX9MPiL
 1Gk3hMwcY88zXxUHWDpOMxa6zrGMiwZTgOwpDTsZ1JpuSyX6uBIVHzlcsslk/4Ho0Rh+
 OWDhBsQnvwtbP+r3GWZD62CuyVZU0WIPqPtdTd8F/ED5HagOXq5aeMt3SExW0hC8frEF
 0XjQ==
X-Gm-Message-State: AOAM530n70qL3DqslYcgApxessjF41o5CDGaKbiEJzbNYGQEZkbTo12n
 i82yssKnsMFYeDlIFd1oxbzongEcUvs=
X-Google-Smtp-Source: ABdhPJyEDMrbdcDmEp5y8ari82l/l9xtPcLHwMwxieRbnlZdrHbzV+xzVS0uxnqbqv6uvts6/k9Jtw==
X-Received: by 2002:a17:90b:182:: with SMTP id t2mr9166784pjs.50.1612012192820; 
 Sat, 30 Jan 2021 05:09:52 -0800 (PST)
Received: from bobo.ozlabs.ibm.com
 (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au.
 [203.221.156.192])
 by smtp.gmail.com with ESMTPSA id y16sm12102240pgg.20.2021.01.30.05.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Jan 2021 05:09:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 14/42] powerpc/64s: move bad_page_fault handling to C
Date: Sat, 30 Jan 2021 23:08:24 +1000
Message-Id: <20210130130852.2952424-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210130130852.2952424-1-npiggin@gmail.com>
References: <20210130130852.2952424-1-npiggin@gmail.com>
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This simplifies code, and it is also useful when introducing
interrupt handler wrappers when introducing wrapper functionality
that doesn't cope with asm entry code calling into more than one
handler function.

32-bit and 64e still have some such cases, which limits some ways
they can use interrupt wrappers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 12 ------------
 arch/powerpc/mm/fault.c              |  4 ++++
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b90d3cde14cf..e69a912c2cc6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1447,12 +1447,6 @@ BEGIN_MMU_FTR_SECTION
 MMU_FTR_SECTION_ELSE
 	bl	do_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
-	cmpdi	r3,0
-	beq+	interrupt_return
-	mr	r5,r3
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ld	r4,_DAR(r1)
-	bl	__bad_page_fault
 	b	interrupt_return
 
 1:	bl	do_break
@@ -1557,12 +1551,6 @@ BEGIN_MMU_FTR_SECTION
 MMU_FTR_SECTION_ELSE
 	bl	do_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
-	cmpdi	r3,0
-	beq+	interrupt_return
-	mr	r5,r3
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ld	r4,_DAR(r1)
-	bl	__bad_page_fault
 	b	interrupt_return
 
 	GEN_KVM instruction_access
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 970ac317e018..fc2d9a27c649 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -557,6 +557,10 @@ long do_page_fault(struct pt_regs *regs)
 	if (likely(entry)) {
 		instruction_pointer_set(regs, extable_fixup(entry));
 		err = 0;
+	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64)) {
+		/* 32 and 64e handle this in asm */
+		__bad_page_fault(regs, err);
+		err = 0;
 	}
 
 out:
-- 
2.23.0

