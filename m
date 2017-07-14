Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x83J06cbxzDqlW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 16:51:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/mm/radix: Refactor radix__mark_rodata_ro()
Date: Fri, 14 Jul 2017 16:51:21 +1000
Message-Id: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the core logic into a helper, so we can use it for changing permissions
other than _PAGE_WRITE.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 8c13e4282308..336e52ec652c 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -112,10 +112,9 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void radix__mark_rodata_ro(void)
+void radix__change_memory_range(unsigned long start, unsigned long end,
+				unsigned long clear)
 {
-	unsigned long start = (unsigned long)_stext;
-	unsigned long end = (unsigned long)__init_begin;
 	unsigned long idx;
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -125,7 +124,8 @@ void radix__mark_rodata_ro(void)
 	start = ALIGN_DOWN(start, PAGE_SIZE);
 	end = PAGE_ALIGN(end); // aligns up
 
-	pr_devel("marking ro start %lx, end %lx\n", start, end);
+	pr_debug("Changing flags on range %lx-%lx removing 0x%lx\n",
+		 start, end, clear);
 
 	for (idx = start; idx < end; idx += PAGE_SIZE) {
 		pgdp = pgd_offset_k(idx);
@@ -147,11 +147,21 @@ void radix__mark_rodata_ro(void)
 		if (!ptep)
 			continue;
 update_the_pte:
-		radix__pte_update(&init_mm, idx, ptep, _PAGE_WRITE, 0, 0);
+		radix__pte_update(&init_mm, idx, ptep, clear, 0, 0);
 	}
 
 	radix__flush_tlb_kernel_range(start, end);
 }
+
+void radix__mark_rodata_ro(void)
+{
+	unsigned long start, end;
+
+	start = (unsigned long)_stext;
+	end = (unsigned long)__init_begin;
+
+	radix__change_memory_range(start, end, _PAGE_WRITE);
+}
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
 static inline void __meminit print_mapping(unsigned long start,
-- 
2.7.4
