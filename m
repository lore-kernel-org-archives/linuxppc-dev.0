Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74A6C2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:17 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/8 v3] KVM: PPC: e500: Move vcpu's MMU configuration to
 dedicated functions
Date: Thu, 11 Apr 2013 13:03:09 +0300
Message-ID: <1365674594-17410-4-git-send-email-mihai.caraman@freescale.com>
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

Vcpu's MMU default configuration and geometry update logic was buried in
a chunk of code. Move them to dedicated functions to add more clarity.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - No change

v2:
 - Add better patch description

 arch/powerpc/kvm/e500_mmu.c |   60 +++++++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 44f7762..08a5b0d 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -690,6 +690,20 @@ int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
+static int vcpu_mmu_geometry_update(struct kvm_vcpu *vcpu,
+		struct kvm_book3e_206_tlb_params *params)
+{
+	vcpu->arch.tlbcfg[0] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+	if (params->tlb_sizes[0] <= 2048)
+		vcpu->arch.tlbcfg[0] |= params->tlb_sizes[0];
+	vcpu->arch.tlbcfg[0] |= params->tlb_ways[0] << TLBnCFG_ASSOC_SHIFT;
+
+	vcpu->arch.tlbcfg[1] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+	vcpu->arch.tlbcfg[1] |= params->tlb_sizes[1];
+	vcpu->arch.tlbcfg[1] |= params->tlb_ways[1] << TLBnCFG_ASSOC_SHIFT;
+	return 0;
+}
+
 int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 			      struct kvm_config_tlb *cfg)
 {
@@ -786,16 +800,8 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 	vcpu_e500->gtlb_offset[0] = 0;
 	vcpu_e500->gtlb_offset[1] = params.tlb_sizes[0];
 
-	vcpu->arch.mmucfg = mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
-
-	vcpu->arch.tlbcfg[0] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
-	if (params.tlb_sizes[0] <= 2048)
-		vcpu->arch.tlbcfg[0] |= params.tlb_sizes[0];
-	vcpu->arch.tlbcfg[0] |= params.tlb_ways[0] << TLBnCFG_ASSOC_SHIFT;
-
-	vcpu->arch.tlbcfg[1] &= ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
-	vcpu->arch.tlbcfg[1] |= params.tlb_sizes[1];
-	vcpu->arch.tlbcfg[1] |= params.tlb_ways[1] << TLBnCFG_ASSOC_SHIFT;
+	/* Update vcpu's MMU geometry based on SW_TLB input */
+	vcpu_mmu_geometry_update(vcpu, &params);
 
 	vcpu_e500->shared_tlb_pages = pages;
 	vcpu_e500->num_shared_tlb_pages = num_pages;
@@ -831,6 +837,27 @@ int kvm_vcpu_ioctl_dirty_tlb(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/* Vcpu's MMU default configuration */
+static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
+		       struct kvmppc_e500_tlb_params *params)
+{
+	/* Initialize RASIZE, PIDSIZE, NTLBS and MAVN fields with host values*/
+	vcpu->arch.mmucfg = mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
+
+	/* Initialize TLBnCFG fields with host values and SW_TLB geometry*/
+	vcpu->arch.tlbcfg[0] = mfspr(SPRN_TLB0CFG) &
+			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+	vcpu->arch.tlbcfg[0] |= params[0].entries;
+	vcpu->arch.tlbcfg[0] |= params[0].ways << TLBnCFG_ASSOC_SHIFT;
+
+	vcpu->arch.tlbcfg[1] = mfspr(SPRN_TLB1CFG) &
+			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
+	vcpu->arch.tlbcfg[1] |= params[1].entries;
+	vcpu->arch.tlbcfg[1] |= params[1].ways << TLBnCFG_ASSOC_SHIFT;
+
+	return 0;
+}
+
 int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 {
 	struct kvm_vcpu *vcpu = &vcpu_e500->vcpu;
@@ -875,18 +902,7 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	if (!vcpu_e500->g2h_tlb1_map)
 		goto err;
 
-	/* Init TLB configuration register */
-	vcpu->arch.tlbcfg[0] = mfspr(SPRN_TLB0CFG) &
-			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
-	vcpu->arch.tlbcfg[0] |= vcpu_e500->gtlb_params[0].entries;
-	vcpu->arch.tlbcfg[0] |=
-		vcpu_e500->gtlb_params[0].ways << TLBnCFG_ASSOC_SHIFT;
-
-	vcpu->arch.tlbcfg[1] = mfspr(SPRN_TLB1CFG) &
-			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
-	vcpu->arch.tlbcfg[1] |= vcpu_e500->gtlb_params[1].entries;
-	vcpu->arch.tlbcfg[1] |=
-		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
+	vcpu_mmu_init(vcpu, vcpu_e500->gtlb_params);
 
 	kvmppc_recalc_tlb1map_range(vcpu_e500);
 	return 0;
-- 
1.7.4.1
