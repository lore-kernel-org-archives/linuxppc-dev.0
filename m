Return-Path: <linuxppc-dev+bounces-22217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70CECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4L6v69z3bxl;
	Tue, 09 Jun 2026 00:52:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930338;
	cv=none; b=Hwzi3TV8MLumGWe9olihsmjz4CzsX1Y49zXEGf3yn5wvKKUqTSQ76fvNHrUp8eq/zaPfjRvBUMD7PTp3wQ/eOiN0ValpbXUA5wIp0BnZ3975ldR5rM8Hg1iPqSlMKepekYwo+tomLQNT4fYUVpIcdMkOpxR1yy5efQOkUaqNowA9gqfnYSt7KEd0jy1N7B3Jf0BhfZQhn881KQNmM8gfC0L1gAGJ63/s0IN/s8rvf0c7AyRZ4hm9eBe0+1ekv95SxPGlt7Wv65Bg2bShtQGcGMpz8u2DlFUukJaUZ9xjWx4csNSgNBcD40vhIAybfgP6vIssCnDkZ2elbHpV6fIkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930338; c=relaxed/relaxed;
	bh=hrW8tPBqivkeKVbG8YPwky0NqdAux6a+K/Nb9EiXEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arvMHPl90BaL3XIC/OGCQlbfHysgzRKkR/5iFkVECiYA8iQ+j2PszgPgTVqVlZw4sRq9osFcMwdB5lDR5JxGnsVAxkoa82+6oT6GC2THV3iQV+ycieKZOUUWg3hwDkmb510evEKmMb8lKs2wzM+vkEKjYaLtjR343+KWfnDD90wBkXRLqAzZl+7CgJBOH4jlDGstnnHJksZzRTziYvXJ9kwNVi8moC+TcI02gBNTCoWLW6/xNeykYBFSoE6v/8j3ilH1FGJBR+F1ILk4Hlscqdpcs5xZ0WVvxNoN6itlM8z2x+ZaoIHgtg5jAWHviDaqIkAzNkABTJ9Lt2oZIHFDlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 541 seconds by postgrey-1.37 at boromir; Tue, 09 Jun 2026 00:52:12 AEST
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4D2fpqz3brl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:11 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B53292028C2;
	Mon,  8 Jun 2026 16:43:11 +0200 (CEST)
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
Subject: [PATCH 31/60] kvm: Allocate struct kvm_plane in architecture code
Date: Mon,  8 Jun 2026 16:42:23 +0200
Message-ID: <20260608144252.351443-32-joro@8bytes.org>
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

From: Joerg Roedel <joerg.roedel@amd.com>

Move plane allocation to architecture code so that per-arch
implementations can embed the structure into another one for keeping
additional data.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/kvm/arm.c       | 13 +++++++++++++
 arch/loongarch/kvm/vm.c    | 13 +++++++++++++
 arch/mips/kvm/mips.c       | 13 +++++++++++++
 arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
 arch/riscv/kvm/main.c      | 13 +++++++++++++
 arch/s390/kvm/kvm-s390.c   | 13 +++++++++++++
 arch/x86/kvm/x86.c         | 13 +++++++++++++
 include/linux/kvm_host.h   |  2 ++
 virt/kvm/kvm_main.c        |  6 +++---
 9 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7e6d2773fd39..d7a4b9b239dc 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -205,6 +205,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 /**
  * kvm_arch_init_vm - initializes a VM data structure
  * @kvm:	pointer to the KVM struct
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 14f1232c6e0c..e4d2814b717d 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -114,6 +114,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 60870452119d..e22d2a267e03 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -120,6 +120,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 {
 	return false;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cfa40be20e00..35658cded0cb 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -504,6 +504,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 5adba3a455a3..46834b2ddfae 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -22,6 +22,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 static void kvm_riscv_setup_vendor_features(void)
 {
 	/* Andes AX66: split two-stage TLBs */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 24f24ea95f86..94c40b2aa759 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3191,6 +3191,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 void kvm_arch_free_vm(struct kvm *kvm)
 {
 	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 25299c8c28e3..d6bf0425525c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -487,6 +487,19 @@ unsigned kvm_arch_max_planes(struct kvm *kvm)
 	return 1;
 }
 
+struct kvm_plane *kvm_alloc_plane(void)
+{
+	/* For better type checking, do not return kzalloc() value directly */
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	return plane;
+}
+
+void kvm_free_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
 /*
  * All feature MSRs except uCode revID, which tracks the currently loaded uCode
  * patch, are immutable once the vCPU model is defined.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 90b97137840e..55e3e9046975 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1157,6 +1157,8 @@ void vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 unsigned kvm_arch_max_planes(struct kvm *kvm);
+struct kvm_plane *kvm_alloc_plane(void);
+void kvm_free_plane(struct kvm_plane *plane);
 
 #ifdef CONFIG_KVM_IOAPIC
 void kvm_arch_post_irq_ack_notifier_list_update(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f0f78bb74e51..4f2c8f46a0d3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1209,7 +1209,7 @@ static void kvm_disable_virtualization(void);
 
 static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 {
-	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+	struct kvm_plane *plane = kvm_alloc_plane();
 
 	if (!plane)
 		return NULL;
@@ -1227,7 +1227,7 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 	return plane;
 
 out_free_plane:
-	kfree(plane);
+	kvm_free_plane(plane);
 
 	return NULL;
 }
@@ -1235,7 +1235,7 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 static void kvm_destroy_one_plane(struct kvm_plane *plane)
 {
 	kvm_arch_plane_destroy(plane);
-	kfree(plane);
+	kvm_free_plane(plane);
 }
 
 static void kvm_destroy_planes(struct kvm *kvm)
-- 
2.53.0


