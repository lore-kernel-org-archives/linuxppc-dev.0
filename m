Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE520B7D31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:57 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:46 +1000
Subject: [PATCH 12/20] powerpc/mm: Add hook to flush pgtables when a PTE page
	is freed
Message-Id: <20090723055957.9D90EDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

64-bit BookE will use that hook to maintain the virtually linear
page tables or the indirect entries in the TLB when using the
HW loader.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgalloc.h |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/pgalloc.h	2009-07-22 16:47:46.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgalloc.h	2009-07-22 16:47:49.000000000 +1000
@@ -4,6 +4,12 @@
 
 #include <linux/mm.h>
 
+#ifdef CONFIG_PPC_BOOK3E
+extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address);
+#else
+#define tlb_flush_pgtable(tlb, address)	do { } while(0)
+#endif
+
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
@@ -41,11 +47,16 @@ extern void pgtable_free_tlb(struct mmu_
 #define __pte_free_tlb(tlb,ptepage,address)		\
 do { \
 	pgtable_page_dtor(ptepage); \
+ 	tlb_flush_pgtable(tlb, address);				\
 	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
 					PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); \
 } while (0)
 #else
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, (pte))
+#define __pte_free_tlb(tlb,pte,address)			\
+do { 							\
+	tlb_flush_pgtable(tlb, address);		\
+	pte_free((tlb)->mm, (pte));  			\
+} while (0)
 #endif
 
 
