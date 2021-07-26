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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF474C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:01:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E281604D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E281604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5nd1QT9z3fsM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 14:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=S6/W3WJS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d;
 helo=mail-pj1-x102d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=S6/W3WJS; dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5Zj2jnnz3bfC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:51:41 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id l19so11209113pjz.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yrQqMqJQy0pD69345VC9XUGRd5IuhvhW0vV2AuIPX00=;
 b=S6/W3WJS8IFExRdExqTAvDDz6z0UTUOsILfUtj+NLBTHO/LV3RWAyVHeK2HZJ008/U
 zLkS19ZdH4MF2L55rd5X4oAVDSBqCYBjg8T+7BJ8U8utfoegtEHdjRXonYpCkGkkYzYr
 7RBm9lSC6Lpmy9TzULKFViXqEMWbKNgOhTiS6g3WPqsEM1U1zAPFK1GGZN2mKrmBX3xd
 cebU/hVXh/u4ISsvtlgPXa/Wl8Y+xeefHABFXYrm9Cwiaq/7FYG2/GRqi15I30oqmgo9
 oEq2FuXu0of0g+B+wg01+bUPX/tuRmvt52PajX2DZHSHDaNNV3k+zmbQ3DwosEjjCX8G
 MCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yrQqMqJQy0pD69345VC9XUGRd5IuhvhW0vV2AuIPX00=;
 b=O4IZt/JCwLkb+V4w7GR8LE347O5b327HdCZ5E+lDkVHqnRW4GmlYxLKpA8P+aoOJpS
 nWrwQBTswi0CLcKr5xgYy+lMNQxlE8qAWORUkycz8fieOYgyy0DWnuBnK6iw1IhhDiXl
 2BKAiW7FZYKcdImTnpLdQR+zo2QfZpJMv4N8ZuBVHMlJ4Yb21wmnnzKZuQp0LytA8gQS
 RVOB10/fxC5T6i72eEtWKDXdUd4v/vr1qUrh2OoVzKzaDimm/+RF0BmwRY7865bYAZ5d
 WpbRQgQMTxLan/ShmmWSND8xVLtUhuPbwy+EPQBDB2kMjwaNpQBaafxYf13eXNczYX+g
 6V1A==
X-Gm-Message-State: AOAM531t70SPBQif3nolffTj9ARmDTXSZiBA9HAB6UIKlbqZAeMeOwZC
 O2QY4+ki19oZc725ahFAO8BgB3SXZRw=
X-Google-Smtp-Source: ABdhPJyvmfU7zAJVedynlPUw2XNSDPiMja3RDY2SXQXjITzUPKoZrA/HjwMtqnySk+q1TQa1GiahNQ==
X-Received: by 2002:a17:90a:7884:: with SMTP id
 x4mr25345156pjk.53.1627271499434; 
 Sun, 25 Jul 2021 20:51:39 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:51:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 23/55] KVM: PPC: Book3S HV P9: Reduce mtmsrd instructions
 required to save host SPRs
Date: Mon, 26 Jul 2021 13:50:04 +1000
Message-Id: <20210726035036.739609-24-npiggin@gmail.com>
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

This reduces the number of mtmsrd required to enable facility bits when
saving/restoring registers, by having the KVM code set all bits up front
rather than using individual facility functions that set their particular
MSR bits.

-42 cycles (7803) POWER9 virt-mode NULL hcall

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/process.c         | 24 +++++++++++
 arch/powerpc/kvm/book3s_hv.c          | 61 ++++++++++++++++++---------
 arch/powerpc/kvm/book3s_hv_p9_entry.c |  1 +
 3 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 185beb290580..00b55b38a460 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -593,6 +593,30 @@ static void save_all(struct task_struct *tsk)
 	msr_check_and_clear(msr_all_available);
 }
 
