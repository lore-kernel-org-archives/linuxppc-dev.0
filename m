Return-Path: <linuxppc-dev+bounces-22244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A00CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4p55Ydz3dWP;
	Tue, 09 Jun 2026 00:52:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930362;
	cv=none; b=SiltKyCz88rw/UmhIB/vvQfJ/VvUM0DDO4VIgUypATEsmRBTf7EsR4fgxOofERN8tWOM1qRiK4dXukctLa/tSFHUDGNVr+iJ1pmRaJ59ToTEPH5a6DrtyCQ/xnwqJ//YUOEsqbVEfyVk1IpQTSFSxZQdjryVD4sfKUylBnYsofA8iJPeJuLnl+IK93Qv2PY3V5Gvyp9RSfwkEhkCdZVTGqMXCywgmQOUTGjyyWmiXG9Zv6bY6eslczpxi/vWf3bVg+cCQC1xPyAiT5NsL2/IvOTem484yi4p2DC2Epc5680t4fIvBX17AHmyztba0IvwoG0cWr6N6M/KJ1HZEBBVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930362; c=relaxed/relaxed;
	bh=aJnO/O6dOhTTSoZNq+/9GtHPi2/msQ0czZO9gTYZsbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afQA/wc4EOgRdykI2jAIjQluja6PbCDJl/HYepIskUiZtFP9UWzQYoaVA3Yanq+1+PQ0VyhMoZCAICuvP0UTdypOqZsVZuBTZAnOJscTffkFzqUnKORhCxXOwjIv/6q7loZScjZPmjl5UaH13hSVkmABGsKgmer5unovGdv/f12C/1YcJsB1pv7YR6F3MST566rkIKeUaZfglv6h9gBlqNgLq26uteLtT0Ln3FIA5CXD0VqKnWf8yKHs2DQOlJrulX5g6eyUzgV7iPNfo3mbMDD4kry5Ag3gv7/8dj079O0p1KBcW1eb5TbjoE4XrtpNHdshmECOp7Ljp/Tcg5zX3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4W0jqCz3cC9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:27 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 15AC22028BF;
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
Subject: [PATCH 28/60] kvm: Implement KVM_CAP_PLANES
Date: Mon,  8 Jun 2026 16:42:20 +0200
Message-ID: <20260608144252.351443-29-joro@8bytes.org>
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

Introduce an architecture call-back to request the VM-specific maximum
number of supported planes. Use that to implement the KVM_CAP_PLANES
capability check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/kvm/arm.c       | 5 +++++
 arch/loongarch/kvm/vm.c    | 5 +++++
 arch/mips/kvm/mips.c       | 5 +++++
 arch/powerpc/kvm/powerpc.c | 5 +++++
 arch/riscv/kvm/main.c      | 5 +++++
 arch/s390/kvm/kvm-s390.c   | 5 +++++
 arch/x86/kvm/x86.c         | 5 +++++
 include/linux/kvm_host.h   | 2 ++
 virt/kvm/kvm_main.c        | 4 ++++
 9 files changed, 41 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1e2f42134b74..7e6d2773fd39 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -200,6 +200,11 @@ static int kvm_arm_default_max_vcpus(void)
 	return vgic_present ? kvm_vgic_get_max_vcpus() : KVM_MAX_VCPUS;
 }
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 /**
  * kvm_arch_init_vm - initializes a VM data structure
  * @kvm:	pointer to the KVM struct
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..14f1232c6e0c 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -109,6 +109,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm->arch.phyid_map = NULL;
 }
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 776aba0af096..60870452119d 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -115,6 +115,11 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 	return !!(vcpu->arch.pending_exceptions);
 }
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 {
 	return false;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 5d94e0f676ec..cfa40be20e00 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -499,6 +499,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	module_put(kvm->arch.kvm_ops->owner);
 }
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index cb8a65273c1f..5adba3a455a3 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -17,6 +17,11 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 static void kvm_riscv_setup_vendor_features(void)
 {
 	/* Andes AX66: split two-stage TLBs */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e6fe83da172f..24f24ea95f86 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3186,6 +3186,11 @@ static void sca_dispose(struct kvm *kvm)
 	kvm->arch.sca = NULL;
 }
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 void kvm_arch_free_vm(struct kvm *kvm)
 {
 	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 50601ac2828f..25299c8c28e3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -482,6 +482,11 @@ static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
 			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
 static unsigned int num_msr_based_features;
 
+unsigned kvm_arch_max_planes(struct kvm *kvm)
+{
+	return 1;
+}
+
 /*
  * All feature MSRs except uCode revID, which tracks the currently loaded uCode
  * patch, are immutable once the vCPU model is defined.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 291bccce9b74..3ecd472c7cfa 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1156,6 +1156,8 @@ void kvm_unlock_all_vcpus(struct kvm *kvm);
 void vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
+unsigned kvm_arch_max_planes(struct kvm *kvm);
+
 #ifdef CONFIG_KVM_IOAPIC
 void kvm_arch_post_irq_ack_notifier_list_update(struct kvm *kvm);
 #else
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7a0b632e3ac0..5a0277e2ac7c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5079,6 +5079,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_GUEST_MEMFD_FLAGS:
 		return kvm_gmem_get_supported_flags(kvm);
 #endif
+	case KVM_CAP_PLANES:
+		if (kvm)
+			return kvm_arch_max_planes(kvm);
+		return 1;
 	default:
 		break;
 	}
-- 
2.53.0


