Return-Path: <linuxppc-dev+bounces-22260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D43CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:57:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw530sCbz3fFF;
	Tue, 09 Jun 2026 00:52:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930374;
	cv=none; b=fqQd6sIkRJdUH1U+7gqLg8xqjVm9THULheykW6l4juuatZWnYnN4D2Oa6yQe+0UlS2mjKJm40GZCijmYJwb5qr8XaNa2ARCaR4RPfm2+JRsi75g+XZDcvkK8zpupqFDoHbYjd9mX+EXOV4rFRtH5YUfLfmdLInUI7LBtKQoj7r9unpBi3XowybjddG8kmHf3CfCU+UfVIp4hlBcKAWDriehKwBCP5Oggv0X1FWQsUw7t8536nyCV9CkYLs+dJcatHL8RvS0bM0l0+MthYwTMFi85ZUcvm+cs7nDTZ/qyQohxUXKVTFwETKZ1zPyPIi87B/IZM3JclGQuhDs+MYY54g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930374; c=relaxed/relaxed;
	bh=lr2e6Ht2+WgwLxD0HIpYiGzQa8c2EXG1Z+pPNDKI/qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dejYnNmWzabT0WQSMMUZSAsCgo6t4PefHDoc/asuKWYEzYzLBry3Orzyz7xOktDUxu/3r/TT65ZcJ8MRoJ9gvFR62T2lFPaURlARmkWGGixfE88U2sKJoTRbhpZuej+cloCYf1aoj6FAXGtpE9vL2ONawogxAffK39Dz9N84FxkxmRQ6jM0UpgcvySh/el43h73SCBo69l2Gl+aK2ftJ8v0en518FUJPexJuxSlUDIL4qmdU/keCzu6xansRy98dTUXxkUkBxyyVjnRmyg5EE6EvfJ8sHH0tJLCS8iL+zIJg8/vx919AAzmoumrZzyK052CMyOZ13NoQW0sIKbvCqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4l1Fgbz3byZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:39 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 072512028D6;
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
Subject: [PATCH 51/60] kvm: x86: Share pio_data across planes
Date: Mon,  8 Jun 2026 16:42:43 +0200
Message-ID: <20260608144252.351443-52-joro@8bytes.org>
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

The vcpu->arch.pio_data pointer is memory mapped to user-space
alongside the kvm_run page. So it also needs to be common across all
planes for a given VCPU index.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              | 20 +++++++++++---------
 virt/kvm/kvm_main.c             |  2 +-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0327b77e56b7..1b7aa48c961e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -801,6 +801,8 @@ struct kvm_vcpu_arch_common {
 	bool cpuid_dynamic_bits_dirty;
 	bool is_amd_compatible;
 
+	void *pio_data;
+
 	/*
 	 * cpu_caps holds the effective guest capabilities, i.e. the features
 	 * the vCPU is allowed to use.  Typically, but not always, features can
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5f48392d4738..08fe65b8d57d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8532,7 +8532,7 @@ static int emulator_pio_in_out(struct kvm_vcpu *vcpu, int size,
 }
 
 static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
-      			   unsigned short port, void *val, unsigned int count)
+			   unsigned short port, void *val, unsigned int count)
 {
 	int r = emulator_pio_in_out(vcpu, size, port, val, count, true);
 	if (r)
@@ -12936,7 +12936,6 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
-	struct page *page;
 	int r;
 
 	vcpu->arch.last_vmentry_cpu = -1;
@@ -12960,10 +12959,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	r = -ENOMEM;
 
-	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!page)
-		goto fail_free_lapic;
-	vcpu->arch.pio_data = page_address(page);
+	vcpu->arch.pio_data = vcpu->common->arch.pio_data;
 
 	vcpu->arch.mce_banks = kcalloc(KVM_MAX_MCE_BANKS * 4, sizeof(u64),
 				       GFP_KERNEL_ACCOUNT);
@@ -13023,8 +13019,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 fail_free_mce_banks:
 	kfree(vcpu->arch.mce_banks);
 	kfree(vcpu->arch.mci_ctl2_banks);
-	free_page((unsigned long)vcpu->arch.pio_data);
-fail_free_lapic:
 	kvm_free_lapic(vcpu);
 fail_mmu_destroy:
 	kvm_mmu_destroy(vcpu);
@@ -13072,16 +13066,24 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	kvm_mmu_destroy(vcpu);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
-	free_page((unsigned long)vcpu->arch.pio_data);
 }
 
 int kvm_arch_vcpu_common_init(struct kvm_vcpu_common *common)
 {
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+
+	common->arch.pio_data = page_address(page);
+
 	return 0;
 }
 
 void kvm_arch_vcpu_common_destroy(struct kvm_vcpu_common *common)
 {
+	free_page((unsigned long)common->arch.pio_data);
 	kvfree(common->arch.cpuid_entries);
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a6d7601c3412..8f1a16af519a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4250,7 +4250,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 		page = virt_to_page(vcpu->run);
 #ifdef CONFIG_X86
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
-		page = virt_to_page(vcpu->arch.pio_data);
+		page = virt_to_page(vcpu->common->arch.pio_data);
 #endif
 #ifdef CONFIG_KVM_MMIO
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
-- 
2.53.0


