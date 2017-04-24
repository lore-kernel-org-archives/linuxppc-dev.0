Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBTCr6Mb5zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 00:26:00 +1000 (AEST)
Message-Id: <c958c51cdc884f9db8ac86a3f3909a696c8e2572.1493041713.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1493041713.git.christophe.leroy@c-s.fr>
References: <cover.1493041713.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/3] powerpc/mm: Fix kernel RAM protection after freeing
 unused memory on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Apr 2017 16:25:48 +0200 (CEST)
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
---
 v2: No change
 v3: No change

 arch/powerpc/mm/mem.c        |  1 +
 arch/powerpc/mm/mmu_decl.h   |  3 +++
 arch/powerpc/mm/pgtable_32.c | 13 ++++++++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9ee536ec0739..f261dac36a68 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -401,6 +401,7 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	free_initmem_default(POISON_FREE_INITMEM);
+	remap_init_ram();
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f988db655e5b..718fa45310be 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -95,6 +95,7 @@ extern void _tlbia(void);
 
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
+void remap_init_ram(void);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
@@ -106,6 +107,8 @@ struct hash_pte;
 extern struct hash_pte *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
 
+#else
+static inline void remap_init_ram(void) {}
 #endif /* CONFIG_PPC32 */
 
 extern unsigned long ioremap_bot;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 8e8940fad12f..31728f3cdd20 100644
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
 
+void remap_init_ram(void)
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
2.12.0
