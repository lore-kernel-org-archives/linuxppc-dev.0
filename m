Return-Path: <linuxppc-dev+bounces-22239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4645CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4l07Whz3dKc;
	Tue, 09 Jun 2026 00:52:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930358;
	cv=none; b=RTrzZRcL9//7ySrw5tMDC4Kx7Fwl8CVO6kSBZy3tQS6nhnFqMn/yd57mx2b44vIETjVWInj+R2y1GWWNYA2ndoeQOj4TIpTezJs7Ma2jVFmDitbGa8aJMT6vy80XzDJHqVeZfnQjZiqeO3zSlP/RUbzadiB23mrFQNXnqqiq6Ezq6n5oRuqKE1u21WSx4AMwR756rxkyL9L56P8vlkQt7x7rXHzo84IKm5qzri+rM7Auq8q6nsOON243vDC122Cqj5O7CuthGEgMjbnc1Vy0gX9k7CXhfJyNtIZT2XqD45i9BZ/Z04eKbFka6yysGLG8yImlKPvLQu/4IAlzLhYy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930358; c=relaxed/relaxed;
	bh=QsYplZ1HRXjd8HRC57G4eyJFUWV8N1eu/ti4WWatSIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJncLBAgyNCDJWnOZd1JKlka1sAoD2XWtrylwlhywVD7guX8s5NgO1dSdhfjUrdItpXe4Gn1MDM7TPjWBGAyipNXxeScGwhUaZ9fA8wENdSpEd1JHTaIx+JgSjOwLuLoMQ2927oR0v+ggL5ZV6aRhHCyGHxHdreqoZ2w6+PsQtKfWce3gEOzCuKah10CaOsePNxmc+lduDcLr4MBF8g6bC7DYXjunSQMjFRmWR9dPEW6d8372w/fN0TGb4Pz+8qLTiaV0Vpn92j2KLWcFYJUSUCuywi4iQPWPlWQqBXazN53YUhtBeBe5aPvf00ygv33Mz4etUAMBAhFDIUo28MU4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4R5vLqz3c5X
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:23 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 28B6D2028C4;
	Mon,  8 Jun 2026 16:43:12 +0200 (CEST)
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
Subject: [PATCH 33/60] KVM: Implement KVM_CREATE_VCPU ioctl for planes
Date: Mon,  8 Jun 2026 16:42:25 +0200
Message-ID: <20260608144252.351443-34-joro@8bytes.org>
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

Implement the KVM_CREATE_VCPU ioctl per plane. Also introduce an
empty IOCTL path for the plane-vcpus, including per-architecture
call-backs.

