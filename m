Return-Path: <linuxppc-dev+bounces-22228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E8CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Z2q1Bz3cVL;
	Tue, 09 Jun 2026 00:52:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930346;
	cv=none; b=RF8CeEz+BMym9s1GbBIfMqhXoU3UNE+ycRI09updhh1D1UZ7aDh8n633c/5xzFQxW2DCHg/r+KVPy1+FRdyYujiw8MGitV/7LpMGe/afqxvH/vciPkw2eLUs0OYRWIuZvFlh+sn0/WLh5UmgfIq8fTYDQUlnjod76eXUdH9i9h/EzrTnYUQ1KbC2g4Hk2EhbEBlr6SN3n4PplEgBcXB1Q0Ja7yP5NzOgOk0sFUhqWrT613JY5eZhvEAzTDgeVGB77HLNnAYvoGroFSptlVp6EYA4uBzs2/HJiNuFIHME5Ii/nxvgIifDqcSVjrvmns4Qt1xoA6FEy5KiSh0G14QkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930346; c=relaxed/relaxed;
	bh=e80JkIrfZWZ3YMBPZ5oKlNwxXaXsf4lP6bQEY3OIgEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKPSJMgLQEclFE4uygrVMjhJrEz8zuR4kjvGy+d+BT/M7blZSqiz9oSxcNDrJK6zv026AWnEcvLKM87vkzjIjj4TufUuiWn8KdhESeOMansglKnVIy5P6/0F/sfMk50wwcKdC+iewEGlfr5Xxg09VVBbYZi7gYPxVg29MhZmQkfkl1gaJ9K0HT/S+SgwkT5q4/Q/H5PZsFhYouVGPpKGyztj6jldbRIEocubM0tHYZ0DxxXxlG5hISJdonSR9+VR1wCddazABT6ATdNDzfX6WftXHJn4j2kcEgBoD65oeDVIeENIIEEgwUdagsuMiFldlxjtUqDKkj6zuqTViku7Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4M0HQjz3bxp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:18 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6FCF12028D8;
	Mon,  8 Jun 2026 16:43:16 +0200 (CEST)
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
Subject: [PATCH 53/60] kvm: x86: Introduce max_planes x86-op
Date: Mon,  8 Jun 2026 16:42:45 +0200
Message-ID: <20260608144252.351443-54-joro@8bytes.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Allow x86 hardware backends to overwrite the number of supported
planes per VM type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 1 +
 arch/x86/include/asm/kvm_host.h    | 2 ++
 arch/x86/kvm/svm/svm.c             | 1 +
 arch/x86/kvm/vmx/main.c            | 1 +
 arch/x86/kvm/x86.c                 | 8 +++++++-
 arch/x86/kvm/x86.h                 | 1 +
 6 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 207d56d12459..4f96090c04c9 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -152,6 +152,7 @@ KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
 KVM_X86_OP(alloc_plane)
 KVM_X86_OP(free_plane)
+KVM_X86_OP(max_planes)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1b7aa48c961e..bfa0188d372f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2016,6 +2016,8 @@ struct kvm_x86_ops {
 
 	struct kvm_plane *(*alloc_plane)(void);
 	void (*free_plane)(struct kvm_plane *);
+
+	unsigned (*max_planes)(struct kvm *);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2a92d8d18d7c..99357de14034 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5448,6 +5448,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.alloc_plane = x86_alloc_plane,
 	.free_plane = x86_free_plane,
+	.max_planes = kvm_x86_default_max_planes,
 };
 
 /*
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index a2fc4eeeca1d..572921bdfb32 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1034,6 +1034,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.alloc_plane = x86_alloc_plane,
 	.free_plane = x86_free_plane,
+	.max_planes = kvm_x86_default_max_planes,
 };
 
 struct kvm_x86_init_ops vt_init_ops __initdata = {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 60b34bd4da9d..c6910356b061 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -482,10 +482,16 @@ static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
 			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
 static unsigned int num_msr_based_features;
 
-unsigned kvm_arch_max_planes(struct kvm *kvm)
+unsigned kvm_x86_default_max_planes(struct kvm *kvm)
 {
 	return 1;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_default_max_planes);
+
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return kvm_x86_call(max_planes)(kvm);
+}
 
 struct kvm_plane *x86_alloc_plane(void)
 {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 812bd6004a4c..ff57ba568031 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -800,5 +800,6 @@ static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
 
 struct kvm_plane *x86_alloc_plane(void);
 void x86_free_plane(struct kvm_plane *plane);
+unsigned kvm_x86_default_max_planes(struct kvm *kvm);
 
 #endif
-- 
2.53.0


