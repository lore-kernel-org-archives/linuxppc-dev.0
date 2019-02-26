Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EE2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:59:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E683E213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq4iAkH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E683E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447t6K5sh3zDqHp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uq4iAkH4"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sxJ5Jv3zDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:51:32 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id r14so5888278pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 00:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=B+b/BiQ0qghbLj8l9sRsG12oACod+AAcyqEHA3gxsgk=;
 b=Uq4iAkH4uJsZCdUUh5NlkkPnB4fbFcs6rnotcvAFcR2QGsJXqH5PWDV6RbK5/r5iD3
 7jMwHxM6GIdXJgBIkmjcKx84LEGz45cj8DmWxGY9hf8TORZdOjJrExtXiCr8dr3yiEO2
 0HN5aOHgs/9rKyv5d0iJxxP438vQtoTMwX40wSGF+BET9br+a9wNBYsUGLZPR2Ka5XVe
 ePXenUmXWLjYQh62RHDtGvbFSPxVdD1KcDDXubjorvdlaHek9AT0NT59mu5NNCJBfZbq
 29ZIk/k/9bTS9zkjaF72kdN7IPg5kpUPgZAERWeRgg16BioYSKDgtB/dEJmu2A20bvT5
 RtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=B+b/BiQ0qghbLj8l9sRsG12oACod+AAcyqEHA3gxsgk=;
 b=HCwG7DG9XIzTRaAr5jiYuRlu+S/j/VrIHQ7KHqVInUevf3P7LB7gbVevZJD7470bdb
 M1KbUGt6qjS86eO0s94wTzViuLSlQj0HP9d37COBpp0GrPAFKhkqefRARdkTu/zGjE7r
 +45YER6zzb0qK43YeswDR5V5YDgETeDRQQw1hoO5PgzmsfQPcmJN1KSgEjYdIw5Lnu6J
 0DIFyTFo8bXGp0zU4XR5uBlsH7TxKX8QAJTkIEGuMEnPLj46RcTG9HiUEVsurhnHF8wd
 YFOICgY9nCxEdmCAL/jZshP2WGVbKhTsDIC44eUV5UdQdz+CJoj0MZu2YaMsqaCAS6xQ
 hAbQ==
X-Gm-Message-State: AHQUAuYTcZN6dedHmVBE3gmHPutT8fF8IA5DiBcvftBPTbPjZH4uAKtv
 1SnQxdSrFAayhFoDTu57SssvH7Ra
X-Google-Smtp-Source: AHgI3IZ+4DaqiTtO8/TsZ/025BqAjOL3dDO4RTylyuV/p+YOQK2BdknQqFop6/XkH2Z+SCPrhl0+ow==
X-Received: by 2002:a17:902:8643:: with SMTP id
 y3mr24630965plt.195.1551171090648; 
 Tue, 26 Feb 2019 00:51:30 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id t10sm29217103pfa.151.2019.02.26.00.51.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 00:51:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/4] powerpc/64s: Fix data interrupts vs d-side MCE
 reentrancy
Date: Tue, 26 Feb 2019 18:51:10 +1000
Message-Id: <20190226085110.29653-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190226085110.29653-1-npiggin@gmail.com>
References: <20190226085110.29653-1-npiggin@gmail.com>
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

Handlers for interrupts that set DAR / DSISR, set MSR[RI] before those
SPRs are read. If a d-side machine check hits in this window, DAR /
DSISR will be clobbered silently, leading to random corruption.

Fix this by having handlers save those registers before setting MSR[RI].

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 36 ++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0b8b57597837..0e6f274788dd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -582,12 +582,25 @@ EXC_REAL_END(data_access, 0x300, 0x80)
 
 TRAMP_REAL_BEGIN(tramp_real_data_access)
 EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x300)
+	/*
+	 * DAR/DSISR must be read before setting MSR[RI], because
+	 * a d-side MCE will clobber those registers so is not
+	 * recoverable if they are live.
+	 */
+	mfspr	r10,SPRN_DAR
+	mfspr	r11,SPRN_DSISR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	stw	r11,PACA_EXGEN+EX_DSISR(r13)
 EXCEPTION_PROLOG_2(data_access_common, EXC_STD)
 
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXGEN)
 EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x300)
+	mfspr	r10,SPRN_DAR
+	mfspr	r11,SPRN_DSISR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	stw	r11,PACA_EXGEN+EX_DSISR(r13)
 EXCEPTION_PROLOG_2_RELON(data_access_common, EXC_STD)
 EXC_VIRT_END(data_access, 0x4300, 0x80)
 
@@ -598,11 +611,8 @@ EXC_COMMON_BEGIN(data_access_common)
 	 * Here r13 points to the paca, r9 contains the saved CR,
 	 * SRR0 and SRR1 are saved in r11 and r12,
 	 * r9 - r13 are saved in paca->exgen.
+	 * EX_DAR and EX_DSISR have saved DAR/DSISR
 	 */
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
@@ -626,20 +636,22 @@ EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 TRAMP_REAL_BEGIN(tramp_real_data_access_slb)
 EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXSLB+EX_DAR(r13)
 EXCEPTION_PROLOG_2(data_access_slb_common, EXC_STD)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXSLB)
 EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXSLB+EX_DAR(r13)
 EXCEPTION_PROLOG_2_RELON(data_access_slb_common, EXC_STD)
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
 EXC_COMMON_BEGIN(data_access_slb_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXSLB+EX_DAR(r13)
 	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
 	ld	r4,PACA_EXSLB+EX_DAR(r13)
 	std	r4,_DAR(r1)
@@ -739,6 +751,10 @@ EXC_REAL_BEGIN(alignment, 0x600, 0x100)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXGEN)
 EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x600)
+	mfspr	r10,SPRN_DAR
+	mfspr	r11,SPRN_DSISR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	stw	r11,PACA_EXGEN+EX_DSISR(r13)
 EXCEPTION_PROLOG_2(alignment_common, EXC_STD)
 EXC_REAL_END(alignment, 0x600, 0x100)
 
@@ -746,15 +762,15 @@ EXC_VIRT_BEGIN(alignment, 0x4600, 0x100)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXGEN)
 EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x600)
+	mfspr	r10,SPRN_DAR
+	mfspr	r11,SPRN_DSISR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	stw	r11,PACA_EXGEN+EX_DSISR(r13)
 EXCEPTION_PROLOG_2_RELON(alignment_common, EXC_STD)
 EXC_VIRT_END(alignment, 0x4600, 0x100)
 
 TRAMP_KVM(PACA_EXGEN, 0x600)
 EXC_COMMON_BEGIN(alignment_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-- 
2.18.0

