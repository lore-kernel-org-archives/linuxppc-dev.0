Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9CD11A069E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 22:55:42 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH] KVM: PPC: e500: Emulate power management control SPR
Date: Mon, 30 Jun 2014 15:55:29 +0300
Message-ID: <1404132929-27308-1-git-send-email-mihai.caraman@freescale.com>
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
as nop.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500_emulate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 002d517..98a22e5 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -250,6 +250,10 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
 				spr_val);
 		break;
 
+	case SPRN_PWRMGTCR0:
+		/* Guest relies on host power management configurations */
+		break;
+
 	/* extra exceptions */
 	case SPRN_IVOR32:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] = spr_val;
@@ -355,6 +359,10 @@ int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_v
 		*spr_val = 0;
 		break;
 
+	case SPRN_PWRMGTCR0:
+		*spr_val = 0;
+		break;
+
 	case SPRN_MMUCFG:
 		*spr_val = vcpu->arch.mmucfg;
 		break;
-- 
1.7.11.7
