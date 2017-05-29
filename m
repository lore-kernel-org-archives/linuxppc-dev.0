Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc11y4SMRzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 01:32:06 +1000 (AEST)
Message-Id: <2f16c69c1f1dd6a985b0c2f10ae50bfea46cacc6.1496070452.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/7] powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 May 2017 17:32:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements STRICT_KERNEL_RWX on PPC32.

As for CONFIG_DEBUG_PAGEALLOC, it deactivates BAT and LTLB mappings
in order to allow page protection setup at the level of each page.

As BAT/LTLB mappings are deactivated, there might be a performance
impact. For this reason, we make it optional and keep it OFF by default.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig              |  3 ++-
 arch/powerpc/kernel/vmlinux.lds.S |  2 +-
 arch/powerpc/mm/init_32.c         |  6 ++++++
 arch/powerpc/mm/pgtable_32.c      | 24 ++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b3f03b88a3a..2f40fa79c759 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -171,7 +171,8 @@ config PPC
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC64 && PPC_BOOK3S
+	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC32 || (PPC64 && PPC_BOOK3S)
+	select ARCH_OPTIONAL_KERNEL_RWX		if PPC32
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 397382936c78..029d256bfb20 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -8,7 +8,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) && !defined(CONFIG_PPC32)
 #define STRICT_ALIGN_SIZE	(1 << 24)
 #else
 #define STRICT_ALIGN_SIZE	PAGE_SIZE
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 8a7c38b8d335..7d5fee1bb116 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -113,6 +113,12 @@ void __init MMU_setup(void)
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	if (rodata_enabled) {
+		__map_without_bats = 1;
+		__map_without_ltlbs = 1;
+	}
+#endif
 }
 
 /*
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 0dc9c9d8fafb..46b02fe33864 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -34,6 +34,7 @@
 #include <asm/fixmap.h>
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #include "mmu_decl.h"
 
@@ -375,6 +376,29 @@ void remap_init_ram(void)
 	change_page_attr(page, numpages, PAGE_KERNEL);
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
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
