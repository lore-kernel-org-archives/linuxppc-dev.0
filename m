Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3A74DDF2B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:03:20 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: tnt@246tNt.com, pantelis.antoniou@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: change rheap functions to use long integers instead
	of pointers
Date: Tue,  3 Apr 2007 11:02:55 -0500
Message-Id: <11756161753280-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(This patch is currently for review only.  It is based on Paul's for-2.6.22
branch.  Please note that the code in this branch is missing many fixes for
2.6.21, and so some code will not compile.  Specifially, ARCH=ppc is very
broken.)

The rheap allocation functions are coded to return a pointer, but the actual
value returned is an offset into a buffer.  Callers of rheap_alloc() typically
cast the return value to an integer.  Similarly, rheap_free() took a pointer
as a parameter, when it should be an unsigned long.

This patch changes all of the relevant rheap functions to use an unsigned long
instead of a pointer.  The allocation functions return a signed long, where a
negative number indicates error.

All code which calls the rheap functions is updated accordingly.  Macros
IS_MURAM_ERR() and IS_DPERR() have been deleted.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/lib/rheap.c                |   95 +++++++++---------
 arch/powerpc/sysdev/commproc.c          |   15 ++--
 arch/powerpc/sysdev/cpm2_common.c       |   11 +-
 arch/powerpc/sysdev/qe_lib/qe.c         |   25 +++---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c   |   16 ++--
 arch/powerpc/sysdev/qe_lib/ucc_slow.c   |   21 ++--
 arch/ppc/8xx_io/commproc.c              |   11 +-
 arch/ppc/lib/rheap.c                    |   92 +++++++++---------
 arch/ppc/syslib/cpm2_common.c           |   11 +-
 drivers/net/fs_enet/mac-scc.c           |    6 +-
 drivers/net/ucc_geth.c                  |  161 +++++++++++++------------------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    4 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    4 +-
 include/asm-powerpc/qe.h                |    9 +--
 include/asm-ppc/commproc.h              |    7 +-
 include/asm-ppc/cpm2.h                  |    5 -
 include/asm-ppc/rheap.h                 |   20 ++--
 17 files changed, 237 insertions(+), 276 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 6c5c5dd..e69a210 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -133,7 +133,7 @@ static rh_block_t *get_slot(rh_info_t * info)
 	info->empty_slots--;
 
 	/* Initialize */
-	blk->start = NULL;
+	blk->start = 0;
 	blk->size = 0;
 	blk->owner = NULL;
 
@@ -158,7 +158,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 
 	/* We assume that they are aligned properly */
 	size = blkn->size;
-	s = (unsigned long)blkn->start;
+	s = blkn->start;
 	e = s + size;
 
 	/* Find the blocks immediately before and after the given one
@@ -170,7 +170,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 
-		bs = (unsigned long)blk->start;
+		bs = blk->start;
 		be = bs + blk->size;
 
 		if (next == NULL && s >= bs)
@@ -188,10 +188,10 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 	}
 
 	/* Now check if they are really adjacent */
-	if (before != NULL && s != (unsigned long)before->start + before->size)
+	if (before && s != (before->start + before->size))
 		before = NULL;
 
-	if (after != NULL && e != (unsigned long)after->start)
+	if (after && e != after->start)
 		after = NULL;
 
 	/* No coalescing; list insert and return */
@@ -216,7 +216,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 
 	/* Grow the after block backwards */
 	if (before == NULL && after != NULL) {
-		after->start = (int8_t *)after->start - size;
+		after->start -= size;
 		after->size += size;
 		return;
 	}
@@ -321,14 +321,14 @@ void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 }
 
 /* Attach a free memory region, coalesces regions if adjuscent */
-int rh_attach_region(rh_info_t * info, void *start, int size)
+int rh_attach_region(rh_info_t * info, unsigned long start, int size)
 {
 	rh_block_t *blk;
 	unsigned long s, e, m;
 	int r;
 
 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;
 
@@ -339,8 +339,8 @@ int rh_attach_region(rh_info_t * info, void *start, int size)
 	e = e & ~m;
 
 	/* Take final values */
-	start = (void *)s;
-	size = (int)(e - s);
+	start = s;
+	size = e - s;
 
 	/* Grow the blocks, if needed */
 	r = assure_empty(info, 1);
@@ -358,7 +358,7 @@ int rh_attach_region(rh_info_t * info, void *start, int size)
 }
 
 /* Detatch given address range, splits free block if needed. */
-void *rh_detach_region(rh_info_t * info, void *start, int size)
+long rh_detach_region(rh_info_t * info, unsigned long start, int size)
 {
 	struct list_head *l;
 	rh_block_t *blk, *newblk;
@@ -366,10 +366,10 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 
 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;
 
@@ -380,34 +380,34 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 	e = e & ~m;
 
 	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
+		bs = blk->start;
+		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
 		blk = NULL;
 	}
 
 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Perfect fit */
 	if (bs == s && be == e) {
 		/* Delete from free list, release slot */
 		list_del(&blk->list);
 		release_slot(info, blk);
-		return (void *)s;
+		return s;
 	}
 
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
+			blk->start += size;
 		blk->size -= size;
 
 	} else {
@@ -416,25 +416,25 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 
 		/* the back free fragment */
 		newblk = get_slot(info);
-		newblk->start = (void *)e;
+		newblk->start = e;
 		newblk->size = be - e;
 
 		list_add(&newblk->list, &blk->list);
 	}
 
-	return (void *)s;
+	return s;
 }
 
-void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owner)
+long rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk;
 	rh_block_t *newblk;
-	void *start;
+	unsigned long start;
 
 	/* Validate size, (must be power of two) */
 	if (size <= 0 || (alignment & (alignment - 1)) != 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* given alignment larger that default rheap alignment */
 	if (alignment > info->alignment)
@@ -444,7 +444,7 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
 
 	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
@@ -455,7 +455,7 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	}
 
 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Just fits */
 	if (blk->size == size) {
@@ -475,7 +475,7 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	newblk->owner = owner;
 
 	/* blk still in free list, with updated start, size */
-	blk->start = (int8_t *)blk->start + size;
+	blk->start += size;
 	blk->size -= size;
 
 	start = newblk->start;
@@ -486,19 +486,18 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	/* this is no problem with the deallocator since */
 	/* we scan for pointers that lie in the blocks   */
 	if (alignment > info->alignment)
-		start = (void *)(((unsigned long)start + alignment - 1) &
-				~(alignment - 1));
+		start = (start + alignment - 1) & ~(alignment - 1);
 
 	return start;
 }
 
