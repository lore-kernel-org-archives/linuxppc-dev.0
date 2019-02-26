Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:17:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7602173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3HV+ze7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7602173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447pWp5xlQzDqTf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:17:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h3HV+ze7"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447pLL31PYzDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 17:09:30 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id a3so5679248pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 22:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OM6DZ8FssG3VifsSQSUkcZ4QE9MKsoZni0ApGDOFvGs=;
 b=h3HV+ze7lYDLaAB61/9RbmgTnwt7a4fC90zsCssc9DKNeJ/gjinsSfVESDV8ZdM5dz
 akvoP7682Zk4iCnTky8nR3iogW7rbmp50rH+DVRN9BRuNCTAnvxocEsxyglN3HWiPgZC
 7XLxxrPXxaQ9w0CKzLA9iiLLUrp853xi+8Jqd5FyWNXxNg2dI35eTyJf2SndHUvdD02D
 mz6RgmoTr3hQ8j+Cg6IYmTAnaMCpgXtiOZ1xRNHmEWF31DgXVmqH20JIvnQirFFiWzuk
 h2KDtoBRtrbC6YKBUMlB3F1dcJv1Kuv3OAuDbun246Ugp9fy6mM3CpTJdjnwFAPSpju2
 WqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OM6DZ8FssG3VifsSQSUkcZ4QE9MKsoZni0ApGDOFvGs=;
 b=Q6LJP7pnmdESZR45xTXRj1SYh5k5BrLOrBtNxtF8NMywxTORFeeSsSgj1eZP6IBW47
 lyrIHnaxf5Uz4SdcgbE6fJSBjY46iT+jVbqz+CZ79bNKZkWJUSo36HWGj/pDRbOpFKYD
 xr5cRRka9rh8AVbQpt8f6MtUc2G1K98IjlhSh6kk5ZhNpDdKBVvzhLUXlUNldhPsv/pw
 TuqDRFKK9/YYhIp/HWzcs03r76BqDhSD5istLQzftvCS/S2XmQmTlunQu/qt3EVzUL8F
 6W0aEFwQTpykJrf/e7jSowJ7yXfPmS/He4XduWH9Ndur6m8FHLqIuPz6e2ILYYAw1AS3
 /DYQ==
X-Gm-Message-State: AHQUAuYjc0ybgE6QguB5/twzKZaK7aQY1XGWyaqb9PTiBIV95pBGt+IN
 ug6uWp2KbAhxAkUVpNZ8zk+p5xTqqm8=
X-Google-Smtp-Source: AHgI3IYgZzo5xwwibvueD+ZKftptfI57kY75XpH72A3lcovWH7FhCZUxm0VgWsjgR2SMiIxGrIw17A==
X-Received: by 2002:a62:a504:: with SMTP id v4mr24824964pfm.22.1551161367844; 
 Mon, 25 Feb 2019 22:09:27 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id s6sm18478814pgm.90.2019.02.25.22.09.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 22:09:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/4] powerpc/64s: Fix data interrupts vs d-side MCE
 reentrancy
Date: Tue, 26 Feb 2019 16:09:01 +1000
Message-Id: <20190226060901.18715-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190226060901.18715-1-npiggin@gmail.com>
References: <20190226060901.18715-1-npiggin@gmail.com>
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
index 0b8b57597837..77e9c70f1b49 100644
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
+	std	r10,PACA_EXGEN+EX_DAR(r13)
 EXCEPTION_PROLOG_2(data_access_slb_common, EXC_STD)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXSLB)
 EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
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

