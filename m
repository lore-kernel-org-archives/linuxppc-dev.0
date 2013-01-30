Return-Path: <B02008@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67FBB2C011B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:30:06 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 4/5] KVM: PPC: e500: Emulate EPTCFG register
Date: Wed, 30 Jan 2013 15:29:43 +0200
Message-ID: <1359552584-17861-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
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
in the presence of MAV 2.0. Emulate EPTCFG register now.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kvm/e500.h             |    6 ++++++
 arch/powerpc/kvm/e500_emulate.c     |    9 +++++++++
 arch/powerpc/kvm/e500_mmu.c         |    5 +++++
 4 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 88fcfe6..f480b20 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -503,6 +503,7 @@ struct kvm_vcpu_arch {
 	u32 tlbcfg[4];
 	u32 tlbps[4];
 	u32 mmucfg;
+	u32 eptcfg;
 	u32 epr;
 	struct kvmppc_booke_debug_reg dbg_reg;
 #endif
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index b9f76d8..983eb95 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -308,4 +308,10 @@ static inline unsigned int has_mmu_v2(const struct kvm_vcpu *vcpu)
 	return ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
 }
 
+static inline unsigned int supports_page_tables(const struct kvm_vcpu *vcpu)
+{
+	return ((vcpu->arch.tlbcfg[0] & TLBnCFG_IND)
+		|| (vcpu->arch.tlbcfg[1] & TLBnCFG_IND));
+}
+
 #endif /* KVM_E500_H */
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 5515dc5..493e231 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -339,6 +339,15 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 			return EMULATE_FAIL;
 		*spr_val = vcpu->arch.tlbps[1];
 		break;
+	case SPRN_EPTCFG:
+		if (!has_mmu_v2(vcpu))
+			return EMULATE_FAIL;
+		/*
+		 * Legacy Linux guests access EPTCFG register even if the E.PT
+		 * category is disabled in the VM. Give them a chance to live.
+		 */
+		*spr_val = vcpu->arch.eptcfg;
+		break;
 	default:
 		emulated = kvmppc_booke_emulate_mfspr(vcpu, sprn, spr_val);
 	}
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 9a1f7b7..199c11e 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -799,6 +799,11 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	if (has_mmu_v2(vcpu)) {
 		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
 		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
+
+		if (supports_page_tables(vcpu))
+			vcpu->arch.eptcfg = mfspr(SPRN_EPTCFG);
+		else
+			vcpu->arch.eptcfg = 0;
 	}
 
 	kvmppc_recalc_tlb1map_range(vcpu_e500);
-- 
1.7.4.1
