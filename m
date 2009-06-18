Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CAA6AB721C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 13:39:52 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 18 Jun 2009 13:39:13 +1000
Subject: [PATCH] powerpc/mm: Make k(un)map_atomic out of line
Message-Id: <20090618033952.B60D4DDDA2@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those functions are way too big to be inline, besides, kmap_atomic()
wants to call debug_kmap_atomic() which isn't exported for modules
and causes module link failures.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/highmem.h |   55 +--------------------------
 arch/powerpc/mm/Makefile           |    1 
 arch/powerpc/mm/highmem.c          |   75 +++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 51 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/highmem.h	2009-06-18 11:34:42.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/highmem.h	2009-06-18 11:34:45.000000000 +1000
@@ -62,6 +62,9 @@ extern pte_t *pkmap_page_table;
 
 extern void *kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
+extern void *kmap_atomic_prot(struct page *page, enum km_type type,
+			      pgprot_t prot);
+extern void kunmap_atomic(void *kvaddr, enum km_type type);
 
 static inline void *kmap(struct page *page)
 {
@@ -79,62 +82,11 @@ static inline void kunmap(struct page *p
 	kunmap_high(page);
 }
 
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
- */
-static inline void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr;
-
-	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-
-	debug_kmap_atomic(type);
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void*) vaddr;
-}
-
 static inline void *kmap_atomic(struct page *page, enum km_type type)
 {
 	return kmap_atomic_prot(page, type, kmap_prot);
 }
 
-static inline void kunmap_atomic(void *kvaddr, enum km_type type)
-{
-#ifdef CONFIG_DEBUG_HIGHMEM
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
-		pagefault_enable();
-		return;
-	}
-
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-	/*
-	 * force other mappings to Oops if they'll try to access
-	 * this pte without first remap it
-	 */
-	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	local_flush_tlb_page(NULL, vaddr);
-#endif
-	pagefault_enable();
-}
-
 static inline struct page *kmap_atomic_to_page(void *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long) ptr;
@@ -148,6 +100,7 @@ static inline struct page *kmap_atomic_t
 	return pte_page(*pte);
 }
 
+
 #define flush_cache_kmaps()	flush_cache_all()
 
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2009-06-18 11:34:42.000000000 +1000
+++ linux-work/arch/powerpc/mm/Makefile	2009-06-18 11:34:45.000000000 +1000
@@ -30,3 +30,4 @@ obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
+obj-$(CONFIG_HIGHMEM)		+= highmem.o
Index: linux-work/arch/powerpc/mm/highmem.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/highmem.c	2009-06-18 11:35:51.000000000 +1000
@@ -0,0 +1,75 @@
+/*
+ * highmem.c: virtual kernel memory mappings for high memory
+ *
+ * PowerPC version, stolen from the i386 version.
+ *
+ * Used in CONFIG_HIGHMEM systems for memory pages which
+ * are not addressable by direct kernel virtual addresses.
+ *
+ * Copyright (C) 1999 Gerhard Wichert, Siemens AG
+ *		      Gerhard.Wichert@pdb.siemens.de
+ *
+ *
+ * Redesigned the x86 32-bit VM architecture to deal with
+ * up to 16 Terrabyte physical memory. With current x86 CPUs
+ * we now support up to 64 Gigabytes physical RAM.
+ *
+ * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
+ *
+ * Reworked for PowerPC by various contributors. Moved from
+ * highmem.h by Benjamin Herrenschmidt (c) 2009 IBM Corp.
+ */
+
+
+/*
+ * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
+ * gives a more generic (and caching) interface. But kmap_atomic can
+ * be used in IRQ contexts, so in some (very limited) cases we need
+ * it.
+ */
+void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
+{
+	unsigned int idx;
+	unsigned long vaddr;
+
+	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
+	pagefault_disable();
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	debug_kmap_atomic(type);
+	idx = type + KM_TYPE_NR*smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+#ifdef CONFIG_DEBUG_HIGHMEM
+	BUG_ON(!pte_none(*(kmap_pte-idx)));
+#endif
+	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
+	local_flush_tlb_page(NULL, vaddr);
+
+	return (void*) vaddr;
+}
+EXPORT_SYMBOL(kmap_atomic_prot);
+
+void kunmap_atomic(void *kvaddr, enum km_type type)
+{
+#ifdef CONFIG_DEBUG_HIGHMEM
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
+	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
+
+	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
+		pagefault_enable();
+		return;
+	}
+
+	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+
+	/*
+	 * force other mappings to Oops if they'll try to access
+	 * this pte without first remap it
+	 */
+	pte_clear(&init_mm, vaddr, kmap_pte-idx);
+	local_flush_tlb_page(NULL, vaddr);
+#endif
+	pagefault_enable();
+}
+EXPORT_SYMBOL(kunmap_atomic);
