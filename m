Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMDXK3fv8zDrjJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 21:25:53 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e3so2055012pfc.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 04:25:53 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 1/3] arch/powerpc/set_memory: Implement set_memory_xx
 routines
Date: Tue,  1 Aug 2017 21:25:33 +1000
Message-Id: <20170801112535.20765-2-bsingharora@gmail.com>
In-Reply-To: <20170801112535.20765-1-bsingharora@gmail.com>
References: <20170801112535.20765-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for set_memory_xx routines. With the STRICT_KERNEL_RWX
feature support we got support for changing the page permissions
for pte ranges. This patch adds support for both radix and hash
so that we can change their permissions via set/clear masks.

A new helper is required for hash (hash__change_memory_range()
is changed to hash__change_boot_memory_range() as it deals with
bolted PTE's).

hash__change_memory_range() works with vmalloc'ed PAGE_SIZE requests
for permission changes. hash__change_memory_range() does not invoke
updatepp, instead it changes the software PTE and invalidates the PTE.

For radix, radix__change_memory_range() is setup to do the right
thing for vmalloc'd addresses. It takes a new parameter to decide
what attributes to set.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h  |  6 +++
 arch/powerpc/include/asm/book3s/64/radix.h |  6 +++
 arch/powerpc/include/asm/set_memory.h      | 34 +++++++++++++++
 arch/powerpc/mm/pgtable-hash64.c           | 51 ++++++++++++++++++++--
 arch/powerpc/mm/pgtable-radix.c            | 26 ++++++------
 arch/powerpc/mm/pgtable_64.c               | 68 ++++++++++++++++++++++++++++++
 6 files changed, 175 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/include/asm/set_memory.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 36fc7bf..65003c9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -94,6 +94,12 @@ extern void hash__mark_rodata_ro(void);
 extern void hash__mark_initmem_nx(void);
 #endif
 
+/*
+ * For set_memory_*
+ */
+extern int hash__change_memory_range(unsigned long start, unsigned long end,
+				     unsigned long set, unsigned long clear);
+
 extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned long pte, int huge);
 extern unsigned long htab_convert_pte_flags(unsigned long pteflags);
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 544440b..5ca0636 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -121,6 +121,12 @@ extern void radix__mark_rodata_ro(void);
 extern void radix__mark_initmem_nx(void);
 #endif
 
