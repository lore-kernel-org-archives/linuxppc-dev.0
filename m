Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 May 2007 16:27:29 +1000
Subject: [PATCH 4/5] powerpc: spufs support for 64K LS mappings on 4K kernels
In-Reply-To: <1178605646.637780.625211974455.qpush@grosgo>
Message-Id: <20070508062750.17633DDF17@ozlabs.org>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds an option to spufs when the kernel is configured for
4K page to give it the ability to use 64K pages for SPE local store
mappings.

Currently, we are optimistic and try order 4 allocations when creting
contexts. If that fails, the code will fallback to 4K automatically.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/cell/Kconfig             |   15 +
 arch/powerpc/platforms/cell/spufs/Makefile      |    2 
 arch/powerpc/platforms/cell/spufs/context.c     |    4 
 arch/powerpc/platforms/cell/spufs/file.c        |   78 ++++++++--
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c |  181 ++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spufs/switch.c      |   28 +--
 include/asm-powerpc/spu_csa.h                   |   10 +
 7 files changed, 282 insertions(+), 36 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/Kconfig	2007-05-08 15:27:02.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/Kconfig	2007-05-08 15:29:26.000000000 +1000
@@ -35,6 +35,21 @@ config SPU_FS
 	  Units on machines implementing the Broadband Processor
 	  Architecture.
 
+config SPU_FS_64K_LS
+	bool "Use 64K pages to map SPE local  store"
+	# we depend on PPC_MM_SLICES for now rather than selecting
+	# it because we depend on hugetlbfs hooks being present. We
+	# will fix that when the generic code has been improved to
+	# not require hijacking hugetlbfs hooks.
+	depends on SPU_FS && PPC_MM_SLICES && !PPC_64K_PAGES
+	default y
+	select PPC_HAS_HASH_64K
+	help
+	  This option causes SPE local stores to be mapped in process
+	  address spaces using 64K pages while the rest of the kernel
+	  uses 4K pages. This can improve performances of applications
+	  using multiple SPEs by lowering the TLB pressure on them.
+
 config SPU_BASE
 	bool
 	default n
