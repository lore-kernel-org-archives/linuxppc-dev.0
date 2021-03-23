Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D215CC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:17:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757BF6196E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757BF6196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4D4N1Y5Pz3gHC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:17:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=I1jTQ95p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=I1jTQ95p; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4Cnv26FGz3c3B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 12:04:51 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id
 lr1-20020a17090b4b81b02900ea0a3f38c1so364949pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qz7OZxEcix2OHTZvggI/E7prcFB2O0Ezdh7dg685TR0=;
 b=I1jTQ95pGyX4OogGnGmbtF5EyqnJzqHya4k6W2jYd+/oVHyMLL4q+Vk6f5NvzjzWx0
 1kA1bR2Hlh2xKF+t2AMUsB4i4Hq66jdSUmGhQEjPVNCnXz1hIzeo0Q0tvbKcZ3X3HTBh
 F+ILOJluRFhC+mh6kPR2yzP6DfXdARqwb9WlHKjfIVArJmT3Ik2s5ENhbLuVd7g0bfG1
 dPC11zqD/mAn93NSKZJMLADZEAdTJhX30WkTjOW2xtt9XrdE+SHf4E4IGIZTI944Cf13
 KdCwIpp1N7dqJNFsP1DC/vr1JAV1WZMokTAOPbhhctv6w+7AzpJs6Ls/9HkZRgurJpXt
 pKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qz7OZxEcix2OHTZvggI/E7prcFB2O0Ezdh7dg685TR0=;
 b=psvqwOCXyicW54w5n1wFSXHIuHYo6BEw8Kd3URzor3tfJUVxAiq0mYDIN2u5FahfOc
 mdo3wfeuhHxMrcd6vzUmNLWEKFCpA2PmdkHeeWcWD9kKDcCBH499np+ULvZD6LMDpil5
 0DXM0LUT/bYvTfX9dnWoiRKV3TD37huSxI0QVuKTCjLuwT0ddb7C+v9OrY+MBoCB9fv9
 SfZfEVolkNkwETvA2Er9WFbuHnpHz6S1ChNZ2yho+LL0xtLpDUQ3eBYSUAoIQian4OxR
 4XV5FjlwJVM092QHG6WcASHB89Cft9RVIturgJ7kInHiAlS/HtkpbbIoU/Ro7Vq+LhRW
 8Q3Q==
X-Gm-Message-State: AOAM530q4wYJC/3p4uFCA4xQaRevBplSGVuTWsmQEJVXlp+905kzgBSq
 I1xiwgAJum+l4mBNo6kurs0=
X-Google-Smtp-Source: ABdhPJx4WNr7LNNV5hPHVGAFveV7OCIwQ7ktNnCffZxzlm/mwkVJnyOEkVZf7ryLkCJBg4esbwWhpg==
X-Received: by 2002:a17:90a:7847:: with SMTP id
 y7mr1830356pjl.65.1616461489539; 
 Mon, 22 Mar 2021 18:04:49 -0700 (PDT)
Received: from bobo.ibm.com ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id e7sm14491894pfc.88.2021.03.22.18.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 18:04:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v4 31/46] KVM: PPC: Book3S HV P9: Read machine check registers
 while MSR[RI] is 0
Date: Tue, 23 Mar 2021 11:02:50 +1000
Message-Id: <20210323010305.1045293-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210323010305.1045293-1-npiggin@gmail.com>
References: <20210323010305.1045293-1-npiggin@gmail.com>
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

SRR0/1, DAR, DSISR must all be protected from machine check which can
clobber them. Ensure MSR[RI] is clear while they are live.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c           | 11 +++++++--
 arch/powerpc/kvm/book3s_hv_interrupt.c | 33 +++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_ras.c       |  2 ++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 52f844a06899..98e5ae897fad 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3551,11 +3551,16 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	mtspr(SPRN_BESCR, vcpu->arch.bescr);
 	mtspr(SPRN_WORT, vcpu->arch.wort);
 	mtspr(SPRN_TIDR, vcpu->arch.tid);
-	mtspr(SPRN_DAR, vcpu->arch.shregs.dar);
-	mtspr(SPRN_DSISR, vcpu->arch.shregs.dsisr);
 	mtspr(SPRN_AMR, vcpu->arch.amr);
 	mtspr(SPRN_UAMOR, vcpu->arch.uamor);
 
+	/*
+	 * DAR, DSISR, and for nested HV, SPRGs must be set with MSR[RI]
+	 * clear (or hstate set appropriately to catch those registers
+	 * being clobbered if we take a MCE or SRESET), so those are done
+	 * later.
+	 */
+
 	if (!(vcpu->arch.ctrl & 1))
 		mtspr(SPRN_CTRLT, mfspr(SPRN_CTRLF) & ~1);
 
