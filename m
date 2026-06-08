Return-Path: <linuxppc-dev+bounces-22227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF79CCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Z2k90z3cVK;
	Tue, 09 Jun 2026 00:52:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930345;
	cv=none; b=RUG9FnYmbb68ImPRGmNU9Ju/yKtwlP97sKjVOdgCHS+iMYVXeFCb88bIEes+3D5h5ep0Ht8CBh8V0Abi7/n9aZDuIvVs8AftxsFqnenZ4InDPcCtls7TvSR8kwTLv08VLw3SCQfXMdEZJ7LlZqLN/WH3bUyQnqA5RC9w3l9Cb2sbHUtRNQuoxq2R/BuG1B4nJzhyIuQOa14R2QnWkWj/nPIwANT1HAY1/djmPPi0waScpcvWclWLu1ma3nJ1JtIYrBI6PvDF2tIi1qXKy61Iy63BS6PjnxBxDvgHXr8iHK1yuQzu9PUOzBUuwx6p0SVDPDYiY7qFMWMseso830USpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930345; c=relaxed/relaxed;
	bh=UOIkUwmlgWfSL8sxyeuEERr3mzauhqFvvM/fkgZD0Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7a4jcLB0qUn24Y/EL2RP256TkO+/wv0U5N+h3l6Zv1G26ebwBMGFgYdza9zIPhpDS+efx54C7+0KqMlNVDDw/R+2zi7uPG6+z2HldjEo1JFm2VPN5HEUdS4WS3sfXDBKrvRVhWtbJhhOagrGH1fOXMG+M2tAHqrIogAhC0wfMhxZeUYXknkWkCmVLDD/fxzMWuajubpQIGeiWxyKleI0dtgdnAvg0KckU7EORU+TpAdUdnCD+oZsLh9IualK/y07RPoxVecWOYAnRL3g1Eu67Uiri/wV6c6+REsxpikqYhSvDopzkXCmj8e3isSNzxxaMIjY71DPQIk5qUbmi4iUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4J5rtRz3btm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:16 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8D3EE2028AF;
	Mon,  8 Jun 2026 16:43:07 +0200 (CEST)
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
	joerg.roedel@amd.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH 12/60] kvm: Move vcpu accounting to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:04 +0200
Message-ID: <20260608144252.351443-13-joro@8bytes.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Do the accounting of created vcpus and the sanity checks only once per
plane.

Co-developed-by: Carlos López <clopez@suse.de>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h |   2 +
 virt/kvm/kvm_main.c      | 108 ++++++++++++++++++++++++---------------
 2 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c4c4922df965..47144a83f9c5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -325,6 +325,8 @@ struct kvm_mmio_fragment {
 struct kvm_vcpu_common {
 	struct kvm *kvm;
 
+	int vcpu_idx; /* index into kvm->planes[]->vcpu_array */
+
 	/* Currently active VCPU */
 	struct kvm_vcpu *current_vcpu;
 };
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fb840d029c56..14e74cdc4709 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -438,18 +438,58 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 }
 #endif
 
-static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm)
+static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned long id)
 {
-	struct kvm_vcpu_common *common = kzalloc(sizeof(*common), GFP_KERNEL_ACCOUNT);
+	struct kvm_vcpu_common *common __free(kfree) = kzalloc(sizeof(*common), GFP_KERNEL_ACCOUNT);
+	int r;
 
-	if (common == NULL)
-		return -ENOMEM;
+	/*
+	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject
+	 * too-large values instead of silently truncating.
+	 *
+	 * Ensure KVM_MAX_VCPU_IDS isn't pushed above INT_MAX without first
+	 * changing the storage type (at the very least, IDs should be tracked
+	 * as unsigned ints).
+	 */
+	BUILD_BUG_ON(KVM_MAX_VCPU_IDS > INT_MAX);
+	if (id >= KVM_MAX_VCPU_IDS)
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+	kvm->created_vcpus++;
+	mutex_unlock(&kvm->lock);
+
+	if (common == NULL) {
+		r = -ENOMEM;
+		goto out_drop_counter;
+	}
+
+	common->vcpu_idx = atomic_read(&kvm->online_vcpus);
 
 	common->kvm = kvm;
 	common->current_vcpu = vcpu;
-	vcpu->common = common;
+	vcpu->common = no_free_ptr(common);
 
 	return 0;
+
+out_drop_counter:
+	mutex_lock(&kvm->lock);
+	kvm->created_vcpus--;
+	mutex_unlock(&kvm->lock);
+
+	return r;
+}
+
+static void kvm_vcpu_finish_common(struct kvm_vcpu *vcpu)
+{
+	smp_wmb();
+	if (vcpu->plane_level == 0) {
+		/*
+		 * Pairs with smp_rmb() in kvm_get_vcpu.  Store the vcpu
+		 * pointer before kvm->online_vcpu's incremented value.
+		 */
+		atomic_inc(&vcpu->kvm->online_vcpus);
+	}
 }
 
 static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