-void *rh_alloc(rh_info_t * info, int size, const char *owner)
+long rh_alloc(rh_info_t * info, int size, const char *owner)
 {
 	return rh_alloc_align(info, size, info->alignment, owner);
 }
 
 /* allocate at precisely the given address */
-void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
+long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk, *newblk1, *newblk2;
@@ -506,10 +505,10 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 
 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;
 
@@ -520,20 +519,20 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	e = e & ~m;
 
 	if (assure_empty(info, 2) < 0)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
+		bs = blk->start;
+		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
 	}
 
 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Perfect fit */
 	if (bs == s && be == e) {
@@ -551,7 +550,7 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
+			blk->start += size;
 		blk->size -= size;
 
 	} else {
@@ -560,14 +559,14 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 
 		/* The back free fragment */
 		newblk2 = get_slot(info);
-		newblk2->start = (void *)e;
+		newblk2->start = e;
 		newblk2->size = be - e;
 
 		list_add(&newblk2->list, &blk->list);
 	}
 
 	newblk1 = get_slot(info);
-	newblk1->start = (void *)s;
+	newblk1->start = s;
 	newblk1->size = e - s;
 	newblk1->owner = owner;
 
@@ -577,7 +576,7 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	return start;
 }
 
-int rh_free(rh_info_t * info, void *start)
+int rh_free(rh_info_t * info, unsigned long start)
 {
 	rh_block_t *blk, *blk2;
 	struct list_head *l;
@@ -642,7 +641,7 @@ int rh_get_stats(rh_info_t * info, int what, int max_stats, rh_stats_t * stats)
 	return nr;
 }
 
-int rh_set_owner(rh_info_t * info, void *start, const char *owner)
+int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner)
 {
 	rh_block_t *blk, *blk2;
 	struct list_head *l;
@@ -684,8 +683,8 @@ void rh_dump(rh_info_t * info)
 		nr = maxnr;
 	for (i = 0; i < nr; i++)
 		printk(KERN_INFO
-		       "    0x%p-0x%p (%u)\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
+		       "    0x%lx-0x%lx (%u)\n",
+		       st[i].start, st[i].start + st[i].size,
 		       st[i].size);
 	printk(KERN_INFO "\n");
 
@@ -695,8 +694,8 @@ void rh_dump(rh_info_t * info)
 		nr = maxnr;
 	for (i = 0; i < nr; i++)
 		printk(KERN_INFO
-		       "    0x%p-0x%p (%u) %s\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
+		       "    0x%lx-0x%lx (%u) %s\n",
+		       st[i].start, st[i].start + st[i].size,
 		       st[i].size, st[i].owner != NULL ? st[i].owner : "");
 	printk(KERN_INFO "\n");
 }
@@ -704,6 +703,6 @@ void rh_dump(rh_info_t * info)
 void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 {
 	printk(KERN_INFO
-	       "blk @0x%p: 0x%p-0x%p (%u)\n",
-	       blk, blk->start, (int8_t *) blk->start + blk->size, blk->size);
+	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
+	       blk, blk->start, blk->start + blk->size, blk->size);
 }
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 9b4fafd..cea7d73 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -330,7 +330,7 @@ void m8xx_cpm_dpinit(void)
 	 * with the processor and the microcode patches applied / activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }
 
 /*
@@ -340,7 +340,7 @@ void m8xx_cpm_dpinit(void)
  */
 uint cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -358,24 +358,24 @@ int cpm_dpfree(uint offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return ret;
 }
 EXPORT_SYMBOL(cpm_dpfree);
 
-uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+long cpm_dpalloc_fixed(uint offset, uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc_fixed);
 
@@ -396,3 +396,4 @@ uint cpm_dpram_phys(u8* addr)
 	return (dpram_pbase + (uint)(addr - dpram_vbase));
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index ec26599..4a68712 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -248,15 +248,14 @@ static void cpm2_dpinit(void)
 	 * varies with the processor and the microcode patches activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE,
-			CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }
 
 /* This function returns an index into the DPRAM area.
  */
 uint cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -274,7 +273,7 @@ int cpm_dpfree(uint offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return ret;
@@ -284,12 +283,12 @@ EXPORT_SYMBOL(cpm_dpfree);
 /* not sure if this is ever needed */
 uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return (uint)start;
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index e3d71e0..02762a5 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma *sdma = &qe_immr->sdma;
-	u32 sdma_buf_offset;
+	long sdma_buf_offset;
 
 	if (!sdma)
 		return -ENODEV;
@@ -252,10 +252,10 @@ static int qe_sdma_init(void)
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
 	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
-	if (IS_MURAM_ERR(sdma_buf_offset))
+	if (sdma_buf_offset < 0)
 		return -ENOMEM;
 
-	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
+	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
 					QE_SDMR_CEN_SHIFT)));
 
@@ -291,23 +291,22 @@ static void qe_muram_init(void)
 	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
 		address = *of_get_address(np, 0, &size, &flags);
 		of_node_put(np);
-		rh_attach_region(&qe_muram_info,
-			(void *)address, (int)size);
+		rh_attach_region(&qe_muram_info, address, (int) size);
 	}
 }
 
 /* This function returns an index into the MURAM area.
  */
-u32 qe_muram_alloc(u32 size, u32 align)
+long qe_muram_alloc(u32 size, u32 align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&qe_muram_lock, flags);
 	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
 	spin_unlock_irqrestore(&qe_muram_lock, flags);
 
-	return (u32) start;
+	return start;
 }
 EXPORT_SYMBOL(qe_muram_alloc);
 
