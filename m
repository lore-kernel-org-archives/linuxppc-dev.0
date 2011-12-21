Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6E39DB71B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:35 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 06/16] KVM: PPC: booke: Move vm core init/destroy out of
 booke.c
Message-ID: <20111221013426.GF8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e500mc will want to do lpid allocation/deallocation here.

Signed-off-by: Scott Wood <scottwood@freescale.com>
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
index 933e611..f66e741 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -936,15 +936,6 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
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
index 923f375..80b9c84 100644
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
1.7.7.rc3.4.g8d714
