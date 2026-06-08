Return-Path: <linuxppc-dev+bounces-22213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29301CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4H3VpJz3bsn;
	Tue, 09 Jun 2026 00:52:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930335;
	cv=none; b=UoJ8miKWEnM0kHinFpssMepAZuJx31E/1T/18wOb5YaK9Ar89C2HQElsfHwvxICpF3XT9DcSj7EzqCFB6exTf0HhiR6KvVFDKljA/xfKhGFChgf/SdxIPijACTvlqxBCDyGM9So8BvfhiheIKZ1urryguCbZ+dUI2CQNkp3ut4ld3LDxcezZrZiuciiD16JB/D20R5MgAzWHsP4KPoCzxeg1XzOCHA7ghador+W0fNYFV2OszUTfUXaoW2Ev5fUioo6nUz1KHyv54KzY+a6ob4mugx+Fbmkqpts4ZtkgxvqZZCdQrolb2DalIN5t4QOE3gP+YmI6yB3GWgt0rARlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930335; c=relaxed/relaxed;
	bh=gq8rN47S5nTE90wJ+1WWKBTYBGL2Ei1Ka/v76Pzjg/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V26Hm8Q4x/0HQLA608OhqClvMSet5C1nDPEx5/XxloampUc2OH2v+bYFB75ZsjTbFd0yK74xXsemDFVgZThUQqWsntot0UWdtoyfhtMmgb4DmJv7/8NieBa1ky0FgCdG17xrhKLSGcNAlSo08u0DY+FYS7scLpuzFVXNkNTrD4mip9/AU9VA+epNJEnjR8ELzhgiXG+Baa+MHmkQb1nn9mWIdwaROeFVEwi4idktkj6QdU5DBwoXf2sn0JqrAOLXKeIbztwPsHS87g/XO14pSBmKDpXBqgmkbAs9TNrsGUbDPt9w1J8/jw8RlNZPHD71PajEFpmLU2VPTnoYQ4AwVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4C2mcYz3brC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:11 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BB2242028DE;
	Mon,  8 Jun 2026 16:43:17 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [PATCH 59/60] kvm: svm: Implement max_planes x86 operation
Date: Mon,  8 Jun 2026 16:42:51 +0200
Message-ID: <20260608144252.351443-60-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Lendacky <thomas.lendacky@amd.com>

Report the number of VMPL levels supported by SEV-SNP guests.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 14 ++++++++++++--
 arch/x86/kvm/svm/svm.c | 12 +++++++++++-
 arch/x86/kvm/svm/svm.h |  3 +++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b67566fcb69e..528c8bd3e8fc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -114,6 +114,7 @@ static unsigned long sev_me_mask;
 static unsigned int nr_asids;
 static unsigned long *sev_asid_bitmap;
 static unsigned long *sev_reclaim_asid_bitmap;
+static unsigned int vmpl_levels;
 
 static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
 {
@@ -3103,6 +3104,9 @@ void __init sev_hardware_setup(void)
 	/* Set encryption bit location for SEV-ES guests */
 	sev_enc_bit = ebx & 0x3f;
 
+	/* Get the number of supported VMPL levels */
+	vmpl_levels = (ebx >> 12) & 0xf;
+
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
 	if (!max_sev_asid)
@@ -3217,9 +3221,10 @@ void __init sev_hardware_setup(void)
 										"disabled",
 			min_sev_es_asid, max_sev_es_asid);
 	if (boot_cpu_has(X86_FEATURE_SEV_SNP))
-		pr_info("SEV-SNP %s (ASIDs %u - %u)\n",
+		pr_info("SEV-SNP %s (ASIDs %u - %u), VMPL Levels %u\n",
 			str_enabled_disabled(sev_snp_supported),
-			min_snp_asid, max_snp_asid);
+			min_snp_asid, max_snp_asid,
+			vmpl_levels);
 
 	sev_enabled = sev_supported;
 	sev_es_enabled = sev_es_supported;
@@ -5852,3 +5857,8 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 
 	return blocked;
 }
+
+int sev_snp_max_planes(struct kvm *kvm)
+{
+	return vmpl_levels;
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2ae82dc058c9..705063c7f0f0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5321,6 +5321,16 @@ static void svm_free_plane(struct kvm_plane *plane)
 	kfree(svm_plane);
 }
 
+static unsigned svm_max_planes(struct kvm *kvm)
+{
+#ifdef CONFIG_KVM_AMD_SEV
+	if (____sev_snp_guest(kvm))
+		return sev_snp_max_planes(kvm);
+#endif
+
+	return kvm_x86_default_max_planes(kvm);
+}
+
 struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
@@ -5465,7 +5475,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.alloc_plane = svm_alloc_plane,
 	.free_plane = svm_free_plane,
-	.max_planes = kvm_x86_default_max_planes,
+	.max_planes = svm_max_planes,
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7e860f2abafb..7aba2cceb44d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1008,6 +1008,8 @@ static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
 	return is_sev_snp_guest(vcpu) &&
 		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
 };
+int sev_nr_vcpu_planes(struct kvm *kvm);
+int sev_snp_max_planes(struct kvm *kvm);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1051,6 +1053,7 @@ static inline bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
 static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
+static inline unsigned sev_snp_max_planes(struct kvm *kvm) { return 1; }
 #endif
 
 /* vmenter.S */
-- 
2.53.0


