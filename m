Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 164E2B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 03:57:03 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: <kvm-ppc@vger.kernel.org> <kvm-ppc@vger.kernel.org>
Subject: [PATCH 05/30] KVM: PPC: booke: Move vm core init/destroy out of
 booke.c
Date: Fri, 17 Feb 2012 17:56:33 +0100
Message-Id: <1329497818-9729-6-git-send-email-agraf@suse.de>
In-Reply-To: <1329497818-9729-1-git-send-email-agraf@suse.de>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

e500mc will want to do lpid allocation/deallocation here.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/44x.c   |    9 +++++++++
 arch/powerpc/kvm/booke.c |    9 ---------
 arch/powerpc/kvm/e500.c  |    9 +++++++++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 879a1a7..50e7dbc 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -163,6 +163,15 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
 }
 
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+	return 0;
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+}
+
 static int __init kvmppc_44x_init(void)
 {
 	int r;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index a2456c7..2ee9bae 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -932,15 +932,6 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 {
 }
 
-int kvmppc_core_init_vm(struct kvm *kvm)
-{
-	return 0;
-}
-
-void kvmppc_core_destroy_vm(struct kvm *kvm)
-{
-}
-
 void kvmppc_set_tcr(struct kvm_vcpu *vcpu, u32 new_tcr)
 {
 	vcpu->arch.tcr = new_tcr;
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 2d5fe04..ac6c9ae 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -226,6 +226,15 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
 }
 
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+	return 0;
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+}
+
 static int __init kvmppc_e500_init(void)
 {
 	int r, i;
-- 
1.6.0.2