@@ -3598,6 +3603,8 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 			hvregs.vcpu_token = vcpu->vcpu_id;
 		}
 		hvregs.hdec_expiry = time_limit;
+		mtspr(SPRN_DAR, vcpu->arch.shregs.dar);
+		mtspr(SPRN_DSISR, vcpu->arch.shregs.dsisr);
 		trap = plpar_hcall_norets(H_ENTER_NESTED, __pa(&hvregs),
 					  __pa(&vcpu->arch.regs));
 		kvmhv_restore_hv_return_state(vcpu, &hvregs);
diff --git a/arch/powerpc/kvm/book3s_hv_interrupt.c b/arch/powerpc/kvm/book3s_hv_interrupt.c
index c1105a4cc9b7..a7e5628ac36c 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupt.c
+++ b/arch/powerpc/kvm/book3s_hv_interrupt.c
@@ -137,6 +137,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	s64 hdec;
 	u64 tb, purr, spurr;
 	u64 *exsave;
+	bool ri_set;
 	unsigned long msr = mfmsr();
 	int trap;
 	unsigned long host_hfscr = mfspr(SPRN_HFSCR);
@@ -208,9 +209,6 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	 */
 	mtspr(SPRN_HDEC, hdec);
 
-	mtspr(SPRN_SRR0, vcpu->arch.shregs.srr0);
-	mtspr(SPRN_SRR1, vcpu->arch.shregs.srr1);
-
 	start_timing(vcpu, &vcpu->arch.rm_entry);
 
 	vcpu->arch.ceded = 0;
@@ -236,6 +234,13 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	 */
 	mtspr(SPRN_HDSISR, HDSISR_CANARY);
 
+	__mtmsrd(0, 1); /* clear RI */
+
+	mtspr(SPRN_DAR, vcpu->arch.shregs.dar);
+	mtspr(SPRN_DSISR, vcpu->arch.shregs.dsisr);
+	mtspr(SPRN_SRR0, vcpu->arch.shregs.srr0);
+	mtspr(SPRN_SRR1, vcpu->arch.shregs.srr1);
+
 	accumulate_time(vcpu, &vcpu->arch.guest_time);
 
 	local_paca->kvm_hstate.in_guest = KVM_GUEST_MODE_GUEST_HV_FAST;
@@ -253,7 +258,13 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	/* 0x2 bit for HSRR is only used by PR and P7/8 HV paths, clear it */
 	trap = local_paca->kvm_hstate.scratch0 & ~0x2;
+
+	/* HSRR interrupts leave MSR[RI] unchanged, SRR interrupts clear it. */
+	ri_set = false;
 	if (likely(trap > BOOK3S_INTERRUPT_MACHINE_CHECK)) {
+		if (trap != BOOK3S_INTERRUPT_SYSCALL &&
+				(vcpu->arch.shregs.msr & MSR_RI))
+			ri_set = true;
 		exsave = local_paca->exgen;
 	} else if (trap == BOOK3S_INTERRUPT_SYSTEM_RESET) {
 		exsave = local_paca->exnmi;
@@ -263,6 +274,22 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	vcpu->arch.regs.gpr[1] = local_paca->kvm_hstate.scratch1;
 	vcpu->arch.regs.gpr[3] = local_paca->kvm_hstate.scratch2;
+
+	/*
+	 * Only set RI after reading machine check regs (DAR, DSISR, SRR0/1)
+	 * and hstate scratch (which we need to move into exsave to make
+	 * re-entrant vs SRESET/MCE)
+	 */
+	if (ri_set) {
+		if (unlikely(!(mfmsr() & MSR_RI))) {
+			__mtmsrd(MSR_RI, 1);
+			WARN_ON_ONCE(1);
+		}
+	} else {
+		WARN_ON_ONCE(mfmsr() & MSR_RI);
+		__mtmsrd(MSR_RI, 1);
+	}
+
 	vcpu->arch.regs.gpr[9] = exsave[EX_R9/sizeof(u64)];
 	vcpu->arch.regs.gpr[10] = exsave[EX_R10/sizeof(u64)];
 	vcpu->arch.regs.gpr[11] = exsave[EX_R11/sizeof(u64)];
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index d4bca93b79f6..8d8a4d5f0b55 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -199,6 +199,8 @@ static void kvmppc_tb_resync_done(void)
  * know about the exact state of the TB value. Resync TB call will
  * restore TB to host timebase.
  *
+ * This could use the new OPAL_HANDLE_HMI2 to avoid resyncing TB every time.
+ *
  * Things to consider:
  * - On TB error, HMI interrupt is reported on all the threads of the core
  *   that has encountered TB error irrespective of split-core mode.
-- 
2.23.0

