Return-Path: <linuxppc-dev+bounces-22230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA29CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Z6F6wz3cX4;
	Tue, 09 Jun 2026 00:52:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930349;
	cv=none; b=YEVgweqCpfQgQ/isz3cLkVs5OmZ+BxUVfzxKgAkd3YWyUF8dexlw65ExBeopiwOSmz9boQ6HloNOae+tUJHN/q3Y5RlPuqGMjtDRQDSRgN8UuQyO+gyIHFkoLd+sLo4ceKxY8yovQpuF3z7kR+UhqPbs7ej+RhVQM0QRTeSbzMZ4Wnkkqs+X5gaFwyLnA2Hgx+X5zQYPQhFMOzkj0Wvdgg82x44yOUB8dgeJ8GWIpwX/PHY5tPOqlUj4cH6SMd8raHluQTDVrULSTodFY3wxrQ1ol+5tr665JoXh8BEms20VoRzvM+Ve42s/7ojAqVTdx7tVnDqjUYouZ8Lp7Ia7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930349; c=relaxed/relaxed;
	bh=a88BMcsT0/Qb7iogK9L3bwkMtRQzl9J5097Gytot2S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcWqt//VTGlPAKHM9vz8JMgSCyrEA3F6c5iTJ9vQcoZH0WHHKOzzRKMbisWgmB94diJ4pYp3WFmVCMubU58me755GR+tUd7F1MAiN0Kg6UH8QTN5AMabDJ1ogOWO7Th/QHKkqrvp5RzD64FJ0LlLszwuBrMEptVrg5oCLoyxgT15vdzFcROZRDlYNLCONHDGOwa+iTjR3Mjw2jS7Ss6yg0Z3dOEHeftDZCshVROdO48WgNOXxsH37na7qQlTGxnJcJIlwkcOFhQ1OOyAo6m3bbZGtGScig1LXpaYIEKbxecgf42wonFSwAPKMMBKZc6ZFPLFuQ41+ehs4wHTT24iZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4M4ZFqz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:19 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E8B912028C3;
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
Subject: [PATCH 32/60] kvm: Allocate struct kvm_run only for struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:24 +0200
Message-ID: <20260608144252.351443-33-joro@8bytes.org>
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

Share the struct kvm_run across all planes for one VCPU id.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h |  3 +++
 virt/kvm/kvm_main.c      | 29 ++++++++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 55e3e9046975..385e1ee8fd3a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -327,6 +327,9 @@ struct kvm_mmio_fragment {
 struct kvm_vcpu_common {
 	struct kvm *kvm;
 
+	/* kvm_run struct shared across all planes */
+	struct kvm_run *run;
+
 	int vcpu_idx; /* index into kvm->planes[]->vcpu_array */
 
 	/* Currently active VCPU */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4f2c8f46a0d3..2d0d5f4fd356 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -441,6 +441,7 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned long id)
 {
 	struct kvm_vcpu_common *common __free(kfree) = kzalloc(sizeof(*common), GFP_KERNEL_ACCOUNT);
+	struct page *page;
 	int r;
 
 	/*
@@ -466,6 +467,14 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 	common->vcpu_idx = atomic_read(&kvm->online_vcpus);
 
+	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
+	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!page) {
+		r = -ENOMEM;
+		goto out_drop_counter;
+	}
+	common->run = page_address(page);
+
 	mutex_init(&common->mutex);
 
 #ifndef __KVM_HAVE_ARCH_WQP
@@ -487,7 +496,7 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 		r = kvm_dirty_ring_alloc(kvm, &common->dirty_ring,
 					 id, kvm->dirty_ring_size);
 		if (r)
-			goto out_drop_counter;
+			goto out_free_run;
 	}
 
 	r = kvm_arch_vcpu_common_init(common);
@@ -503,6 +512,8 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 
 out_free_dirty_ring:
 	kvm_dirty_ring_free(&common->dirty_ring);
+out_free_run:
+	free_page((unsigned long)common->run);
 out_drop_counter:
 	mutex_lock(&kvm->lock);
 	kvm->created_vcpus--;
@@ -546,6 +557,7 @@ static void kvm_vcpu_common_destroy(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = common->kvm;
 
 	vcpu->common = NULL;
+	vcpu->run = NULL;
 
 	if (vcpu->plane_level != 0)
 	       return;
@@ -563,6 +575,7 @@ static void kvm_vcpu_common_destroy(struct kvm_vcpu *vcpu)
 	 */
 	put_pid(common->pid);
 	kvm_dirty_ring_free(&common->dirty_ring);
+	free_page((unsigned long)common->run);
 	kfree(common);
 }
 
@@ -4337,7 +4350,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 {
 	int r = -EINVAL;
 	struct kvm_vcpu *vcpu;
-	struct page *page;
 
 	mutex_lock(&kvm->lock);
 	if (kvm->created_vcpus >= kvm->max_vcpus) {
@@ -4359,20 +4371,13 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto vcpu_free;
 
 	vcpu->vcpu_idx = vcpu->common->vcpu_idx;
-
-	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
-	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!page) {
-		r = -ENOMEM;
-		goto vcpu_free_common;
-	}
-	vcpu->run = page_address(page);
+	vcpu->run = vcpu->common->run;
 
 	kvm_vcpu_init(vcpu, kvm, id);
 
 	r = kvm_arch_vcpu_create(vcpu);
 	if (r)
-		goto vcpu_free_run_page;
+		goto vcpu_free_common;
 
 	mutex_lock(&kvm->lock);
 
@@ -4415,8 +4420,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 unlock_vcpu_destroy:
 	mutex_unlock(&kvm->lock);
 	kvm_arch_vcpu_destroy(vcpu);
-vcpu_free_run_page:
-	free_page((unsigned long)vcpu->run);
 vcpu_free_common:
 	kvm_vcpu_common_destroy(vcpu);
 vcpu_free:
-- 
2.53.0