+void save_user_regs_kvm(void)
+{
+	unsigned long usermsr;
+
+	if (!current->thread.regs)
+		return;
+
+	usermsr = current->thread.regs->msr;
+
+	if (usermsr & MSR_FP)
+		save_fpu(current);
+
+	if (usermsr & MSR_VEC)
+		save_altivec(current);
+
+	if (usermsr & MSR_TM) {
+                current->thread.tm_tfhar = mfspr(SPRN_TFHAR);
+                current->thread.tm_tfiar = mfspr(SPRN_TFIAR);
+                current->thread.tm_texasr = mfspr(SPRN_TEXASR);
+                current->thread.regs->msr &= ~MSR_TM;
+	}
+}
+EXPORT_SYMBOL_GPL(save_user_regs_kvm);
+
 void flush_all_to_thread(struct task_struct *tsk)
 {
 	if (tsk->thread.regs) {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2e966d62a583..dedcf3ddba3b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4103,6 +4103,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	struct p9_host_os_sprs host_os_sprs;
 	s64 dec;
 	u64 tb, next_timer;
+	unsigned long msr;
 	int trap;
 
 	WARN_ON_ONCE(vcpu->arch.ceded);
@@ -4114,8 +4115,23 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (next_timer < time_limit)
 		time_limit = next_timer;
 
+	vcpu->arch.ceded = 0;
+
 	save_p9_host_os_sprs(&host_os_sprs);
 
+	/* MSR bits may have been cleared by context switch */
+	msr = 0;
+	if (IS_ENABLED(CONFIG_PPC_FPU))
+		msr |= MSR_FP;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		msr |= MSR_VEC;
+	if (cpu_has_feature(CPU_FTR_VSX))
+		msr |= MSR_VSX;
+	if (cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+		msr |= MSR_TM;
+	msr = msr_check_and_set(msr);
+
 	kvmppc_subcore_enter_guest();
 
 	vc->entry_exit_map = 1;
@@ -4124,12 +4140,13 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	vcpu_vpa_increment_dispatch(vcpu);
 
 	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
 		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+		msr = mfmsr(); /* TM restore can update msr */
+	}
 
 	switch_pmu_to_guest(vcpu, &host_os_sprs);
 
-	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
 	load_fp_state(&vcpu->arch.fp);
 #ifdef CONFIG_ALTIVEC
 	load_vr_state(&vcpu->arch.vr);
@@ -4238,7 +4255,6 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	restore_p9_host_os_sprs(vcpu, &host_os_sprs);
 
-	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
 	store_fp_state(&vcpu->arch.fp);
 #ifdef CONFIG_ALTIVEC
 	store_vr_state(&vcpu->arch.vr);
@@ -4767,6 +4783,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	goto done;
 }
 
+void save_user_regs_kvm(void);
+
 static int kvmppc_vcpu_run_hv(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -4776,19 +4794,24 @@ static int kvmppc_vcpu_run_hv(struct kvm_vcpu *vcpu)
 	unsigned long user_tar = 0;
 	unsigned int user_vrsave;
 	struct kvm *kvm;
+	unsigned long msr;
 
 	if (!vcpu->arch.sane) {
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		return -EINVAL;
 	}
 
+	/* No need to go into the guest when all we'll do is come back out */
+	if (signal_pending(current)) {
+		run->exit_reason = KVM_EXIT_INTR;
+		return -EINTR;
+	}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	/*
 	 * Don't allow entry with a suspended transaction, because
 	 * the guest entry/exit code will lose it.
-	 * If the guest has TM enabled, save away their TM-related SPRs
-	 * (they will get restored by the TM unavailable interrupt).
 	 */
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (cpu_has_feature(CPU_FTR_TM) && current->thread.regs &&
 	    (current->thread.regs->msr & MSR_TM)) {
 		if (MSR_TM_ACTIVE(current->thread.regs->msr)) {
@@ -4796,12 +4819,6 @@ static int kvmppc_vcpu_run_hv(struct kvm_vcpu *vcpu)
 			run->fail_entry.hardware_entry_failure_reason = 0;
 			return -EINVAL;
 		}
-		/* Enable TM so we can read the TM SPRs */
-		mtmsr(mfmsr() | MSR_TM);
-		current->thread.tm_tfhar = mfspr(SPRN_TFHAR);
-		current->thread.tm_tfiar = mfspr(SPRN_TFIAR);
-		current->thread.tm_texasr = mfspr(SPRN_TEXASR);
-		current->thread.regs->msr &= ~MSR_TM;
 	}
 #endif
 
@@ -4816,18 +4833,24 @@ static int kvmppc_vcpu_run_hv(struct kvm_vcpu *vcpu)
 
 	kvmppc_core_prepare_to_enter(vcpu);
 
-	/* No need to go into the guest when all we'll do is come back out */
-	if (signal_pending(current)) {
-		run->exit_reason = KVM_EXIT_INTR;
-		return -EINTR;
-	}
-
 	kvm = vcpu->kvm;
 	atomic_inc(&kvm->arch.vcpus_running);
 	/* Order vcpus_running vs. mmu_ready, see kvmppc_alloc_reset_hpt */
 	smp_mb();
 
-	flush_all_to_thread(current);
+	msr = 0;
+	if (IS_ENABLED(CONFIG_PPC_FPU))
+		msr |= MSR_FP;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		msr |= MSR_VEC;
+	if (cpu_has_feature(CPU_FTR_VSX))
+		msr |= MSR_VSX;
+	if (cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+		msr |= MSR_TM;
+	msr = msr_check_and_set(msr);
+
+	save_user_regs_kvm();
 
 	/* Save userspace EBB and other register values */
 	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index a7f63082b4e3..fb9cb34445ea 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -224,6 +224,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 		vc->tb_offset_applied = vc->tb_offset;
 	}
 
+	/* Could avoid mfmsr by passing around, but probably no big deal */
 	msr = mfmsr();
 
 	host_hfscr = mfspr(SPRN_HFSCR);
-- 
2.23.0

