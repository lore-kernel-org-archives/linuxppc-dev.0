Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D276E1A002F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 18:17:55 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v2] KVM: PPC: e500: Emulate power management control SPR
Date: Fri, 4 Jul 2014 11:17:28 +0300
Message-ID: <1404461848-31999-1-git-send-email-mihai.caraman@freescale.com>
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

For FSL e6500 core the kernel uses power management SPR register (PWRMGTCR0)
to enable idle power down for cores and devices by setting up the idle count
period at boot time. With the host already controlling the power management
configuration the guest could simply benefit from it, so emulate guest request
as a general store.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - treat the operation as a general store

 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/e500_emulate.c     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 62b2cee..faf2f0e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -584,6 +584,7 @@ struct kvm_vcpu_arch {
 	u32 mmucfg;
 	u32 eptcfg;
 	u32 epr;
+	u32 pwrmgtcr0;
 	u32 crit_save;
 	/* guest debug registers*/
 	struct debug_reg dbg_reg;
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 002d517..c99c40e 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -250,6 +250,14 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
 				spr_val);
 		break;
 
+	case SPRN_PWRMGTCR0:
+		/*
+		 * Guest relies on host power management configurations
+		 * Treat the request as a general store
+		 */
+		vcpu->arch.pwrmgtcr0 = spr_val;
+		break;
+
 	/* extra exceptions */
 	case SPRN_IVOR32:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] = spr_val;
@@ -368,6 +376,10 @@ int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_v
 		*spr_val = vcpu->arch.eptcfg;
 		break;
 
+	case SPRN_PWRMGTCR0:
+		*spr_val = vcpu->arch.pwrmgtcr0;
+		break;
+
 	/* extra exceptions */
 	case SPRN_IVOR32:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL];
-- 
1.7.11.7
