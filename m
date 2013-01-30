Return-Path: <B02008@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8982A2C0115
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:30:05 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/5] KVM: PPC: e500: Remove E.PT category from VCPUs
Date: Wed, 30 Jan 2013 15:29:42 +0200
Message-ID: <1359552584-17861-4-git-send-email-mihai.caraman@freescale.com>
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

Embedded.Page Table (E.PT) category in VMs requires indirect tlb entries
emulation which is not supported yet. Configure TLBnCFG to remove E.PT
category from VCPUs.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500_mmu.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 129299a..9a1f7b7 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -692,12 +692,14 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 	vcpu_e500->gtlb_offset[0] = 0;
 	vcpu_e500->gtlb_offset[1] = params.tlb_sizes[0];
 
-	vcpu->arch.tlbcfg[0] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+	vcpu->arch.tlbcfg[0] &=
+			      ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | TLBnCFG_IND);
 	if (params.tlb_sizes[0] <= 2048)
 		vcpu->arch.tlbcfg[0] |= params.tlb_sizes[0];
 	vcpu->arch.tlbcfg[0] |= params.tlb_ways[0] << TLBnCFG_ASSOC_SHIFT;
 
-	vcpu->arch.tlbcfg[1] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+	vcpu->arch.tlbcfg[1] &=
+			      ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | TLBnCFG_IND);
 	vcpu->arch.tlbcfg[1] |= params.tlb_sizes[1];
 	vcpu->arch.tlbcfg[1] |= params.tlb_ways[1] << TLBnCFG_ASSOC_SHIFT;
 
@@ -783,13 +785,13 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 
 	/* Init TLB configuration register */
 	vcpu->arch.tlbcfg[0] = mfspr(SPRN_TLB0CFG) &
-			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | TLBnCFG_IND);
 	vcpu->arch.tlbcfg[0] |= vcpu_e500->gtlb_params[0].entries;
 	vcpu->arch.tlbcfg[0] |=
 		vcpu_e500->gtlb_params[0].ways << TLBnCFG_ASSOC_SHIFT;
 
 	vcpu->arch.tlbcfg[1] = mfspr(SPRN_TLB1CFG) &
-			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | TLBnCFG_IND);
 	vcpu->arch.tlbcfg[1] |= vcpu_e500->gtlb_params[1].entries;
 	vcpu->arch.tlbcfg[1] |=
 		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
-- 
1.7.4.1
