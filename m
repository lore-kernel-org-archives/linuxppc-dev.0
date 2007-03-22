Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Mar 2007 13:59:41 +1100
Subject: [PATCH 3/4] [PATCH] powerpc: DEBUG_PAGEALLOC for 32 bits
Message-Id: <20070322030115.A69F7DDF42@ozlabs.org>
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

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig.debug       |    9 ++++++
 arch/powerpc/mm/init_32.c        |    4 +++
 arch/powerpc/mm/pgtable_32.c     |   52 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/ppc_mmu_32.c     |    4 ++-
 include/asm-powerpc/cacheflush.h |    6 ++++
 5 files changed, 74 insertions(+), 1 deletion(-)

Index: linux-cell/arch/powerpc/Kconfig.debug
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig.debug	2007-03-22 13:09:28.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig.debug	2007-03-22 13:17:35.000000000 +1100
@@ -18,6 +18,15 @@ config DEBUG_STACK_USAGE
 
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
Index: linux-cell/arch/powerpc/mm/init_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/init_32.c	2007-03-22 13:09:29.000000000 +1100
+++ linux-cell/arch/powerpc/mm/init_32.c	2007-03-22 13:17:35.000000000 +1100
@@ -115,6 +115,10 @@ void MMU_setup(void)
 	if (strstr(cmd_line, "noltlbs")) {
 		__map_without_ltlbs = 1;
 	}
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	__map_without_bats = 1;
+	__map_without_ltlbs = 1;
+#endif
 }
 
 /*
Index: linux-cell/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/pgtable_32.c	2007-03-22 13:16:20.000000000 +1100
+++ linux-cell/arch/powerpc/mm/pgtable_32.c	2007-03-22 13:17:35.000000000 +1100
@@ -451,3 +451,55 @@ exit:
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
Index: linux-cell/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/ppc_mmu_32.c	2007-03-22 13:09:29.000000000 +1100
+++ linux-cell/arch/powerpc/mm/ppc_mmu_32.c	2007-03-22 13:17:35.000000000 +1100
@@ -85,8 +85,10 @@ unsigned long __init mmu_mapin_ram(void)
 	unsigned long max_size = (256<<20);
 	unsigned long align;
 
-	if (__map_without_bats)
+	if (__map_without_bats) {
+		printk(KERN_DEBUG "RAM mapped without BATs\n");
 		return 0;
+	}
 
 	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
 
Index: linux-cell/include/asm-powerpc/cacheflush.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/cacheflush.h	2007-03-22 13:09:29.000000000 +1100
+++ linux-cell/include/asm-powerpc/cacheflush.h	2007-03-22 13:17:35.000000000 +1100
@@ -64,6 +64,12 @@ extern void flush_dcache_phys_range(unsi
 	memcpy(dst, src, len)
 
 
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+/* internal debugging function */
+void kernel_map_pages(struct page *page, int numpages, int enable);
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_CACHEFLUSH_H */
