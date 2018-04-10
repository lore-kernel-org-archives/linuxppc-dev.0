Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L6Rw37n2zF1x1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:49:00 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id a39-v6so7432342pla.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 05:49:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/5] KVM: PPC: Book3S HV: kvmppc_radix_tlbie_page use
 Linux flush function
Date: Tue, 10 Apr 2018 22:48:39 +1000
Message-Id: <20180410124842.30184-3-npiggin@gmail.com>
In-Reply-To: <20180410124842.30184-1-npiggin@gmail.com>
References: <20180410124842.30184-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This has the advantage of consolidating TLB flush code in fewer
places, and it also implements powerpc:tlbie trace events.

1GB pages should be handled without further modification.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 81d5ad26f9a1..dab6b622011c 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -139,28 +139,16 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	return 0;
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
-#define MMU_BASE_PSIZE	MMU_PAGE_64K
-#else
-#define MMU_BASE_PSIZE	MMU_PAGE_4K
-#endif
-
 static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
 				    unsigned int pshift)
 {
-	int psize = MMU_BASE_PSIZE;
-
-	if (pshift >= PMD_SHIFT)
-		psize = MMU_PAGE_2M;
-	addr &= ~0xfffUL;
-	addr |= mmu_psize_defs[psize].ap << 5;
-	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_TLBIE_5(%0, %1, 0, 0, 1)
-		     : : "r" (addr), "r" (kvm->arch.lpid) : "memory");
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_BUG))
-		asm volatile(PPC_TLBIE_5(%0, %1, 0, 0, 1)
-			     : : "r" (addr), "r" (kvm->arch.lpid) : "memory");
-	asm volatile("eieio ; tlbsync ; ptesync": : :"memory");
+	unsigned long psize = PAGE_SIZE;
+
+	if (pshift)
+		psize = 1UL << pshift;
+
+	addr &= ~(psize - 1);
+	radix__flush_tlb_lpid_page(kvm->arch.lpid, addr, psize);
 }
 
 unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep,
-- 
2.17.0
