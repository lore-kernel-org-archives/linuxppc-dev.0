Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Jtb2TWJzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:00:07 +1000 (AEST)
Message-Id: <eabf767c896a023e5670adfa07398f1008756c13.1492596044.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492596044.git.christophe.leroy@c-s.fr>
References: <cover.1492596044.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 13:00:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements CONFIG_DEBUG_RODATA on PPC32.

As for CONFIG_DEBUG_PAGEALLOC, it deactivates BAT and LTLB mappings
in order to allow page protection setup at the level of each page.

As BAT/LTLB mappings are deactivated, their might be performance
impact. For this reason, we keep it OFF by default.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig.debug         | 11 +++++++++++
 arch/powerpc/include/asm/pgtable.h |  8 ++++++++
 arch/powerpc/kernel/ftrace.c       |  2 ++
 arch/powerpc/mm/init_32.c          |  3 ++-
 arch/powerpc/mm/pgtable_32.c       | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c86df246339e..047f91564e52 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -369,4 +369,15 @@ config PPC_HTDUMP
 	def_bool y
 	depends on PPC_PTDUMP && PPC_BOOK3S
 
+config DEBUG_RODATA
+       bool "Write protect kernel read-only data structures"
+       depends on DEBUG_KERNEL && PPC32
+       default n
+       help
+	 Mark the kernel read-only data as write-protected in the pagetables,
+	 in order to catch accidental (and incorrect) writes to such const
+	 data. This option may have a performance impact because block
+	 mapping via BATs etc... will be disabled.
+	 If in doubt, say "N".
+
 endmenu
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index dd01212935ac..5de74b60ed00 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -80,6 +80,14 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
+
+#ifdef CONFIG_DEBUG_RODATA
+void set_kernel_text_rw(void);
+void set_kernel_text_ro(void);
+#else
+static inline void set_kernel_text_rw(void) {}
+static inline void set_kernel_text_ro(void) {}
+#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 32509de6ce4c..4af81fb23653 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -526,7 +526,9 @@ void ftrace_replace_code(int enable)
  */
 void arch_ftrace_update_code(int command)
 {
+	set_kernel_text_rw();
 	ftrace_modify_all_code(command);
+	set_kernel_text_ro();
 }
 
 int __init ftrace_dyn_arch_init(void)
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 8a7c38b8d335..e39c812b97ca 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -109,7 +109,8 @@ void __init MMU_setup(void)
 	if (strstr(boot_command_line, "noltlbs")) {
 		__map_without_ltlbs = 1;
 	}
-	if (debug_pagealloc_enabled()) {
+	if (debug_pagealloc_enabled() ||
+	    IS_ENABLED(CONFIG_DEBUG_RODATA)) {
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 31728f3cdd20..b071ce64d173 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -41,6 +41,7 @@ unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
+extern char __start_rodata[], __init_begin[];
 
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
@@ -375,6 +376,41 @@ void remap_init_ram(void)
 	change_page_attr(page, numpages, PAGE_KERNEL);
 }
 
+#ifdef CONFIG_DEBUG_RODATA
+void set_kernel_text_rw(void)
+{
+	struct page *page = virt_to_page(_stext);
+	unsigned long numpages = PFN_UP((unsigned long)etext) -
+				 PFN_DOWN((unsigned long)_stext);
+
+	change_page_attr(page, numpages, PAGE_KERNEL_X);
+}
+
+void set_kernel_text_ro(void)
+{
+	struct page *page = virt_to_page(_stext);
+	unsigned long numpages = PFN_UP((unsigned long)etext) -
+				 PFN_DOWN((unsigned long)_stext);
+
+	change_page_attr(page, numpages, PAGE_KERNEL_ROX);
+}
+
+void mark_rodata_ro(void)
+{
+	/*
+	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
+	 * to cover NOTES and EXCEPTION_TABLE.
+	 */
+	struct page *page = virt_to_page(__start_rodata);
+	unsigned long numpages = PFN_UP((unsigned long)__init_begin) -
+				 PFN_DOWN((unsigned long)__start_rodata);
+
+	set_kernel_text_ro();
+
+	change_page_attr(page, numpages, PAGE_KERNEL_RO);
+}
+#endif
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
-- 
2.12.0
