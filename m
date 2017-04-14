Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4J2W5GdrzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 23:11:30 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Fix protection of kernel RAM after freeing unused
 memory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170414131126.AA07A67422@localhost.localdomain>
Date: Fri, 14 Apr 2017 15:11:26 +0200 (CEST)
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
page tables. This patch fixes that.

[    5.860093] Freeing unused kernel memory: 592K (c0570000 - c0604000)

---[ Start of kernel VM ]---
0xc0000000-0xc0497fff        4704K  rw  X  present dirty accessed shared
0xc0498000-0xc056ffff         864K  rw     present dirty accessed shared
0xc0570000-0xc059ffff         192K  rw  X  present dirty accessed shared
0xc05a0000-0xc7ffffff      125312K  rw     present dirty accessed shared
---[ vmalloc() Area ]---

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mem.c        |  3 +++
 arch/powerpc/mm/mmu_decl.h   |  1 +
 arch/powerpc/mm/pgtable_32.c | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9ee536ec0739..e95931c4e6cf 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -401,6 +401,9 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	free_initmem_default(POISON_FREE_INITMEM);
+#ifdef CONFIG_PPC32
+	remap_init_ram();
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f988db655e5b..d39d92600839 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -95,6 +95,7 @@ extern void _tlbia(void);
 
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
+void remap_init_ram(void);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a65c0b4c0669..d506bd61b629 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -323,6 +323,26 @@ get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
         return(retval);
 }
 
+void remap_init_ram(void)
+{
+	unsigned long start = (unsigned long)_sinittext & PAGE_MASK;
+	unsigned long end = (unsigned long)_einittext;
+	unsigned long va;
+
+	for (va = start; va < end; va += PAGE_SIZE) {
+		pte_t *kpte;
+		pmd_t *kpmd;
+		pte_t pte = pfn_pte(__pa(va) >> PAGE_SHIFT, PAGE_KERNEL);
+
+		if (!get_pteptr(&init_mm, va, &kpte, &kpmd))
+			continue;
+		__set_pte_at(&init_mm, va, kpte, pte, 0);
+		wmb();
+		pte_unmap(kpte);
+	}
+	flush_tlb_kernel_range(start, end);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 
 static int __change_page_attr(struct page *page, pgprot_t prot)
-- 
2.12.0
