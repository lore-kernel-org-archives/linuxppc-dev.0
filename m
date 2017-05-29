Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc1250L7fzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 01:32:12 +1000 (AEST)
Message-Id: <79264a0fdaf65642c93b20a8c1df55535674df5a.1496070452.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/7] powerpc/mm: Simplify __set_fixmap()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 May 2017 17:32:08 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__set_fixmap() uses __fix_to_virt() then does the boundary checks
by it self. Instead, we can use fix_to_virt() which does the
verification at build time. For this, we need to use it inline
so that GCC can see the real value of idx at buildtime.

In the meantime, we remove the 'fixmaps' variable.
This variable is set but has never been used from the beginning
(commit 2c419bdeca1d9 ("[POWERPC] Port fixmap from x86 and use
for kmap_atomic"))

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/fixmap.h | 10 +++++++---
 arch/powerpc/mm/pgtable_32.c      | 15 ---------------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 4508b322f2cd..6c40dfda5912 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -17,6 +17,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -62,9 +63,6 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
-extern void __set_fixmap (enum fixed_addresses idx,
-					phys_addr_t phys, pgprot_t flags);
-
 #define __FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
 
@@ -72,5 +70,11 @@ extern void __set_fixmap (enum fixed_addresses idx,
 
 #include <asm-generic/fixmap.h>
 
+static inline void __set_fixmap(enum fixed_addresses idx,
+				phys_addr_t phys, pgprot_t flags)
+{
+	map_kernel_page(fix_to_virt(idx), phys, pgprot_val(flags));
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d672904bad0c..69f9b8bb61bf 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -408,18 +408,3 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 	change_page_attr(page, numpages, enable ? PAGE_KERNEL : __pgprot(0));
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
-
-static int fixmaps;
-
-void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
-{
-	unsigned long address = __fix_to_virt(idx);
-
-	if (idx >= __end_of_fixed_addresses) {
-		BUG();
-		return;
-	}
-
-	map_kernel_page(address, phys, pgprot_val(flags));
-	fixmaps++;
-}
-- 
2.12.0