@@ -482,10 +522,19 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 
 static void kvm_vcpu_common_destroy(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->plane_level == 0)
-		kfree(vcpu->common);
+	struct kvm_vcpu_common *common = vcpu->common;
+	struct kvm *kvm = common->kvm;
 
 	vcpu->common = NULL;
+
+	if (vcpu->plane_level != 0)
+	       return;
+
+	mutex_lock(&common->kvm->lock);
+	kvm->created_vcpus--;
+	mutex_unlock(&common->kvm->lock);
+
+	kfree(common);
 }
 
 static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
@@ -4235,22 +4284,10 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
  */
 static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 {
-	int r;
+	int r = -EINVAL;
 	struct kvm_vcpu *vcpu;
 	struct page *page;
 
-	/*
-	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject
-	 * too-large values instead of silently truncating.
-	 *
-	 * Ensure KVM_MAX_VCPU_IDS isn't pushed above INT_MAX without first
-	 * changing the storage type (at the very least, IDs should be tracked
-	 * as unsigned ints).
-	 */
-	BUILD_BUG_ON(KVM_MAX_VCPU_IDS > INT_MAX);
-	if (id >= KVM_MAX_VCPU_IDS)
-		return -EINVAL;
-
 	mutex_lock(&kvm->lock);
 	if (kvm->created_vcpus >= kvm->max_vcpus) {
 		mutex_unlock(&kvm->lock);
@@ -4258,24 +4295,20 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	}
 
 	r = kvm_arch_vcpu_precreate(kvm, id);
-	if (r) {
-		mutex_unlock(&kvm->lock);
-		return r;
-	}
-
-	kvm->created_vcpus++;
 	mutex_unlock(&kvm->lock);
+	if (r)
+		return r;
 
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
-	if (!vcpu) {
-		r = -ENOMEM;
-		goto vcpu_decrement;
-	}
+	if (!vcpu)
+		return -ENOMEM;
 
-	r = kvm_vcpu_init_common(vcpu, kvm);
+	r = kvm_vcpu_init_common(vcpu, kvm, id);
 	if (r)
 		goto vcpu_free;
 
+	vcpu->vcpu_idx = vcpu->common->vcpu_idx;
+
 	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!page) {
@@ -4304,7 +4337,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto unlock_vcpu_destroy;
 	}
 
-	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
 	r = xa_insert(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
 	WARN_ON_ONCE(r == -EBUSY);
 	if (r)
@@ -4324,12 +4356,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	if (r < 0)
 		goto kvm_put_xa_erase;
 
-	/*
-	 * Pairs with smp_rmb() in kvm_get_vcpu.  Store the vcpu
-	 * pointer before kvm->online_vcpu's incremented value.
-	 */
-	smp_wmb();
-	atomic_inc(&kvm->online_vcpus);
+	kvm_vcpu_finish_common(vcpu);
 	mutex_unlock(&vcpu->mutex);
 
 	mutex_unlock(&kvm->lock);
@@ -4352,10 +4379,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	kvm_vcpu_common_destroy(vcpu);
 vcpu_free:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
-vcpu_decrement:
-	mutex_lock(&kvm->lock);
-	kvm->created_vcpus--;
-	mutex_unlock(&kvm->lock);
+
 	return r;
 }
 
-- 
2.53.0


