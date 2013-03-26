Return-Path: <B02008@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 669B92C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 09:05:47 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 4/7 v2] KVM: PPC: e500: Add support for EPTCFG register
Date: Wed, 27 Mar 2013 00:05:09 +0200
Message-ID: <1364335512-28426-5-git-send-email-mihai.caraman@freescale.com>
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

EPTCFG register defined by E.PT is accessed unconditionally by Linux guests
in the presence of MAV 2.0. Support it now.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - Use has_feature() function

 Documentation/virtual/kvm/api.txt   |    1 +
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/include/uapi/asm/kvm.h |    1 +
 arch/powerpc/kvm/e500.h             |    5 +++++
 arch/powerpc/kvm/e500_emulate.c     |    9 +++++++++
 arch/powerpc/kvm/e500_mmu.c         |   11 +++++++++++
 6 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index f045377..a1f2200 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1807,6 +1807,7 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_TLB1PS	| 32
   PPC   | KVM_REG_PPC_TLB2PS	| 32
   PPC   | KVM_REG_PPC_TLB3PS	| 32
+  PPC   | KVM_REG_PPC_EPTCFG	| 32
 
 ARM registers are mapped using the lower 32 bits.  The upper 16 of that
 is the register group type, or coprocessor number:
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3b6cee3..8a48e68 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -504,6 +504,7 @@ struct kvm_vcpu_arch {
 	u32 tlbcfg[4];
 	u32 tlbps[4];
 	u32 mmucfg;
+	u32 eptcfg;
 	u32 epr;
 	u32 crit_save;
 	struct kvmppc_booke_debug_reg dbg_reg;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 7cfd13f..9d7fbf0 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -443,4 +443,5 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_TLB1PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x97)
 #define KVM_REG_PPC_TLB2PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x98)
 #define KVM_REG_PPC_TLB3PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x99)
+#define KVM_REG_PPC_EPTCFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x9a)
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 795934d..6cfc669 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -24,6 +24,7 @@
 #include <asm/tlb.h>
 
 #define VCPU_FTR_MMU_V2		0
+#define VCPU_FTR_E_PT		1
 
 #define E500_PID_NUM   3
 #define E500_TLB_NUM   2
@@ -309,6 +310,10 @@ static inline bool has_feature(const struct kvm_vcpu *vcpu,
 	case VCPU_FTR_MMU_V2:
 		has_ftr = ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
 		break;
+	case VCPU_FTR_E_PT:
+		has_ftr = ((vcpu->arch.tlbcfg[1] & TLBnCFG_IND) &&
+			   (vcpu->arch.tlbcfg[0] & TLBnCFG_PT));
+		break;
 	default:
 		has_ftr = false;
 	}
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 12b8de2..b10a012 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -317,6 +317,15 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 	case SPRN_MMUCFG:
 		*spr_val = vcpu->arch.mmucfg;
 		break;
+	case SPRN_EPTCFG:
+		if (!has_feature(vcpu, VCPU_FTR_MMU_V2))
+			return EMULATE_FAIL;
+		/*
+		 * Legacy Linux guests access EPTCFG register even if the E.PT
+		 * category is disabled in the VM. Give them a chance to live.
+		 */
+		*spr_val = vcpu->arch.eptcfg;
+		break;
 
 	/* extra exceptions */
 	case SPRN_IVOR32:
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index e354fa1..cf60db1 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -617,6 +617,8 @@ int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 		*val = get_reg_val(id, vcpu->arch.shared->mas6);
 	case KVM_REG_PPC_MMUCFG:
 		*val = get_reg_val(id, vcpu->arch.mmucfg);
+	case KVM_REG_PPC_EPTCFG:
+		*val = get_reg_val(id, vcpu->arch.eptcfg);
 	case KVM_REG_PPC_TLB0CFG:
 	case KVM_REG_PPC_TLB1CFG:
 	case KVM_REG_PPC_TLB2CFG:
@@ -668,6 +670,10 @@ int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 			r = -EINVAL;
 		break;
 	}
+	case KVM_REG_PPC_EPTCFG:
+		if (set_reg_val(id, *val) != vcpu->arch.eptcfg)
+			r = -EINVAL;
+		break;
 	case KVM_REG_PPC_TLB0CFG:
 	case KVM_REG_PPC_TLB1CFG:
 	case KVM_REG_PPC_TLB2CFG:
@@ -861,6 +867,11 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
 	vcpu->arch.tlbcfg[1] |= params[1].ways << TLBnCFG_ASSOC_SHIFT;
 
 	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
+		if (has_feature(vcpu, VCPU_FTR_E_PT))
+			vcpu->arch.eptcfg = mfspr(SPRN_EPTCFG);
+		else
+			vcpu->arch.eptcfg = 0;
+
 		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
 		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
 	}
-- 
1.7.4.1
