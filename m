Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EC5F2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:30:02 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/5] KVM: PPC: e500: Emulate TLBnPS registers
Date: Wed, 30 Jan 2013 15:29:41 +0200
Message-ID: <1359552584-17861-3-git-send-email-mihai.caraman@freescale.com>
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

Emulate TLBnPS registers which are available in MMU Architecture Version
(MAV) 2.0.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kvm/e500.h             |    5 +++++
 arch/powerpc/kvm/e500_emulate.c     |   10 ++++++++++
 arch/powerpc/kvm/e500_mmu.c         |    5 +++++
 4 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8a72d59..88fcfe6 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -501,6 +501,7 @@ struct kvm_vcpu_arch {
 	spinlock_t wdt_lock;
 	struct timer_list wdt_timer;
 	u32 tlbcfg[4];
+	u32 tlbps[4];
 	u32 mmucfg;
 	u32 epr;
 	struct kvmppc_booke_debug_reg dbg_reg;
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 41cefd4..b9f76d8 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -303,4 +303,9 @@ static inline unsigned int get_tlbmiss_tid(struct kvm_vcpu *vcpu)
 #define get_tlb_sts(gtlbe)              (MAS1_TS)
 #endif /* !BOOKE_HV */
 
+static inline unsigned int has_mmu_v2(const struct kvm_vcpu *vcpu)
+{
+	return ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
+}
+
 #endif /* KVM_E500_H */
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index e78f353..5515dc5 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -329,6 +329,16 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_DBELL_CRIT];
 		break;
 #endif
+	case SPRN_TLB0PS:
+		if (!has_mmu_v2(vcpu))
+			return EMULATE_FAIL;
+		*spr_val = vcpu->arch.tlbps[0];
+		break;
+	case SPRN_TLB1PS:
+		if (!has_mmu_v2(vcpu))
+			return EMULATE_FAIL;
+		*spr_val = vcpu->arch.tlbps[1];
+		break;
 	default:
 		emulated = kvmppc_booke_emulate_mfspr(vcpu, sprn, spr_val);
 	}
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index bb1b2b0..129299a 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -794,6 +794,11 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	vcpu->arch.tlbcfg[1] |=
 		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
 
+	if (has_mmu_v2(vcpu)) {
+		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
+		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
+	}
+
 	kvmppc_recalc_tlb1map_range(vcpu_e500);
 	return 0;
 
-- 
1.7.4.1
