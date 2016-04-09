Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmKq3SbxzDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:15:59 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:15:57 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6D2CC1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:04:04 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396FtpC42860792
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:15:55 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396Fs7i031733
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:15:55 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 34/68] powerpc/mm/radix: Add radix callback for vmemmap and
 map_kernel page
Date: Sat,  9 Apr 2016 11:43:30 +0530
Message-Id: <1460182444-2468-35-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 12 ++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  6 ++++++
 arch/powerpc/mm/pgtable-radix.c              | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 623911ed64e9..c16037116625 100644
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
+		return map_radix_kernel_page(ea, pa, __pgprot(flags), PAGE_SIZE);
+	}
 	return hlmap_kernel_page(ea, pa, flags);
 }
 
@@ -732,6 +739,8 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
 						   unsigned long page_size,
 						   unsigned long phys)
 {
+	if (radix_enabled())
+		return rvmemmap_create_mapping(start, page_size, phys);
 	return hlvmemmap_create_mapping(start, page_size, phys);
 }
 
@@ -739,6 +748,9 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
 static inline void vmemmap_remove_mapping(unsigned long start,
 					  unsigned long page_size)
 {
+
+	if (radix_enabled())
+		return rvmemmap_remove_mapping(start, page_size);
 	return hlvmemmap_remove_mapping(start, page_size);
 }
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 806dc2195f85..040c4a56d07b 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -133,6 +133,12 @@ static inline int rpmd_trans_huge(pmd_t pmd)
 
 #endif
 
+extern int __meminit rvmemmap_create_mapping(unsigned long start,
+					     unsigned long page_size,
+					     unsigned long phys);
+extern void rvmemmap_remove_mapping(unsigned long start,
+				    unsigned long page_size);
+
 extern int map_radix_kernel_page(unsigned long ea, unsigned long pa,
 				 pgprot_t flags, unsigned int psz);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 5737769469b3..a5d0ae5630b3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -342,3 +342,23 @@ void rsetup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(first_memblock_base + first_memblock_size);
 }
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+int __meminit rvmemmap_create_mapping(unsigned long start,
+				      unsigned long page_size,
+				      unsigned long phys)
+{
+	/* Create a PTE encoding */
+	unsigned long flags = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_KERNEL_RW;
+
+	BUG_ON(map_radix_kernel_page(start, phys, __pgprot(flags), page_size));
+	return 0;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void rvmemmap_remove_mapping(unsigned long start, unsigned long page_size)
+{
+	/* FIXME!! intel does more. We should free page tables mapping vmemmap ? */
+}
+#endif
+#endif
-- 
2.5.0
