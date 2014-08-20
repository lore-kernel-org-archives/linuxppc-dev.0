Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB0531A0367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:36:49 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 5/6] KVM: PPC: Booke: Add setter functions for IVPR,
 IVOR2 and IVOR8 emulation
Date: Wed, 20 Aug 2014 16:36:26 +0300
Message-ID: <1408541787-24625-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
References: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add setter functions for IVPR, IVOR2 and IVOR8 emulation in preparation
for ONE_REG support.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - new patch
 - add api documentation for ONE_REG IVPR and IVORs

 arch/powerpc/kvm/booke.c         | 24 ++++++++++++++++++++++++
 arch/powerpc/kvm/booke.h         |  3 +++
 arch/powerpc/kvm/booke_emulate.c | 15 +++------------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 831c1b4..d4df648 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1782,6 +1782,30 @@ void kvmppc_clr_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits)
 	update_timer_ints(vcpu);
 }
 
+void kvmppc_set_ivpr(struct kvm_vcpu *vcpu, ulong new_ivpr)
+{
+	vcpu->arch.ivpr = new_ivpr;
+#ifdef CONFIG_KVM_BOOKE_HV
+	mtspr(SPRN_GIVPR, new_ivpr);
+#endif
+}
+
+void kvmppc_set_ivor2(struct kvm_vcpu *vcpu, u32 new_ivor)
+{
+	vcpu->arch.ivor[BOOKE_IRQPRIO_DATA_STORAGE] = new_ivor;
+#ifdef CONFIG_KVM_BOOKE_HV
+	mtspr(SPRN_GIVOR2, new_ivor);
+#endif
+}
+
+void kvmppc_set_ivor8(struct kvm_vcpu *vcpu, u32 new_ivor)
+{
+	vcpu->arch.ivor[BOOKE_IRQPRIO_SYSCALL] = new_ivor;
+#ifdef CONFIG_KVM_BOOKE_HV
+	mtspr(SPRN_GIVOR8, new_ivor);
+#endif
+}
+
 void kvmppc_decrementer_func(unsigned long data)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 22ba08e..0242530 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -80,6 +80,9 @@ void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr);
 void kvmppc_set_tcr(struct kvm_vcpu *vcpu, u32 new_tcr);
 void kvmppc_set_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits);
 void kvmppc_clr_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits);
+void kvmppc_set_ivpr(struct kvm_vcpu *vcpu, ulong new_ivpr);
+void kvmppc_set_ivor2(struct kvm_vcpu *vcpu, u32 new_ivor);
+void kvmppc_set_ivor8(struct kvm_vcpu *vcpu, u32 new_ivor);
 
 int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                             unsigned int inst, int *advance);
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 92bc668..94c64e3 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -191,10 +191,7 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		break;
 
 	case SPRN_IVPR:
-		vcpu->arch.ivpr = spr_val;
-#ifdef CONFIG_KVM_BOOKE_HV
-		mtspr(SPRN_GIVPR, spr_val);
-#endif
+		kvmppc_set_ivpr(vcpu, spr_val);
 		break;
 	case SPRN_IVOR0:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_CRITICAL] = spr_val;
@@ -203,10 +200,7 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		vcpu->arch.ivor[BOOKE_IRQPRIO_MACHINE_CHECK] = spr_val;
 		break;
 	case SPRN_IVOR2:
-		vcpu->arch.ivor[BOOKE_IRQPRIO_DATA_STORAGE] = spr_val;
-#ifdef CONFIG_KVM_BOOKE_HV
-		mtspr(SPRN_GIVOR2, spr_val);
-#endif
+		kvmppc_set_ivor2(vcpu, spr_val);
 		break;
 	case SPRN_IVOR3:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_INST_STORAGE] = spr_val;
@@ -224,10 +218,7 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		vcpu->arch.ivor[BOOKE_IRQPRIO_FP_UNAVAIL] = spr_val;
 		break;
 	case SPRN_IVOR8:
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SYSCALL] = spr_val;
-#ifdef CONFIG_KVM_BOOKE_HV
-		mtspr(SPRN_GIVOR8, spr_val);
-#endif
+		kvmppc_set_ivor8(vcpu, spr_val);
 		break;
 	case SPRN_IVOR9:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_AP_UNAVAIL] = spr_val;
-- 
1.7.11.7