@@ -317,7 +316,7 @@ int qe_muram_free(u32 offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&qe_muram_lock, flags);
-	ret = rh_free(&qe_muram_info, (void *)offset);
+	ret = rh_free(&qe_muram_info, offset);
 	spin_unlock_irqrestore(&qe_muram_lock, flags);
 
 	return ret;
@@ -325,16 +324,16 @@ int qe_muram_free(u32 offset)
 EXPORT_SYMBOL(qe_muram_free);
 
 /* not sure if this is ever needed */
-u32 qe_muram_alloc_fixed(u32 offset, u32 size)
+long qe_muram_alloc_fixed(u32 offset, u32 size)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&qe_muram_lock, flags);
-	start = rh_alloc_fixed(&qe_muram_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&qe_muram_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&qe_muram_lock, flags);
 
-	return (u32) start;
+	return start;
 }
 EXPORT_SYMBOL(qe_muram_alloc_fixed);
 
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index a457ac1..685b06f 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -136,6 +136,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	struct ucc_fast *uf_regs;
 	u32 gumr;
 	int ret;
+	long offset;
 
 	if (!uf_info)
 		return -EINVAL;
@@ -263,26 +264,25 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	out_be32(&uf_regs->gumr, gumr);
 
 	/* Allocate memory for Tx Virtual Fifo */
