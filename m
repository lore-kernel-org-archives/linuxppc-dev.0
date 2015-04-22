Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 237201A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:40:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc/vdso: Remove unused debug code
Date: Wed, 22 Apr 2015 15:40:34 +1000
Message-Id: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
Cc: scottwood@freescale.com, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's in the git history if we ever need it back.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso.c | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 305eb0d9b768..869fd0c53280 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -140,50 +140,6 @@ struct lib64_elfinfo
 };
 
 
-#ifdef __DEBUG
-static void dump_one_vdso_page(struct page *pg, struct page *upg)
-{
-	printk("kpg: %p (c:%d,f:%08lx)", __va(page_to_pfn(pg) << PAGE_SHIFT),
-	       page_count(pg),
-	       pg->flags);
-	if (upg && !IS_ERR(upg) /* && pg != upg*/) {
-		printk(" upg: %p (c:%d,f:%08lx)", __va(page_to_pfn(upg)
-						       << PAGE_SHIFT),
-		       page_count(upg),
-		       upg->flags);
-	}
-	printk("\n");
-}
-
-static void dump_vdso_pages(struct vm_area_struct * vma)
-{
-	int i;
-
-	if (!vma || is_32bit_task()) {
-		printk("vDSO32 @ %016lx:\n", (unsigned long)vdso32_kbase);
-		for (i=0; i<vdso32_pages; i++) {
-			struct page *pg = virt_to_page(vdso32_kbase +
-						       i*PAGE_SIZE);
-			struct page *upg = (vma && vma->vm_mm) ?
-				follow_page(vma, vma->vm_start + i*PAGE_SIZE, 0)
-				: NULL;
-			dump_one_vdso_page(pg, upg);
-		}
-	}
-	if (!vma || !is_32bit_task()) {
-		printk("vDSO64 @ %016lx:\n", (unsigned long)vdso64_kbase);
-		for (i=0; i<vdso64_pages; i++) {
-			struct page *pg = virt_to_page(vdso64_kbase +
-						       i*PAGE_SIZE);
-			struct page *upg = (vma && vma->vm_mm) ?
-				follow_page(vma, vma->vm_start + i*PAGE_SIZE, 0)
-				: NULL;
-			dump_one_vdso_page(pg, upg);
-		}
-	}
-}
-#endif /* DEBUG */
-
 /*
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
-- 
2.1.0
