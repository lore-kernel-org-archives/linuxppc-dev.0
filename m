Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29D51DDF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 00:56:56 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l26Dup0u016327
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 07:56:52 -0600
Subject: [HACK] powerpc: DEBUG_PAGEALLOC for 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 14:56:50 +0100
Message-Id: <1173189411.12263.4.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's an implementation of DEBUG_PAGEALLOC for ppc32. It disables BAT
mapping and is only tested with Hash table based processor though it
shouldn't be too hard to adapt it to others.

It has at least one known problem: The current ppc32 kernel has a known
problem when running without BATs as it can't cope with hash misses in
some hash management code path. In practice, it will probably work just
fine on UP and might deadlock every now and then on SMP. I might look
into fixing that some day....

In the meantime, I think I already found a hit with that patch in
ide-pmac... good tool to have. I'll look into doing it for 64 bits
later.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/Kconfig.debug
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig.debug	2007-03-06 11:10:19.000000000 +0100
+++ linux-work/arch/powerpc/Kconfig.debug	2007-03-06 11:10:24.000000000 +0100
@@ -18,6 +18,15 @@
 
 	  This option will slow down process creation somewhat.
 
+config DEBUG_PAGEALLOC
+        bool "Debug page memory allocations"
+        depends on DEBUG_KERNEL && !SOFTWARE_SUSPEND && PPC32
+        help
+          Unmap pages from the kernel linear mapping after free_pages().
+          This results in a large slowdown, but helps to find certain types
+          of memory corruptions.
+
+
 config HCALL_STATS
 	bool "Hypervisor call instrumentation"
 	depends on PPC_PSERIES && DEBUG_FS
Index: linux-work/arch/powerpc/mm/init_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_32.c	2007-03-06 11:10:19.000000000 +0100
+++ linux-work/arch/powerpc/mm/init_32.c	2007-03-06 14:15:33.000000000 +0100
@@ -115,6 +115,10 @@
 	if (strstr(cmd_line, "noltlbs")) {
 		__map_without_ltlbs = 1;
 	}
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	__map_without_bats = 1;
+	__map_without_ltlbs = 1;
+#endif
 }
 
 /*
Index: linux-work/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable_32.c	2007-03-06 11:10:19.000000000 +0100
+++ linux-work/arch/powerpc/mm/pgtable_32.c	2007-03-06 14:38:51.000000000 +0100
@@ -266,9 +266,9 @@
 	pg = pte_alloc_kernel(pd, va);
 	if (pg != 0) {
 		err = 0;
-		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
-		if (mem_init_done)
-			flush_HPTE(0, va, pmd_val(*pd));
+		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
+						     __pgprot(flags)));
+		flush_HPTE(0, va, pmd_val(*pd));
 	}
 	return err;
 }
@@ -445,3 +445,55 @@
 	return ret;
 }
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+
+static int __change_page_attr(struct page *page, pgprot_t prot)
+{
+	pte_t *kpte;
+	pmd_t *kpmd;
+	unsigned long address;
+
+	BUG_ON(PageHighMem(page));
+	address = (unsigned long)page_address(page);
+
+	if (v_mapped_by_bats(address) || v_mapped_by_tlbcam(address))
+		return 0;
+	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
+		return -EINVAL;
+	set_pte_at(&init_mm, address, kpte, mk_pte(page, prot));
+	wmb();
+	flush_HPTE(0, address, pmd_val(*kpmd));
+	pte_unmap(kpte);
+
+	return 0;
+}
+
+/*
+ * Change the page attributes of an page in the linear mapping.
+ *
+ * THIS CONFLICTS WITH BAT MAPPINGS, DEBUG USE ONLY
+ */
+static int change_page_attr(struct page *page, int numpages, pgprot_t prot)
+{
+	int i, err = 0;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	for (i = 0; i < numpages; i++, page++) {
+		err = __change_page_attr(page, prot);
+		if (err)
+			break;
+	}
+	local_irq_restore(flags);
+	return err;
+}
+
+
+void kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (PageHighMem(page))
+		return;
+
+	change_page_attr(page, numpages, enable ? PAGE_KERNEL : __pgprot(0));
+}
+#endif /* CONFIG_DEBUG_PAGEALLOC */
Index: linux-work/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/ppc_mmu_32.c	2007-03-06 11:10:19.000000000 +0100
+++ linux-work/arch/powerpc/mm/ppc_mmu_32.c	2007-03-06 14:16:24.000000000 +0100
@@ -85,8 +85,10 @@
 	unsigned long max_size = (256<<20);
 	unsigned long align;
 
-	if (__map_without_bats)
+	if (__map_without_bats) {
+		printk(KERN_DEBUG "RAM mapped without BATs for data\n");
 		return 0;
+	}
 
 	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
 
Index: linux-work/include/asm-powerpc/cacheflush.h
===================================================================
--- linux-work.orig/include/asm-powerpc/cacheflush.h	2007-03-06 11:10:19.000000000 +0100
+++ linux-work/include/asm-powerpc/cacheflush.h	2007-03-06 11:10:24.000000000 +0100
@@ -64,6 +64,12 @@
 	memcpy(dst, src, len)
 
 
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+/* internal debugging function */
+void kernel_map_pages(struct page *page, int numpages, int enable);
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_CACHEFLUSH_H */
