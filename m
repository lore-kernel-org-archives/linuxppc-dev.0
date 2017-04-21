Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8bVW2MQdzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:02:11 +1000 (AEST)
Message-Id: <97d45054364142af48b8767f9f9e115504d7568b.1492778567.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492778567.git.christophe.leroy@c-s.fr>
References: <cover.1492778567.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Apr 2017 15:02:07 +0200 (CEST)
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
 v2: For ftrace, only change the attributes of the page to be modified

 arch/powerpc/Kconfig.debug         | 11 +++++++++++
 arch/powerpc/include/asm/pgtable.h |  8 ++++++++
 arch/powerpc/kernel/ftrace.c       |  8 +++++---
 arch/powerpc/mm/init_32.c          |  3 ++-
 arch/powerpc/mm/pgtable_32.c       | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 4 deletions(-)

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
index dd01212935ac..142337f3b745 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -80,6 +80,14 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
+
+#ifdef CONFIG_DEBUG_RODATA
+void set_kernel_text_rw(unsigned long addr);
+void set_kernel_text_ro(unsigned long addr);
+#else
+static inline void set_kernel_text_rw(unsigned long addr) {}
+static inline void set_kernel_text_ro(unsigned long addr) {}
+#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 32509de6ce4c..06d2ac53f471 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -46,6 +46,7 @@ static int
 ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 {
 	unsigned int replaced;
+	int err;
 
 	/*
 	 * Note:
@@ -67,10 +68,11 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 	}
 
 	/* replace the text with the new text */
-	if (patch_instruction((unsigned int *)ip, new))
-		return -EPERM;
+	set_kernel_text_rw(ip);
+	err = patch_instruction((unsigned int *)ip, new);
+	set_kernel_text_ro(ip);
 
-	return 0;
+	return err ? -EPERM : 0;
 }
 
 /*
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
index 31728f3cdd20..972effec1bb2 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -34,6 +34,7 @@
 #include <asm/fixmap.h>
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #include "mmu_decl.h"
 
@@ -375,6 +376,41 @@ void remap_init_ram(void)
 	change_page_attr(page, numpages, PAGE_KERNEL);
 }
 
+#ifdef CONFIG_DEBUG_RODATA
+void set_kernel_text_rw(unsigned long addr)
+{
+	if (core_kernel_text(addr))
+		change_page_attr(virt_to_page(addr), 1, PAGE_KERNEL_X);
+}
+
+void set_kernel_text_ro(unsigned long addr)
+{
+	if (core_kernel_text(addr))
+		change_page_attr(virt_to_page(addr), 1, PAGE_KERNEL_ROX);
+}
+
+void mark_rodata_ro(void)
+{
+	struct page *page;
+	unsigned long numpages;
+
+	page = virt_to_page(_stext);
+	numpages = PFN_UP((unsigned long)_etext) -
+		   PFN_DOWN((unsigned long)_stext);
+
+	change_page_attr(page, numpages, PAGE_KERNEL_ROX);
+	/*
+	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
+	 * to cover NOTES and EXCEPTION_TABLE.
+	 */
+	page = virt_to_page(__start_rodata);
+	numpages = PFN_UP((unsigned long)__init_begin) -
+		   PFN_DOWN((unsigned long)__start_rodata);
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
