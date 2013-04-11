Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDC052C0110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:19 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 5/8] KVM: PPC: e500: Add support for EPTCFG register
Date: Thu, 11 Apr 2013 13:03:11 +0300
Message-ID: <1365674594-17410-6-git-send-email-mihai.caraman@freescale.com>
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

EPTCFG register defined by E.PT is accessed unconditionally by Linux guests
in the presence of MAV 2.0. Emulate it now.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - Initialize EPTCFG to 0 since E.PT is not supported now

 Documentation/virtual/kvm/api.txt   |    1 +
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/include/uapi/asm/kvm.h |    1 +
 arch/powerpc/kvm/e500_emulate.c     |    9 +++++++++
 arch/powerpc/kvm/e500_mmu.c         |   12 ++++++++++++
 5 files changed, 24 insertions(+), 0 deletions(-)

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
index 91341d9..7f4d191 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -446,5 +446,6 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_TLB1PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x98)
 #define KVM_REG_PPC_TLB2PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x99)
 #define KVM_REG_PPC_TLB3PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x9a)
+#define KVM_REG_PPC_EPTCFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x9b)
 
 #endif /* __LINUX_KVM_POWERPC_H */
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
index a863dc1..1c1c5cb 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -624,6 +624,9 @@ int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_MMUCFG:
 		*val = get_reg_val(id, vcpu->arch.mmucfg);
 		break;
+	case KVM_REG_PPC_EPTCFG:
+		*val = get_reg_val(id, vcpu->arch.eptcfg);
+		break;
 	case KVM_REG_PPC_TLB0CFG:
 	case KVM_REG_PPC_TLB1CFG:
 	case KVM_REG_PPC_TLB2CFG:
@@ -678,6 +681,12 @@ int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 			r = -EINVAL;
 		break;
 	}
+	case KVM_REG_PPC_EPTCFG: {
+		u32 reg = set_reg_val(id, *val);
+		if (reg != vcpu->arch.eptcfg)
+			r = -EINVAL;
+		break;
+	}
 	case KVM_REG_PPC_TLB0CFG:
 	case KVM_REG_PPC_TLB1CFG:
 	case KVM_REG_PPC_TLB2CFG:
@@ -875,6 +884,9 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
 	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
 		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
 		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
+
+		/* Guest mmu emulation currently doesn't handle E.PT */
+		vcpu->arch.eptcfg = 0;
 	}
 
 	return 0;
-- 
1.7.4.1
