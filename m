Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A436C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:54:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DBA20861
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuQ2S7bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DBA20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kK0V66M3zDqNy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 17:54:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DuQ2S7bO"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kJqM1DRNzDqNQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 17:46:39 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id e5so10969267plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 22:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NCwz64lHJFijoQpp4yA59hxGx/pN4J3mnfPZpJiLMFg=;
 b=DuQ2S7bOPB41eWBkYzY0MQYnnO82WJIktl5v50rDhMSNvQnB43ew4g9BDthoHfvmxn
 ow/8AcfiVc3w/die+PKrqAgIGps0j8MBpG8iyhoO8LuXBVGZ/BoXcUCkux0uxhzRlJpt
 O11JU7gYZwarPEan7iglGmi3yEkwdFSQZ1dFcxzD6QlByYTQG90JCiJcjLD2WjUX7IKV
 0PYCFZ9kR91bV70CyY6Slai4LIlb/bK8kyNcCZmmJgFANsIg2THtUFQzVdh0/ViV/LX3
 OxpBHfOsmNUnA5xSORFTqCcaJU3iZV0WA10Qc4z37bs7y+eXaN0p4FJ0AWIIAh8a4Rzw
 eL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NCwz64lHJFijoQpp4yA59hxGx/pN4J3mnfPZpJiLMFg=;
 b=byl0eOp4kEGFwnbrP+7PsUrtAPQflzBbCB+ItZBY8UZV+5YJJ+MXiXPYXaaKAoXFXf
 nEDYpQ9me6nSiOZ32jAPHLWw6S+92qwbHePzxJLvEoKS678KNJXfEHWBppFPm3KyBnee
 7HM5KhvtYN0tGrydbhCoZbPcZ+MNVTuFaNorirEfsn2C/dgIOoS/+bPyrOO031wD6Y2k
 nKw3s107RvUHNqBbZnMNbDkCW70TtTMQPkjbqXoLiK+3IsyvPprgdgjlJvm28NKHv2kg
 U8Vy77ZkNT5VzAzcv9WPg4o+xx/OZzN9+6Iz3CEkP+9NcfUVXC9snDYTP5acTrJ554w/
 tCyA==
X-Gm-Message-State: AJcUukdqYXibG9oJuq+0jICBn/JTS/xLEANaBLFa2oCV6vZvZfz1V7Rj
 ZWgiA9p0pGu3O4DrrDx2O+RIuqpp
X-Google-Smtp-Source: ALg8bN560FLE/4JBh6b4JrAqEbGk0aqYxOv+BFwblce0zjQteECsdSXsZy7v1YrbODMZ8XAOz8iqpA==
X-Received: by 2002:a17:902:32c3:: with SMTP id
 z61mr32987082plb.114.1548139597043; 
 Mon, 21 Jan 2019 22:46:37 -0800 (PST)
Received: from roar.local0.net (193-116-118-220.tpgi.com.au. [193.116.118.220])
 by smtp.gmail.com with ESMTPSA id v15sm18341830pfn.94.2019.01.21.22.46.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 22:46:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/64s: Fix data interrupts vs d-side MCE reentrancy
Date: Tue, 22 Jan 2019 16:46:18 +1000
Message-Id: <20190122064618.1510-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122064618.1510-1-npiggin@gmail.com>
References: <20190122064618.1510-1-npiggin@gmail.com>
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
SPRs are read and saved away.

If a d-side machine check hits in this window, DAR / DSISR will be
clobbered silently, leading to random behaviour.

Fix this by saving those registers before MSR[RI] is set.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 31 +++++++++++++++++++---------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0d91d1c8aad1..8008ea6730ba 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -574,12 +574,20 @@ EXC_REAL_END(data_access, 0x300, 0x80)
 
 TRAMP_REAL_BEGIN(tramp_real_data_access)
 EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x300)
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
 
@@ -590,11 +598,8 @@ EXC_COMMON_BEGIN(data_access_common)
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
@@ -614,6 +619,8 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXSLB)
 EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
 EXCEPTION_PROLOG_2(data_access_slb_common, EXC_STD)
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
@@ -621,14 +628,14 @@ EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
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
@@ -728,6 +735,10 @@ EXC_REAL_BEGIN(alignment, 0x600, 0x100)
 SET_SCRATCH0(r13)		/* save r13 */
 EXCEPTION_PROLOG_0(PACA_EXGEN)
 EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x600)
+	mfspr	r10,SPRN_DAR
+	mfspr	r11,SPRN_DSISR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	stw	r11,PACA_EXGEN+EX_DSISR(r13)
 EXCEPTION_PROLOG_2(alignment_common, EXC_STD)
 EXC_REAL_END(alignment, 0x600, 0x100)
 
@@ -735,15 +746,15 @@ EXC_VIRT_BEGIN(alignment, 0x4600, 0x100)
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

