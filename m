Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2258CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:15:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9404D2173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpKI/Zq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9404D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447pTh2npqzDqDp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:15:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZpKI/Zq0"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447pLH6V07zDqPX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 17:09:27 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id e17so3639422pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 22:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PAN5eBWgoMwzQInwGn9Ijcp0joz4DR/o3Ea+sp8q+E4=;
 b=ZpKI/Zq0pDb3UYJnSCm/s6PZipbk03WrwJsBBSzVcCGOU60/ychraSiYx9eMmaWo5e
 kl77bZYct+nP53xuzpJeM/xF9S7aTS0BlpJ/iHGWTCqx5z/jx+rL4Ow0v8ZADtRx5glS
 FMn3VLspY874saFnzj/umLNKEFFfs4TQv+rV4kXa1I+gmk/KugqMXp2kKf3SOjMfEXoo
 dE2ZINd02cQZNHA90z6Y3BN7ouX95c89z/Do6Mv7/+FWj/zpzaegAT7Yv3sLNm3oziyI
 yAShu8P/VtUOFtqpU7RGqjfEp+tbN2QuPQzkS81u91j0rbGentPXd/Lp/7H69ynWXP8E
 GA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PAN5eBWgoMwzQInwGn9Ijcp0joz4DR/o3Ea+sp8q+E4=;
 b=Qu1C3AWk1TCzXTnNdDPjVz8wGL4cLc0sbcdwexxe/6zA4A3UsNbGDhL34HWxpmOkz1
 yEpabx7dhbH3GL1IaNcaYN9TvT9mVlGrdnB7yyb5X15mXQgOBqbg0huPpLxDqnzJVI8M
 dfeQmFA82o2OLR2n4cvI+RMupCncPqdlTpBmi6Vx5YhdrrEb+SK/XFFrumhwu+Z6HYGk
 BwsZRxE/OI5OYOuIifXa9/TtFlqmgT6IrUKxzDgVq2dlTPAEuVBBhZZ/t9leJyzJxTXS
 OjrYug742p1vFHck4ne/KSiCC0SSK0Ds2wrbSCqox6tIl17GxtDXLOr9NmJ4uf6XC053
 /xzQ==
X-Gm-Message-State: AHQUAuavlfdi9FG5phKfSDDuHb33ZfRxH8c2FM5Qgv4XKU3r7K3R88Ws
 Xeyh611fJQr04c25JThz/WO8c+GDrrY=
X-Google-Smtp-Source: AHgI3IZdBavhKP3wPnQDt6iG6Lnu5b+0d+unsHmS3dj24xHg0NYVDGHL2wOfdkQAxs9pR/0bGDud5A==
X-Received: by 2002:a63:c310:: with SMTP id c16mr22114317pgd.233.1551161365533; 
 Mon, 25 Feb 2019 22:09:25 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id s6sm18478814pgm.90.2019.02.25.22.09.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 22:09:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/4] powerpc/64s: Prepare to handle data interrupts vs
 d-side MCE reentrancy
Date: Tue, 26 Feb 2019 16:09:00 +1000
Message-Id: <20190226060901.18715-4-npiggin@gmail.com>
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

A subsequent fix for data interrupts (those that set DAR / DSISR)
requires some interrupt macros to be open-coded, and also requires
the 0x300 interrupt handler to be moved out-of-line.

This patch does that without changing behaviour, which makes the later
fix a smaller change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 48 ++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d2e9fc968655..0b8b57597837 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -574,8 +574,23 @@ EXC_COMMON_BEGIN(mce_return)
 	RFI_TO_KERNEL
 	b	.
 
-EXC_REAL(data_access, 0x300, 0x80)
-EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
+EXC_REAL_BEGIN(data_access, 0x300, 0x80)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	tramp_real_data_access
+EXC_REAL_END(data_access, 0x300, 0x80)
+
+TRAMP_REAL_BEGIN(tramp_real_data_access)
+EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x300)
+EXCEPTION_PROLOG_2(data_access_common, EXC_STD)
+
+EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x300)
+EXCEPTION_PROLOG_2_RELON(data_access_common, EXC_STD)
+EXC_VIRT_END(data_access, 0x4300, 0x80)
+
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 
 EXC_COMMON_BEGIN(data_access_common)
@@ -604,11 +619,20 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-EXCEPTION_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, KVMTEST_PR, 0x380);
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXSLB)
+	b	tramp_real_data_access_slb
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
+TRAMP_REAL_BEGIN(tramp_real_data_access_slb)
+EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+EXCEPTION_PROLOG_2(data_access_slb_common, EXC_STD)
+
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
-EXCEPTION_RELON_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, NOTEST, 0x380);
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXSLB)
+EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+EXCEPTION_PROLOG_2_RELON(data_access_slb_common, EXC_STD)
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
@@ -711,8 +735,20 @@ TRAMP_KVM_HV(PACA_EXGEN, 0x500)
 EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
 
-EXC_REAL(alignment, 0x600, 0x100)
-EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
+EXC_REAL_BEGIN(alignment, 0x600, 0x100)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x600)
+EXCEPTION_PROLOG_2(alignment_common, EXC_STD)
+EXC_REAL_END(alignment, 0x600, 0x100)
+
+EXC_VIRT_BEGIN(alignment, 0x4600, 0x100)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x600)
+EXCEPTION_PROLOG_2_RELON(alignment_common, EXC_STD)
+EXC_VIRT_END(alignment, 0x4600, 0x100)
+
 TRAMP_KVM(PACA_EXGEN, 0x600)
 EXC_COMMON_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
-- 
2.18.0

