Return-Path: <linuxppc-dev+bounces-22246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ABDCD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4r3q1lz3dXS;
	Tue, 09 Jun 2026 00:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930360;
	cv=none; b=RNN8kclfA7AyDPR4NP+kOf5LoNfLaeMTVye0D5NuTU9Yu7m7y9tQQ/zCroQ50Xys+ZwMrK2ZdZj8TSWgPOXpKNuhnVgkhBZT1A01ZZqpfUyIwTBTkrL6VD7KIMxLn5UeJuoE1QZH+ialZilO0zJ5YmzNHlR5J0CRPznsgvFiE74F0OZ76RbTu/aVWeD++b+5sDeRYDZKFE7uMP8KqbEOyB8VtCWpYLBg6FUsK157gNIX0thlmPiV1Lif2UIR4q1b2jZD9NDaawBWJrv4ewPRmIWYiJ7LnZbtbkgWwIa55Bm1uNy4FZvzCtQEv5R7z6j/V0qU2WxzsEesdaXrZShyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930360; c=relaxed/relaxed;
	bh=zmiCHQdHfkmKuuSlpMigywtEjJTN4Buzk7T2+uIJtgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0GOna5wTsx+A46rSDf8fvT06TisetdgzCu2x4KwTZzriovWGcNQpkXWtpDVf/CYuDY/E3E0JV02CEbBrY1Q0HpsQDuvHP3tgWKmhlKjabdfJQUNVRgr/8dpXLDwfRYGo8bRkNVfbdmcpKD4fsHpPaGwY2AEYastzxvyfp9tJVV5FaXylGg2XXfGWyCRTo0zRPluKgyMO2Wdt3PDnvLQnKwpQbZc8NJ8pG+tVEUMOF7+0KrnroQPACoq3JMroPeR6dBQaCQIcKIlWggCsmxi0y7xNqCd/T+UZCwFDo0FICi1OazA1WXIKBULheVO5vFiXV2xFovB11GHQPJ9/D3BRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4V14K7z3c96
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:26 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 255222028AD;
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
	joerg.roedel@amd.com
Subject: [PATCH 10/60] kvm: Move vcpu_array to struct kvm_plane
Date: Mon,  8 Jun 2026 16:42:02 +0200
Message-ID: <20260608144252.351443-11-joro@8bytes.org>
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

