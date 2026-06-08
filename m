Return-Path: <linuxppc-dev+bounces-22253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFB0CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4y6ptCz3f4Z;
	Tue, 09 Jun 2026 00:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930369;
	cv=none; b=Cs94fFC6YOs7t3/j2TCVJMNtJoAbzXr9UDp8ZXYng+yKZcCnenEdYCkpEOBv0814pcHW75hSnfLdWXQr47UGjGAQX/LwNzDfGzS7uN6wb6KNkSY1gUeMHnEFfn0XuSMB+lZGUKZs5BlTf2iVWb9vZHrXm1e6VsauVUQgtYfBFT7aSpvFcH5ac8Z6vKlJ7kcqv4XAir1yCGyQ66gkmM+AO6q6lQ7bUehaFoM2byghhpEL8HrxWAVHeJI2IgeR8XAV+u3I3cSIwQf3sOIHBWka+B8kqCaBgNfsjV3jwXoFlN2Fa0MCKfBmhRKcOi1YF9nn9v2gPiDZeRUapQ8m420dqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930369; c=relaxed/relaxed;
	bh=d7cVvrLPT1nDfeX/sab2rzFk0HpH+ccX3/IETQ9g3FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKYuDs7epV4HvUJuSmU3yAasfZZTUzEuMwmwQqZPMW3WiCUljeYUNfPt0e1i+rwxX2KN7OuW7WlO6No+PiXsl7GgNUr5O3VtkapgNf+FPDez9ooI6H34JC2Y5RoK3g+7HVbSqrrYWQhKPyKpVGkQYK9cwbf7OlzXRnU3IdihGctK6hP8hEHPDorO3O40WQgjQSVQLZr0bJO/onY0z2/YMP6rnKS/Y7iULVO9KH1Cuf6KIQCQUEnFii4m2lwiM6SetFFZM6NlhHzc2pnrIeTiSbd12V97oBxzgKOgqfnXoCpG0fvZt4EtCV9f2vAyJm9p1jtP00ZKeVvRqQ6zE8xUpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Z4zlNz3cVZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:30 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9C7712028BD;
	Mon,  8 Jun 2026 16:43:10 +0200 (CEST)
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
Subject: [PATCH 26/60] kvm: Introduce arch-specific plane state
Date: Mon,  8 Jun 2026 16:42:18 +0200
Message-ID: <20260608144252.351443-27-joro@8bytes.org>
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

Introduce struct kvm_arch_plane which is per architecture and will be
used to store architecture-specific per-plane state.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/include/asm/kvm_host.h     | 12 ++++++++++++
 arch/loongarch/include/asm/kvm_host.h | 12 ++++++++++++
 arch/mips/include/asm/kvm_host.h      | 12 ++++++++++++
 arch/powerpc/include/asm/kvm_host.h   | 12 ++++++++++++
 arch/riscv/include/asm/kvm_host.h     | 12 ++++++++++++
 arch/s390/include/asm/kvm_host.h      | 12 ++++++++++++
 arch/x86/include/asm/kvm_host.h       | 12 ++++++++++++
 include/linux/kvm_host.h              |  2 ++
 include/linux/kvm_types.h             |  1 +
 virt/kvm/kvm_main.c                   |  9 +++++++++
 10 files changed, 96 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32dc484781f0..e9cca2adb371 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -306,6 +306,18 @@ enum fgt_group_id {
 	__NR_FGT_GROUP_IDS__
 };
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
 
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 776bc487a705..225aa87ebbdd 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -116,6 +116,18 @@ struct kvm_phyid_map {
 	struct kvm_phyid_info phys_map[KVM_MAX_PHYID];
 };
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 struct kvm_arch {
 	/* Guest physical mm */
 	kvm_pte_t *pgd;
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c14b10821817..b01911eb9064 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -172,6 +172,18 @@ struct loongson_kvm_ipi {
 };
 #endif
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 struct kvm_arch {
 	/* Guest physical mm */
 	struct mm_struct gpa_mm;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..c5b9fbaf34f3 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -269,6 +269,18 @@ struct kvm_hpt_info {
 
 struct kvm_resize_hpt;
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 /* Flag values for kvm_arch.secure_guest */
 #define KVMPPC_SECURE_INIT_START 0x1 /* H_SVM_INIT_START has been called */
 #define KVMPPC_SECURE_INIT_DONE  0x2 /* H_SVM_INIT_DONE completed */
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 75b0a951c1bc..bcbf487d4cb7 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -76,6 +76,18 @@ struct kvm_vcpu_stat {
 struct kvm_arch_memory_slot {
 };
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 struct kvm_arch {
 	/* G-stage vmid */
 	struct kvm_vmid vmid;
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8a4f4a39f7a2..bb3bfbfd35d8 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -638,6 +638,18 @@ struct kvm_s390_pv {
 
 struct kvm_s390_mmu_cache;
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 struct kvm_arch {
 	struct esca_block *sca;
 	debug_info_t *dbf;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 43c92f0ada1e..dd95c70bfdba 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1412,6 +1412,18 @@ enum kvm_mmu_type {
 	KVM_NR_MMU_TYPES,
 };
 
+/* Per-plane state of VM */
+struct kvm_arch_plane {};
+
+static inline int kvm_arch_plane_init(struct kvm *kvm,
+				      struct kvm_plane *plane,
+				      unsigned plane_level)
+{
+	return 0;
+}
+
+static inline void kvm_arch_plane_destroy(struct kvm_plane *plane) {}
+
 struct kvm_arch {
 	unsigned long n_used_mmu_pages;
 	unsigned long n_requested_mmu_pages;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7d06459a06f3..4a0eaa1de479 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -847,6 +847,8 @@ struct kvm_plane {
 
 	/* Per-Plane VCPU array */
 	struct xarray vcpu_array;
+
+	struct kvm_arch_plane arch;
 };
 
 struct kvm {
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..07e82928c948 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -42,6 +42,7 @@ struct kvm_interrupt;
 struct kvm_irq_routing_table;
 struct kvm_memory_slot;
 struct kvm_one_reg;
+struct kvm_plane;
 struct kvm_run;
 struct kvm_userspace_memory_region;
 struct kvm_vcpu;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f85ddb0fc781..91fb9abf9b31 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1211,13 +1211,22 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 
 	xa_init(&plane->vcpu_array);
 
+	if (kvm_arch_plane_init(kvm, plane, plane_level))
+		goto out_free_plane;
+
 	kvm->planes[plane_level] = plane;
 
 	return plane;
+
+out_free_plane:
+	kfree(plane);
+
+	return NULL;
 }
 
 static void kvm_destroy_one_plane(struct kvm_plane *plane)
 {
+	kvm_arch_plane_destroy(plane);
 	kfree(plane);
 }
 
-- 
2.53.0


