Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCZ6FTqzF1PJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:09:14 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id f6so33010pgs.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:09:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 12/14] powerpc: pass node id into create_section_mapping
Date: Wed, 14 Feb 2018 01:08:22 +1000
Message-Id: <20180213150824.27689-13-npiggin@gmail.com>
In-Reply-To: <20180213150824.27689-1-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h  | 2 +-
 arch/powerpc/include/asm/book3s/64/radix.h | 2 +-
 arch/powerpc/include/asm/sparsemem.h       | 2 +-
 arch/powerpc/mm/hash_utils_64.c            | 2 +-
 arch/powerpc/mm/mem.c                      | 4 ++--
 arch/powerpc/mm/pgtable-book3s64.c         | 6 +++---
 arch/powerpc/mm/pgtable-radix.c            | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0920eff731b3..b1ace9619e94 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -201,7 +201,7 @@ extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
 extern void hash__vmemmap_remove_mapping(unsigned long start,
 				     unsigned long page_size);
 
-int hash__create_section_mapping(unsigned long start, unsigned long end);
+int hash__create_section_mapping(unsigned long start, unsigned long end, int nid);
 int hash__remove_section_mapping(unsigned long start, unsigned long end);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 365010f66570..705193e7192f 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -313,7 +313,7 @@ static inline unsigned long radix__get_tree_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int radix__create_section_mapping(unsigned long start, unsigned long end);
+int radix__create_section_mapping(unsigned long start, unsigned long end, int nid);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index a7916ee6dfb6..bc66712bdc3c 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -17,7 +17,7 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end);
+extern int create_section_mapping(unsigned long start, unsigned long end, int nid);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7d07c7e17db6..ceb5494804b2 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -781,7 +781,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 	}
 }
 
-int hash__create_section_mapping(unsigned long start, unsigned long end)
+int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	int rc = htab_bolt_mapping(start, end, __pa(start),
 				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 4eee46ea4d96..f50ce66dd6bd 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -117,7 +117,7 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 #endif
 
-int __weak create_section_mapping(unsigned long start, unsigned long end)
+int __weak create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	return -ENODEV;
 }
@@ -137,7 +137,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 	resize_hpt_for_hotplug(memblock_phys_mem_size());
 
 	start = (unsigned long)__va(start);
-	rc = create_section_mapping(start, start + size);
+	rc = create_section_mapping(start, start + size, nid);
 	if (rc) {
 		pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
 			start, start + size, rc);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 422e80253a33..c736280068ce 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -155,12 +155,12 @@ void mmu_cleanup_all(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int create_section_mapping(unsigned long start, unsigned long end)
+int create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	if (radix_enabled())
-		return radix__create_section_mapping(start, end);
+		return radix__create_section_mapping(start, end, nid);
 
-	return hash__create_section_mapping(start, end);
+	return hash__create_section_mapping(start, end, nid);
 }
 
 int remove_section_mapping(unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 328ff9abc333..435b19e74508 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -862,9 +862,9 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 	radix__flush_tlb_kernel_range(start, end);
 }
 
-int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
+int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	return create_physical_mapping(start, end);
+	return create_physical_mapping(start, end, nid);
 }
 
 int radix__remove_section_mapping(unsigned long start, unsigned long end)
-- 
2.16.1