Co-developed-by: Carlos López <clopez@suse.de>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/kvm/arm.c       |  5 ++
 arch/loongarch/kvm/vcpu.c  |  5 ++
 arch/mips/kvm/mips.c       |  5 ++
 arch/powerpc/kvm/powerpc.c |  5 ++
 arch/riscv/kvm/vcpu.c      |  5 ++
 arch/s390/kvm/kvm-s390.c   |  5 ++
 arch/x86/kvm/x86.c         | 29 ++++++++++++
 include/linux/kvm_host.h   | 12 +++--
 virt/kvm/kvm_main.c        | 97 ++++++++++++++++++++++++++++----------
 9 files changed, 141 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d7a4b9b239dc..b2bfea5df7e0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1824,6 +1824,11 @@ static int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 	return __kvm_arm_vcpu_set_events(vcpu, events);
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	return false;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index bab3c66ae58d..0b66b8186923 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1232,6 +1232,11 @@ static int kvm_loongarch_vcpu_set_attr(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	return false;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e22d2a267e03..28795bad178b 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -933,6 +933,11 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	return false;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 			 unsigned long arg)
 {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 35658cded0cb..476f7ea02c79 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2055,6 +2055,11 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	return false;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
                          unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 66cde226eb87..17680b659bdd 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -263,6 +263,11 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	return false;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 94c40b2aa759..261859cb1bb6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5454,6 +5454,11 @@ static int kvm_s390_handle_pv_vcpu_dump(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	return false;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d6bf0425525c..623838885753 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6227,6 +6227,35 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	switch (ioctl) {
+	case KVM_GET_DEBUGREGS:
+	case KVM_SET_DEBUGREGS:
+	case KVM_GET_LAPIC:
+	case KVM_SET_LAPIC:
+	case KVM_GET_MSRS:
+	case KVM_SET_MSRS:
+	case KVM_GET_NESTED_STATE:
+	case KVM_SET_NESTED_STATE:
+	case KVM_GET_ONE_REG:
+	case KVM_SET_ONE_REG:
+	case KVM_GET_SREGS2:
+	case KVM_SET_SREGS2:
+	case KVM_GET_VCPU_EVENTS:
+	case KVM_SET_VCPU_EVENTS:
+	case KVM_GET_XCRS:
+	case KVM_SET_XCRS:
+	case KVM_GET_XSAVE:
+	case KVM_GET_XSAVE2:
+	case KVM_SET_XSAVE:
+	case KVM_GET_REG_LIST:
+		return true;
+	default:
+		return false;
+	}
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 385e1ee8fd3a..b8c3f8f11cb4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1126,7 +1126,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 #define kvm_for_each_vcpu(idx, vcpup, kvm)					\
 	plane_for_each_vcpu(idx, vcpup, kvm->planes[0])
 
-static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
+static inline struct kvm_vcpu *plane_get_vcpu_by_id(struct kvm_plane *plane, int id)
 {
 	struct kvm_vcpu *vcpu = NULL;
 	unsigned long i;
@@ -1134,15 +1134,20 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	if (id < 0)
 		return NULL;
 	if (id < KVM_MAX_VCPUS)
-		vcpu = kvm_get_vcpu(kvm, id);
+		vcpu = plane_get_vcpu(plane, id);
 	if (vcpu && vcpu->vcpu_id == id)
 		return vcpu;
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	plane_for_each_vcpu(i, vcpu, plane)
 		if (vcpu->vcpu_id == id)
 			return vcpu;
 	return NULL;
 }
 
+static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
+{
+	return plane_get_vcpu_by_id(kvm->planes[0], id);
+}
+
 static inline bool kvm_is_vcpu_creation_in_progress(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->lock);
@@ -1688,6 +1693,7 @@ bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
+bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl);
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg);
 long kvm_arch_vcpu_unlocked_ioctl(struct file *filp,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2d0d5f4fd356..8839f91fd15e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -538,14 +538,11 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 {
 	vcpu->cpu = -1;
 	vcpu->kvm = kvm;
-	vcpu->plane = kvm->planes[0];
 	vcpu->vcpu_id = id;
 	kvm_async_pf_vcpu_init(vcpu);
 
 	vcpu->last_used_slot = NULL;
 
-	vcpu->plane_level = 0;
-
 	/* Fill the stats id string for the vcpu */
 	snprintf(vcpu->stats_id, sizeof(vcpu->stats_id), "kvm-%d/vcpu-%d",
 		 task_pid_nr(current), id);
@@ -4306,9 +4303,13 @@ static struct file_operations kvm_vcpu_fops = {
  */
 static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 {
-	char name[8 + 1 + ITOA_MAX_LEN + 1];
+	char name[14 + 1 + (2 * ITOA_MAX_LEN) + 1];
+
+	if (vcpu->plane_level == 0)
+		snprintf(name, sizeof(name), "kvm-vcpu:%d", vcpu->vcpu_id);
+	else
+		snprintf(name, sizeof(name), "kvm-vcpu-plane%d:%d", vcpu->plane_level, vcpu->vcpu_id);
 
-	snprintf(name, sizeof(name), "kvm-vcpu:%d", vcpu->vcpu_id);
 	return anon_inode_getfd(name, &kvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
 }
 
@@ -4327,13 +4328,17 @@ DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
 
 static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
+	char dir_name[10 + (2 * ITOA_MAX_LEN) + 1];
 	struct dentry *debugfs_dentry;
-	char dir_name[ITOA_MAX_LEN * 2];
 
 	if (!debugfs_initialized())
 		return;
 
-	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
+	if (vcpu->plane_level == 0)
+		snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
+	else
+		snprintf(dir_name, sizeof(dir_name), "vcpu%d-plane%d", vcpu->plane_level, vcpu->vcpu_id);
+
 	debugfs_dentry = debugfs_create_dir(dir_name,
 					    vcpu->kvm->debugfs_dentry);
 	debugfs_create_file("pid", 0444, debugfs_dentry, vcpu,
@@ -4346,10 +4351,11 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 /*
  * Creates some virtual cpus.  Good luck creating more than one.
  */
-static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
+static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id)
 {
-	int r = -EINVAL;
+	struct kvm *kvm = plane->kvm;
 	struct kvm_vcpu *vcpu;
+	int r;
 
 	mutex_lock(&kvm->lock);
 	if (kvm->created_vcpus >= kvm->max_vcpus) {
@@ -4366,11 +4372,28 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	if (!vcpu)
 		return -ENOMEM;
 
-	r = kvm_vcpu_init_common(vcpu, kvm, id);
-	if (r)
+	r = -EEXIST;
+	if (plane_get_vcpu_by_id(plane, id))
 		goto vcpu_free;
 
+	if (plane->level > 0) {
+		struct kvm_vcpu *vcpu_plane0 = kvm_get_vcpu_by_id(kvm, id);
+
+		/* Plane0 VCPU must exist before creating non-plane0 VCPUs */
+		r = -EINVAL;
+		if (vcpu_plane0 == NULL)
+			goto vcpu_free;
+
+		vcpu->common = vcpu_plane0->common;
+	} else {
+		r = kvm_vcpu_init_common(vcpu, kvm, id);
+		if (r)
+			goto vcpu_free;
+	}
+
 	vcpu->vcpu_idx = vcpu->common->vcpu_idx;
+	vcpu->plane = plane;
+	vcpu->plane_level = plane->level;
 	vcpu->run = vcpu->common->run;
 
 	kvm_vcpu_init(vcpu, kvm, id);
@@ -4381,12 +4404,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm_get_vcpu_by_id(kvm, id)) {
-		r = -EEXIST;
-		goto unlock_vcpu_destroy;
-	}
-
-	r = xa_insert(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
+	r = xa_insert(&plane->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
 	WARN_ON_ONCE(r == -EBUSY);
 	if (r)
 		goto unlock_vcpu_destroy;
@@ -4416,7 +4434,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 kvm_put_xa_erase:
 	kvm_vcpu_unlock(vcpu);
 	kvm_put_kvm_no_destroy(kvm);
-	xa_erase(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx);
+	xa_erase(&plane->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	mutex_unlock(&kvm->lock);
 	kvm_arch_vcpu_destroy(vcpu);
@@ -4550,7 +4568,7 @@ static int kvm_wait_for_vcpu_online(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Acquire and release the vCPU's mutex to wait for vCPU creation to
-	 * complete (kvm_vm_ioctl_create_vcpu() holds the mutex until the vCPU
+	 * complete (kvm_plane_ioctl_create_vcpu() holds the mutex until the vCPU
 	 * is fully online).
 	 */
 	if (mutex_lock_killable(kvm_vcpu_mutex(vcpu)))
@@ -4564,6 +4582,22 @@ static int kvm_wait_for_vcpu_online(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static inline bool kvm_is_vcpu_plane_ioctl(unsigned ioctl)
+{
+	switch (ioctl) {
+	case KVM_GET_FPU:
+	case KVM_SET_FPU:
+	case KVM_GET_REGS:
+	case KVM_SET_REGS:
+	case KVM_GET_SREGS:
+	case KVM_SET_SREGS:
+	case KVM_TRANSLATE:
+		return true;
+	default:
+		return kvm_arch_is_vcpu_plane_ioctl(ioctl);
+	}
+}
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4576,6 +4610,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_dead)
 		return -EIO;
 
+	if (vcpu->plane_level > 0 && !kvm_is_vcpu_plane_ioctl(ioctl))
+		return -EINVAL;
+
 	if (unlikely(_IOC_TYPE(ioctl) != KVMIO))
 		return -EINVAL;
 
@@ -4858,6 +4895,21 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
 }
 #endif
 
+static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsigned long arg)
+{
+	long r;
+
+	switch (ioctl) {
+	case KVM_CREATE_VCPU:
+		r = kvm_plane_ioctl_create_vcpu(plane, arg);
+		break;
+	default:
+		r = -ENOTTY;
+	}
+
+	return r;
+}
+
 static long kvm_plane_ioctl(struct file *filp, unsigned int ioctl,
 			    unsigned long arg)
 {
@@ -4866,10 +4918,7 @@ static long kvm_plane_ioctl(struct file *filp, unsigned int ioctl,
 	if (plane->kvm->mm != current->mm || plane->kvm->vm_dead)
 		return -EIO;
 
-	switch (ioctl) {
-	default:
-		return -ENOTTY;
-	}
+	return __kvm_plane_ioctl(plane, ioctl, arg);
 }
 
 static int kvm_plane_release(struct inode *inode, struct file *filp)
@@ -5396,7 +5445,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_create_plane(kvm, arg);
 		break;
 	case KVM_CREATE_VCPU:
-		r = kvm_vm_ioctl_create_vcpu(kvm, arg);
+		r = __kvm_plane_ioctl(kvm->planes[0], ioctl, arg);
 		break;
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
-- 
2.53.0


