Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:45:51 +1100
Subject: [PATCH 1/11] powerpc: Unconfuse htab_bolt_mapping() callers
Message-Id: <1142934351.193140.181086235013.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

htab_bolt_mapping() takes a vstart and pstart parameter, but all but one of
its callers actually pass it vstart and vstart. Luckily before it passes
paddr (calculated from paddr) to the hpte_insert routines it calls
virt_to_abs() (aka. __pa()) on the address, so there isn't actually a bug.

map_io_page() however does pass pstart properly, so currently it's broken
AFAICT because we're calling __pa(paddr) which will get us something very
large. Presumably no one's calling map_io_page() in the right context.

Anyway, change htab_bolt_mapping() callers to properly pass pstart, and then
use it properly in htab_bolt_mapping(), ie. don't call __pa() on it again.

Booted on p5 LPAR, iSeries and Power3.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/hash_utils_64.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

Index: to-merge/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_utils_64.c
+++ to-merge/arch/powerpc/mm/hash_utils_64.c
@@ -169,7 +169,7 @@ int htab_bolt_mapping(unsigned long vsta
 #ifdef CONFIG_PPC_ISERIES
 		if (_machine == PLATFORM_ISERIES_LPAR)
 			ret = iSeries_hpte_insert(hpteg, va,
-						  __pa(vaddr),
+						  paddr,
 						  tmp_mode,
 						  HPTE_V_BOLTED,
 						  psize);
@@ -178,7 +178,7 @@ int htab_bolt_mapping(unsigned long vsta
 #ifdef CONFIG_PPC_PSERIES
 		if (_machine & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
-						       virt_to_abs(paddr),
+						       paddr,
 						       tmp_mode,
 						       HPTE_V_BOLTED,
 						       psize);
@@ -186,7 +186,7 @@ int htab_bolt_mapping(unsigned long vsta
 #endif
 #ifdef CONFIG_PPC_MULTIPLATFORM
 			ret = native_hpte_insert(hpteg, va,
-						 virt_to_abs(paddr),
+						 paddr,
 						 tmp_mode, HPTE_V_BOLTED,
 						 psize);
 #endif
@@ -392,7 +392,7 @@ static unsigned long __init htab_get_tab
 #ifdef CONFIG_MEMORY_HOTPLUG
 void create_section_mapping(unsigned long start, unsigned long end)
 {
-		BUG_ON(htab_bolt_mapping(start, end, start,
+		BUG_ON(htab_bolt_mapping(start, end, __pa(start),
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX,
 			mmu_linear_psize));
 }
@@ -473,21 +473,22 @@ void __init htab_initialize(void)
 
 		if (dart_tablebase != 0 && dart_tablebase >= base
 		    && dart_tablebase < (base + size)) {
+			unsigned long dart_table_end = dart_tablebase + 16 * MB;
 			if (base != dart_tablebase)
 				BUG_ON(htab_bolt_mapping(base, dart_tablebase,
-							 base, mode_rw,
-							 mmu_linear_psize));
-			if ((base + size) > (dart_tablebase + 16*MB))
+							__pa(base), mode_rw,
+							mmu_linear_psize));
+			if ((base + size) > dart_table_end)
 				BUG_ON(htab_bolt_mapping(dart_tablebase+16*MB,
-							 base + size,
-							 dart_tablebase+16*MB,
+							base + size,
+							__pa(dart_table_end),
 							 mode_rw,
 							 mmu_linear_psize));
 			continue;
 		}
 #endif /* CONFIG_U3_DART */
-		BUG_ON(htab_bolt_mapping(base, base + size, base,
-					 mode_rw, mmu_linear_psize));
+		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
+					mode_rw, mmu_linear_psize));
        }
 
 	/*
@@ -504,8 +505,8 @@ void __init htab_initialize(void)
 		if (base + size >= tce_alloc_start)
 			tce_alloc_start = base + size + 1;
 
- 		BUG_ON(htab_bolt_mapping(tce_alloc_start, tce_alloc_end,
- 					 tce_alloc_start, mode_rw,
+		BUG_ON(htab_bolt_mapping(tce_alloc_start, tce_alloc_end,
+					 __pa(tce_alloc_start), mode_rw,
 					 mmu_linear_psize));
 	}
 
