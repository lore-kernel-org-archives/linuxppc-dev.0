Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F2C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:12:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05EE61076
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05EE61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8NzR1sXXz3dkv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 21:12:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=pQbQhvaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pQbQhvaz; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8Ngq4Dz6z305k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 20:59:19 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id
 s17-20020a17090a8811b029016e89654f93so1509353pjn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uOhQOZZ0TP//EOpTNMJtlDhd+r1Yd9XIBoFed9DzhPM=;
 b=pQbQhvazmKucusvsqjn7Dv/5csW0ZFzytYjt0EWLaDnDcY7IBwG50V2DZW9oyYA3q8
 029GtYdMjyqocsCw5SE14T0if18i6EISOhqe9Lp52lGNLOKHnfFEeHasUdQhqulVY4lP
 5pmLLPXaHyguN4pr7TfSHmKuNHP2NdiUnu93Oyjcz+f1Jw8twnaeZP9XUFywjLv0mSi8
 jmDbLt6GI1gngKZgCmMvSrVZeVDvCzAGYHImuMc0ic0gqCcbliSDQqzcAviFi4aVSOSV
 KLf9pNHtR2lwrbHN1iDwz8Ab76mv6NJmfS4gHokIWG4HVhJB4GyrWHfLcO3NpZdSXYH5
 JAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uOhQOZZ0TP//EOpTNMJtlDhd+r1Yd9XIBoFed9DzhPM=;
 b=f/D+5IrAVubmHo8opaqgWI5HnmDVjQE88HatfgLtUvR/K7MRUqfdapcQEHObtSH2Pc
 wnsdVuieUQryDIiI0GR/M1qqo/MXtY479CyjUL1CEdemX9uEQURUoMaRwYuiTsSV0mNc
 4LnhXonfQjRtgZon90gP5OjbdzlKsOpis0s/X9HH0cdNdWyk95ewsMvd4LQfgKNvmFcg
 K9r9dIwLC2hqNf3T4PnwiOY9HN+5bw+p3AvG4RP0Gz+QfzwRSnwK44Nup3to0OD54Ivg
 k7so2iBxRzh0i2s07OO5ERC1QfVFXxu8LeVCMszM4B6KvbgAMHBwvwgVg/MSkQhlErEN
 zusw==
X-Gm-Message-State: AOAM533uu0r3PTPVVhOwnlFLn9mJXuEmS+CZc/+ek1MFwLLhSNp+msJC
 iZ4E6GbHX5mDsvWkfOIesPU=
X-Google-Smtp-Source: ABdhPJzZcOHoCfpP3Hs+tVpyLYm2o2d6CYTFDMHroY8meB9krhlYDv8V2g/wy5nQjerrh2+nHY4Tqg==
X-Received: by 2002:a17:90a:5a83:: with SMTP id
 n3mr3487212pji.32.1624359556344; 
 Tue, 22 Jun 2021 03:59:16 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id l6sm5623621pgh.34.2021.06.22.03.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 03:59:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 33/43] KVM: PPC: Book3S HV P9: More SPR speed improvements
Date: Tue, 22 Jun 2021 20:57:26 +1000
Message-Id: <20210622105736.633352-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210622105736.633352-1-npiggin@gmail.com>
References: <20210622105736.633352-1-npiggin@gmail.com>
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

This avoids more scoreboard stalls and reduces mtSPRs.

-193 cycles (6985) POWER9 virt-mode NULL hcall

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 67 ++++++++++++++++-----------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index b41be3d8f101..4d1a2d1ff4c1 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -618,24 +618,29 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 		vc->tb_offset_applied = vc->tb_offset;
 	}
 
-	if (vc->pcr)
-		mtspr(SPRN_PCR, vc->pcr | PCR_MASK);
-	mtspr(SPRN_DPDES, vc->dpdes);
 	mtspr(SPRN_VTB, vc->vtb);
-
 	mtspr(SPRN_PURR, vcpu->arch.purr);
 	mtspr(SPRN_SPURR, vcpu->arch.spurr);
 
