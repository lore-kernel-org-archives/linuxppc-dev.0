Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyC41GSzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 37/70] powerpc/mm/radix: Add radix callbacks for vmemmap
 and map_kernel page()
Date: Fri, 29 Apr 2016 23:26:00 +1000
Message-Id: <1461936393-10131-37-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 12 ++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  6 ++++++
 arch/powerpc/mm/pgtable-radix.c              | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c1b787dcfbb6..9bc2471a8207 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -725,6 +725,13 @@ void pgtable_cache_init(void);
 static inline int map_kernel_page(unsigned long ea, unsigned long pa,
 				  unsigned long flags)
 {
+	if (radix_enabled()) {
+#if defined(CONFIG_PPC_RADIX_MMU) && defined(DEBUG_VM)
+		unsigned long page_size = 1 << mmu_psize_defs[mmu_io_psize].shift;
+		WARN((page_size != PAGE_SIZE), "I/O page size != PAGE_SIZE");
+#endif
+		return radix__map_kernel_page(ea, pa, __pgprot(flags), PAGE_SIZE);
+	}
 	return hash__map_kernel_page(ea, pa, flags);
 }
 
@@ -732,6 +739,8 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
 						   unsigned long page_size,
 						   unsigned long phys)
 {
+	if (radix_enabled())
+		return radix__vmemmap_create_mapping(start, page_size, phys);
 	return hash__vmemmap_create_mapping(start, page_size, phys);
 }
 
@@ -739,6 +748,9 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
 static inline void vmemmap_remove_mapping(unsigned long start,
 					  unsigned long page_size)
 {
+
+	if (radix_enabled())
+		return radix__vmemmap_remove_mapping(start, page_size);
 	return hash__vmemmap_remove_mapping(start, page_size);
 }
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index a26259fcffd6..63eb629a8b64 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -130,6 +130,12 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
 
 #endif
 
+extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
+					     unsigned long page_size,
+					     unsigned long phys);
+extern void radix__vmemmap_remove_mapping(unsigned long start,
+				    unsigned long page_size);
+
 extern int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 				 pgprot_t flags, unsigned int psz);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 4918850e1061..0472f8aa40e1 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -354,3 +354,23 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(first_memblock_base + first_memblock_size);
 }
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+int __meminit radix__vmemmap_create_mapping(unsigned long start,
+				      unsigned long page_size,
+				      unsigned long phys)
+{
+	/* Create a PTE encoding */
+	unsigned long flags = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_KERNEL_RW;
+
+	BUG_ON(radix__map_kernel_page(start, phys, __pgprot(flags), page_size));
+	return 0;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
+{
+	/* FIXME!! intel does more. We should free page tables mapping vmemmap ? */
+}
+#endif
+#endif
-- 
2.5.0
