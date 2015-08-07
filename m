Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E51CD1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 16:19:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 2/5] powerpc/cell: Drop support for 64K local store on 4K
 kernels
Date: Fri,  7 Aug 2015 16:19:44 +1000
Message-Id: <1438928387-6454-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in the olden days we added support for using 64K pages to map the
SPU (Synergistic Processing Unit) local store on Cell, when the main
kernel was using 4K pages.

This was useful at the time because distros were using 4K pages, but
using 64K pages on the SPUs could reduce TLB pressure there.

However these days the number of Cell users is approaching zero, and
supporting this option adds unpleasant complexity to the memory
management code.

So drop the option, CONFIG_SPU_FS_64K_LS, and all related code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/spu_csa.h              |   6 --
 arch/powerpc/mm/hugetlbpage.c                   |   8 --
 arch/powerpc/platforms/cell/Kconfig             |  15 ---
 arch/powerpc/platforms/cell/spufs/file.c        |  55 -----------
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c | 124 +-----------------------
 5 files changed, 2 insertions(+), 206 deletions(-)

diff --git a/arch/powerpc/include/asm/spu_csa.h b/arch/powerpc/include/asm/spu_csa.h
index a40fd491250c..51f80b41cda3 100644
--- a/arch/powerpc/include/asm/spu_csa.h
+++ b/arch/powerpc/include/asm/spu_csa.h
@@ -241,12 +241,6 @@ struct spu_priv2_collapsed {
  */
 struct spu_state {
 	struct spu_lscsa *lscsa;
-#ifdef CONFIG_SPU_FS_64K_LS
-	int		use_big_pages;
-	/* One struct page per 64k page */
-#define SPU_LSCSA_NUM_BIG_PAGES	(sizeof(struct spu_lscsa) / 0x10000)
-	struct page	*lscsa_pages[SPU_LSCSA_NUM_BIG_PAGES];
-#endif
 	struct spu_problem_collapsed prob;
 	struct spu_priv1_collapsed priv1;
 	struct spu_priv2_collapsed priv2;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bb0bd7025cb8..06c14523b787 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -808,14 +808,6 @@ static int __init add_huge_page_size(unsigned long long size)
 	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
 		return -EINVAL;
 
-#ifdef CONFIG_SPU_FS_64K_LS
-	/* Disable support for 64K huge pages when 64K SPU local store
-	 * support is enabled as the current implementation conflicts.
-	 */
-	if (shift == PAGE_SHIFT_64K)
-		return -EINVAL;
-#endif /* CONFIG_SPU_FS_64K_LS */
-
 	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
 
 	/* Return if huge page size has already been setup */
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 2f23133ab3d1..b0ac1773cea6 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -57,21 +57,6 @@ config SPU_FS
 	  Units on machines implementing the Broadband Processor
 	  Architecture.
 
-config SPU_FS_64K_LS
-	bool "Use 64K pages to map SPE local  store"
-	# we depend on PPC_MM_SLICES for now rather than selecting
-	# it because we depend on hugetlbfs hooks being present. We
-	# will fix that when the generic code has been improved to
-	# not require hijacking hugetlbfs hooks.
-	depends on SPU_FS && PPC_MM_SLICES && !PPC_64K_PAGES
-	default y
-	select PPC_HAS_HASH_64K
-	help
-	  This option causes SPE local stores to be mapped in process
-	  address spaces using 64K pages while the rest of the kernel
-	  uses 4K pages. This can improve performances of applications
-	  using multiple SPEs by lowering the TLB pressure on them.
-
 config SPU_BASE
 	bool
 	default n
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index d966bbe58b8f..5038fd578e65 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -239,23 +239,6 @@ spufs_mem_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	unsigned long address = (unsigned long)vmf->virtual_address;
 	unsigned long pfn, offset;
 
-#ifdef CONFIG_SPU_FS_64K_LS
-	struct spu_state *csa = &ctx->csa;
-	int psize;
-
-	/* Check what page size we are using */
-	psize = get_slice_psize(vma->vm_mm, address);
-
-	/* Some sanity checking */
-	BUG_ON(csa->use_big_pages != (psize == MMU_PAGE_64K));
-
-	/* Wow, 64K, cool, we need to align the address though */
-	if (csa->use_big_pages) {
-		BUG_ON(vma->vm_start & 0xffff);
-		address &= ~0xfffful;
-	}
-#endif /* CONFIG_SPU_FS_64K_LS */
-
 	offset = vmf->pgoff << PAGE_SHIFT;
 	if (offset >= LS_SIZE)
 		return VM_FAULT_SIGBUS;
@@ -310,22 +293,6 @@ static const struct vm_operations_struct spufs_mem_mmap_vmops = {
 
 static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-#ifdef CONFIG_SPU_FS_64K_LS
-	struct spu_context	*ctx = file->private_data;
-	struct spu_state	*csa = &ctx->csa;
-
-	/* Sanity check VMA alignment */
-	if (csa->use_big_pages) {
-		pr_debug("spufs_mem_mmap 64K, start=0x%lx, end=0x%lx,"
-			 " pgoff=0x%lx\n", vma->vm_start, vma->vm_end,
-			 vma->vm_pgoff);
-		if (vma->vm_start & 0xffff)
-			return -EINVAL;
-		if (vma->vm_pgoff & 0xf)
-			return -EINVAL;
-	}
-#endif /* CONFIG_SPU_FS_64K_LS */
-
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
@@ -336,25 +303,6 @@ static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-#ifdef CONFIG_SPU_FS_64K_LS
-static unsigned long spufs_get_unmapped_area(struct file *file,
-		unsigned long addr, unsigned long len, unsigned long pgoff,
-		unsigned long flags)
-{
-	struct spu_context	*ctx = file->private_data;
-	struct spu_state	*csa = &ctx->csa;
-
-	/* If not using big pages, fallback to normal MM g_u_a */
-	if (!csa->use_big_pages)
-		return current->mm->get_unmapped_area(file, addr, len,
-						      pgoff, flags);
-
-	/* Else, try to obtain a 64K pages slice */
-	return slice_get_unmapped_area(addr, len, flags,
-				       MMU_PAGE_64K, 1);
-}
-#endif /* CONFIG_SPU_FS_64K_LS */
-
 static const struct file_operations spufs_mem_fops = {
 	.open			= spufs_mem_open,
 	.release		= spufs_mem_release,
@@ -362,9 +310,6 @@ static const struct file_operations spufs_mem_fops = {
 	.write			= spufs_mem_write,
 	.llseek			= generic_file_llseek,
 	.mmap			= spufs_mem_mmap,
-#ifdef CONFIG_SPU_FS_64K_LS
-	.get_unmapped_area	= spufs_get_unmapped_area,
-#endif
 };
 
 static int spufs_ps_fault(struct vm_area_struct *vma,
diff --git a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
index 147069938cfe..b847e9403566 100644
--- a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
+++ b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
@@ -31,7 +31,7 @@
 
 #include "spufs.h"
 
-static int spu_alloc_lscsa_std(struct spu_state *csa)
+int spu_alloc_lscsa(struct spu_state *csa)
 {
 	struct spu_lscsa *lscsa;
 	unsigned char *p;
@@ -48,7 +48,7 @@ static int spu_alloc_lscsa_std(struct spu_state *csa)
 	return 0;
 }
 
-static void spu_free_lscsa_std(struct spu_state *csa)
+void spu_free_lscsa(struct spu_state *csa)
 {
 	/* Clear reserved bit before vfree. */
 	unsigned char *p;
@@ -61,123 +61,3 @@ static void spu_free_lscsa_std(struct spu_state *csa)
 
 	vfree(csa->lscsa);
 }
-
-#ifdef CONFIG_SPU_FS_64K_LS
-
-#define SPU_64K_PAGE_SHIFT	16
-#define SPU_64K_PAGE_ORDER	(SPU_64K_PAGE_SHIFT - PAGE_SHIFT)
-#define SPU_64K_PAGE_COUNT	(1ul << SPU_64K_PAGE_ORDER)
-
-int spu_alloc_lscsa(struct spu_state *csa)
-{
-	struct page	**pgarray;
-	unsigned char	*p;
-	int		i, j, n_4k;
-
-	/* Check availability of 64K pages */
-	if (!spu_64k_pages_available())
-		goto fail;
-
-	csa->use_big_pages = 1;
-
-	pr_debug("spu_alloc_lscsa(csa=0x%p), trying to allocate 64K pages\n",
-		 csa);
-
-	/* First try to allocate our 64K pages. We need 5 of them
-	 * with the current implementation. In the future, we should try
-	 * to separate the lscsa with the actual local store image, thus
-	 * allowing us to require only 4 64K pages per context
-	 */
-	for (i = 0; i < SPU_LSCSA_NUM_BIG_PAGES; i++) {
-		/* XXX This is likely to fail, we should use a special pool
-		 *     similar to what hugetlbfs does.
-		 */
-		csa->lscsa_pages[i] = alloc_pages(GFP_KERNEL,
-						  SPU_64K_PAGE_ORDER);
-		if (csa->lscsa_pages[i] == NULL)
-			goto fail;
-	}
-
-	pr_debug(" success ! creating vmap...\n");
-
-	/* Now we need to create a vmalloc mapping of these for the kernel
-	 * and SPU context switch code to use. Currently, we stick to a
-	 * normal kernel vmalloc mapping, which in our case will be 4K
-	 */
-	n_4k = SPU_64K_PAGE_COUNT * SPU_LSCSA_NUM_BIG_PAGES;
-	pgarray = kmalloc(sizeof(struct page *) * n_4k, GFP_KERNEL);
-	if (pgarray == NULL)
-		goto fail;
-	for (i = 0; i < SPU_LSCSA_NUM_BIG_PAGES; i++)
-		for (j = 0; j < SPU_64K_PAGE_COUNT; j++)
-			/* We assume all the struct page's are contiguous
-			 * which should be hopefully the case for an order 4
-			 * allocation..
-			 */
-			pgarray[i * SPU_64K_PAGE_COUNT + j] =
-				csa->lscsa_pages[i] + j;
-	csa->lscsa = vmap(pgarray, n_4k, VM_USERMAP, PAGE_KERNEL);
-	kfree(pgarray);
-	if (csa->lscsa == NULL)
-		goto fail;
-
-	memset(csa->lscsa, 0, sizeof(struct spu_lscsa));
-
-	/* Set LS pages reserved to allow for user-space mapping.
-	 *
-	 * XXX isn't that a bit obsolete ? I think we should just
-	 * make sure the page count is high enough. Anyway, won't harm
-	 * for now
-	 */
-	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
-		SetPageReserved(vmalloc_to_page(p));
-
-	pr_debug(" all good !\n");
-
-	return 0;
-fail:
-	pr_debug("spufs: failed to allocate lscsa 64K pages, falling back\n");
-	spu_free_lscsa(csa);
-	return spu_alloc_lscsa_std(csa);
-}
-
-void spu_free_lscsa(struct spu_state *csa)
-{
-	unsigned char *p;
-	int i;
-
-	if (!csa->use_big_pages) {
-		spu_free_lscsa_std(csa);
-		return;
-	}
-	csa->use_big_pages = 0;
-
-	if (csa->lscsa == NULL)
-		goto free_pages;
-
-	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
-		ClearPageReserved(vmalloc_to_page(p));
-
-	vunmap(csa->lscsa);
-	csa->lscsa = NULL;
-
- free_pages:
-
-	for (i = 0; i < SPU_LSCSA_NUM_BIG_PAGES; i++)
-		if (csa->lscsa_pages[i])
-			__free_pages(csa->lscsa_pages[i], SPU_64K_PAGE_ORDER);
-}
-
-#else /* CONFIG_SPU_FS_64K_LS */
-
-int spu_alloc_lscsa(struct spu_state *csa)
-{
-	return spu_alloc_lscsa_std(csa);
-}
-
-void spu_free_lscsa(struct spu_state *csa)
-{
-	spu_free_lscsa_std(csa);
-}
-
-#endif /* !defined(CONFIG_SPU_FS_64K_LS) */
-- 
2.1.4
