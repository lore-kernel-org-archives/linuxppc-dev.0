Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18614.18410.958014.376185@cargo.ozlabs.ibm.com>
Date: Thu, 28 Aug 2008 16:38:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Only make kernel text pages of linear mapping
	executable
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit bc033b63bbfeb6c4b4eb0a1d083c650e4a0d2af8 ("powerpc/mm: Fix
attribute confusion with htab_bolt_mapping()") moved the check for
whether we should make pages of the linear mapping executable from
htab_bolt_mapping into its callers, including htab_initialize.
A side-effect of this is that the decision is now made once for
each contiguous section in the LMB array rather than for each page
individually.  This can often mean that the whole of the linear
mapping ends up being executable.

This reverts to the previous behaviour, where individual pages are
checked for being part of the kernel text or not, by moving the check
back down into htab_bolt_mapping.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 14be408..1fe7ac6 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -191,12 +191,17 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 		unsigned long hash, hpteg;
 		unsigned long vsid = get_kernel_vsid(vaddr, ssize);
 		unsigned long va = hpt_va(vaddr, vsid, ssize);
+		unsigned long tprot = prot;
+
+		/* Only kernel text is executable */
+		if (!in_kernel_text(vaddr))
+			tprot |= HPTE_R_N;
 
 		hash = hpt_hash(va, shift, ssize);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 		BUG_ON(!ppc_md.hpte_insert);
-		ret = ppc_md.hpte_insert(hpteg, va, paddr, prot,
+		ret = ppc_md.hpte_insert(hpteg, va, paddr, tprot,
 					 HPTE_V_BOLTED, psize, ssize);
 
 		if (ret < 0)
@@ -584,7 +589,7 @@ void __init htab_initialize(void)
 {
 	unsigned long table;
 	unsigned long pteg_count;
-	unsigned long prot, tprot;
+	unsigned long prot;
 	unsigned long base = 0, size = 0, limit;
 	int i;
 
@@ -660,10 +665,9 @@ void __init htab_initialize(void)
 	for (i=0; i < lmb.memory.cnt; i++) {
 		base = (unsigned long)__va(lmb.memory.region[i].base);
 		size = lmb.memory.region[i].size;
-		tprot = prot | (in_kernel_text(base) ? _PAGE_EXEC : 0);
 
 		DBG("creating mapping for region: %lx..%lx (prot: %x)\n",
-		    base, size, tprot);
+		    base, size, prot);
 
 #ifdef CONFIG_U3_DART
 		/* Do not map the DART space. Fortunately, it will be aligned
@@ -680,21 +684,21 @@ void __init htab_initialize(void)
 			unsigned long dart_table_end = dart_tablebase + 16 * MB;
 			if (base != dart_tablebase)
 				BUG_ON(htab_bolt_mapping(base, dart_tablebase,
-							__pa(base), tprot,
+							__pa(base), prot,
 							mmu_linear_psize,
 							mmu_kernel_ssize));
 			if ((base + size) > dart_table_end)
 				BUG_ON(htab_bolt_mapping(dart_tablebase+16*MB,
 							base + size,
 							__pa(dart_table_end),
-							 tprot,
+							 prot,
 							 mmu_linear_psize,
 							 mmu_kernel_ssize));
 			continue;
 		}
 #endif /* CONFIG_U3_DART */
 		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
-				tprot, mmu_linear_psize, mmu_kernel_ssize));
+				prot, mmu_linear_psize, mmu_kernel_ssize));
        }
 
 	/*
