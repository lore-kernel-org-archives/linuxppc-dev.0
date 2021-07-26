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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B075DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:01:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D34604D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57D34604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5p60Lyxz3dg6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 14:01:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=vOPZwS02;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vOPZwS02; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5Zl4DdDz30QB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:51:43 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 m2-20020a17090a71c2b0290175cf22899cso12424819pjs.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dcPpW+gVoT4ynH1L1M9O+sLZoAI7u1MA7ldnBV8oR7Y=;
 b=vOPZwS02yoJOGLWz4Iy/PiyeyCbWOXHv/4at/U8Vh8SFm4GtkI73RdS+WYVbzP/Z+t
 kAMa95542GpqHu8SyBCfHmBP2lwv5IP/DZZAx/BKSYuIChwaJ3ktqb0ofgrXb7UEicRJ
 BFqspS/o4M1MqtrBynYhzdhci7t9QS/Fu6kSi/u1aQt1LnZRqAiXyPVTnxfQeCtKGCqA
 JLtZwLYhcdHdtpoF/NQAPnDt/3AlHKVXOKYVT0XoWib3y/3Nuna8yBezK69OCtgoz87/
 wro8AYkpcESiUIkUDfyUZG3N89oFJxpRVeoy1pBTOv891E+7cqumPG+tty8rmqloIJuy
 Zlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dcPpW+gVoT4ynH1L1M9O+sLZoAI7u1MA7ldnBV8oR7Y=;
 b=BOGUkNexMCxIBFvIW/eA/2sV7/VmN2YGPGAeQc91p3mUdFo7rUkwgNbSc7iSFjja79
 TUEzpv9JqW/VIZJIkOKv+CyiAoMm3b4sUKzxFWOVnseBCuOcKtFB5J8Eqn/sG1sm79aD
 mOTevrt4Io1c1wEkvdcwEA3oce5JKIPMZk/w3cTUGA01YDbPb3WdAvgDiRT3V4866juW
 Z8LoFIp7vG8XmYLLxUmEjmhzHba+ND30VdA3Y9njmNOGMHdaDLkEvXWwZFItR7EtJlvl
 5wU8bXbeSFpQnw6wtFXVPBkGjEtErIvnQXcAUUDiY72ej4ixQ8fSSQhOIgUSUJNlvFcy
 DzOg==
X-Gm-Message-State: AOAM533Lg1yM9ddTOJH0FK54mEb2sZdBPd8bu3BrNBaNPlR1MI6ylWJw
 uFnIgxiE45ax0Ylz2rARV8c=
X-Google-Smtp-Source: ABdhPJypQXxe5aG6GybNm+5ublhlaXyP4/3pV0wcw8Z9Sgbhefsl3Umgsds3uIkyF80QP+hKmJy0UQ==
X-Received: by 2002:a63:4c03:: with SMTP id z3mr16084182pga.130.1627271501608; 
 Sun, 25 Jul 2021 20:51:41 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:51:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 24/55] KVM: PPC: Book3S HV P9: Improve mtmsrd scheduling by
 delaying MSR[EE] disable
Date: Mon, 26 Jul 2021 13:50:05 +1000
Message-Id: <20210726035036.739609-25-npiggin@gmail.com>
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

Moving the mtmsrd after the host SPRs are saved and before the guest
SPRs start to be loaded can prevent an SPR scoreboard stall (because
the mtmsrd is L=1 type which does not cause context synchronisation.

This is also now more convenient to combined with the mtmsrd L=0
instruction to enable facilities just below, but that is not done yet.

-12 cycles (7791) POWER9 virt-mode NULL hcall

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dedcf3ddba3b..7654235c1507 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4119,6 +4119,18 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	save_p9_host_os_sprs(&host_os_sprs);
 
+	/*
+	 * This could be combined with MSR[RI] clearing, but that expands
+	 * the unrecoverable window. It would be better to cover unrecoverable
+	 * with KVM bad interrupt handling rather than use MSR[RI] at all.
+	 *
+	 * Much more difficult and less worthwhile to combine with IR/DR
+	 * disable.
+	 */
+	hard_irq_disable();
+	if (lazy_irq_pending())
+		return 0;
+
 	/* MSR bits may have been cleared by context switch */
 	msr = 0;
 	if (IS_ENABLED(CONFIG_PPC_FPU))
@@ -4618,6 +4630,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	struct kvmppc_vcore *vc;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_nested_guest *nested = vcpu->arch.nested;
+	unsigned long flags;
 
 	trace_kvmppc_run_vcpu_enter(vcpu);
 
@@ -4661,11 +4674,11 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (kvm_is_radix(kvm))
 		kvmppc_prepare_radix_vcpu(vcpu, pcpu);
 
-	local_irq_disable();
-	hard_irq_disable();
+	/* flags save not required, but irq_pmu has no disable/enable API */
+	powerpc_local_irq_pmu_save(flags);
 	if (signal_pending(current))
 		goto sigpend;
-	if (lazy_irq_pending() || need_resched() || !kvm->arch.mmu_ready)
+	if (need_resched() || !kvm->arch.mmu_ready)
 		goto out;
 
 	if (!nested) {
@@ -4720,7 +4733,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	guest_exit_irqoff();
 
-	local_irq_enable();
+	powerpc_local_irq_pmu_restore(flags);
 
 	cpumask_clear_cpu(pcpu, &kvm->arch.cpu_in_guest);
 
@@ -4778,7 +4791,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	run->exit_reason = KVM_EXIT_INTR;
 	vcpu->arch.ret = -EINTR;
  out:
-	local_irq_enable();
+	powerpc_local_irq_pmu_restore(flags);
 	preempt_enable();
 	goto done;
 }
-- 
2.23.0

