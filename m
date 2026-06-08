Return-Path: <linuxppc-dev+bounces-22232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8015ACD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4b4Hdsz3cYy;
	Tue, 09 Jun 2026 00:52:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930350;
	cv=none; b=fezcplJ1c/Mbb7pzSfvJnfOyISyD/QT8gjRkYimiDeRr60IsL++D7WG1tNBg++9GhYIzFsKrzQnKVhlsyf7sC4d3pTBE7+stdkRz5Nb/fXDMwNgZtU5jcHWIzzmeqRUJmKbMBIviy8OfIqnsYueaVhPb//F8IsafkLHdXwIToKlMJBglpu8VJ39HF8kD0SfMmlwmKyZ5KKz6AfDCjvXXM3dZZkAZ5tNuxUzB1jWzCwHZdidIAKfwne95Q3tl1inwxE8PIPYfB78DY+J6DphKg69MQmhq6Z71nxxJqIwEHktx6WVEMq1uVHu6YSOoWEgaMe2y6h+PZhLMhRVjwkH5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930350; c=relaxed/relaxed;
	bh=R/0tRAfldpUwB/n4n6p1s06znfD0kaq/3EbN2A2Xe0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kclC8/94RSFOb6bzltxIB5dcbg9IuZVMTgF41uVRKHSyp9OUblNBdky74acq3Zm+ndPkX6C00lePpkEBfAGznuBOGFm2FzB5NvPBtQE0H2zOMVZfMpSosMWNpXxN4tcatxLz6W+U0ZIQc2QAx72X+WzFjCOeXi0nuGVBg/2MgH1X+zXCcGqHK/PK0L5QnmOFIQLATWoc/jAnn3s5/dP5ElRtdLtcJpowMEQ99lM0LBWUXjTlVSmTi4eeEATEV8CX6iFGn5hWF/x8t6osC0HPftb3L4EWtSbLF+Jc9IxI/mqiHfwbYRqYJgDg9sipAobwt3UmUWhcFPYHT3x6EVVkuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4N6Q4pz3c1g
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:20 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E5A762028AC;
	Mon,  8 Jun 2026 16:43:06 +0200 (CEST)
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
Subject: [PATCH 09/60] kvm: Introduce struct kvm_plane
Date: Mon,  8 Jun 2026 16:42:01 +0200
Message-ID: <20260608144252.351443-10-joro@8bytes.org>
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

Introduce a data structure to keep VM-wide per-plane state. Initialize
the structure with a back-pointer to struct kvm and the plane level
the structure represents.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h |  7 +++++++
 include/uapi/linux/kvm.h |  6 ++++++
 virt/kvm/kvm_main.c      | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..5be4c9f118b4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -767,6 +767,11 @@ struct kvm_memslots {
 	int node_idx;
 };
 
+struct kvm_plane {
+	struct kvm *kvm;
+	unsigned level;
+};
+
 struct kvm {
 #ifdef KVM_HAVE_MMU_RWLOCK
 	rwlock_t mmu_lock;
@@ -806,6 +811,8 @@ struct kvm {
 	spinlock_t gpc_lock;
 	struct list_head gpc_list;
 
+	struct kvm_plane *planes[KVM_MAX_PLANES];
+
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
 	 * at the beginning of KVM_CREATE_VCPU.  online_vcpus is only
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..813f964a6dc1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -730,6 +730,11 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+/*
+ * Maximum number of supported planes
+ */
+#define KVM_MAX_PLANES	16
+
 /*
  * Extension capability list.
  */
@@ -996,6 +1001,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_PLANES 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 881f92d7a469..a68469c6d12e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1095,6 +1095,38 @@ static inline struct kvm_io_bus *kvm_get_bus_for_destruction(struct kvm *kvm,
 static int kvm_enable_virtualization(void);
 static void kvm_disable_virtualization(void);
 
+static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
+{
+	struct kvm_plane *plane = kzalloc(sizeof(*plane), GFP_KERNEL_ACCOUNT);
+
+	if (!plane)
+		return NULL;
+
+	plane->kvm = kvm;
+	plane->level = plane_level;
+
+	kvm->planes[plane_level] = plane;
+
+	return plane;
+}
+
+static void kvm_destroy_one_plane(struct kvm_plane *plane)
+{
+	kfree(plane);
+}
+
+static void kvm_destroy_planes(struct kvm *kvm)
+{
+	int i;
+
+	for (i = 0; i < KVM_MAX_PLANES; ++i) {
+		if (kvm->planes[i] == NULL)
+			continue;
+		kvm_destroy_one_plane(kvm->planes[i]);
+		kvm->planes[i] = NULL;
+	}
+}
+
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 {
 	struct kvm *kvm = kvm_arch_alloc_vm();
@@ -1127,6 +1159,12 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 
 	BUILD_BUG_ON(KVM_MEM_SLOTS_NUM > SHRT_MAX);
 
+	/* Initialize planes array and allocate plane 0 */
+	if (kvm_create_plane(kvm, 0) == NULL) {
+		r = -ENOMEM;
+		goto out_no_planes;
+	}
+
 	/*
 	 * Force subsequent debugfs file creations to fail if the VM directory
 	 * is not created (by kvm_create_vm_debugfs()).
@@ -1225,6 +1263,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_irq_srcu:
 	cleanup_srcu_struct(&kvm->srcu);
 out_err_no_srcu:
+	kvm_destroy_planes(kvm);
+out_no_planes:
 	kvm_arch_free_vm(kvm);
 	mmdrop(current->mm);
 	return ERR_PTR(r);
@@ -1304,6 +1344,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	xa_destroy(&kvm->mem_attr_array);
 #endif
 	kvm_arch_free_vm(kvm);
+	kvm_destroy_planes(kvm);
 	preempt_notifier_dec();
 	kvm_disable_virtualization();
 	mmdrop(mm);
-- 
2.53.0


