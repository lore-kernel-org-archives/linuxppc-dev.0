Return-Path: <SRS0=/PaX=OY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EBC433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Oct 2021 16:24:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0485F61206
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Oct 2021 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0485F61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HNQzT5NxPz3fcn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Oct 2021 03:24:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dD75TwsV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=dD75TwsV; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HNQTc2g9zz308w
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Oct 2021 03:02:28 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so1002314pji.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Oct 2021 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c2h6hidknEDcFoUX05/j1Ej4Ouz2ogn73Ns94+r0eEk=;
 b=dD75TwsVYQlxNjW1EDlQhUGoyN0jlOo8DSumQUxFoahJxXp8/4MPPZwf95QCrPCOg5
 +rqYR8KqqRmaOsxHAWBXZJtLUuD8zapKuaIzMvFKn+7aIV1emSlI/o3hcQqInWifIglg
 uP33nV2itQqwov7m80bjBinG6BFzidypSKd3le0MueteljlZqX9MCbrULoo0CsZQuvOD
 NnbRZ0dsiXBe02o21uhKI486CpWUeWEpHDU2TmkAqnti9KQGaKYW7+mjzY0eraL89hoS
 79AL356P7sAo/qRnw3tk+W6va26ko52A8Zi9TzSEl2K596O999L/VKMmtPTcHxnArNty
 AS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c2h6hidknEDcFoUX05/j1Ej4Ouz2ogn73Ns94+r0eEk=;
 b=gKSTcmxESTvFPKlYOgCfMxK7qtkLfFubdRPoej1nhgrltb+yipT/9xqi2mArAA0h1Z
 GcxERUItlKzWEqPsY1xU1b6iu/i9ZU0937g0WV1u9ePKfA+5xBzAFVpFeV7Z6M+m2Aqj
 Fk+8nr55hTfp+KyzByKdo1LZDJrxk3HJ40btQNVbuvMaKD9HKQarwXpEa0/5JvVBSM6V
 XAU5wqlL2GdMcMuRNmCKCOXtdTSu8dPe4EBhRidBmQTilyXU5ZF6Rxwzfqx7ZrvzZbkv
 2N4SDn1seC61HA86csxffnEbTIXhT/1nfkgJfMhcQg5mn+RAdyXF7TR0Xu18vwzyW+5q
 6ttg==
X-Gm-Message-State: AOAM532EFZyayBK6CApnN8LAXOKedH6Xo9/fNvHYK7pjjCKFylMVEioZ
 05O6obqVqshgJxbDzo67fZA=
X-Google-Smtp-Source: ABdhPJzuLrGXs46c3TVnrZtvSmM5Np40Qc40RJxs/U84mvaQ1xhPfmn1OH7uneOvZx+5B9hYrMpkpA==
X-Received: by 2002:a17:902:8214:b0:13e:c554:6b55 with SMTP id
 x20-20020a170902821400b0013ec5546b55mr430735pln.80.1633363346386; 
 Mon, 04 Oct 2021 09:02:26 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (115-64-153-41.tpgi.com.au. [115.64.153.41])
 by smtp.gmail.com with ESMTPSA id 130sm15557223pfz.77.2021.10.04.09.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 09:02:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 35/52] KVM: PPC: Book3S HV P9: More SPR speed improvements
Date: Tue,  5 Oct 2021 02:00:32 +1000
Message-Id: <20211004160049.1338837-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211004160049.1338837-1-npiggin@gmail.com>
References: <20211004160049.1338837-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This avoids more scoreboard stalls and reduces mtSPRs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 73 ++++++++++++++++-----------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index 67f57b03a896..a23f09fa7d2d 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -645,24 +645,29 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
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
@@ -881,20 +886,6 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	vc->dpdes = mfspr(SPRN_DPDES);
 	vc->vtb = mfspr(SPRN_VTB);
 
-	save_clear_guest_mmu(kvm, vcpu);
-	switch_mmu_to_host(kvm, host_pidr);
-
-	/*
-	 * If we are in real mode, only switch MMU on after the MMU is
-	 * switched to host, to avoid the P9_RADIX_PREFETCH_BUG.
-	 */
-	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
-			vcpu->arch.shregs.msr & MSR_TS_MASK)
-		msr |= MSR_TS_S;
-	__mtmsrd(msr, 0);
-
-	store_vcpu_state(vcpu);
-
 	dec = mfspr(SPRN_DEC);
 	if (!(lpcr & LPCR_LD)) /* Sign extend if not using large decrementer */
 		dec = (s32) dec;
@@ -912,6 +903,22 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
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
+	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
+			vcpu->arch.shregs.msr & MSR_TS_MASK)
+		msr |= MSR_TS_S;
+	__mtmsrd(msr, 0);
+
+	store_vcpu_state(vcpu);
+
 	mtspr(SPRN_PURR, local_paca->kvm_hstate.host_purr);
 	mtspr(SPRN_SPURR, local_paca->kvm_hstate.host_spurr);
 
@@ -919,15 +926,21 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
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

