Return-Path: <yang.shi@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 331E6B7130
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 12:56:00 +1000 (EST)
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B8B87DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 12:55:58 +1000 (EST)
From: Yang Shi <yang.shi@windriver.com>
To: yu.liu@freescale.com, hollisb@us.ibm.com, avi@redhat.com
Subject: [PATCH 1/2] KVM/PPC: Fix PPC KVM e500_tlb.c build error
Date: Thu,  2 Jul 2009 10:55:29 +0800
Message-Id: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since include/asm/mmu-fsl-booke.h was replaced by include/asm/mmu-book3e.h,
fix e500_tlb.h to reflect the change and fix e500_tlb.c to align with the
new page size macro definition in include/asm/mmu-book3e.h.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/powerpc/kvm/e500_tlb.c |    8 ++++----
 arch/powerpc/kvm/e500_tlb.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 0e773fc..616762b 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -309,7 +309,7 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	vcpu_e500->shadow_pages[tlbsel][esel] = new_page;
 
 	/* Force TS=1 IPROT=0 TSIZE=4KB for all guest mappings. */
-	stlbe->mas1 = MAS1_TSIZE(BOOKE_PAGESZ_4K)
+	stlbe->mas1 = MAS1_TSIZE(BOOK3E_PAGESZ_4K)
 		| MAS1_TID(get_tlb_tid(gtlbe)) | MAS1_TS | MAS1_VALID;
 	stlbe->mas2 = (gvaddr & MAS2_EPN)
 		| e500_shadow_mas2_attrib(gtlbe->mas2,
@@ -545,7 +545,7 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
 		case 0:
 			/* TLB0 */
 			gtlbe->mas1 &= ~MAS1_TSIZE(~0);
-			gtlbe->mas1 |= MAS1_TSIZE(BOOKE_PAGESZ_4K);
+			gtlbe->mas1 |= MAS1_TSIZE(BOOK3E_PAGESZ_4K);
 
 			stlbsel = 0;
 			sesel = kvmppc_e500_stlbe_map(vcpu_e500, 0, esel);
@@ -679,14 +679,14 @@ void kvmppc_e500_tlb_setup(struct kvmppc_vcpu_e500 *vcpu_e500)
 
 	/* Insert large initial mapping for guest. */
 	tlbe = &vcpu_e500->guest_tlb[1][0];
-	tlbe->mas1 = MAS1_VALID | MAS1_TSIZE(BOOKE_PAGESZ_256M);
+	tlbe->mas1 = MAS1_VALID | MAS1_TSIZE(BOOK3E_PAGESZ_256M);
 	tlbe->mas2 = 0;
 	tlbe->mas3 = E500_TLB_SUPER_PERM_MASK;
 	tlbe->mas7 = 0;
 
 	/* 4K map for serial output. Used by kernel wrapper. */
 	tlbe = &vcpu_e500->guest_tlb[1][1];
-	tlbe->mas1 = MAS1_VALID | MAS1_TSIZE(BOOKE_PAGESZ_4K);
+	tlbe->mas1 = MAS1_VALID | MAS1_TSIZE(BOOK3E_PAGESZ_4K);
 	tlbe->mas2 = (0xe0004500 & 0xFFFFF000) | MAS2_I | MAS2_G;
 	tlbe->mas3 = (0xe0004500 & 0xFFFFF000) | E500_TLB_SUPER_PERM_MASK;
 	tlbe->mas7 = 0;
diff --git a/arch/powerpc/kvm/e500_tlb.h b/arch/powerpc/kvm/e500_tlb.h
index 45b064b..abb1bf8 100644
--- a/arch/powerpc/kvm/e500_tlb.h
+++ b/arch/powerpc/kvm/e500_tlb.h
@@ -16,7 +16,7 @@
 #define __KVM_E500_TLB_H__
 
 #include <linux/kvm_host.h>
-#include <asm/mmu-fsl-booke.h>
+#include <asm/mmu-book3e.h>
 #include <asm/tlb.h>
 #include <asm/kvm_e500.h>
 
-- 
1.6.0.4