Each plane will have its own set of VCPUs, so move the vcpu_array to
the plane structure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h | 30 +++++++++++++++++++++---------
 virt/kvm/kvm_main.c      | 33 +++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5be4c9f118b4..5a72f73a2f31 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -324,12 +324,14 @@ struct kvm_mmio_fragment {
 
 struct kvm_vcpu {
 	struct kvm *kvm;
+	struct kvm_plane *plane;
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	struct preempt_notifier preempt_notifier;
 #endif
 	int cpu;
 	int vcpu_id; /* id given by userspace at creation */
-	int vcpu_idx; /* index into kvm->vcpu_array */
+	int vcpu_idx; /* index into kvm->planes[]->vcpu_array */
 	int ____srcu_idx; /* Don't use this directly.  You've been warned. */
 #ifdef CONFIG_PROVE_RCU
 	int srcu_depth;
@@ -770,6 +772,9 @@ struct kvm_memslots {
 struct kvm_plane {
 	struct kvm *kvm;
 	unsigned level;
+
+	/* Per-Plane VCPU array */
+	struct xarray vcpu_array;
 };
 
 struct kvm {
@@ -795,7 +800,6 @@ struct kvm {
 	struct kvm_memslots __memslots[KVM_MAX_NR_ADDRESS_SPACES][2];
 	/* The current active memslot set for each address space */
 	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
-	struct xarray vcpu_array;
 	/*
 	 * Protected by slots_lock, but can be read outside if an
 	 * incorrect answer is acceptable.
@@ -996,9 +1000,9 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 					 lockdep_is_held(&kvm->slots_lock));
 }
 
-static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
+static inline struct kvm_vcpu *plane_get_vcpu(struct kvm_plane *plane, int i)
 {
-	int num_vcpus = atomic_read(&kvm->online_vcpus);
+	int num_vcpus = atomic_read(&plane->kvm->online_vcpus);
 
 	/*
 	 * Explicitly verify the target vCPU is online, as the anti-speculation
@@ -1012,13 +1016,21 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 
 	/* Pairs with smp_wmb() in kvm_vm_ioctl_create_vcpu.  */
 	smp_rmb();
-	return xa_load(&kvm->vcpu_array, i);
+	return xa_load(&plane->vcpu_array, i);
 }
 
-#define kvm_for_each_vcpu(idx, vcpup, kvm)				\
-	if (atomic_read(&kvm->online_vcpus))				\
-		xa_for_each_range(&kvm->vcpu_array, idx, vcpup, 0,	\
-				  (atomic_read(&kvm->online_vcpus) - 1))
+static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
+{
+	return plane_get_vcpu(kvm->planes[0], i);
+}
+
+#define plane_for_each_vcpu(idx, vcpup, plane)					\
+	if (atomic_read(&plane->kvm->online_vcpus))				\
+		xa_for_each_range(&plane->vcpu_array, idx, vcpup, 0,		\
+				  (atomic_read(&plane->kvm->online_vcpus) - 1))
+
+#define kvm_for_each_vcpu(idx, vcpup, kvm)					\
+	plane_for_each_vcpu(idx, vcpup, kvm->planes[0])
 
 static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a68469c6d12e..668645dd3945 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -443,6 +443,7 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	mutex_init(&vcpu->mutex);
 	vcpu->cpu = -1;
 	vcpu->kvm = kvm;
+	vcpu->plane = kvm->planes[0];
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
 	rwlock_init(&vcpu->pid_lock);
@@ -479,14 +480,14 @@ static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
-void kvm_destroy_vcpus(struct kvm *kvm)
+static void plane_destroy_vcpus(struct kvm_plane *plane)
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	plane_for_each_vcpu(i, vcpu, plane) {
 		kvm_vcpu_destroy(vcpu);
-		xa_erase(&kvm->vcpu_array, i);
+		xa_erase(&plane->vcpu_array, i);
 
 		/*
 		 * Assert that the vCPU isn't visible in any way, to ensure KVM
@@ -494,7 +495,22 @@ void kvm_destroy_vcpus(struct kvm *kvm)
 		 * in VM-wide request, e.g. to flush remote TLBs when tearing
 		 * down MMUs, or to mark the VM dead if a KVM_BUG_ON() fires.
 		 */
-		WARN_ON_ONCE(xa_load(&kvm->vcpu_array, i) || kvm_get_vcpu(kvm, i));
+		WARN_ON_ONCE(xa_load(&plane->vcpu_array, i) || plane_get_vcpu(plane, i));
+	}
+
+}
+
+void kvm_destroy_vcpus(struct kvm *kvm)
+{
+	unsigned lvl;
+
+	for (lvl = KVM_MAX_PLANES; lvl > 0; lvl--) {
+		struct kvm_plane *plane = kvm->planes[lvl - 1];
+
+		if (plane == NULL)
+			continue;
+
+		plane_destroy_vcpus(plane);
 	}
 
 	atomic_set(&kvm->online_vcpus, 0);
@@ -1105,6 +1121,8 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 	plane->kvm = kvm;
 	plane->level = plane_level;
 
+	xa_init(&plane->vcpu_array);
+
 	kvm->planes[plane_level] = plane;
 
 	return plane;
@@ -1146,7 +1164,6 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	mutex_init(&kvm->slots_arch_lock);
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
-	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	xa_init(&kvm->mem_attr_array);
 #endif
@@ -4039,7 +4056,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 		if (idx == me->vcpu_idx)
 			continue;
 
-		vcpu = xa_load(&kvm->vcpu_array, idx);
+		vcpu = xa_load(&kvm->planes[0]->vcpu_array, idx);
 		if (!READ_ONCE(vcpu->ready))
 			continue;
 		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
@@ -4258,7 +4275,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	}
 
 	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
-	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
+	r = xa_insert(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
 	WARN_ON_ONCE(r == -EBUSY);
 	if (r)
 		goto unlock_vcpu_destroy;
@@ -4293,7 +4310,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 kvm_put_xa_erase:
 	mutex_unlock(&vcpu->mutex);
 	kvm_put_kvm_no_destroy(kvm);
-	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
+	xa_erase(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	mutex_unlock(&kvm->lock);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
-- 
2.53.0


