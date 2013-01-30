Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 880852C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:29:58 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
 initialization earlier
Date: Wed, 30 Jan 2013 15:29:40 +0200
Message-ID: <1359552584-17861-2-git-send-email-mihai.caraman@freescale.com>
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

VCPU's MMUCFG register initialization should not depend on KVM_CAP_SW_TLB
ioctl call. Move it earlier into tlb initalization phase.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500_mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 5c44759..bb1b2b0 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -692,8 +692,6 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 	vcpu_e500->gtlb_offset[0] = 0;
 	vcpu_e500->gtlb_offset[1] = params.tlb_sizes[0];
 
-	vcpu->arch.mmucfg = mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
-
 	vcpu->arch.tlbcfg[0] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
 	if (params.tlb_sizes[0] <= 2048)
 		vcpu->arch.tlbcfg[0] |= params.tlb_sizes[0];
@@ -781,6 +779,8 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	if (!vcpu_e500->g2h_tlb1_map)
 		goto err;
 
+	vcpu->arch.mmucfg = mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
+
 	/* Init TLB configuration register */
 	vcpu->arch.tlbcfg[0] = mfspr(SPRN_TLB0CFG) &
 			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
-- 
1.7.4.1
