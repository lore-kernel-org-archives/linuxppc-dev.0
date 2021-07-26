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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4B2C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9156056C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD9156056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5yh32yyz3hbV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 14:09:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=e8ofBwpR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a;
 helo=mail-pl1-x62a.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=e8ofBwpR; dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5bV15knz3dBK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:52:22 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id n10so10141869plf.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tttWjAtBQpkJ27E6dJTO6j5NLUnzZ0bw5ZHHFoKnVA0=;
 b=e8ofBwpRuix3BZnZ/sCmRdVBeUzScf3k1D1QdscTeSA1CRauJ46tQxlDoaY+vg61W4
 bwu3sltOwRzhmAUtqpYH4q9b7zd21lAQB3zWBwr35Izry7wgOLBV2PWjyEKpCnYr9jk+
 3z17gj+XN6WIs60U05ZTsaFeKpn0GlHXrxrg1YJSM74dyi3d4sMpu5IP6FqkfxN003pF
 gLdLUK5RE2PrQJELSUjs6lKp7pSFMqbzmmb2NWjra/UR4NPQ9ThoXgBhsRiov2tXZgxu
 JECRfoW28XaYnD9aoNkuMw2iNvr5bfCoVDrwjcjjtUAEd+essDE47dhXpND5v2Gccp+R
 oI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tttWjAtBQpkJ27E6dJTO6j5NLUnzZ0bw5ZHHFoKnVA0=;
 b=ZFf882m32UuqWPS7Aa21bNHL+YNpY18UO6wvUA9ghqr9DvjmpG0kRfxXnLgvDv3PU5
 qAkRSYDwcfRoHzGETVqD+vYF5De42Xdwy1d0ngVyk4iDR1BfLXYmixamUZBS6XT7t0OH
 Wt0M/EEw2SNCd8004edaDVulI7WIn/yj/kr86evhu4QBeqFeUV6aiX6+ZGtHHUqiCb+/
 WNRUgdj0IBFU0LlQPCJ1QGIkJ149W/FXNIy5DMS/FDRQBjbrtjdEWNN85v+4D1KETCoE
 jQzumfWoqq0z9mgsFm9KbPnQyyUP2JZEK/JmyRpeLYAyp/PRfXHvZactdLYRMhmJzlge
 ljdw==
X-Gm-Message-State: AOAM53192GVSLdH5pfCrzSykpk71CLoAsl1yMEHLHdHYfzQR0lBgvdYn
 a5rEvMaCqLWhgcTQZN11EK0=
X-Google-Smtp-Source: ABdhPJx0wIzImavcgz6WNC2kw85/dKnC2rstlM3M6u9aU2Db3EM8upzVhqbzxz+TW2P56OtHe3NI5Q==
X-Received: by 2002:a17:902:e54f:b029:12b:55c9:3b48 with SMTP id
 n15-20020a170902e54fb029012b55c93b48mr13020127plf.45.1627271540148; 
 Sun, 25 Jul 2021 20:52:20 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:52:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 41/55] KVM: PPC: Book3S HV P9: Demand fault TM facility
 registers
Date: Mon, 26 Jul 2021 13:50:22 +1000
Message-Id: <20210726035036.739609-42-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use HFSCR facility disabling to implement demand faulting for TM, with
a hysteresis counter similar to the load_fp etc counters in context
switching that implement the equivalent demand faulting for userspace
facilities.

This speeds up guest entry/exit by avoiding the register save/restore
when a guest is not frequently using them. When a guest does use them
often, there will be some additional demand fault overhead, but these
are not commonly used facilities.

