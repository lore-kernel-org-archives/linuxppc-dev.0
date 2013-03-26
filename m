Return-Path: <B02008@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C82CA2C0101
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 09:06:16 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/7 v2] KVM: PPC: e500: Add support for TLBnPS registers
Date: Wed, 27 Mar 2013 00:05:08 +0200
Message-ID: <1364335512-28426-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
References: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
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
v2:
 - Add vcpu generic function has_feature()

 Documentation/virtual/kvm/api.txt   |    4 ++++
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/include/uapi/asm/kvm.h |    4 ++++
 arch/powerpc/kvm/e500.h             |   16 ++++++++++++++++
 arch/powerpc/kvm/e500_emulate.c     |   10 ++++++++++
 arch/powerpc/kvm/e500_mmu.c         |   20 ++++++++++++++++++++
 6 files changed, 55 insertions(+), 0 deletions(-)

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
index 777dc81..7cfd13f 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -439,4 +439,8 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_TLB1CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x93)
 #define KVM_REG_PPC_TLB2CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x94)
 #define KVM_REG_PPC_TLB3CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x95)
+#define KVM_REG_PPC_TLB0PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x96)
+#define KVM_REG_PPC_TLB1PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x97)
+#define KVM_REG_PPC_TLB2PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x98)
+#define KVM_REG_PPC_TLB3PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x99)
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index b73ca7a..795934d 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -23,6 +23,8 @@
 #include <asm/mmu-book3e.h>
 #include <asm/tlb.h>
 
+#define VCPU_FTR_MMU_V2		0
+
 #define E500_PID_NUM   3
 #define E500_TLB_NUM   2
 
@@ -299,4 +301,18 @@ static inline unsigned int get_tlbmiss_tid(struct kvm_vcpu *vcpu)
 #define get_tlb_sts(gtlbe)              (MAS1_TS)
 #endif /* !BOOKE_HV */
 
+static inline bool has_feature(const struct kvm_vcpu *vcpu,
+			       unsigned long vcpu_ftr)
+{
+	bool has_ftr;
+	switch (vcpu_ftr) {
+	case VCPU_FTR_MMU_V2:
+		has_ftr = ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
+		break;
+	default:
+		has_ftr = false;
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
index 7d6bb12..e354fa1 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -623,6 +623,12 @@ int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_TLB3CFG:
 		i = id - KVM_REG_PPC_TLB0CFG;
 		*val = get_reg_val(id, vcpu->arch.tlbcfg[i]);
+	case KVM_REG_PPC_TLB0PS:
+	case KVM_REG_PPC_TLB1PS:
+	case KVM_REG_PPC_TLB2PS:
+	case KVM_REG_PPC_TLB3PS:
+		i = id - KVM_REG_PPC_TLB0PS;
+		*val = get_reg_val(id, vcpu->arch.tlbps[i]);
 	default:
 		r = -EINVAL;
 		break;
@@ -672,6 +678,15 @@ int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 			r = -EINVAL;
 		break;
 	}
+	case KVM_REG_PPC_TLB0PS:
+	case KVM_REG_PPC_TLB1PS:
+	case KVM_REG_PPC_TLB2PS:
+	case KVM_REG_PPC_TLB3PS: {
+		i = id - KVM_REG_PPC_TLB0PS;
+		if (set_reg_val(id, *val) != vcpu->arch.tlbps[i])
+			r = -EINVAL;
+		break;
+	}
 	default:
 		r = -EINVAL;
 		break;
@@ -845,6 +860,11 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
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