+	if (vc->pcr)
+		mtspr(SPRN_PCR, vc->pcr | PCR_MASK);
+	if (vc->dpdes)
+		mtspr(SPRN_DPDES, vc->dpdes);
+
 	if (dawr_enabled()) {
-		mtspr(SPRN_DAWR0, vcpu->arch.dawr0);
-		mtspr(SPRN_DAWRX0, vcpu->arch.dawrx0);
+		if (vcpu->arch.dawr0 != host_dawr0)
+			mtspr(SPRN_DAWR0, vcpu->arch.dawr0);
+		if (vcpu->arch.dawrx0 != host_dawrx0)
+			mtspr(SPRN_DAWRX0, vcpu->arch.dawrx0);
 		if (cpu_has_feature(CPU_FTR_DAWR1)) {
-			mtspr(SPRN_DAWR1, vcpu->arch.dawr1);
-			mtspr(SPRN_DAWRX1, vcpu->arch.dawrx1);
+			if (vcpu->arch.dawr1 != host_dawr1)
+				mtspr(SPRN_DAWR1, vcpu->arch.dawr1);
+			if (vcpu->arch.dawrx1 != host_dawrx1)
+				mtspr(SPRN_DAWRX1, vcpu->arch.dawrx1);
 		}
 	}
-	mtspr(SPRN_CIABR, vcpu->arch.ciabr);
-	mtspr(SPRN_IC, vcpu->arch.ic);
+	if (vcpu->arch.ciabr != host_ciabr)
+		mtspr(SPRN_CIABR, vcpu->arch.ciabr);
 
 	mtspr(SPRN_PSSCR, vcpu->arch.psscr | PSSCR_EC |
 	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
@@ -833,17 +838,6 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	vc->dpdes = mfspr(SPRN_DPDES);
 	vc->vtb = mfspr(SPRN_VTB);
 
-	save_clear_guest_mmu(kvm, vcpu);
-	switch_mmu_to_host(kvm, host_pidr);
-
-	/*
-	 * If we are in real mode, only switch MMU on after the MMU is
-	 * switched to host, to avoid the P9_RADIX_PREFETCH_BUG.
-	 */
-	__mtmsrd(msr, 0);
-
-	store_vcpu_state(vcpu);
-
 	dec = mfspr(SPRN_DEC);
 	if (!(lpcr & LPCR_LD)) /* Sign extend if not using large decrementer */
 		dec = (s32) dec;
@@ -861,6 +855,19 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 		vc->tb_offset_applied = 0;
 	}
 
+	save_clear_guest_mmu(kvm, vcpu);
+	switch_mmu_to_host(kvm, host_pidr);
+
+	/*
+	 * Enable MSR here in order to have facilities enabled to save
+	 * guest registers. This enables MMU (if we were in realmode), so
+	 * only switch MMU on after the MMU is switched to host, to avoid
+	 * the P9_RADIX_PREFETCH_BUG or hash guest context.
+	 */
+	__mtmsrd(msr, 0);
+
+	store_vcpu_state(vcpu);
+
 	mtspr(SPRN_PURR, local_paca->kvm_hstate.host_purr);
 	mtspr(SPRN_SPURR, local_paca->kvm_hstate.host_spurr);
 
@@ -868,15 +875,21 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	mtspr(SPRN_PSSCR, host_psscr |
 	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
 	mtspr(SPRN_HFSCR, host_hfscr);
-	mtspr(SPRN_CIABR, host_ciabr);
-	mtspr(SPRN_DAWR0, host_dawr0);
-	mtspr(SPRN_DAWRX0, host_dawrx0);
+	if (vcpu->arch.ciabr != host_ciabr)
+		mtspr(SPRN_CIABR, host_ciabr);
+	if (vcpu->arch.dawr0 != host_dawr0)
+		mtspr(SPRN_DAWR0, host_dawr0);
+	if (vcpu->arch.dawrx0 != host_dawrx0)
+		mtspr(SPRN_DAWRX0, host_dawrx0);
 	if (cpu_has_feature(CPU_FTR_DAWR1)) {
-		mtspr(SPRN_DAWR1, host_dawr1);
-		mtspr(SPRN_DAWRX1, host_dawrx1);
+		if (vcpu->arch.dawr1 != host_dawr1)
+			mtspr(SPRN_DAWR1, host_dawr1);
+		if (vcpu->arch.dawrx1 != host_dawrx1)
+			mtspr(SPRN_DAWRX1, host_dawrx1);
 	}
 
-	mtspr(SPRN_DPDES, 0);
+	if (vc->dpdes)
+		mtspr(SPRN_DPDES, 0);
 	if (vc->pcr)
 		mtspr(SPRN_PCR, PCR_MASK);
 
-- 
2.23.0

