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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3388C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:04:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3768D6192E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3768D6192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4Cnf3Qypz3bvb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:04:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=X+PfdV1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=X+PfdV1e; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4CmG158Gz30BN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 12:03:25 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id l123so12531945pfl.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J3cK4jIgVFCIZB9lAK522/nzTZFAhV1eu0uDLWDmS4E=;
 b=X+PfdV1exKv1Sr5zJ9NBf4VU6soYGihQlntYPg3REi/Jc4XynpMWOQNT8phOBwh4RE
 e8MVAtCU2saL9YG2W0BZ4Jt2MBbDWpV7QRpSVkyw00RTmlO3U97sGcmB5lzdTgcdmCjA
 mwTFomv0d8MeLBZarXG0pXFD2e94V5AIUNZ88oDslgcKQ64XHAvd0W6iK45fRjSlvYlh
 5BZCbKEQlmy5GAZmWM07eIgXUfkLmTvndaR5UBaIx7ppQGl1UgVqAI641rboyn5jx5wL
 nyLkLurQiM/UknRKMiC8IZkMhme90vMXQUyrr5SihggQ68DU+kaxYN2Y9q4sW2xrOFPu
 ef8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J3cK4jIgVFCIZB9lAK522/nzTZFAhV1eu0uDLWDmS4E=;
 b=LxDK+YiCBrG6snK9fBzc3wHLh/T1kfUnEe4JsH/8RMsQY1WcGQjqE4URdgsA9TxIzA
 K5VmALJI787zvjBQT0b5e3lYGA/e2WCljymXhQgXYaDPLTMwSfokBTafvMpZ6cYoyqma
 LUG5l86XufAgiOcjC7eZq7Vr40YbIhjAqFqNWmWzgVNCYOHc0OImAFfMxfpQsiQ3OVWn
 78DGkAjvNOcqVB5JGvvp+bmEI1EK7KYTvQoB4yytF75TUqMMdE2KViIJr4R6ht2zLRqG
 tPYEc4K0AcRJGC+o68zI0EbcWH/8DtOxt36vR5tHfZZJTStgIdPCOa8LvSm+wMUY/wK/
 A1fA==
X-Gm-Message-State: AOAM53233EEE7yTb7itefJT3Y0eElWRqDJQrgJUpppGlocCaQEsvFi5m
 FAdzYgDksbsJy8ylIoptMxY=
X-Google-Smtp-Source: ABdhPJyD0G6piKizl5XrZ+O/0ufllQSBmKWooinkcf45yobOqvY7RKnohFBDPy8ZLgQfhKz4FUm28g==
X-Received: by 2002:a17:902:e54c:b029:e6:42ee:18ae with SMTP id
 n12-20020a170902e54cb02900e642ee18aemr2209447plf.68.1616461403647; 
 Mon, 22 Mar 2021 18:03:23 -0700 (PDT)
Received: from bobo.ibm.com ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id e7sm14491894pfc.88.2021.03.22.18.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 18:03:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v4 02/46] KVM: PPC: Book3S HV: Add a function to filter guest
 LPCR bits
Date: Tue, 23 Mar 2021 11:02:21 +1000
Message-Id: <20210323010305.1045293-3-npiggin@gmail.com>
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

