Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26DC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B0661369
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B0661369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB68t6Kjpz3d8B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 02:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Umdbyta1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633;
 helo=mail-pl1-x633.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Umdbyta1; dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB60c52DZz3bxw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 02:04:32 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id h8so1156191plt.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KWJaCRXIq7/feMmpom+ln/HtX2aZcvMttDNOU/B0+No=;
 b=Umdbyta1RELonlt70ju8XP8sL/vUMhFF5y9sWE5I40qlLI2pFzQfYXJaJTeMkKnJZa
 zRtC+0IZQPq0xsLlqOpjwRqaxef0tj0bj5mx9jPIwjc58WGXAvva2xU0M81AElBsEZ15
 URrTmbgyoAUSgSgEEQTmO+KFmvDn73vMV2uesxnyFGr6lneadiSEER+y2bwZvWY9tIYe
 Wi74Ap7Vp+V0hxG33bVTB/tB4JpXd9EafxeflciElfIdXSgCeaokBu8BSpNXGAiPvkkF
 kzdZ8AACiXvhyT5hF3wtEjWJ3D6qwhQqgoGkLsYLfLgwL7dpgkzh5Os7neFuOTCYhLNp
 CUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KWJaCRXIq7/feMmpom+ln/HtX2aZcvMttDNOU/B0+No=;
 b=m3IEr79WdKsj+uLSyrI8EBuzqcVoX+Z+jHPZLyKn5AGq9+5eneQnL+dE6RLqp8w15W
 jHN1Wn6F0BSy8h4nD/jMI7bTjTGz5C191xG0UDW4KgJhrTIxA0+NzcVfqdD1AmB5+BMr
 Krg4fn0iXu2dHzh6W8/Yv7GMvuFazGx60pqwd9jkYL1fucjcAFHyBtRpFz+Nwf8lpMH0
 S0w4Qow0M5iUGlWqH2MdyX/73y7gzEWKHmsSliOtchaLxdM3bpXVruPVU+bvg1MzNGbA
 pATxBX61OyNU1MT1dkXm20fpimuM75sWSIILsXarbxMC64ZkL5f5wNZYMEXUSgPzSXRa
 mnJA==
X-Gm-Message-State: AOAM532fSY5YxRxzl0n4nc0nyelTcjZ2o1JHYB92SE3TJ+mcoEAILG8F
 8y9/YeDO4VfIpDjG+T6WWSo=
X-Google-Smtp-Source: ABdhPJyN8FgVsBy5q3uMcMp0tflQ9HG38pSDHdkWWHprul9Y22oapM35QMWgQDLpCLQMwtzw0SzhCA==
X-Received: by 2002:a17:902:f686:b029:e5:de44:af60 with SMTP id
 l6-20020a170902f686b02900e5de44af60mr8411834plg.64.1617289470876; 
 Thu, 01 Apr 2021 08:04:30 -0700 (PDT)
Received: from bobo.ibm.com ([1.128.218.207])
 by smtp.gmail.com with ESMTPSA id l3sm5599632pju.44.2021.04.01.08.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:04:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 17/48] KVM: PPC: Book3S 64: move bad_host_intr check to HV
 handler
Date: Fri,  2 Apr 2021 01:02:54 +1000
Message-Id: <20210401150325.442125-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401150325.442125-1-npiggin@gmail.com>
References: <20210401150325.442125-1-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is not used by PR KVM.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_64_entry.S      | 4 ----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 4 +++-
 arch/powerpc/kvm/book3s_segment.S       | 3 +++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
index 30acbfbd1875..0791eb2e3b81 100644
--- a/arch/powerpc/kvm/book3s_64_entry.S
+++ b/arch/powerpc/kvm/book3s_64_entry.S
@@ -107,16 +107,12 @@ do_kvm_interrupt:
 	beq-	.Lmaybe_skip
 .Lno_skip:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	cmpwi	r9,KVM_GUEST_MODE_HOST_HV
-	beq	kvmppc_bad_host_intr
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	cmpwi	r9,KVM_GUEST_MODE_GUEST
-	ld	r9,HSTATE_SCRATCH2(r13)
 	beq	kvmppc_interrupt_pr
 #endif
 	b	kvmppc_interrupt_hv
 #else
-	ld	r9,HSTATE_SCRATCH2(r13)
 	b	kvmppc_interrupt_pr
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f976efb7e4a9..75405ef53238 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1265,6 +1265,7 @@ hdec_soon:
 kvmppc_interrupt_hv:
 	/*
 	 * Register contents:
+	 * R9		= HSTATE_IN_GUEST
 	 * R12		= (guest CR << 32) | interrupt vector
 	 * R13		= PACA
 	 * guest R12 saved in shadow VCPU SCRATCH0
@@ -1272,6 +1273,8 @@ kvmppc_interrupt_hv:
 	 * guest R9 saved in HSTATE_SCRATCH2
 	 */
 	/* We're now back in the host but in guest MMU context */
+	cmpwi	r9,KVM_GUEST_MODE_HOST_HV
+	beq	kvmppc_bad_host_intr
 	li	r9, KVM_GUEST_MODE_HOST_HV
 	stb	r9, HSTATE_IN_GUEST(r13)
 
@@ -3272,7 +3275,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_P9_TM_HV_ASSIST)
  * cfar is saved in HSTATE_CFAR(r13)
  * ppr is saved in HSTATE_PPR(r13)
  */
-.global kvmppc_bad_host_intr
 kvmppc_bad_host_intr:
 	/*
 	 * Switch to the emergency stack, but start half-way down in
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 1f492aa4c8d6..202046a83fc1 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -164,12 +164,15 @@ kvmppc_interrupt_pr:
 	/* 64-bit entry. Register usage at this point:
 	 *
 	 * SPRG_SCRATCH0   = guest R13
+	 * R9              = HSTATE_IN_GUEST
 	 * R12             = (guest CR << 32) | exit handler id
 	 * R13             = PACA
 	 * HSTATE.SCRATCH0 = guest R12
+	 * HSTATE.SCRATCH2 = guest R9
 	 */
 #ifdef CONFIG_PPC64
 	/* Match 32-bit entry */
+	ld	r9,HSTATE_SCRATCH2(r13)
 	rotldi	r12, r12, 32		  /* Flip R12 halves for stw */
 	stw	r12, HSTATE_SCRATCH1(r13) /* CR is now in the low half */
 	srdi	r12, r12, 32		  /* shift trap into low half */
-- 
2.23.0

