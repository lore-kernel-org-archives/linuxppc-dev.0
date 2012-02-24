Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05180B7004
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:51 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 34/37] KVM: PPC: e500: fix typo in tlb code
Date: Fri, 24 Feb 2012 15:26:28 +0100
Message-Id: <1330093591-19523-35-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The tlbncfg registers should be populated with their respective TLB's
values. Fix the obvious typo.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/e500_tlb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 279e10a..e05232b 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -1268,8 +1268,8 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 
 	vcpu->arch.tlbcfg[1] = mfspr(SPRN_TLB1CFG) &
 			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
-	vcpu->arch.tlbcfg[0] |= vcpu_e500->gtlb_params[1].entries;
-	vcpu->arch.tlbcfg[0] |=
+	vcpu->arch.tlbcfg[1] |= vcpu_e500->gtlb_params[1].entries;
+	vcpu->arch.tlbcfg[1] |=
 		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
 
 	return 0;
-- 
1.6.0.2