Guest LPCR depends on hardware type, and future changes will add
restrictions based on errata and guest MMU mode. Move this logic
to a common function and use it for the cases where the guest
wants to update its LPCR (or the LPCR of a nested guest).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 +
 arch/powerpc/kvm/book3s_hv.c          | 60 ++++++++++++++++++---------
 arch/powerpc/kvm/book3s_hv_nested.c   |  3 +-
 3 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 2f5f919f6cd3..3eec3ef6f083 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -258,6 +258,8 @@ extern long kvmppc_hv_get_dirty_log_hpt(struct kvm *kvm,
 extern void kvmppc_harvest_vpa_dirty(struct kvmppc_vpa *vpa,
 			struct kvm_memory_slot *memslot,
 			unsigned long *map);
+extern unsigned long kvmppc_filter_lpcr_hv(struct kvmppc_vcore *vc,
+			unsigned long lpcr);
 extern void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr,
 			unsigned long mask);
 extern void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 13bad6bf4c95..c4539c38c639 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1635,6 +1635,27 @@ static int kvm_arch_vcpu_ioctl_set_sregs_hv(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/*
+ * Enforce limits on guest LPCR values based on hardware availability,
+ * guest configuration, and possibly hypervisor support and security
+ * concerns.
+ */
+unsigned long kvmppc_filter_lpcr_hv(struct kvmppc_vcore *vc, unsigned long lpcr)
+{
+	/* On POWER8 and above, userspace can modify AIL */
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		lpcr &= ~LPCR_AIL;
+
+	/*
+	 * On POWER9, allow userspace to enable large decrementer for the
+	 * guest, whether or not the host has it enabled.
+	 */
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		lpcr &= ~LPCR_LD;
+
+	return lpcr;
+}
+
 static void kvmppc_set_lpcr(struct kvm_vcpu *vcpu, u64 new_lpcr,
 		bool preserve_top32)
 {
@@ -1643,6 +1664,23 @@ static void kvmppc_set_lpcr(struct kvm_vcpu *vcpu, u64 new_lpcr,
 	u64 mask;
 
 	spin_lock(&vc->lock);
+
+	/*
+	 * Userspace can only modify
+	 * DPFD (default prefetch depth), ILE (interrupt little-endian),
+	 * TC (translation control), AIL (alternate interrupt location),
+	 * LD (large decrementer).
+	 * These are subject to restrictions from kvmppc_filter_lcpr_hv().
+	 */
+	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL | LPCR_LD;
+
+	/* Broken 32-bit version of LPCR must not clear top bits */
+	if (preserve_top32)
+		mask &= 0xFFFFFFFF;
+
+	new_lpcr = kvmppc_filter_lpcr_hv(vc,
+			(vc->lpcr & ~mask) | (new_lpcr & mask));
+
 	/*
 	 * If ILE (interrupt little-endian) has changed, update the
 	 * MSR_LE bit in the intr_msr for each vcpu in this vcore.
@@ -1661,25 +1699,8 @@ static void kvmppc_set_lpcr(struct kvm_vcpu *vcpu, u64 new_lpcr,
 		}
 	}
 
-	/*
-	 * Userspace can only modify DPFD (default prefetch depth),
-	 * ILE (interrupt little-endian) and TC (translation control).
-	 * On POWER8 and POWER9 userspace can also modify AIL (alt. interrupt loc.).
-	 */
-	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC;
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		mask |= LPCR_AIL;
-	/*
-	 * On POWER9, allow userspace to enable large decrementer for the
-	 * guest, whether or not the host has it enabled.
-	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		mask |= LPCR_LD;
+	vc->lpcr = new_lpcr;
 
-	/* Broken 32-bit version of LPCR must not clear top bits */
-	if (preserve_top32)
-		mask &= 0xFFFFFFFF;
-	vc->lpcr = (vc->lpcr & ~mask) | (new_lpcr & mask);
 	spin_unlock(&vc->lock);
 }
 
@@ -4641,8 +4662,9 @@ void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr, unsigned long mask)
 		struct kvmppc_vcore *vc = kvm->arch.vcores[i];
 		if (!vc)
 			continue;
+
 		spin_lock(&vc->lock);
-		vc->lpcr = (vc->lpcr & ~mask) | lpcr;
+		vc->lpcr = kvmppc_filter_lpcr_hv(vc, (vc->lpcr & ~mask) | lpcr);
 		spin_unlock(&vc->lock);
 		if (++cores_done >= kvm->arch.online_vcores)
 			break;
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 2fe1fea4c934..f7b441b3eb17 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -142,7 +142,8 @@ static void sanitise_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	 */
 	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL | LPCR_LD |
 		LPCR_LPES | LPCR_MER;
-	hr->lpcr = (vc->lpcr & ~mask) | (hr->lpcr & mask);
+	hr->lpcr = kvmppc_filter_lpcr_hv(vc,
+			(vc->lpcr & ~mask) | (hr->lpcr & mask));
 
 	/*
 	 * Don't let L1 enable features for L2 which we've disabled for L1,
-- 
2.23.0