+/*
+ * For set_memory_*
+ */
+extern int radix__change_memory_range(unsigned long start, unsigned long end,
+				      unsigned long set, unsigned long clear);
+
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
 {
diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
new file mode 100644
index 0000000..b19c67c
--- /dev/null
+++ b/arch/powerpc/include/asm/set_memory.h
@@ -0,0 +1,34 @@
+/*
+ * set_memory.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * Copyright IBM Corporation, 2017
+ *
+ * Authors: Balbir Singh <bsingharora@gmail.com>
+ */
+
+#ifndef __ASM_SET_MEMORY_H
+#define __ASM_SET_MEMORY_H
+
+/*
+ * Functions to change memory attributes.
+ */
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
+
+#endif
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 656f7f3..db5b477 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -424,9 +424,52 @@ int hash__has_transparent_hugepage(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+/*
+ * This routine will change pte protection only for vmalloc'd
+ * PAGE_SIZE pages, do not invoke for bolted pages
+ */
+int hash__change_memory_range(unsigned long start, unsigned long end,
+				unsigned long set, unsigned long clear)
+{
+	unsigned long idx;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	start = ALIGN_DOWN(start, PAGE_SIZE);
+	end = PAGE_ALIGN(end); // aligns up
+
+	/*
+	 * Update the software PTE and flush the entry.
+	 * This should cause a new fault with the right
+	 * things setup in the hash page table
+	 */
+	pr_debug("Changing flags on range %lx-%lx setting 0x%lx removing 0x%lx\n",
+		 start, end, set, clear);
+
+	for (idx = start; idx < end; idx += PAGE_SIZE) {
+		pgdp = pgd_offset_k(idx);
+		pudp = pud_alloc(&init_mm, pgdp, idx);
+		if (!pudp)
+			return -1;
+		pmdp = pmd_alloc(&init_mm, pudp, idx);
+		if (!pmdp)
+			return -1;
+		ptep = pte_alloc_kernel(pmdp, idx);
+		if (!ptep)
+			return -1;
+		hash__pte_update(&init_mm, idx, ptep, clear, set, 0);
+		hash__flush_tlb_kernel_range(idx, idx + PAGE_SIZE);
+	}
+	return 0;
+
+}
+EXPORT_SYMBOL(hash__change_memory_range);
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
-static bool hash__change_memory_range(unsigned long start, unsigned long end,
-				      unsigned long newpp)
+bool hash__change_boot_memory_range(unsigned long start, unsigned long end,
+				unsigned long newpp)
 {
 	unsigned long idx;
 	unsigned int step, shift;
@@ -482,7 +525,7 @@ void hash__mark_rodata_ro(void)
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
-	WARN_ON(!hash__change_memory_range(start, end, PP_RXXX));
+	WARN_ON(!hash__change_boot_memory_range(start, end, PP_RXXX));
 }
 
 void hash__mark_initmem_nx(void)
@@ -494,6 +537,6 @@ void hash__mark_initmem_nx(void)
 
 	pp = htab_convert_pte_flags(pgprot_val(PAGE_KERNEL));
 
-	WARN_ON(!hash__change_memory_range(start, end, pp));
+	WARN_ON(!hash__change_boot_memory_range(start, end, pp));
 }
 #endif
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6e0176d..0e66324 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -114,9 +114,8 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 	return 0;
 }
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void radix__change_memory_range(unsigned long start, unsigned long end,
-				unsigned long clear)
+int radix__change_memory_range(unsigned long start, unsigned long end,
+				unsigned long set, unsigned long clear)
 {
 	unsigned long idx;
 	pgd_t *pgdp;
@@ -127,35 +126,38 @@ void radix__change_memory_range(unsigned long start, unsigned long end,
 	start = ALIGN_DOWN(start, PAGE_SIZE);
 	end = PAGE_ALIGN(end); // aligns up
 
-	pr_debug("Changing flags on range %lx-%lx removing 0x%lx\n",
-		 start, end, clear);
+	pr_debug("Changing flags on range %lx-%lx setting 0x%lx removing 0x%lx\n",
+		 start, end, set, clear);
 
 	for (idx = start; idx < end; idx += PAGE_SIZE) {
 		pgdp = pgd_offset_k(idx);
 		pudp = pud_alloc(&init_mm, pgdp, idx);
 		if (!pudp)
-			continue;
+			return -1;
 		if (pud_huge(*pudp)) {
 			ptep = (pte_t *)pudp;
 			goto update_the_pte;
 		}
 		pmdp = pmd_alloc(&init_mm, pudp, idx);
 		if (!pmdp)
-			continue;
+			return -1;
 		if (pmd_huge(*pmdp)) {
 			ptep = pmdp_ptep(pmdp);
 			goto update_the_pte;
 		}
 		ptep = pte_alloc_kernel(pmdp, idx);
 		if (!ptep)
-			continue;
+			return -1;
 update_the_pte:
-		radix__pte_update(&init_mm, idx, ptep, clear, 0, 0);
+		radix__pte_update(&init_mm, idx, ptep, clear, set, 0);
 	}
 
 	radix__flush_tlb_kernel_range(start, end);
+	return 0;
 }
+EXPORT_SYMBOL(radix__change_memory_range);
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void radix__mark_rodata_ro(void)
 {
 	unsigned long start, end;
@@ -163,12 +165,12 @@ void radix__mark_rodata_ro(void)
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
-	radix__change_memory_range(start, end, _PAGE_WRITE);
+	radix__change_memory_range(start, end, 0, _PAGE_WRITE);
 
 	start = (unsigned long)__start_interrupts - PHYSICAL_START;
 	end = (unsigned long)__end_interrupts - PHYSICAL_START;
 
-	radix__change_memory_range(start, end, _PAGE_WRITE);
+	radix__change_memory_range(start, end, 0, _PAGE_WRITE);
 }
 
 
@@ -177,7 +179,7 @@ void radix__mark_initmem_nx(void)
 	unsigned long start = (unsigned long)__init_begin;
 	unsigned long end = (unsigned long)__init_end;
 
-	radix__change_memory_range(start, end, _PAGE_EXEC);
+	radix__change_memory_range(start, end, 0, _PAGE_EXEC);
 }
 
 #endif /* CONFIG_STRICT_KERNEL_RWX */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0736e94..3ee4c7d 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -514,3 +514,71 @@ void mark_initmem_nx(void)
 		hash__mark_initmem_nx();
 }
 #endif
+
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+/*
+ * Some of these bits are taken from arm64/mm/page_attr.c
+ */
+static int change_memory_common(unsigned long addr, int numpages,
+				unsigned long set, unsigned long clear)
+{
+	unsigned long start = addr;
+	unsigned long size = PAGE_SIZE*numpages;
+	unsigned long end = start + size;
+	struct vm_struct *area;
+
+	if (!PAGE_ALIGNED(addr)) {
+		start &= PAGE_MASK;
+		end = start + size;
+		WARN_ON_ONCE(1);
+	}
+
+	/*
+	 * So check whether the [addr, addr + size) interval is entirely
+	 * covered by precisely one VM area that has the VM_ALLOC flag set.
+	 */
+	area = find_vm_area((void *)addr);
+	if (!area ||
+	    end > (unsigned long)area->addr + area->size ||
+	    !(area->flags & VM_ALLOC))
+		return -EINVAL;
+
+	if (!numpages)
+		return 0;
+
+	if (radix_enabled())
+		return radix__change_memory_range(start, start + size,
+							set, clear);
+	else
+		return hash__change_memory_range(start, start + size,
+							set, clear);
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					0, _PAGE_WRITE);
+}
+EXPORT_SYMBOL(set_memory_ro);
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					_PAGE_WRITE, 0);
+}
+EXPORT_SYMBOL(set_memory_rw);
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					0, _PAGE_EXEC);
+}
+EXPORT_SYMBOL(set_memory_nx);
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					_PAGE_EXEC, 0);
+}
+EXPORT_SYMBOL(set_memory_x);
+#endif
-- 
2.9.4
