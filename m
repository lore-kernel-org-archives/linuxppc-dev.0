Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F53C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 03:57:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5910660EB2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 03:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5910660EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5jX0jvgz3fFg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 13:57:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=MrnqtCfO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MrnqtCfO; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5ZM4d8Hz3bZw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:51:23 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id i1so10011561plr.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RUY4DjhoVcwh8vw/6xuD0mzIiPpFrZzyIYMqsoNMJh4=;
 b=MrnqtCfOgs+2lfNq5vjfN03YUCQ80Z5XjAbdu7GXoNslUaPkTt9YcHIAEeP8u13s1q
 KicdBW6jZIbfzLI6tf00YeDcUfHAe+7n9oSPWfFDuXEhs/6jp63syOVVHgjURoS9jsFo
 f0+ASg5h2+u7ZEkK+NmLx3L6VRruJ3DRipafFdxETRAs6enf6AuLqXVg2dCXuTh+GNiH
 bWgGTnXJfESeG6VfGCizzM69vNKE9jowHfjxSF4nhdiyj3q9RI+iclc9zrcBBC615ceS
 aONS9zhY+fMP1zKcyt9ngJoEd5MLB1ka0njsyl8kNSYJvxzEis2bnGBLCEYTBq3KV2vU
 mKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RUY4DjhoVcwh8vw/6xuD0mzIiPpFrZzyIYMqsoNMJh4=;
 b=MY5YN3bH2eGZzPWmTr7AlPeAi39UepWr/q+MzaB1R9Zk9uBBLDcMgYPYIerAVnR5lZ
 n4I5vA8vlm0cMSdBwuKqUOSZAQNqX1QtuodI9tKECa463O5hN8JQu1vaVCnQdksppfVe
 EL/kpyWNxKBsyPn2M6wQiID8ETMyzMfH7MrAh4uL+JCSzvopcZj6XmQRUx69AoZUWShR
 mNstSRNMeLK836Ih6yNb8f7sp6wxX6tve2C5PJJwpGnpyxlWkJ8SLLl3XAz/ORtLKO8d
 ukoN8kcpq/kMqck1DNfPeY/eeiDsJWUm54EVa0XFwPO0XQFZgLvMwlGqAnml3mJQ0JjZ
 7OMA==
X-Gm-Message-State: AOAM531mc+EC2DI5IsB5x+2ZCdRIGoyUAR/hW+1kU9rdq1VntP6ILcvO
 ZnRyL4gbzWH/CxdnMQgdPD6W0O6FjAg=
X-Google-Smtp-Source: ABdhPJxrwfLnqWKH2gIYKRX/ffRt6PcNWY15ekXVP+YAfRQvKiVKQGSJV9ZzXL8DItYzdaoU+5Dwhg==
X-Received: by 2002:a63:ae48:: with SMTP id e8mr16599544pgp.0.1627271481104;
 Sun, 25 Jul 2021 20:51:21 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:51:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 15/55] powerpc/64s: Always set PMU control registers to
 frozen/disabled when not in use
Date: Mon, 26 Jul 2021 13:49:56 +1000
Message-Id: <20210726035036.739609-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210726035036.739609-1-npiggin@gmail.com>
References: <20210726035036.739609-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

KVM PMU management code looks for particular frozen/disabled bits in
the PMU registers so it knows whether it must clear them when coming
out of a guest or not. Setting this up helps KVM make these optimisations
without getting confused. Longer term the better approach might be to
move guest/host PMU switching to the perf subsystem.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/cpu_setup_power.c | 4 ++--
 arch/powerpc/kernel/dt_cpu_ftrs.c     | 6 +++---
 arch/powerpc/kvm/book3s_hv.c          | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.c b/arch/powerpc/kernel/cpu_setup_power.c
index a29dc8326622..3dc61e203f37 100644
--- a/arch/powerpc/kernel/cpu_setup_power.c
+++ b/arch/powerpc/kernel/cpu_setup_power.c
@@ -109,7 +109,7 @@ static void init_PMU_HV_ISA207(void)
 static void init_PMU(void)
 {
 	mtspr(SPRN_MMCRA, 0);
-	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR0, MMCR0_FC);
 	mtspr(SPRN_MMCR1, 0);
 	mtspr(SPRN_MMCR2, 0);
 }
@@ -123,7 +123,7 @@ static void init_PMU_ISA31(void)
 {
 	mtspr(SPRN_MMCR3, 0);
 	mtspr(SPRN_MMCRA, MMCRA_BHRB_DISABLE);
-	mtspr(SPRN_MMCR0, MMCR0_PMCCEXT);
+	mtspr(SPRN_MMCR0, MMCR0_FC | MMCR0_PMCCEXT);
 }
 
 /*
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 38ea20fadc4a..a6bb0ee179cd 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -353,7 +353,7 @@ static void init_pmu_power8(void)
 	}
 
 	mtspr(SPRN_MMCRA, 0);
-	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR0, MMCR0_FC);
 	mtspr(SPRN_MMCR1, 0);
 	mtspr(SPRN_MMCR2, 0);
 	mtspr(SPRN_MMCRS, 0);
@@ -392,7 +392,7 @@ static void init_pmu_power9(void)
 		mtspr(SPRN_MMCRC, 0);
 
 	mtspr(SPRN_MMCRA, 0);
-	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR0, MMCR0_FC);
 	mtspr(SPRN_MMCR1, 0);
 	mtspr(SPRN_MMCR2, 0);
 }
@@ -428,7 +428,7 @@ static void init_pmu_power10(void)
 
 	mtspr(SPRN_MMCR3, 0);
 	mtspr(SPRN_MMCRA, MMCRA_BHRB_DISABLE);
-	mtspr(SPRN_MMCR0, MMCR0_PMCCEXT);
+	mtspr(SPRN_MMCR0, MMCR0_FC | MMCR0_PMCCEXT);
 }
 
 static int __init feat_enable_pmu_power10(struct dt_cpu_feature *f)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ab89db561c85..2eef708c4354 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2691,6 +2691,11 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 #endif
 #endif
 	vcpu->arch.mmcr[0] = MMCR0_FC;
+	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+		vcpu->arch.mmcr[0] |= MMCR0_PMCCEXT;
+		vcpu->arch.mmcra = MMCRA_BHRB_DISABLE;
+	}
+
 	vcpu->arch.ctrl = CTRL_RUNLATCH;
 	/* default to host PVR, since we can't spoof it */
 	kvmppc_set_pvr_hv(vcpu, mfspr(SPRN_PVR));
-- 
2.23.0