-304 cycles (6681) POWER9 virt-mode NULL hcall with the previous patch

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s_hv.c          | 26 ++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 25 +++++++++++++++++--------
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1c00c4a565f5..74ee3a5b110e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -581,6 +581,7 @@ struct kvm_vcpu_arch {
 	ulong ppr;
 	u32 pspb;
 	u8 load_ebb;
+	u8 load_tm;
 	ulong fscr;
 	ulong shadow_fscr;
 	ulong ebbhr;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dd8199a423cf..5b2114c00c43 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1451,6 +1451,16 @@ static int kvmppc_ebb_unavailable(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
+static int kvmppc_tm_unavailable(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.hfscr_permitted & HFSCR_TM))
+		return EMULATE_FAIL;
+
+	vcpu->arch.hfscr |= HFSCR_TM;
+
+	return RESUME_GUEST;
+}
+
 static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 				 struct task_struct *tsk)
 {
@@ -1747,6 +1757,8 @@ XXX benchmark guest exits
 				r = kvmppc_pmu_unavailable(vcpu);
 			if (cause == FSCR_EBB_LG)
 				r = kvmppc_ebb_unavailable(vcpu);
+			if (cause == FSCR_TM_LG)
+				r = kvmppc_tm_unavailable(vcpu);
 		}
 		if (r == EMULATE_FAIL) {
 			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
@@ -2763,9 +2775,9 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 	vcpu->arch.hfscr_permitted = vcpu->arch.hfscr;
 
 	/*
-	 * PM, EBB is demand-faulted so start with it clear.
+	 * PM, EBB, TM are demand-faulted so start with it clear.
 	 */
-	vcpu->arch.hfscr &= ~(HFSCR_PM | HFSCR_EBB);
+	vcpu->arch.hfscr &= ~(HFSCR_PM | HFSCR_EBB | HFSCR_TM);
 
 	kvmppc_mmu_book3s_hv_init(vcpu);
 
@@ -3835,8 +3847,9 @@ static int kvmhv_vcpu_entry_p9_nested(struct kvm_vcpu *vcpu, u64 time_limit, uns
 		msr |= MSR_VEC;
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr |= MSR_VSX;
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+	if ((cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) &&
+			(vcpu->arch.hfscr & HFSCR_TM))
 		msr |= MSR_TM;
 	msr = msr_check_and_set(msr);
 
@@ -4552,8 +4565,9 @@ static int kvmppc_vcpu_run_hv(struct kvm_vcpu *vcpu)
 		msr |= MSR_VEC;
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr |= MSR_VSX;
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+	if ((cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) &&
+			(vcpu->arch.hfscr & HFSCR_TM))
 		msr |= MSR_TM;
 	msr = msr_check_and_set(msr);
 
diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index f68a3d107d04..db5eb83e26d1 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -295,10 +295,11 @@ bool load_vcpu_state(struct kvm_vcpu *vcpu,
 {
 	bool ret = false;
 
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
+	if ((cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) &&
+		       (vcpu->arch.hfscr & HFSCR_TM)) {
 		unsigned long guest_msr = vcpu->arch.shregs.msr;
-		if (MSR_TM_ACTIVE(guest_msr)) {
+		if (MSR_TM_ACTIVE(guest_msr) || local_paca->kvm_hstate.fake_suspend) {
 			kvmppc_restore_tm_hv(vcpu, guest_msr, true);
 			ret = true;
 		} else {
@@ -330,15 +331,22 @@ void store_vcpu_state(struct kvm_vcpu *vcpu)
 #endif
 	vcpu->arch.vrsave = mfspr(SPRN_VRSAVE);
 
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
+	if ((cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) &&
+		       (vcpu->arch.hfscr & HFSCR_TM)) {
 		unsigned long guest_msr = vcpu->arch.shregs.msr;
-		if (MSR_TM_ACTIVE(guest_msr)) {
+		if (MSR_TM_ACTIVE(guest_msr) || local_paca->kvm_hstate.fake_suspend) {
 			kvmppc_save_tm_hv(vcpu, guest_msr, true);
 		} else {
 			vcpu->arch.texasr = mfspr(SPRN_TEXASR);
 			vcpu->arch.tfhar = mfspr(SPRN_TFHAR);
 			vcpu->arch.tfiar = mfspr(SPRN_TFIAR);
+
+			if (!vcpu->arch.nested) {
+				vcpu->arch.load_tm++; /* see load_ebb comment */
+				if (!vcpu->arch.load_tm)
+					vcpu->arch.hfscr &= ~HFSCR_TM;
+			}
 		}
 	}
 }
@@ -629,8 +637,9 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 		msr |= MSR_VEC;
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr |= MSR_VSX;
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+	if ((cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) &&
+			(vcpu->arch.hfscr & HFSCR_TM))
 		msr |= MSR_TM;
 	msr = msr_check_and_set(msr);
 	/* Save MSR for restore. This is after hard disable, so EE is clear. */
-- 
2.23.0

