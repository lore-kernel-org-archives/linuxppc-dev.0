Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2k4MxyzDr4Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 08/10] powerpc/mm/hash: Implement mark_rodata_ro() for hash
Date: Mon,  3 Jul 2017 23:01:52 +1000
Message-Id: <1499086914-25695-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

With hash we update the bolted pte to mark it read-only. We rely
on the MMU_FTR_KERNEL_RO to generate the correct permissions
for read-only text. The radix implementation just prints a warning
in this implementation

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h  |  3 +++
 arch/powerpc/include/asm/book3s/64/radix.h |  4 +++
 arch/powerpc/mm/pgtable-hash64.c           | 41 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c            |  7 +++++
 arch/powerpc/mm/pgtable_64.c               |  9 +++++++
 5 files changed, 64 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 4e957b027fe0..0ce513f2926f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -89,6 +89,9 @@ static inline int hash__pgd_bad(pgd_t pgd)
 {
 	return (pgd_val(pgd) == 0);
 }
+#ifdef CONFIG_STRICT_KERNEL_RWX
+extern void hash__mark_rodata_ro(void);
+#endif
 
 extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned long pte, int huge);
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index ba43754e96d2..487709ff6875 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -116,6 +116,10 @@
 #define RADIX_PUD_TABLE_SIZE	(sizeof(pud_t) << RADIX_PUD_INDEX_SIZE)
 #define RADIX_PGD_TABLE_SIZE	(sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE)
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+extern void radix__mark_rodata_ro(void);
+#endif
+
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
 {
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index a0facee58811..0809102b66bd 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -11,8 +11,12 @@
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
+#include <linux/mm.h>
 
 #include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+#include <asm/mmu.h>
 #include <asm/tlb.h>
 
 #include "mmu_decl.h"
@@ -419,3 +423,40 @@ int hash__has_transparent_hugepage(void)
 	return 1;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void hash__mark_rodata_ro(void)
+{
+	unsigned long start = (unsigned long)_stext;
+	unsigned long end = (unsigned long)__init_begin;
+	unsigned long idx;
+	unsigned int step, shift;
+	unsigned long newpp = PP_RXXX;
+
+	if (!mmu_has_feature(MMU_FTR_KERNEL_RO)) {
+		pr_info("R/O rodata not supported\n");
+		return;
+	}
+
+	shift = mmu_psize_defs[mmu_linear_psize].shift;
+	step = 1 << shift;
+
+	start = ((start + step - 1) >> shift) << shift;
+	end = (end >> shift) << shift;
+
+	pr_devel("marking ro start %lx, end %lx, step %x\n",
+			start, end, step);
+
+	if (start == end) {
+		pr_warn("could not set rodata ro, relocate the start"
+			" of the kernel to a 0x%x boundary\n", step);
+		return;
+	}
+
+	for (idx = start; idx < end; idx += step)
+		/* Not sure if we can do much with the return value */
+		mmu_hash_ops.hpte_updateboltedpp(newpp, idx, mmu_linear_psize,
+							mmu_kernel_ssize);
+
+}
+#endif
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 1342859552b1..b07e0008d02a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -110,6 +110,13 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 	return 0;
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void radix__mark_rodata_ro(void)
+{
+	pr_warn("Not yet implemented for radix\n");
+}
+#endif
+
 static inline void __meminit print_mapping(unsigned long start,
 					   unsigned long end,
 					   unsigned long size)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index bce0ed50789c..5b0c2d63d645 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -491,3 +491,12 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 }
 EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
 #endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void mark_rodata_ro(void)
+{
+	if (radix_enabled())
+		return radix__mark_rodata_ro();
+	return hash__mark_rodata_ro();
+}
+#endif
-- 
2.7.4
