Return-Path: <linuxppc-dev+bounces-22241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FBFCD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4l2CKQz3dKy;
	Tue, 09 Jun 2026 00:52:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930357;
	cv=none; b=MSnnB35LCYpc9FSc5WYgIAxGiSb1YO0II8R13jUA3SoELmaKf/mV3/EFRClIgVyO5wyFWiNSCmttZPICiLsltq1p2LeiisJl2I4U1IxycHQF1lRHq6Z3o/W40bJv0NKj1VntGpUpzuMExkcvPVcQIaJerxOIw+YvA8yrWjinY3UUhFZ8ltJ08h/jDoqL803DxCLim9AxVOLqj5aL7Itwb3cPfKe5rzDVohSaI7ktbCtv3mJlkiJDcEsAnasoIn3CZUl4b3O7jF+Xo9YHbx3KF1Spq9w1+GFHY7nELzJfJjaW6WbMIU8g2l/IYDYLpsYDROh04zuotCnAPgcgcDXa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930357; c=relaxed/relaxed;
	bh=MfYNjrc8e3AQ4A6uiFeqmsM1a/1IAn7LvcJsUFQdDsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbx3mu40yTBexrkX87+9gkx5da94SD5pGD+++d47M7LV7lStutRyOR9ymHjQ8lpPknzp0pum994SqQbHBeufmtVF+dmd50WAsyB5DqfzBhbixya3FdEiEkNCwQNBwNmNYoCASfXqbezw6GaGmTOTtSbk5yxZgfXE2+xV2//d/8ueCq5np+x7w6TkPZZf1G7QkXxGUHxXM15UcMwHS/s8SBDv+7BGlBDp1MaZVyRIkuvNCBTE1bk2kg/Dt1yo7FnMPKFBxNOCokkhCobWcv7fCLRJ0RmMK7MUNvVlTuZZcxbqds+Kr3ovUedMZH11aYvfTQQePy6S44mYCa3FQmQzVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4S5nz0z3c7H
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:24 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 579A02028AE;
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
Subject: [PATCH 11/60] kvm: Introduce struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:03 +0200
Message-ID: <20260608144252.351443-12-joro@8bytes.org>
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

When creating one VCPU object per plane there is still a lot of VCPU
state which needes to be shared across all planes. Create struct
kvm_vcpu_common as a container for this shared state.

Co-developed-by: Carlos López <clopez@suse.de>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 10 ++++++++++
 virt/kvm/kvm_main.c      | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5a72f73a2f31..c4c4922df965 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -322,6 +322,13 @@ struct kvm_mmio_fragment {
 	unsigned int len;
 };
 
+struct kvm_vcpu_common {
+	struct kvm *kvm;
+
+	/* Currently active VCPU */
+	struct kvm_vcpu *current_vcpu;
+};
+
 struct kvm_vcpu {
 	struct kvm *kvm;
 	struct kvm_plane *plane;
@@ -400,6 +407,9 @@ struct kvm_vcpu {
 	 */
 	struct kvm_memory_slot *last_used_slot;
 	u64 last_used_slot_gen;
+
+	struct kvm_vcpu_common *common;
+	unsigned plane_level;
 };
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 668645dd3945..fb840d029c56 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -438,6 +438,20 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 }
 #endif
 
+static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+	struct kvm_vcpu_common *common = kzalloc(sizeof(*common), GFP_KERNEL_ACCOUNT);
+
+	if (common == NULL)
+		return -ENOMEM;
+
+	common->kvm = kvm;
+	common->current_vcpu = vcpu;
+	vcpu->common = common;
+
+	return 0;
+}
+
 static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 {
 	mutex_init(&vcpu->mutex);
@@ -459,14 +473,26 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
 	vcpu->last_used_slot = NULL;
 
+	vcpu->plane_level = 0;
+
 	/* Fill the stats id string for the vcpu */
 	snprintf(vcpu->stats_id, sizeof(vcpu->stats_id), "kvm-%d/vcpu-%d",
 		 task_pid_nr(current), id);
 }
 
+static void kvm_vcpu_common_destroy(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->plane_level == 0)
+		kfree(vcpu->common);
+
+	vcpu->common = NULL;
+}
+
 static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	kvm_arch_vcpu_destroy(vcpu);
+
+	kvm_vcpu_common_destroy(vcpu);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 
 	/*
@@ -1360,8 +1386,8 @@ static void kvm_destroy_vm(struct kvm *kvm)
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	xa_destroy(&kvm->mem_attr_array);
 #endif
-	kvm_arch_free_vm(kvm);
 	kvm_destroy_planes(kvm);
+	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
 	kvm_disable_virtualization();
 	mmdrop(mm);
@@ -4246,11 +4272,15 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto vcpu_decrement;
 	}
 
+	r = kvm_vcpu_init_common(vcpu, kvm);
+	if (r)
+		goto vcpu_free;
+
 	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!page) {
 		r = -ENOMEM;
-		goto vcpu_free;
+		goto vcpu_free_common;
 	}
 	vcpu->run = page_address(page);
 
@@ -4318,6 +4348,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	kvm_arch_vcpu_destroy(vcpu);
 vcpu_free_run_page:
 	free_page((unsigned long)vcpu->run);
+vcpu_free_common:
+	kvm_vcpu_common_destroy(vcpu);
 vcpu_free:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 vcpu_decrement:
-- 
2.53.0


