Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMvjS3tqzzDsTx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 23:51:08 +1000 (AEST)
Message-Id: <3077e852befcf50371ef6c79d4902562447d92e1.1501679954.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1501679953.git.christophe.leroy@c-s.fr>
References: <cover.1501679953.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/5] powerpc/mm: Fix kernel RAM protection after freeing
 unused memory on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  2 Aug 2017 15:51:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As seen below, allthough the init sections have been freed, the
associated memory area is still marked as executable in the
page tables.

~ dmesg
[    5.860093] Freeing unused kernel memory: 592K (c0570000 - c0604000)

~ cat /sys/kernel/debug/kernel_page_tables
---[ Start of kernel VM ]---
0xc0000000-0xc0497fff        4704K  rw  X  present dirty accessed shared
0xc0498000-0xc056ffff         864K  rw     present dirty accessed shared
0xc0570000-0xc059ffff         192K  rw  X  present dirty accessed shared
0xc05a0000-0xc7ffffff      125312K  rw     present dirty accessed shared
---[ vmalloc() Area ]---

This patch fixes that.

The implementation is done by reusing the change_page_attr()
function implemented for CONFIG_DEBUG_PAGEALLOC

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: Function remap_init_ram() renamed mark_initmem_nx() to match new
  PPC64 implementation

 arch/powerpc/include/asm/pgtable.h |  2 +-
 arch/powerpc/mm/pgtable_32.c       | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index afae9a336136..ab7f44475b1f 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -81,7 +81,7 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
 void mark_initmem_nx(void);
 #else
 static inline void mark_initmem_nx(void) { }
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 991036f818bb..85e8f0e0efe6 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -323,8 +323,6 @@ get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
         return(retval);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-
 static int __change_page_attr_noflush(struct page *page, pgprot_t prot)
 {
 	pte_t *kpte;
@@ -347,7 +345,7 @@ static int __change_page_attr_noflush(struct page *page, pgprot_t prot)
 /*
  * Change the page attributes of an page in the linear mapping.
  *
- * THIS CONFLICTS WITH BAT MAPPINGS, DEBUG USE ONLY
+ * THIS DOES NOTHING WITH BAT MAPPINGS, DEBUG USE ONLY
  */
 static int change_page_attr(struct page *page, int numpages, pgprot_t prot)
 {
@@ -368,7 +366,16 @@ static int change_page_attr(struct page *page, int numpages, pgprot_t prot)
 	return err;
 }
 
+void mark_initmem_nx(void)
+{
+	struct page *page = virt_to_page(_sinittext);
+	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
+				 PFN_DOWN((unsigned long)_sinittext);
+
+	change_page_attr(page, numpages, PAGE_KERNEL);
+}
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	if (PageHighMem(page))
-- 
2.13.3
