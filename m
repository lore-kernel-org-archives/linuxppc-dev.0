Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC6782C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:16 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 4/8 v3] KVM: PPC: e500: Add support for TLBnPS registers
Date: Thu, 11 Apr 2013 13:03:10 +0300
Message-ID: <1365674594-17410-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
References: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
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

Add support for TLBnPS registers available in MMU Architecture Version
(MAV) 2.0.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - Add vcpu_ftr enum
 
v2:
 - Add vcpu generic function has_feature()

 Documentation/virtual/kvm/api.txt   |    4 ++++
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/include/uapi/asm/kvm.h |    4 ++++
 arch/powerpc/kvm/e500.h             |   18 ++++++++++++++++++
 arch/powerpc/kvm/e500_emulate.c     |   10 ++++++++++
 arch/powerpc/kvm/e500_mmu.c         |   22 ++++++++++++++++++++++
 6 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1a76663..f045377 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1803,6 +1803,10 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_TLB1CFG	| 32
   PPC   | KVM_REG_PPC_TLB2CFG	| 32
   PPC   | KVM_REG_PPC_TLB3CFG	| 32
+  PPC   | KVM_REG_PPC_TLB0PS	| 32
+  PPC   | KVM_REG_PPC_TLB1PS	| 32
+  PPC   | KVM_REG_PPC_TLB2PS	| 32
+  PPC   | KVM_REG_PPC_TLB3PS	| 32
 
 ARM registers are mapped using the lower 32 bits.  The upper 16 of that
 is the register group type, or coprocessor number:
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e34f8fe..3b6cee3 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -502,6 +502,7 @@ struct kvm_vcpu_arch {
 	spinlock_t wdt_lock;
 	struct timer_list wdt_timer;
 	u32 tlbcfg[4];
+	u32 tlbps[4];
 	u32 mmucfg;
 	u32 epr;
 	u32 crit_save;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 93d063f..91341d9 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -442,5 +442,9 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_TLB1CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x94)
 #define KVM_REG_PPC_TLB2CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x95)
 #define KVM_REG_PPC_TLB3CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x96)
+#define KVM_REG_PPC_TLB0PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x97)
+#define KVM_REG_PPC_TLB1PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x98)
+#define KVM_REG_PPC_TLB2PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x99)
+#define KVM_REG_PPC_TLB3PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x9a)
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index b73ca7a..c2e5e98 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -23,6 +23,10 @@
 #include <asm/mmu-book3e.h>
 #include <asm/tlb.h>
 
+enum vcpu_ftr {
+	VCPU_FTR_MMU_V2
+};
+
 #define E500_PID_NUM   3
 #define E500_TLB_NUM   2
 
@@ -299,4 +303,18 @@ static inline unsigned int get_tlbmiss_tid(struct kvm_vcpu *vcpu)
 #define get_tlb_sts(gtlbe)              (MAS1_TS)
 #endif /* !BOOKE_HV */
 
+static inline bool has_feature(const struct kvm_vcpu *vcpu,
+			       enum vcpu_ftr ftr)
+{
+	bool has_ftr;
+	switch (ftr) {
+	case VCPU_FTR_MMU_V2:
+		has_ftr = ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
+		break;
+	default:
+		return false;
+	}
+	return has_ftr;
+}
+
 #endif /* KVM_E500_H */
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index e78f353..12b8de2 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -284,6 +284,16 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 	case SPRN_TLB1CFG:
 		*spr_val = vcpu->arch.tlbcfg[1];
 		break;
+	case SPRN_TLB0PS:
+		if (!has_feature(vcpu, VCPU_FTR_MMU_V2))
+			return EMULATE_FAIL;
+		*spr_val = vcpu->arch.tlbps[0];
+		break;
+	case SPRN_TLB1PS:
+		if (!has_feature(vcpu, VCPU_FTR_MMU_V2))
+			return EMULATE_FAIL;
+		*spr_val = vcpu->arch.tlbps[1];
+		break;
 	case SPRN_L1CSR0:
 		*spr_val = vcpu_e500->l1csr0;
 		break;
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 08a5b0d..a863dc1 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -631,6 +631,13 @@ int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 		i = id - KVM_REG_PPC_TLB0CFG;
 		*val = get_reg_val(id, vcpu->arch.tlbcfg[i]);
 		break;
+	case KVM_REG_PPC_TLB0PS:
+	case KVM_REG_PPC_TLB1PS:
+	case KVM_REG_PPC_TLB2PS:
+	case KVM_REG_PPC_TLB3PS:
+		i = id - KVM_REG_PPC_TLB0PS;
+		*val = get_reg_val(id, vcpu->arch.tlbps[i]);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -682,6 +689,16 @@ int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 			r = -EINVAL;
 		break;
 	}
+	case KVM_REG_PPC_TLB0PS:
+	case KVM_REG_PPC_TLB1PS:
+	case KVM_REG_PPC_TLB2PS:
+	case KVM_REG_PPC_TLB3PS: {
+		u32 reg = set_reg_val(id, *val);
+		i = id - KVM_REG_PPC_TLB0PS;
+		if (reg != vcpu->arch.tlbps[i])
+			r = -EINVAL;
+		break;
+	}
 	default:
 		r = -EINVAL;
 		break;
@@ -855,6 +872,11 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
 	vcpu->arch.tlbcfg[1] |= params[1].entries;
 	vcpu->arch.tlbcfg[1] |= params[1].ways << TLBnCFG_ASSOC_SHIFT;
 
+	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
+		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
+		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
+	}
+
 	return 0;
 }
 
-- 
1.7.4.1
