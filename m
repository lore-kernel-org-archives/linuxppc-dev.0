Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81CF0100813
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/26] KVM: PPC: Introduce shared page
Date: Sat, 26 Jun 2010 01:24:49 +0200
Message-Id: <1277508314-915-2-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For transparent variable sharing between the hypervisor and guest, I introduce
a shared page. This shared page will contain all the registers the guest can
read and write safely without exiting guest context.

This patch only implements the stubs required for the basic structure of the
shared page. The actual register moving follows.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    2 ++
 arch/powerpc/include/asm/kvm_para.h |    5 +++++
 arch/powerpc/kernel/asm-offsets.c   |    1 +
 arch/powerpc/kvm/44x.c              |    7 +++++++
 arch/powerpc/kvm/book3s.c           |    7 +++++++
 arch/powerpc/kvm/e500.c             |    7 +++++++
 6 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 895eb63..bca9391 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <linux/kvm_para.h>
 #include <asm/kvm_asm.h>
 
 #define KVM_MAX_VCPUS 1
@@ -289,6 +290,7 @@ struct kvm_vcpu_arch {
 	struct tasklet_struct tasklet;
 	u64 dec_jiffies;
 	unsigned long pending_exceptions;
+	struct kvm_vcpu_arch_shared *shared;
 
 #ifdef CONFIG_PPC_BOOK3S
 	struct kmem_cache *hpte_cache;
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 2d48f6a..1485ba8 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -20,6 +20,11 @@
 #ifndef __POWERPC_KVM_PARA_H__
 #define __POWERPC_KVM_PARA_H__
 
+#include <linux/types.h>
+
+struct kvm_vcpu_arch_shared {
+};
+
 #ifdef __KERNEL__
 
 static inline int kvm_para_available(void)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 496cc5b..944f593 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -400,6 +400,7 @@ int main(void)
 	DEFINE(VCPU_SPRG6, offsetof(struct kvm_vcpu, arch.sprg6));
 	DEFINE(VCPU_SPRG7, offsetof(struct kvm_vcpu, arch.sprg7));
 	DEFINE(VCPU_SHADOW_PID, offsetof(struct kvm_vcpu, arch.shadow_pid));
+	DEFINE(VCPU_SHARED, offsetof(struct kvm_vcpu, arch.shared));
 
 	/* book3s */
 #ifdef CONFIG_PPC_BOOK3S
diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 73c0a3f..e7b1f3f 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -123,8 +123,14 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto free_vcpu;
 
+	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
+	if (!vcpu->arch.shared)
+		goto uninit_vcpu;
+
 	return vcpu;
 
+uninit_vcpu:
+	kvm_vcpu_uninit(vcpu);
 free_vcpu:
 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
 out:
@@ -135,6 +141,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_44x *vcpu_44x = to_44x(vcpu);
 
+	free_page((unsigned long)vcpu->arch.shared);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
 }
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 884d4a5..ba79b35 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1247,6 +1247,10 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto free_shadow_vcpu;
 
+	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
+	if (!vcpu->arch.shared)
+		goto uninit_vcpu;
+
 	vcpu->arch.host_retip = kvm_return_point;
 	vcpu->arch.host_msr = mfmsr();
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -1277,6 +1281,8 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 
 	return vcpu;
 
+uninit_vcpu:
+	kvm_vcpu_uninit(vcpu);
 free_shadow_vcpu:
 	kfree(vcpu_book3s->shadow_vcpu);
 free_vcpu:
@@ -1289,6 +1295,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 
+	free_page((unsigned long)vcpu->arch.shared);
 	kvm_vcpu_uninit(vcpu);
 	kfree(vcpu_book3s->shadow_vcpu);
 	vfree(vcpu_book3s);
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index e8a00b0..71750f2 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -117,8 +117,14 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto uninit_vcpu;
 
+	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
+	if (!vcpu->arch.shared)
+		goto uninit_tlb;
+
 	return vcpu;
 
+uninit_tlb:
+	kvmppc_e500_tlb_uninit(vcpu_e500);
 uninit_vcpu:
 	kvm_vcpu_uninit(vcpu);
 free_vcpu:
@@ -131,6 +137,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
+	free_page((unsigned long)vcpu->arch.shared);
 	kvmppc_e500_tlb_uninit(vcpu_e500);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
-- 
1.6.0.2
