Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF0C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:12:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AAB60C40
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5AAB60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlFFw2QBmz3dWL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 02:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ajkySZGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ajkySZGK; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlF2X3J6Bz3cW8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 02:02:28 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so10325112pjn.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PvCtp8x/xnVOg7P/kY+PiLHYDRcQOyLkNAyPlsDlMl8=;
 b=ajkySZGKELPOFGlAUa0DcURtiIKi9T3MyAEIAFYJvPxxWt9C91f84Djb5JTPQCUFDQ
 pJi0II2JSDY5y670wq5wlqBTT291LpkBwSrjMzCoOjL/uvaQDHXKcEkEGTi/MR0ZSM0d
 CVQyKQPDn0vXr8+v4Rtd0AAOmF24Ew3j+uvsWVO3sOX+e7jZkCTWsUh4xHUWnPe2KWvI
 y4qVxsudnZI93rN+VL2lD1Ehem6MT4xIhHgBmciaxi8PivyEm4KktZlQlR8sqIdROgfh
 9k999+8Qu3uD5Fh5bgvenxgcJ/QiLFGbJy07en+uRZiwYfv7jMOCep6KMrZPwytwtTgC
 sn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PvCtp8x/xnVOg7P/kY+PiLHYDRcQOyLkNAyPlsDlMl8=;
 b=Fm2pWuZEuu4gP4QH7TYcVvvZ0godKRt04Nj26Hd6+TMWqxoHjth+/AGO8/QpB4Ahsq
 xd1zXit8xfHoXlozvIMf+YEgCa2atzuYca5mrGiwgUtxZDfvCZo8pc9evB2OVFaUr1w7
 Pe4k7zrzniomozCR8Dn4h9270egFeYjlv2BZSoTP88OzE4lwwIjo5KwK2SrnuaQsTJP7
 wFs1jBKtm/WYu52hy3KiSbNIVctMt81cuKZ2WedWVQ3eTyP/Q6CrAj3Qmcafc1WmKcYD
 xduwXT5wDLgskzKuuKRu/OTaQF5MgNAtScRe2jAME+jkpuhGIhYL+jfsC4qgWqumuZlD
 NPUw==
X-Gm-Message-State: AOAM532s0E3eTjZEVFrL31LeX8JrYA88CSNZq/DeTYNjhrgo0NKdhQQ4
 iCkAoYVK+7OVkRYBrPLFzmQ=
X-Google-Smtp-Source: ABdhPJwM2JXz9u/GyBAQDqJFThzbzJNZQ9eRAZFa1EjHHIAXHksIN4bDV6a30r/1jGgLUAZRKZRnrg==
X-Received: by 2002:a17:90b:3758:: with SMTP id
 ne24mr16269601pjb.218.1628697745967; 
 Wed, 11 Aug 2021 09:02:25 -0700 (PDT)
Received: from bobo.ibm.com ([118.210.97.79])
 by smtp.gmail.com with ESMTPSA id k19sm6596494pff.28.2021.08.11.09.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 09:02:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 16/60] KVM: PPC: Book3S HV: POWER10 enable HAIL when
 running radix guests
Date: Thu, 12 Aug 2021 02:00:50 +1000
Message-Id: <20210811160134.904987-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210811160134.904987-1-npiggin@gmail.com>
References: <20210811160134.904987-1-npiggin@gmail.com>
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

HV interrupts may be taken with the MMU enabled when radix guests are
running. Enable LPCR[HAIL] on ISA v3.1 processors for radix guests.
Make this depend on the host LPCR[HAIL] being enabled. Currently that is
always enabled, but having this test means any issue that might require
LPCR[HAIL] to be disabled in the host will not have to be duplicated in
KVM.

This optimisation takes 1380 cycles off a NULL hcall entry+exit micro
benchmark on a POWER10.

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5e48a929d670..2fe01dc2062f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5034,6 +5034,8 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
  */
 int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
 {
+	unsigned long lpcr, lpcr_mask;
+
 	if (nesting_enabled(kvm))
 		kvmhv_release_all_nested(kvm);
 	kvmppc_rmap_reset(kvm);
@@ -5043,8 +5045,13 @@ int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
 	kvm->arch.radix = 0;
 	spin_unlock(&kvm->mmu_lock);
 	kvmppc_free_radix(kvm);
-	kvmppc_update_lpcr(kvm, LPCR_VPM1,
-			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
+
+	lpcr = LPCR_VPM1;
+	lpcr_mask = LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR;
+	if (cpu_has_feature(CPU_FTR_ARCH_31))
+		lpcr_mask |= LPCR_HAIL;
+	kvmppc_update_lpcr(kvm, lpcr, lpcr_mask);
+
 	return 0;
 }
 
@@ -5054,6 +5061,7 @@ int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
  */
 int kvmppc_switch_mmu_to_radix(struct kvm *kvm)
 {
+	unsigned long lpcr, lpcr_mask;
 	int err;
 
 	err = kvmppc_init_vm_radix(kvm);
@@ -5065,8 +5073,17 @@ int kvmppc_switch_mmu_to_radix(struct kvm *kvm)
 	kvm->arch.radix = 1;
 	spin_unlock(&kvm->mmu_lock);
 	kvmppc_free_hpt(&kvm->arch.hpt);
-	kvmppc_update_lpcr(kvm, LPCR_UPRT | LPCR_GTSE | LPCR_HR,
-			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
+
+	lpcr = LPCR_UPRT | LPCR_GTSE | LPCR_HR;
+	lpcr_mask = LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR;
+	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+		lpcr_mask |= LPCR_HAIL;
+		if (cpu_has_feature(CPU_FTR_HVMODE) &&
+				(kvm->arch.host_lpcr & LPCR_HAIL))
+			lpcr |= LPCR_HAIL;
+	}
+	kvmppc_update_lpcr(kvm, lpcr, lpcr_mask);
+
 	return 0;
 }
 
@@ -5230,6 +5247,10 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 		kvm->arch.mmu_ready = 1;
 		lpcr &= ~LPCR_VPM1;
 		lpcr |= LPCR_UPRT | LPCR_GTSE | LPCR_HR;
+		if (cpu_has_feature(CPU_FTR_HVMODE) &&
+		    cpu_has_feature(CPU_FTR_ARCH_31) &&
+		    (kvm->arch.host_lpcr & LPCR_HAIL))
+			lpcr |= LPCR_HAIL;
 		ret = kvmppc_init_vm_radix(kvm);
 		if (ret) {
 			kvmppc_free_lpid(kvm->arch.lpid);
-- 
2.23.0

