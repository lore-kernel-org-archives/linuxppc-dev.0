Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Mar 2007 13:59:40 +1100
Subject: [PATCH 1/4] powerpc: Cleanup 32 bits map_page
Message-Id: <20070322030114.070AFDDF2A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32 bits map_page() function is used internally by the mm code
for early mmu mappings and for ioremap. It should never be called
for an address that already has a valid PTE or hash entry, so we
add a BUG_ON for that and remove the useless flush_HPTE call.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/mm/pgtable_32.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-cell/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/pgtable_32.c	2007-03-22 13:10:02.000000000 +1100
+++ linux-cell/arch/powerpc/mm/pgtable_32.c	2007-03-22 13:10:49.000000000 +1100
@@ -266,9 +266,12 @@ int map_page(unsigned long va, phys_addr
 	pg = pte_alloc_kernel(pd, va);
 	if (pg != 0) {
 		err = 0;
-		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
-		if (mem_init_done)
-			flush_HPTE(0, va, pmd_val(*pd));
+		/* The PTE should never be already set nor present in the
+		 * hash table
+		 */
+		BUG_ON(pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE));
+		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
+						     __pgprot(flags)));
 	}
 	return err;
 }
