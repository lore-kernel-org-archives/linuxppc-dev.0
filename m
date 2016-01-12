Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D770D1A17C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:16:45 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:46:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CB82EE0073
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:48:00 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GSol8782232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GRs6013502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 14/33] powerpc/mm: Use helper for finding pte bits
 mapping I/O area
Date: Tue, 12 Jan 2016 12:45:49 +0530
Message-Id: <1452582968-22669-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will have different values for hash and radix. Hence we
cannot use #define constants. Add helper

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 5 +++++
 arch/powerpc/include/asm/book3s/64/hash.h    | 5 +++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 5 +++++
 arch/powerpc/kernel/isa-bridge.c             | 4 ++--
 arch/powerpc/kernel/pci_64.c                 | 2 +-
 arch/powerpc/mm/pgtable_64.c                 | 2 +-
 6 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 3ed3303c1295..77adada2f3b4 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -478,6 +478,11 @@ static inline pgprot_t pgprot_writecombine(pgprot_t prot)
 	return pgprot_noncached_wc(prot);
 }
 
+static inline unsigned long pte_io_cache_bits(void)
+{
+	return _PAGE_NO_CACHE | _PAGE_GUARDED;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /*  _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index ced3aed63af2..1b27c0c8effa 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -578,6 +578,11 @@ static inline pgprot_t pgprot_writecombine(pgprot_t prot)
 extern pgprot_t vm_get_page_prot(unsigned long vm_flags);
 #define vm_get_page_prot vm_get_page_prot
 
+static inline unsigned long pte_io_cache_bits(void)
+{
+	return _PAGE_NO_CACHE | _PAGE_GUARDED;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 11e3767216c0..8c4bb8fda0de 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -224,6 +224,11 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
+static inline unsigned long pte_io_cache_bits(void)
+{
+	return _PAGE_NO_CACHE | _PAGE_GUARDED;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int hugepd_ok(hugepd_t hpd)
 {
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 0f1997097960..d81185f025fa 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -109,14 +109,14 @@ static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 		size = 0x10000;
 
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     size, _PAGE_NO_CACHE|_PAGE_GUARDED);
+		     size, pte_io_cache_bits());
 	return;
 
 inval_range:
 	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
 	       "mapping 64k\n");
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     0x10000, _PAGE_NO_CACHE|_PAGE_GUARDED);
+		     0x10000, pte_io_cache_bits());
 }
 
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 60bb187cb46a..7fe1dfd214a1 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -159,7 +159,7 @@ static int pcibios_map_phb_io_space(struct pci_controller *hose)
 
 	/* Establish the mapping */
 	if (__ioremap_at(phys_page, area->addr, size_page,
-			 _PAGE_NO_CACHE | _PAGE_GUARDED) == NULL)
+			 pte_io_cache_bits()) == NULL)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e5f600d19326..6d161cec2e32 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -253,7 +253,7 @@ void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 
 void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = _PAGE_NO_CACHE | _PAGE_GUARDED;
+	unsigned long flags = pte_io_cache_bits();
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
-- 
2.5.0
