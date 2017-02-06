Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGrPQ6Xh0zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:04:10 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGrPQ1t9kz9ryk
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 13:04:10 +1100 (AEDT)
Message-ID: <1486346641.4850.81.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix holes in DD1 TLB workarounds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Neuling
 <michael.neuling@au1.ibm.com>
Date: Mon, 06 Feb 2017 13:04:01 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch gets rid of the the TLB multihits observed in the lab.

Sadly it does disable whatever remaining optimizations we had for
TLB invalidations. It fixes 2 problems:

 - We do sadly need to invalidate in radix__pte_update() even when
the new pte is clear because what might happen otherwise is that we
clear a bunch of PTEs, we drop the PTL, then before we get to do
the flush_tlb_mm(), another thread puts/faults some new things in.
It's rather unlikely and probably requires funky mappings blown by
unmap_mapping_range() (otherwise we probably are protected by the
mmap sem) but possible.

 - In some rare cases we call set_pte_at() on top of a protnone PTE
which is valid, and thus we need to apply the workaround.

Now, I'm working on ways to restore batching by instead coping with
the multi-hits after the fact, but this hasn't yet been proven solid
so this will have to do in the meantime.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index b4d1302..b17d4a1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -149,7 +149,7 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		 * the below sequence and batch the tlb flush. The
 		 * tlb flush batching is done by mmu gather code
 		 */
-		if (new_pte) {
+		if (1 || new_pte) {
 			asm volatile("ptesync" : : : "memory");
 			radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
 			__radix_pte_update(ptep, 0, new_pte);
@@ -179,7 +179,7 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 
 		unsigned long old_pte, new_pte;
 
-		old_pte = __radix_pte_update(ptep, ~0, 0);
+		old_pte = __radix_pte_update(ptep, ~0ul, 0);
 		asm volatile("ptesync" : : : "memory");
 		/*
 		 * new value of pte
@@ -202,9 +202,18 @@ static inline int radix__pte_none(pte_t pte)
 	return (pte_val(pte) & ~RADIX_PTE_NONE_MASK) == 0;
 }
 
+static inline int __pte_present(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
+}
 static inline void radix__set_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, int percpu)
 {
+	if (__pte_present(*ptep)) {
+		unsigned long old_pte = __radix_pte_update(ptep, ~0ul, 0);
+                asm volatile("ptesync" : : : "memory");
+		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
+	}
 	*ptep = pte;
 	asm volatile("ptesync" : : : "memory");
 }
