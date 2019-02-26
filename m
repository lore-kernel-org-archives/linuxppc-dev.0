Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8904C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:57:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E85213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEKEjR5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E85213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447t4f2jNhzDqGG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:57:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SEKEjR5Q"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sxG6C0ZzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:51:30 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id y10so5930860plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PAN5eBWgoMwzQInwGn9Ijcp0joz4DR/o3Ea+sp8q+E4=;
 b=SEKEjR5QjDbuDMc3kaVQM/lTA+CIHZYkmr5ZSsnJrlv/rwJjJh8Mz0PRMKvVF35p2f
 Hm3BDTop1DHqOMLCcPQ6gLA0ybg7/1scnXjhgLX7aSIm+Jnqf+bwk844yffp9ilAh6c+
 LfcXcjklKEoB+r/W4pyaZEuOibrjGotoTualdIADwayKzSb0HTXAj+WfvEL5n6+ov1HD
 AJDO3y116mw1ojAexWEk+FUbKguonnd1Q++e2TRx3mkcUC0onOglcv/6pfh2xEMDcBMQ
 cWw/tX/aby64YGqzj83gvi8NOyfREokJ6ZKhYNpl0+LgXKlJm5E8SBjjfFHIuv4ai51i
 rLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PAN5eBWgoMwzQInwGn9Ijcp0joz4DR/o3Ea+sp8q+E4=;
 b=jci3U3X22B5t6KVT3w+AcKTfMV6egzFN+p43GydljNvfE22BhiejRO8SXTHJsnfAlQ
 XYN30bzTRrtXf/QP08yQ6L5hdx2wWoJcLI8CMAPAbKfHaBFR9CF4RbB4RQ7a+cZCiPq3
 bXchT4Wl5xzn5GNIjh9mu0vyNxiZ9IJ5Y3AJUIgoWT6uXVIcyUhqYVoB2N5wy5GmsVNt
 5Tux84ZVJC/N+66L6A1dSPPItwr3Yn9vzoxWSFZtrW17+h+0LkOJCQH+1iwyDdV7rZ66
 zJ+INM7RIG5WkQxwitg9tlCwZssCXan2v/xUmAft0TYU7curDi/RJMS2mEpj6kFhPb/P
 VrDg==
X-Gm-Message-State: AHQUAuYV0vgfjZiqPYgr4AuDTjYAd7COUtx97IJQrg6RnNTWdOQfPqY7
 NEieuHYWzcNiAQwLblo655LAr2EZ
X-Google-Smtp-Source: AHgI3IaMpI+5gzXIltKufDz4cmk+yoyakFF7l0s0WgkLOQy6o9GLtYL6qj6HfcXdAfIZb1NhC4XyWA==
X-Received: by 2002:a17:902:7889:: with SMTP id
 q9mr25573665pll.305.1551171088476; 
 Tue, 26 Feb 2019 00:51:28 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id t10sm29217103pfa.151.2019.02.26.00.51.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 00:51:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/4] powerpc/64s: Prepare to handle data interrupts vs
 d-side MCE reentrancy
Date: Tue, 26 Feb 2019 18:51:09 +1000
Message-Id: <20190226085110.29653-4-npiggin@gmail.com>
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

