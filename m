Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92149C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:46:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA1D2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB/a2REW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA1D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVsQ0rDCzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:46:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mB/a2REW"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFT1CrXzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:09 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id s198so6451pgs.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CSFlXlQG9+7YxP5FKNXTVd10ZHWMozR2Bk+b5rdMp3w=;
 b=mB/a2REW31o0kYxraOIkHz69HUB89Vwjq/0SLh/P5O7CapsvdY5V9313tomuqpDRRq
 /ty7iok1VB5H0OfFa05Yx1r1Yriul+Ege+AFtduA26JH0vmIaHlxlwF2/TWoAn2oKlp8
 AtKmu41jyeerPmYSxnHz1qfcJUDL3UsjwSWVvUTTAHTXj/52McEvGK5C8YkM8jF5z1m5
 5aJyI7sNopPmPl551dxSmb5YCS8QRp1A7g59GmZo8OQC95uRrf7aFu/cT21RiCQaQktV
 rvpXQkrvw0E1aht5F94me9hWkiEK5ypAiN1Wozz6zxodLk2fa4iooBGyflxojdPVdDGQ
 gidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CSFlXlQG9+7YxP5FKNXTVd10ZHWMozR2Bk+b5rdMp3w=;
 b=H1w62fzD5VpUxBz/PDImTbGQC1RVaRn6xYR2LQbpF61TndB587PJQK2tjmez+djAek
 9+wl9Imc7HsbCytqjU1EnxPhmPm7PQTZZA+YNZvBde0s/C5/OEHYxv+sKG6RHd6B4272
 NntuEFMkNczdFf3vBP2FsJCghdKDuUEBc6Bh3qrMmAxDCvDNLxyutk5WQbVdEyp2+TTj
 wYK3apWgHkAd/fuW3DP+aeZnY4FiKVZgmD9KR0K/W5XTDds7IzIJhRWfQWoTOfN0ghZF
 mz4dsLcgOTFY4SZt4ZB+CI8DiiNI++8a5B9XE0sDHSuNTkVHiuvffglZxKdx6XlOxjpk
 4Cow==
X-Gm-Message-State: AHQUAublyQ7hRO9LvpMX/jxZJOT8eVFDXK/vrHUgJbQ+uAbvNHJcrQ5f
 dHN1h7Ve3u9zwC3gnFW5rFlpbB0K
X-Google-Smtp-Source: AHgI3IbYEzuBlJka9J88I5gurQz43tXK/9PABCR4qGhFA2evNosnnWUEtsuIJhwmpe6BsqPxByZ/Xg==
X-Received: by 2002:a65:6544:: with SMTP id a4mr13169064pgw.412.1549289947212; 
 Mon, 04 Feb 2019 06:19:07 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.19.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/17] powerpc/64s/exception: move EXCEPTION_PROLOG_2* to a
 more logical place
Date: Tue,  5 Feb 2019 00:18:24 +1000
Message-Id: <20190204141828.13043-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204141828.13043-1-npiggin@gmail.com>
References: <20190204141828.13043-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 113 ++++++++++++-----------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index f8f657321c88..e7e5c71b1ad0 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -174,62 +174,6 @@
 	ori	reg,reg,(ABS_ADDR(label))@l;				\
 	addis	reg,reg,(ABS_ADDR(label))@h
 
-.macro EXCEPTION_PROLOG_2_REAL label, hsrr, set_ri
-	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
-	.if ! \set_ri
-	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
-	.endif
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	.else
-	mfspr	r11,SPRN_SRR0		/* save SRR0 */
-	.endif
-	LOAD_HANDLER(r12, \label\())
-	.if \hsrr
-	mtspr	SPRN_HSRR0,r12
-	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
-	mtspr	SPRN_HSRR1,r10
-	HRFI_TO_KERNEL
-	.else
-	mtspr	SPRN_SRR0,r12
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	.endif
-	b	.	/* prevent speculative execution */
-.endm
-
-.macro EXCEPTION_PROLOG_2_VIRT label, hsrr
-#ifdef CONFIG_RELOCATABLE
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0	/* save HSRR0 */
-	.else
-	mfspr	r11,SPRN_SRR0	/* save SRR0 */
-	.endif
-	LOAD_HANDLER(r12, \label\())
-	mtctr	r12
-	.if \hsrr
-	mfspr	r12,SPRN_HSRR1	/* and HSRR1 */
-	.else
-	mfspr	r12,SPRN_SRR1	/* and HSRR1 */
-	.endif
-	li	r10,MSR_RI
-	mtmsrd 	r10,1		/* Set RI (EE=0) */
-	bctr
-#else
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
-	.else
-	mfspr	r11,SPRN_SRR0		/* save SRR0 */
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
-	.endif
-	li	r10,MSR_RI
-	mtmsrd 	r10,1			/* Set RI (EE=0) */
-	b	label
-#endif
-.endm
-
 /* Exception register prefixes */
 #define EXC_HV		1
 #define EXC_STD		0
@@ -339,6 +283,63 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r10,\area\()+EX_R13(r13)
 .endm
 
+.macro EXCEPTION_PROLOG_2_REAL label, hsrr, set_ri
+	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
+	.if ! \set_ri
+	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
+	.endif
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	.else
+	mfspr	r11,SPRN_SRR0		/* save SRR0 */
+	.endif
+	LOAD_HANDLER(r12, \label\())
+	.if \hsrr
+	mtspr	SPRN_HSRR0,r12
+	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
+	mtspr	SPRN_HSRR1,r10
+	HRFI_TO_KERNEL
+	.else
+	mtspr	SPRN_SRR0,r12
+	mfspr	r12,SPRN_SRR1		/* and SRR1 */
+	mtspr	SPRN_SRR1,r10
+	RFI_TO_KERNEL
+	.endif
+	b	.	/* prevent speculative execution */
+.endm
+
+.macro EXCEPTION_PROLOG_2_VIRT label, hsrr
+#ifdef CONFIG_RELOCATABLE
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0	/* save HSRR0 */
+	.else
+	mfspr	r11,SPRN_SRR0	/* save SRR0 */
+	.endif
+	LOAD_HANDLER(r12, \label\())
+	mtctr	r12
+	.if \hsrr
+	mfspr	r12,SPRN_HSRR1	/* and HSRR1 */
+	.else
+	mfspr	r12,SPRN_SRR1	/* and HSRR1 */
+	.endif
+	li	r10,MSR_RI
+	mtmsrd 	r10,1		/* Set RI (EE=0) */
+	bctr
+#else
+	.if \hsrr
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
+	.else
+	mfspr	r11,SPRN_SRR0		/* save SRR0 */
+	mfspr	r12,SPRN_SRR1		/* and SRR1 */
+	.endif
+	li	r10,MSR_RI
+	mtmsrd 	r10,1			/* Set RI (EE=0) */
+	b	label
+#endif
+.endm
+
+
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
  * If hv is possible, interrupts come into to the hv version
-- 
2.18.0