Index: linux-cell/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/context.c	2007-05-08 15:27:02.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/context.c	2007-05-08 15:29:26.000000000 +1000
@@ -36,10 +36,8 @@ struct spu_context *alloc_spu_context(st
 	/* Binding to physical processor deferred
 	 * until spu_activate().
 	 */
-	spu_init_csa(&ctx->csa);
-	if (!ctx->csa.lscsa) {
+	if (spu_init_csa(&ctx->csa))
 		goto out_free;
-	}
 	spin_lock_init(&ctx->mmio_lock);
 	spin_lock_init(&ctx->mapping_lock);
 	kref_init(&ctx->kref);
Index: linux-cell/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/switch.c	2007-05-08 15:27:02.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/switch.c	2007-05-08 15:29:26.000000000 +1000
@@ -2189,40 +2189,30 @@ static void init_priv2(struct spu_state 
  * as it is by far the largest of the context save regions,
  * and may need to be pinned or otherwise specially aligned.
  */
-void spu_init_csa(struct spu_state *csa)
+int spu_init_csa(struct spu_state *csa)
 {
-	struct spu_lscsa *lscsa;
-	unsigned char *p;
+	int rc;
 
 	if (!csa)
-		return;
+		return -EINVAL;
 	memset(csa, 0, sizeof(struct spu_state));
 
-	lscsa = vmalloc(sizeof(struct spu_lscsa));
-	if (!lscsa)
-		return;
+	rc = spu_alloc_lscsa(csa);
+	if (rc)
+		return rc;
 
-	memset(lscsa, 0, sizeof(struct spu_lscsa));
-	csa->lscsa = lscsa;
 	spin_lock_init(&csa->register_lock);
 
-	/* Set LS pages reserved to allow for user-space mapping. */
-	for (p = lscsa->ls; p < lscsa->ls + LS_SIZE; p += PAGE_SIZE)
-		SetPageReserved(vmalloc_to_page(p));
-
 	init_prob(csa);
 	init_priv1(csa);
 	init_priv2(csa);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spu_init_csa);
 
 void spu_fini_csa(struct spu_state *csa)
 {
-	/* Clear reserved bit before vfree. */
-	unsigned char *p;
-	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
-		ClearPageReserved(vmalloc_to_page(p));
-
-	vfree(csa->lscsa);
+	spu_free_lscsa(csa);
 }
 EXPORT_SYMBOL_GPL(spu_fini_csa);
Index: linux-cell/include/asm-powerpc/spu_csa.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/spu_csa.h	2007-05-08 15:27:02.000000000 +1000
+++ linux-cell/include/asm-powerpc/spu_csa.h	2007-05-08 15:29:26.000000000 +1000
@@ -235,6 +235,12 @@ struct spu_priv2_collapsed {
  */
 struct spu_state {
 	struct spu_lscsa *lscsa;
+#ifdef CONFIG_SPU_FS_64K_LS
+	int		use_big_pages;
+	/* One struct page per 64k page */
+#define SPU_LSCSA_NUM_BIG_PAGES	(sizeof(struct spu_lscsa) / 0x10000)
+	struct page	*lscsa_pages[SPU_LSCSA_NUM_BIG_PAGES];
+#endif
 	struct spu_problem_collapsed prob;
 	struct spu_priv1_collapsed priv1;
 	struct spu_priv2_collapsed priv2;
@@ -247,12 +253,14 @@ struct spu_state {
 	spinlock_t register_lock;
 };
 
-extern void spu_init_csa(struct spu_state *csa);
+extern int spu_init_csa(struct spu_state *csa);
 extern void spu_fini_csa(struct spu_state *csa);
 extern int spu_save(struct spu_state *prev, struct spu *spu);
 extern int spu_restore(struct spu_state *new, struct spu *spu);
 extern int spu_switch(struct spu_state *prev, struct spu_state *new,
 		      struct spu *spu);
+extern int spu_alloc_lscsa(struct spu_state *csa);
+extern void spu_free_lscsa(struct spu_state *csa);
 
 #endif /* !__SPU__ */
 #endif /* __KERNEL__ */
Index: linux-cell/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/Makefile	2007-05-08 15:27:02.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/Makefile	2007-05-08 15:29:26.000000000 +1000
@@ -1,4 +1,4 @@
-obj-y += switch.o fault.o
+obj-y += switch.o fault.o lscsa_alloc.o
 
 obj-$(CONFIG_SPU_FS) += spufs.o
 spufs-y += inode.o file.o context.o syscalls.o coredump.o
Index: linux-cell/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c	2007-05-08 15:29:26.000000000 +1000
@@ -0,0 +1,181 @@
+/*
+ * SPU local store allocation routines
+ *
+ * Copyright 2007 Benjamin Herrenschmidt, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+
+#include <asm/spu.h>
+#include <asm/spu_csa.h>
+#include <asm/mmu.h>
+
+static int spu_alloc_lscsa_std(struct spu_state *csa)
+{
+	struct spu_lscsa *lscsa;
+	unsigned char *p;
+
+	lscsa = vmalloc(sizeof(struct spu_lscsa));
+	if (!lscsa)
+		return -ENOMEM;
+	memset(lscsa, 0, sizeof(struct spu_lscsa));
+	csa->lscsa = lscsa;
+
+	/* Set LS pages reserved to allow for user-space mapping. */
+	for (p = lscsa->ls; p < lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		SetPageReserved(vmalloc_to_page(p));
+
+	return 0;
+}
+
+static void spu_free_lscsa_std(struct spu_state *csa)
+{
+	/* Clear reserved bit before vfree. */
+	unsigned char *p;
+
+	if (csa->lscsa == NULL)
+		return;
+
+	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		ClearPageReserved(vmalloc_to_page(p));
+
+	vfree(csa->lscsa);
+}
+
+#ifdef CONFIG_SPU_FS_64K_LS
+
+#define SPU_64K_PAGE_SHIFT	16
+#define SPU_64K_PAGE_ORDER	(SPU_64K_PAGE_SHIFT - PAGE_SHIFT)
+#define SPU_64K_PAGE_COUNT	(1ul << SPU_64K_PAGE_ORDER)
+
+int spu_alloc_lscsa(struct spu_state *csa)
+{
+	struct page	**pgarray;
+	unsigned char	*p;
+	int		i, j, n_4k;
+
+	/* Check availability of 64K pages */
+	if (mmu_psize_defs[MMU_PAGE_64K].shift == 0)
+		goto fail;
+
+	csa->use_big_pages = 1;
+
+	pr_debug("spu_alloc_lscsa(csa=0x%p), trying to allocate 64K pages\n",
+		 csa);
+
+	/* First try to allocate our 64K pages. We need 5 of them
+	 * with the current implementation. In the future, we should try
+	 * to separate the lscsa with the actual local store image, thus
+	 * allowing us to require only 4 64K pages per context
+	 */
+	for (i = 0; i < SPU_LSCSA_NUM_BIG_PAGES; i++) {
+		/* XXX This is likely to fail, we should use a special pool
+		 *     similiar to what hugetlbfs does.
+		 */
+		csa->lscsa_pages[i] = alloc_pages(GFP_KERNEL,
+						  SPU_64K_PAGE_ORDER);
+		if (csa->lscsa_pages[i] == NULL)
+			goto fail;
+	}
+
+	pr_debug(" success ! creating vmap...\n");
+
+	/* Now we need to create a vmalloc mapping of these for the kernel
+	 * and SPU context switch code to use. Currently, we stick to a
+	 * normal kernel vmalloc mapping, which in our case will be 4K
+	 */
+	n_4k = SPU_64K_PAGE_COUNT * SPU_LSCSA_NUM_BIG_PAGES;
+	pgarray = kmalloc(sizeof(struct page *) * n_4k, GFP_KERNEL);
+	if (pgarray == NULL)
+		goto fail;
+	for (i = 0; i < SPU_LSCSA_NUM_BIG_PAGES; i++)
+		for (j = 0; j < SPU_64K_PAGE_COUNT; j++)
+			/* We assume all the struct page's are contiguous
+			 * which should be hopefully the case for an order 4
+			 * allocation..
+			 */
+			pgarray[i * SPU_64K_PAGE_COUNT + j] =
+				csa->lscsa_pages[i] + j;
+	csa->lscsa = vmap(pgarray, n_4k, VM_USERMAP, PAGE_KERNEL);
+	kfree(pgarray);
+	if (csa->lscsa == NULL)
+		goto fail;
+
+	memset(csa->lscsa, 0, sizeof(struct spu_lscsa));
+
+	/* Set LS pages reserved to allow for user-space mapping.
+	 *
+	 * XXX isn't that a bit obsolete ? I think we should just
+	 * make sure the page count is high enough. Anyway, won't harm
+	 * for now
+	 */
+	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		SetPageReserved(vmalloc_to_page(p));
+
+	pr_debug(" all good !\n");
+
+	return 0;
+fail:
+	pr_debug("spufs: failed to allocate lscsa 64K pages, falling back\n");
+	spu_free_lscsa(csa);
+	return spu_alloc_lscsa_std(csa);
+}
+
+void spu_free_lscsa(struct spu_state *csa)
+{
+	unsigned char *p;
+	int i;
+
+	if (!csa->use_big_pages) {
+		spu_free_lscsa_std(csa);
+		return;
+	}
+	csa->use_big_pages = 0;
+
+	if (csa->lscsa == NULL)
+		goto free_pages;
+
+	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		ClearPageReserved(vmalloc_to_page(p));
+
+	vunmap(csa->lscsa);
+	csa->lscsa = NULL;
+
+ free_pages:
+
+	for (i = 0; i < SPU_LSCSA_NUM_BIG_PAGES; i++)
+		if (csa->lscsa_pages[i])
+			__free_pages(csa->lscsa_pages[i], SPU_64K_PAGE_ORDER);
+}
+
+#else /* CONFIG_SPU_FS_64K_LS */
+
+int spu_alloc_lscsa(struct spu_state *csa)
+{
+	return spu_alloc_lscsa_std(csa);
+}
+
+void spu_free_lscsa(struct spu_state *csa)
+{
+	spu_free_lscsa_std(csa);
+}
+
+#endif /* !defined(CONFIG_SPU_FS_64K_LS) */
Index: linux-cell/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/file.c	2007-05-08 15:27:02.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/file.c	2007-05-08 15:29:26.000000000 +1000
@@ -118,14 +118,32 @@ spufs_mem_write(struct file *file, const
 static unsigned long spufs_mem_mmap_nopfn(struct vm_area_struct *vma,
 					  unsigned long address)
 {
-	struct spu_context *ctx = vma->vm_file->private_data;
-	unsigned long pfn, offset = address - vma->vm_start;
-
-	offset += vma->vm_pgoff << PAGE_SHIFT;
+	struct spu_context *ctx	= vma->vm_file->private_data;
+	unsigned long pfn, offset, addr0 = address;
+#ifdef CONFIG_SPU_FS_64K_LS
+	struct spu_state *csa = &ctx->csa;
+	int psize;
+
+	/* Check what page size we are using */
+	psize = get_slice_psize(vma->vm_mm, address);
+
+	/* Some sanity checking */
+	BUG_ON(csa->use_big_pages != (psize == MMU_PAGE_64K));
+
+	/* Wow, 64K, cool, we need to align the address though */
+	if (csa->use_big_pages) {
+		BUG_ON(vma->vm_start & 0xffff);
+		address &= ~0xfffful;
+	}
+#endif /* CONFIG_SPU_FS_64K_LS */
 
+	offset = (address - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
 	if (offset >= LS_SIZE)
 		return NOPFN_SIGBUS;
 
+	pr_debug("spufs_mem_mmap_nopfn address=0x%lx -> 0x%lx, offset=0x%lx\n",
+		 addr0, address, offset);
+
 	spu_acquire(ctx);
 
 	if (ctx->state == SPU_STATE_SAVED) {
@@ -149,9 +167,24 @@ static struct vm_operations_struct spufs
 	.nopfn = spufs_mem_mmap_nopfn,
 };
 
-static int
-spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+#ifdef CONFIG_SPU_FS_64K_LS
+	struct spu_context	*ctx = file->private_data;
+	struct spu_state	*csa = &ctx->csa;
+
+	/* Sanity check VMA alignment */
+	if (csa->use_big_pages) {
+		pr_debug("spufs_mem_mmap 64K, start=0x%lx, end=0x%lx,"
+			 " pgoff=0x%lx\n", vma->vm_start, vma->vm_end,
+			 vma->vm_pgoff);
+		if (vma->vm_start & 0xffff)
+			return -EINVAL;
+		if (vma->vm_pgoff & 0xf)
+			return -EINVAL;
+	}
+#endif /* CONFIG_SPU_FS_64K_LS */
+
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
@@ -163,13 +196,34 @@ spufs_mem_mmap(struct file *file, struct
 	return 0;
 }
 
+#ifdef CONFIG_SPU_FS_64K_LS
+unsigned long spufs_get_unmapped_area(struct file *file, unsigned long addr,
+				      unsigned long len, unsigned long pgoff,
+				      unsigned long flags)
+{
+	struct spu_context	*ctx = file->private_data;
+	struct spu_state	*csa = &ctx->csa;
+
+	/* If not using big pages, fallback to normal MM g_u_a */
+	if (!csa->use_big_pages)
+		return current->mm->get_unmapped_area(file, addr, len,
+						      pgoff, flags);
+
+	/* Else, try to obtain a 64K pages slice */
+	return slice_get_unmapped_area(addr, len, flags,
+				       MMU_PAGE_64K, 1, 0);
+}
+#endif /* CONFIG_SPU_FS_64K_LS */
+
 static const struct file_operations spufs_mem_fops = {
-	.open	 = spufs_mem_open,
-	.release = spufs_mem_release,
-	.read    = spufs_mem_read,
-	.write   = spufs_mem_write,
-	.llseek  = generic_file_llseek,
-	.mmap    = spufs_mem_mmap,
+	.open	 		= spufs_mem_open,
+	.read   		= spufs_mem_read,
+	.write   		= spufs_mem_write,
+	.llseek  		= generic_file_llseek,
+	.mmap    		= spufs_mem_mmap,
+#ifdef CONFIG_SPU_FS_64K_LS
+	.get_unmapped_area	= spufs_get_unmapped_area,
+#endif
 };
 
 static unsigned long spufs_ps_nopfn(struct vm_area_struct *vma,
