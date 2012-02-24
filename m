Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AB29B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/37] KVM: PPC: booke: add booke-level vcpu load/put
Date: Fri, 24 Feb 2012 15:25:58 +0100
Message-Id: <1330093591-19523-5-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

This gives us a place to put load/put actions that correspond to
code that is booke-specific but not specific to a particular core.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/44x.c   |    3 +++
 arch/powerpc/kvm/booke.c |    8 ++++++++
 arch/powerpc/kvm/booke.h |    3 +++
 arch/powerpc/kvm/e500.c  |    3 +++
 4 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 7b612a7..879a1a7 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -29,15 +29,18 @@
 #include <asm/kvm_ppc.h>
 
 #include "44x_tlb.h"
+#include "booke.h"
 
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	kvmppc_booke_vcpu_load(vcpu, cpu);
 	kvmppc_44x_tlb_load(vcpu);
 }
 
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	kvmppc_44x_tlb_put(vcpu);
+	kvmppc_booke_vcpu_put(vcpu);
 }
 
 int kvmppc_core_check_processor_compat(void)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ee9e1ee..a2456c7 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -968,6 +968,14 @@ void kvmppc_decrementer_func(unsigned long data)
 	kvmppc_set_tsr_bits(vcpu, TSR_DIS);
 }
 
+void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+}
+
+void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu)
+{
+}
+
 int __init kvmppc_booke_init(void)
 {
 	unsigned long ivor[16];
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 2fe2027..05d1d99 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -71,4 +71,7 @@ void kvmppc_save_guest_spe(struct kvm_vcpu *vcpu);
 /* high-level function, manages flags, host state */
 void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
 
+void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu);
+
 #endif /* __KVM_BOOKE_H__ */
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index ddcd896..2d5fe04 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -36,6 +36,7 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
 
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	kvmppc_booke_vcpu_load(vcpu, cpu);
 	kvmppc_e500_tlb_load(vcpu, cpu);
 }
 
@@ -47,6 +48,8 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.shadow_msr & MSR_SPE)
 		kvmppc_vcpu_disable_spe(vcpu);
 #endif
+
+	kvmppc_booke_vcpu_put(vcpu);
 }
 
 int kvmppc_core_check_processor_compat(void)
-- 
1.6.0.2
