Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTg21TMVzDr4b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:04:46 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id j186so8878304pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 10:04:46 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v5 4/7] powerpc/mm/hash: Implement mark_rodata_ro() for hash
Date: Thu, 29 Jun 2017 03:04:08 +1000
Message-Id: <20170628170411.28864-5-bsingharora@gmail.com>
In-Reply-To: <20170628170411.28864-1-bsingharora@gmail.com>
References: <20170628170411.28864-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With hash we update the bolted pte to mark it read-only. We rely
on the MMU_FTR_KERNEL_RO to generate the correct permissions
for read-only text. The radix implementation just prints a warning
in this implementation

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h  |  3 +++
 arch/powerpc/include/asm/book3s/64/radix.h |  4 +++
 arch/powerpc/mm/pgtable-hash64.c           | 41 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c            |  7 +++++
 arch/powerpc/mm/pgtable_64.c               |  9 +++++++
 5 files changed, 64 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 4e957b0..0ce513f 100644
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
index ac16d19..368cb54 100644
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
index 8b85a14..7e9c924 100644
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
@@ -342,3 +346,40 @@ int hash__has_transparent_hugepage(void)
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
index 6c062f9..0797c4e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -109,6 +109,13 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
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
index 8d2d674..34d8633 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -487,3 +487,12 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
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
2.9.4