-	uccf->ucc_fast_tx_virtual_fifo_base_offset =
-	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_MURAM_ERR(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+	offset = qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+	if (offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO", __FUNCTION__);
-		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
 	}
+	uccf->ucc_fast_tx_virtual_fifo_base_offset = (u32) offset;
 
 	/* Allocate memory for Rx Virtual Fifo */
-	uccf->ucc_fast_rx_virtual_fifo_base_offset =
-		qe_muram_alloc(uf_info->urfs +
+
+	offset = qe_muram_alloc(uf_info->urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_MURAM_ERR(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+	if (offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO", __FUNCTION__);
-		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
 	}
+	uccf->ucc_fast_rx_virtual_fifo_base_offset = (u32) offset;
 
 	/* Set Virtual Fifo registers */
 	out_be16(&uf_regs->urfs, uf_info->urfs);
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 817df73..8fbb77b 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -124,6 +124,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	u32 id;
 	u32 command;
 	int ret = 0;
+	long offset;
 
 	if (!us_info)
 		return -EINVAL;
@@ -173,13 +174,13 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 #endif				/* STATISTICS */
 
 	/* Get PRAM base */
-	uccs->us_pram_offset =
-		qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
-	if (IS_MURAM_ERR(uccs->us_pram_offset)) {
+	offset = qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
+	if (offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for PRAM", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return -ENOMEM;
 	}
+	uccs->us_pram_offset = (u32) offset;
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
 	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, id, QE_CR_PROTOCOL_UNSPECIFIED,
 		     uccs->us_pram_offset);
@@ -207,25 +208,23 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	INIT_LIST_HEAD(&uccs->confQ);
 
 	/* Allocate BDs. */
-	uccs->rx_base_offset =
-		qe_muram_alloc(us_info->rx_bd_ring_len * sizeof(struct qe_bd),
+	offset = qe_muram_alloc(us_info->rx_bd_ring_len * sizeof(struct qe_bd),
 				QE_ALIGNMENT_OF_BD);
-	if (IS_MURAM_ERR(uccs->rx_base_offset)) {
+	if (offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate RX BDs", __FUNCTION__);
-		uccs->rx_base_offset = 0;
 		ucc_slow_free(uccs);
 		return -ENOMEM;
 	}
+	uccs->rx_base_offset = (u32) offset;
 
-	uccs->tx_base_offset =
-		qe_muram_alloc(us_info->tx_bd_ring_len * sizeof(struct qe_bd),
+	offset = qe_muram_alloc(us_info->tx_bd_ring_len * sizeof(struct qe_bd),
 			QE_ALIGNMENT_OF_BD);
-	if (IS_MURAM_ERR(uccs->tx_base_offset)) {
+	if (offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate TX BDs", __FUNCTION__);
-		uccs->tx_base_offset = 0;
 		ucc_slow_free(uccs);
 		return -ENOMEM;
 	}
+	uccs->tx_base_offset = (u32) offset;
 
 	/* Init Tx bds */
 	bd = uccs->confBd = uccs->tx_bd = qe_muram_addr(uccs->tx_base_offset);
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 3b23bcb..07adf45 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -382,7 +382,7 @@ void m8xx_cpm_dpinit(void)
 	 * with the processor and the microcode patches applied / activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }
 
 /*
@@ -392,7 +392,7 @@ void m8xx_cpm_dpinit(void)
  */
 uint cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -410,7 +410,7 @@ int cpm_dpfree(uint offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return ret;
@@ -419,12 +419,12 @@ EXPORT_SYMBOL(cpm_dpfree);
 
 uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return (uint)start;
@@ -442,3 +442,4 @@ void *cpm_dpram_addr(uint offset)
 	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
diff --git a/arch/ppc/lib/rheap.c b/arch/ppc/lib/rheap.c
index d407007..b1f6a8f 100644
--- a/arch/ppc/lib/rheap.c
+++ b/arch/ppc/lib/rheap.c
@@ -132,7 +132,7 @@ static rh_block_t *get_slot(rh_info_t * info)
 	info->empty_slots--;
 
 	/* Initialize */
-	blk->start = NULL;
+	blk->start = 0;
 	blk->size = 0;
 	blk->owner = NULL;
 
@@ -157,7 +157,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 
 	/* We assume that they are aligned properly */
 	size = blkn->size;
-	s = (unsigned long)blkn->start;
+	s = blkn->start;
 	e = s + size;
 
 	/* Find the blocks immediately before and after the given one
@@ -169,7 +169,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 
-		bs = (unsigned long)blk->start;
+		bs = blk->start;
 		be = bs + blk->size;
 
 		if (next == NULL && s >= bs)
@@ -187,10 +187,10 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 	}
 
 	/* Now check if they are really adjacent */
-	if (before != NULL && s != (unsigned long)before->start + before->size)
+	if (before && s != (before->start + before->size))
 		before = NULL;
 
-	if (after != NULL && e != (unsigned long)after->start)
+	if (after && e != after->start)
 		after = NULL;
 
 	/* No coalescing; list insert and return */
@@ -215,7 +215,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 
 	/* Grow the after block backwards */
 	if (before == NULL && after != NULL) {
-		after->start = (int8_t *)after->start - size;
+		after->start -= size;
 		after->size += size;
 		return;
 	}
@@ -320,14 +320,14 @@ void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 }
 
 /* Attach a free memory region, coalesces regions if adjuscent */
-int rh_attach_region(rh_info_t * info, void *start, int size)
+int rh_attach_region(rh_info_t * info, unsigned long start, int size)
 {
 	rh_block_t *blk;
 	unsigned long s, e, m;
 	int r;
 
 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;
 
@@ -338,8 +338,8 @@ int rh_attach_region(rh_info_t * info, void *start, int size)
 	e = e & ~m;
 
 	/* Take final values */
-	start = (void *)s;
-	size = (int)(e - s);
+	start = s;
+	size = e - s;
 
 	/* Grow the blocks, if needed */
 	r = assure_empty(info, 1);
@@ -357,7 +357,7 @@ int rh_attach_region(rh_info_t * info, void *start, int size)
 }
 
 /* Detatch given address range, splits free block if needed. */
-void *rh_detach_region(rh_info_t * info, void *start, int size)
+long rh_detach_region(rh_info_t * info, unsigned long start, int size)
 {
 	struct list_head *l;
 	rh_block_t *blk, *newblk;
@@ -365,10 +365,10 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 
 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;
 
@@ -379,34 +379,34 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 	e = e & ~m;
 
 	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
+		bs = blk->start;
+		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
 		blk = NULL;
 	}
 
 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Perfect fit */
 	if (bs == s && be == e) {
 		/* Delete from free list, release slot */
 		list_del(&blk->list);
 		release_slot(info, blk);
-		return (void *)s;
+		return s;
 	}
 
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
+			blk->start += size;
 		blk->size -= size;
 
 	} else {
@@ -415,31 +415,31 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 
 		/* the back free fragment */
 		newblk = get_slot(info);
-		newblk->start = (void *)e;
+		newblk->start = e;
 		newblk->size = be - e;
 
 		list_add(&newblk->list, &blk->list);
 	}
 
-	return (void *)s;
+	return s;
 }
 
-void *rh_alloc(rh_info_t * info, int size, const char *owner)
+long rh_alloc(rh_info_t * info, int size, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk;
 	rh_block_t *newblk;
-	void *start;
+	unsigned long start;
 
 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* Align to configured alignment */
 	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
 
 	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
@@ -450,7 +450,7 @@ void *rh_alloc(rh_info_t * info, int size, const char *owner)
 	}
 
 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Just fits */
 	if (blk->size == size) {
@@ -470,7 +470,7 @@ void *rh_alloc(rh_info_t * info, int size, const char *owner)
 	newblk->owner = owner;
 
 	/* blk still in free list, with updated start, size */
-	blk->start = (int8_t *)blk->start + size;
+	blk->start += size;
 	blk->size -= size;
 
 	start = newblk->start;
@@ -481,18 +481,18 @@ void *rh_alloc(rh_info_t * info, int size, const char *owner)
 }
 
 /* allocate at precisely the given address */
-void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
+long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk, *newblk1, *newblk2;
-	unsigned long s, e, m, bs, be;
+	unsigned long s, e, m, bs=0, be=0;
 
 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;
 
@@ -503,20 +503,20 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	e = e & ~m;
 
 	if (assure_empty(info, 2) < 0)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
+		bs = blk->start;
+		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
 	}
 
 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Perfect fit */
 	if (bs == s && be == e) {
@@ -534,7 +534,7 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
+			blk->start += size;
 		blk->size -= size;
 
 	} else {
@@ -543,14 +543,14 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 
 		/* The back free fragment */
 		newblk2 = get_slot(info);
-		newblk2->start = (void *)e;
+		newblk2->start = e;
 		newblk2->size = be - e;
 
 		list_add(&newblk2->list, &blk->list);
 	}
 
 	newblk1 = get_slot(info);
-	newblk1->start = (void *)s;
+	newblk1->start = s;
 	newblk1->size = e - s;
 	newblk1->owner = owner;
 
@@ -560,7 +560,7 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	return start;
 }
 
-int rh_free(rh_info_t * info, void *start)
+int rh_free(rh_info_t * info, unsigned long start)
 {
 	rh_block_t *blk, *blk2;
 	struct list_head *l;
@@ -625,7 +625,7 @@ int rh_get_stats(rh_info_t * info, int what, int max_stats, rh_stats_t * stats)
 	return nr;
 }
 
-int rh_set_owner(rh_info_t * info, void *start, const char *owner)
+int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner)
 {
 	rh_block_t *blk, *blk2;
 	struct list_head *l;
@@ -667,8 +667,8 @@ void rh_dump(rh_info_t * info)
 		nr = maxnr;
 	for (i = 0; i < nr; i++)
 		printk(KERN_INFO
-		       "    0x%p-0x%p (%u)\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
+		       "    0x%lx-0x%lx (%u)\n",
+		       st[i].start, st[i].start + st[i].size,
 		       st[i].size);
 	printk(KERN_INFO "\n");
 
@@ -678,8 +678,8 @@ void rh_dump(rh_info_t * info)
 		nr = maxnr;
 	for (i = 0; i < nr; i++)
 		printk(KERN_INFO
-		       "    0x%p-0x%p (%u) %s\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
+		       "    0x%lx-0x%lx (%u) %s\n",
+		       st[i].start, st[i].start + st[i].size,
 		       st[i].size, st[i].owner != NULL ? st[i].owner : "");
 	printk(KERN_INFO "\n");
 }
@@ -687,6 +687,6 @@ void rh_dump(rh_info_t * info)
 void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 {
 	printk(KERN_INFO
-	       "blk @0x%p: 0x%p-0x%p (%u)\n",
-	       blk, blk->start, (int8_t *) blk->start + blk->size, blk->size);
+	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
+	       blk, blk->start, blk->start + blk->size, blk->size);
 }
diff --git a/arch/ppc/syslib/cpm2_common.c b/arch/ppc/syslib/cpm2_common.c
index cbac44b..d97292e 100644
--- a/arch/ppc/syslib/cpm2_common.c
+++ b/arch/ppc/syslib/cpm2_common.c
@@ -136,15 +136,14 @@ static void cpm2_dpinit(void)
 	 * varies with the processor and the microcode patches activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE,
-			CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }
 
 /* This function returns an index into the DPRAM area.
  */
 uint cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -162,7 +161,7 @@ int cpm_dpfree(uint offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return ret;
@@ -172,12 +171,12 @@ EXPORT_SYMBOL(cpm_dpfree);
 /* not sure if this is ever needed */
 uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
 {
-	void *start;
+	long start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return (uint)start;
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 65925b5..74539ff 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -165,12 +165,14 @@ static int allocate_bd(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	const struct fs_platform_info *fpi = fep->fpi;
+	long offset;
 
-	fep->ring_mem_addr = cpm_dpalloc((fpi->tx_ring + fpi->rx_ring) *
+	offset = cpm_dpalloc((fpi->tx_ring + fpi->rx_ring) *
 					 sizeof(cbd_t), 8);
-	if (IS_DPERR(fep->ring_mem_addr))
+	if (offset < 0)
 		return -ENOMEM;
 
+	fep->ring_mem_addr = (uint) offset;
 	fep->ring_base = cpm_dpram_addr(fep->ring_mem_addr);
 
 	return 0;
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index dab88b9..aad1eee 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -362,14 +362,14 @@ static int fill_init_enet_entries(struct ucc_geth_private *ugeth,
 		/* First entry of Rx does not have page */
 			init_enet_offset = 0;
 		else {
-			init_enet_offset =
-			    qe_muram_alloc(thread_size, thread_alignment);
-			if (IS_MURAM_ERR(init_enet_offset)) {
+			long offset = qe_muram_alloc(thread_size, thread_alignment);
+			if (offset < 0) {
 				ugeth_err
 		("fill_init_enet_entries: Can not allocate DPRAM memory.");
 				qe_put_snum((u8) snum);
 				return -ENOMEM;
 			}
+			init_enet_offset = (u32) offset;
 		}
 		*(p_start++) =
 		    ((u8) snum << ENET_INIT_PARAM_SNUM_SHIFT) | init_enet_offset
@@ -2547,6 +2547,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	u8 function_code = 0;
 	u8 *bd, *endOfRing;
 	u8 numThreadsRxNumerical, numThreadsTxNumerical;
+	long offset;
 
 	ugeth_vdbg("%s: IN", __FUNCTION__);
 
@@ -2804,20 +2805,19 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			if (UCC_GETH_TX_BD_RING_ALIGNMENT > 4)
 				align = UCC_GETH_TX_BD_RING_ALIGNMENT;
 			ugeth->tx_bd_ring_offset[j] =
-				kmalloc((u32) (length + align), GFP_KERNEL);
+				(u32) kmalloc(length + align, GFP_KERNEL);
 
 			if (ugeth->tx_bd_ring_offset[j] != 0)
 				ugeth->p_tx_bd_ring[j] =
 					(void*)((ugeth->tx_bd_ring_offset[j] +
 					align) & ~(align - 1));
 		} else if (uf_info->bd_mem_part == MEM_PART_MURAM) {
-			ugeth->tx_bd_ring_offset[j] =
-			    qe_muram_alloc(length,
-					   UCC_GETH_TX_BD_RING_ALIGNMENT);
-			if (!IS_MURAM_ERR(ugeth->tx_bd_ring_offset[j]))
+			offset = qe_muram_alloc(length, UCC_GETH_TX_BD_RING_ALIGNMENT);
+			if (offset >= 0) {
+				ugeth->tx_bd_ring_offset[j] = (u32) offset;
 				ugeth->p_tx_bd_ring[j] =
-				    (u8 *) qe_muram_addr(ugeth->
-							 tx_bd_ring_offset[j]);
+					qe_muram_addr(ugeth->tx_bd_ring_offset[j]);
+			}
 		}
 		if (!ugeth->p_tx_bd_ring[j]) {
 			ugeth_err
@@ -2840,19 +2840,18 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			if (UCC_GETH_RX_BD_RING_ALIGNMENT > 4)
 				align = UCC_GETH_RX_BD_RING_ALIGNMENT;
 			ugeth->rx_bd_ring_offset[j] =
-				kmalloc((u32) (length + align), GFP_KERNEL);
+				(u32) kmalloc(length + align, GFP_KERNEL);
 			if (ugeth->rx_bd_ring_offset[j] != 0)
 				ugeth->p_rx_bd_ring[j] =
 					(void*)((ugeth->rx_bd_ring_offset[j] +
 					align) & ~(align - 1));
 		} else if (uf_info->bd_mem_part == MEM_PART_MURAM) {
-			ugeth->rx_bd_ring_offset[j] =
-			    qe_muram_alloc(length,
-					   UCC_GETH_RX_BD_RING_ALIGNMENT);
-			if (!IS_MURAM_ERR(ugeth->rx_bd_ring_offset[j]))
+			offset = qe_muram_alloc(length, UCC_GETH_RX_BD_RING_ALIGNMENT);
+			if (offset >= 0) {
+				ugeth->rx_bd_ring_offset[j] = (u32) offset;
 				ugeth->p_rx_bd_ring[j] =
-				    (u8 *) qe_muram_addr(ugeth->
-							 rx_bd_ring_offset[j]);
+					qe_muram_addr(ugeth->rx_bd_ring_offset[j]);
+			}
 		}
 		if (!ugeth->p_rx_bd_ring[j]) {
 			ugeth_err
@@ -2930,19 +2929,18 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	 */
 	/* Tx global PRAM */
 	/* Allocate global tx parameter RAM page */
-	ugeth->tx_glbl_pram_offset =
-	    qe_muram_alloc(sizeof(struct ucc_geth_tx_global_pram),
-			   UCC_GETH_TX_GLOBAL_PRAM_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->tx_glbl_pram_offset)) {
+	offset = qe_muram_alloc(sizeof(struct ucc_geth_tx_global_pram),
+                UCC_GETH_TX_GLOBAL_PRAM_ALIGNMENT);
+
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_tx_glbl_pram.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-	ugeth->p_tx_glbl_pram =
-	    (struct ucc_geth_tx_global_pram *) qe_muram_addr(ugeth->
-							tx_glbl_pram_offset);
+	ugeth->tx_glbl_pram_offset = (u32) offset;
+	ugeth->p_tx_glbl_pram = qe_muram_addr(ugeth->tx_glbl_pram_offset);
 	/* Zero out p_tx_glbl_pram */
 	memset(ugeth->p_tx_glbl_pram, 0, sizeof(struct ucc_geth_tx_global_pram));
 
@@ -2950,22 +2948,19 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 	/* TQPTR */
 	/* Size varies with number of Tx threads */
-	ugeth->thread_dat_tx_offset =
-	    qe_muram_alloc(numThreadsTxNumerical *
+	offset = qe_muram_alloc(numThreadsTxNumerical *
 			   sizeof(struct ucc_geth_thread_data_tx) +
 			   32 * (numThreadsTxNumerical == 1),
 			   UCC_GETH_THREAD_DATA_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->thread_dat_tx_offset)) {
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_thread_data_tx.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-
-	ugeth->p_thread_data_tx =
-	    (struct ucc_geth_thread_data_tx *) qe_muram_addr(ugeth->
-							thread_dat_tx_offset);
+	ugeth->thread_dat_tx_offset = (u32) offset;
+	ugeth->p_thread_data_tx = qe_muram_addr(ugeth->thread_dat_tx_offset);
 	out_be32(&ugeth->p_tx_glbl_pram->tqptr, ugeth->thread_dat_tx_offset);
 
 	/* vtagtable */
@@ -2979,18 +2974,17 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 	/* SQPTR */
 	/* Size varies with number of Tx queues */
-	ugeth->send_q_mem_reg_offset =
-	    qe_muram_alloc(ug_info->numQueuesTx *
+	offset = qe_muram_alloc(ug_info->numQueuesTx *
 			   sizeof(struct ucc_geth_send_queue_qd),
 			   UCC_GETH_SEND_QUEUE_QUEUE_DESCRIPTOR_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->send_q_mem_reg_offset)) {
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_send_q_mem_reg.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-
+	ugeth->send_q_mem_reg_offset = (u32) offset;
 	ugeth->p_send_q_mem_reg =
 	    (struct ucc_geth_send_queue_mem_region *) qe_muram_addr(ugeth->
 			send_q_mem_reg_offset);
@@ -3023,20 +3017,17 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 	if (ug_info->numQueuesTx > 1) {
 	/* scheduler exists only if more than 1 tx queue */
-		ugeth->scheduler_offset =
-		    qe_muram_alloc(sizeof(struct ucc_geth_scheduler),
+		offset = qe_muram_alloc(sizeof(struct ucc_geth_scheduler),
 				   UCC_GETH_SCHEDULER_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->scheduler_offset)) {
+		if (offset < 0) {
 			ugeth_err
 			 ("%s: Can not allocate DPRAM memory for p_scheduler.",
 			     __FUNCTION__);
 			ucc_geth_memclean(ugeth);
 			return -ENOMEM;
 		}
-
-		ugeth->p_scheduler =
-		    (struct ucc_geth_scheduler *) qe_muram_addr(ugeth->
-							   scheduler_offset);
+		ugeth->scheduler_offset = (u32) offset;
+		ugeth->p_scheduler = qe_muram_addr(ugeth->scheduler_offset);
 		out_be32(&ugeth->p_tx_glbl_pram->schedulerbasepointer,
 			 ugeth->scheduler_offset);
 		/* Zero out p_scheduler */
@@ -3070,20 +3061,18 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* TxRMON_PTR (statistics) */
 	if (ug_info->
 	    statisticsMode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX) {
-		ugeth->tx_fw_statistics_pram_offset =
-		    qe_muram_alloc(sizeof
-				   (struct ucc_geth_tx_firmware_statistics_pram),
+		offset = qe_muram_alloc(sizeof(struct ucc_geth_tx_firmware_statistics_pram),
 				   UCC_GETH_TX_STATISTICS_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->tx_fw_statistics_pram_offset)) {
+		if (offset < 0) {
 			ugeth_err
 			    ("%s: Can not allocate DPRAM memory for"
 				" p_tx_fw_statistics_pram.", __FUNCTION__);
 			ucc_geth_memclean(ugeth);
 			return -ENOMEM;
 		}
+		ugeth->tx_fw_statistics_pram_offset = (u32) offset;
 		ugeth->p_tx_fw_statistics_pram =
-		    (struct ucc_geth_tx_firmware_statistics_pram *)
-		    qe_muram_addr(ugeth->tx_fw_statistics_pram_offset);
+			qe_muram_addr(ugeth->tx_fw_statistics_pram_offset);
 		/* Zero out p_tx_fw_statistics_pram */
 		memset(ugeth->p_tx_fw_statistics_pram,
 		       0, sizeof(struct ucc_geth_tx_firmware_statistics_pram));
@@ -3110,19 +3099,17 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 	/* Rx global PRAM */
 	/* Allocate global rx parameter RAM page */
-	ugeth->rx_glbl_pram_offset =
-	    qe_muram_alloc(sizeof(struct ucc_geth_rx_global_pram),
+	offset = qe_muram_alloc(sizeof(struct ucc_geth_rx_global_pram),
 			   UCC_GETH_RX_GLOBAL_PRAM_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->rx_glbl_pram_offset)) {
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_rx_glbl_pram.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-	ugeth->p_rx_glbl_pram =
-	    (struct ucc_geth_rx_global_pram *) qe_muram_addr(ugeth->
-							rx_glbl_pram_offset);
+	ugeth->rx_glbl_pram_offset = (u32) offset;
+	ugeth->p_rx_glbl_pram = qe_muram_addr(ugeth->rx_glbl_pram_offset);
 	/* Zero out p_rx_glbl_pram */
 	memset(ugeth->p_rx_glbl_pram, 0, sizeof(struct ucc_geth_rx_global_pram));
 
@@ -3130,40 +3117,37 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 	/* RQPTR */
 	/* Size varies with number of Rx threads */
-	ugeth->thread_dat_rx_offset =
-	    qe_muram_alloc(numThreadsRxNumerical *
+	offset = qe_muram_alloc(numThreadsRxNumerical *
 			   sizeof(struct ucc_geth_thread_data_rx),
 			   UCC_GETH_THREAD_DATA_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->thread_dat_rx_offset)) {
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_thread_data_rx.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-
-	ugeth->p_thread_data_rx =
-	    (struct ucc_geth_thread_data_rx *) qe_muram_addr(ugeth->
-							thread_dat_rx_offset);
+	ugeth->thread_dat_rx_offset = (u32) offset;
+	ugeth->p_thread_data_rx = qe_muram_addr(ugeth->thread_dat_rx_offset);
 	out_be32(&ugeth->p_rx_glbl_pram->rqptr, ugeth->thread_dat_rx_offset);
 
 	/* typeorlen */
 	out_be16(&ugeth->p_rx_glbl_pram->typeorlen, ug_info->typeorlen);
 
 	/* rxrmonbaseptr (statistics) */
-	if (ug_info->
-	    statisticsMode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_RX) {
-		ugeth->rx_fw_statistics_pram_offset =
-		    qe_muram_alloc(sizeof
-				   (struct ucc_geth_rx_firmware_statistics_pram),
-				   UCC_GETH_RX_STATISTICS_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->rx_fw_statistics_pram_offset)) {
+	if (ug_info->statisticsMode &
+	    UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_RX) {
+		offset = qe_muram_alloc(
+			sizeof(struct ucc_geth_rx_firmware_statistics_pram),
+                        UCC_GETH_RX_STATISTICS_ALIGNMENT);
+		if (offset < 0) {
 			ugeth_err
 				("%s: Can not allocate DPRAM memory for"
 				" p_rx_fw_statistics_pram.", __FUNCTION__);
 			ucc_geth_memclean(ugeth);
 			return -ENOMEM;
 		}
+		ugeth->rx_fw_statistics_pram_offset = (u32) offset;
 		ugeth->p_rx_fw_statistics_pram =
 		    (struct ucc_geth_rx_firmware_statistics_pram *)
 		    qe_muram_addr(ugeth->rx_fw_statistics_pram_offset);
@@ -3175,21 +3159,19 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* intCoalescingPtr */
 
 	/* Size varies with number of Rx queues */
-	ugeth->rx_irq_coalescing_tbl_offset =
-	    qe_muram_alloc(ug_info->numQueuesRx *
+	offset = qe_muram_alloc(ug_info->numQueuesRx *
 			   sizeof(struct ucc_geth_rx_interrupt_coalescing_entry),
 			   UCC_GETH_RX_INTERRUPT_COALESCING_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->rx_irq_coalescing_tbl_offset)) {
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for"
 			" p_rx_irq_coalescing_tbl.", __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-
+	ugeth->rx_irq_coalescing_tbl_offset = (u32) offset;
 	ugeth->p_rx_irq_coalescing_tbl =
-	    (struct ucc_geth_rx_interrupt_coalescing_table *)
-	    qe_muram_addr(ugeth->rx_irq_coalescing_tbl_offset);
+		qe_muram_addr(ugeth->rx_irq_coalescing_tbl_offset);
 	out_be32(&ugeth->p_rx_glbl_pram->intcoalescingptr,
 		 ugeth->rx_irq_coalescing_tbl_offset);
 
@@ -3242,22 +3224,19 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 	/* RBDQPTR */
 	/* Size varies with number of Rx queues */
-	ugeth->rx_bd_qs_tbl_offset =
-	    qe_muram_alloc(ug_info->numQueuesRx *
+	offset = qe_muram_alloc(ug_info->numQueuesRx *
 			   (sizeof(struct ucc_geth_rx_bd_queues_entry) +
 			    sizeof(struct ucc_geth_rx_prefetched_bds)),
 			   UCC_GETH_RX_BD_QUEUES_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->rx_bd_qs_tbl_offset)) {
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_rx_bd_qs_tbl.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-
-	ugeth->p_rx_bd_qs_tbl =
-	    (struct ucc_geth_rx_bd_queues_entry *) qe_muram_addr(ugeth->
-				    rx_bd_qs_tbl_offset);
+	ugeth->rx_bd_qs_tbl_offset = (u32) offset;
+	ugeth->p_rx_bd_qs_tbl = qe_muram_addr(ugeth->rx_bd_qs_tbl_offset);
 	out_be32(&ugeth->p_rx_glbl_pram->rbdqptr, ugeth->rx_bd_qs_tbl_offset);
 	/* Zero out p_rx_bd_qs_tbl */
 	memset(ugeth->p_rx_bd_qs_tbl,
@@ -3333,20 +3312,18 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 		/* Allocate memory for extended filtering Mode Global
 		Parameters */
-		ugeth->exf_glbl_param_offset =
-		    qe_muram_alloc(sizeof(struct ucc_geth_exf_global_pram),
-		UCC_GETH_RX_EXTENDED_FILTERING_GLOBAL_PARAMETERS_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->exf_glbl_param_offset)) {
+		offset = qe_muram_alloc(sizeof(struct ucc_geth_exf_global_pram),
+                        UCC_GETH_RX_EXTENDED_FILTERING_GLOBAL_PARAMETERS_ALIGNMENT);
+		if (offset < 0) {
 			ugeth_err
 				("%s: Can not allocate DPRAM memory for"
 				" p_exf_glbl_param.", __FUNCTION__);
 			ucc_geth_memclean(ugeth);
 			return -ENOMEM;
 		}
-
+		ugeth->exf_glbl_param_offset = (u32) offset;
 		ugeth->p_exf_glbl_param =
-		    (struct ucc_geth_exf_global_pram *) qe_muram_addr(ugeth->
-				 exf_glbl_param_offset);
+			qe_muram_addr(ugeth->exf_glbl_param_offset);
 		out_be32(&ugeth->p_rx_glbl_pram->exfGlobalParam,
 			 ugeth->exf_glbl_param_offset);
 		out_be32(&ugeth->p_exf_glbl_param->l2pcdptr,
@@ -3484,16 +3461,16 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	}
 
 	/* Allocate InitEnet command parameter structure */
-	init_enet_pram_offset = qe_muram_alloc(sizeof(struct ucc_geth_init_pram), 4);
-	if (IS_MURAM_ERR(init_enet_pram_offset)) {
+	offset = qe_muram_alloc(sizeof(struct ucc_geth_init_pram), 4);
+	if (offset < 0) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_init_enet_pram.",
 		     __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-	p_init_enet_pram =
-	    (struct ucc_geth_init_pram *) qe_muram_addr(init_enet_pram_offset);
+	init_enet_pram_offset = (u32) offset;
+	p_init_enet_pram = qe_muram_addr(init_enet_pram_offset);
 
 	/* Copy shadow InitEnet command parameter structure into PRAM */
 	p_init_enet_pram->resinit1 = ugeth->p_init_enet_param_shadow->resinit1;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 925fb60..dfb7e73 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -125,7 +125,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 {
 	int dpmemsz, memsz;
 	u8 *dp_mem;
-	uint dp_offset;
+	long dp_offset;
 	u8 *mem_addr;
 	dma_addr_t dma_addr = 0;
 
@@ -133,7 +133,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 
 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_DPERR(dp_offset)) {
+	if (dp_offset < 0) {
 		printk(KERN_ERR
 		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index fa45599..89943e0 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -222,7 +222,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 {
 	int dpmemsz, memsz;
 	u8 *dp_mem;
-	uint dp_offset;
+	long dp_offset;
 	u8 *mem_addr;
 	dma_addr_t dma_addr = 0;
 
@@ -230,7 +230,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 
 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_DPERR(dp_offset)) {
+	if (dp_offset < 0) {
 		printk(KERN_ERR
 		       "cpm_uart_cpm.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index a62168e..2dd5ed2 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -38,9 +38,9 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
 void qe_setbrg(u32 brg, u32 rate);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
-u32 qe_muram_alloc(u32 size, u32 align);
+long qe_muram_alloc(u32 size, u32 align);
 int qe_muram_free(u32 offset);
-u32 qe_muram_alloc_fixed(u32 offset, u32 size);
+long qe_muram_alloc_fixed(u32 offset, u32 size);
 void qe_muram_dump(void);
 void *qe_muram_addr(u32 offset);
 
@@ -448,10 +448,5 @@ struct ucc_slow_pram {
 #define UCC_FAST_FUNCTION_CODE_DTB_LCL	0x02
 #define UCC_FAST_FUNCTION_CODE_BDB_LCL	0x01
 
-static inline long IS_MURAM_ERR(const u32 offset)
-{
-	return offset > (u32) - 1000L;
-}
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_QE_H */
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
index 4f99df1..51213f3 100644
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -63,18 +63,13 @@
 #define CPM_DATAONLY_SIZE	((uint)0x0700)
 #define CPM_DP_NOSPACE		((uint)0x7fffffff)
 
-static inline long IS_DPERR(const uint offset)
-{
-	return (uint)offset > (uint)-1000L;
-}
-
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
 extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
 extern uint cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(uint offset);
-extern uint cpm_dpalloc_fixed(uint offset, uint size, uint align);
+extern long cpm_dpalloc_fixed(uint offset, uint size, uint align);
 extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(uint offset);
 extern uint cpm_dpram_phys(u8* addr);
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 220cc2d..64e68bf 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -104,11 +104,6 @@
  */
 #define NUM_CPM_HOST_PAGES	2
 
-static inline long IS_DPERR(const uint offset)
-{
-	return (uint)offset > (uint)-1000L;
-}
-
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
diff --git a/include/asm-ppc/rheap.h b/include/asm-ppc/rheap.h
index 39a10d8..3b7eb90 100644
--- a/include/asm-ppc/rheap.h
+++ b/include/asm-ppc/rheap.h
@@ -18,7 +18,7 @@
 
 typedef struct _rh_block {
 	struct list_head list;
-	void *start;
+	unsigned long start;
 	int size;
 	const char *owner;
 } rh_block_t;
@@ -37,8 +37,8 @@ typedef struct _rh_info {
 #define RHIF_STATIC_INFO	0x1
 #define RHIF_STATIC_BLOCK	0x2
 
-typedef struct rh_stats_t {
-	void *start;
+typedef struct _rh_stats {
+	unsigned long start;
 	int size;
 	const char *owner;
 } rh_stats_t;
@@ -57,24 +57,24 @@ extern void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 		    rh_block_t * block);
 
 /* Attach a free region to manage */
-extern int rh_attach_region(rh_info_t * info, void *start, int size);
+extern int rh_attach_region(rh_info_t * info, unsigned long start, int size);
 
 /* Detach a free region */
-extern void *rh_detach_region(rh_info_t * info, void *start, int size);
+extern long rh_detach_region(rh_info_t * info, unsigned long start, int size);
 
 /* Allocate the given size from the remote heap (with alignment) */
-extern void *rh_alloc_align(rh_info_t * info, int size, int alignment,
+extern long rh_alloc_align(rh_info_t * info, int size, int alignment,
 		const char *owner);
 
 /* Allocate the given size from the remote heap */
-extern void *rh_alloc(rh_info_t * info, int size, const char *owner);
+extern long rh_alloc(rh_info_t * info, int size, const char *owner);
 
 /* Allocate the given size from the given address */
-extern void *rh_alloc_fixed(rh_info_t * info, void *start, int size,
+extern long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size,
 			    const char *owner);
 
 /* Free the allocated area */
-extern int rh_free(rh_info_t * info, void *start);
+extern int rh_free(rh_info_t * info, unsigned long start);
 
 /* Get stats for debugging purposes */
 extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
@@ -84,6 +84,6 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
 extern void rh_dump(rh_info_t * info);
 
 /* Set owner of taken block */
-extern int rh_set_owner(rh_info_t * info, void *start, const char *owner);
+extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
 
 #endif				/* __ASM_PPC_RHEAP_H__ */
-- 
1.5.0.2.260.g2eb065
