Message-ID: <40C5884E.40404@intracom.gr>
Date: Tue, 08 Jun 2004 12:35:10 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH]  correct dpalloc handling for 8xx
Content-Type: multipart/mixed;
 boundary="------------070304020103040100040702"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070304020103040100040702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tom

The following patch implements dpalloc/dpfree routines as we
talked about.

Also it updates the cpm_uart driver to use them.

Regards

Pantelis


--------------070304020103040100040702
Content-Type: text/x-patch;
 name="dpalloc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dpalloc.diff"

--- linuxppc_2.5/arch/ppc/8xx_io/commproc.c	Tue Jun  8 12:25:43 2004
+++ linuxppc_2.5-intracom/arch/ppc/8xx_io/commproc.c	Tue Jun  8 12:18:41 2004
@@ -36,11 +36,12 @@
 #include <asm/commproc.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
+#include <asm/rheap.h>

 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);

-static	uint	dp_alloc_base;	/* Starting offset in DP ram */
-static	uint	dp_alloc_top;	/* Max offset + 1 */
+static void m8xx_cpm_dpinit(void);
+
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
 cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
@@ -134,8 +135,7 @@

 	/* Reclaim the DP memory for our use.
 	*/
-	dp_alloc_base = CPM_DATAONLY_BASE;
-	dp_alloc_top = dp_alloc_base + CPM_DATAONLY_SIZE;
+	m8xx_cpm_dpinit();

 	/* get the PTE for the bootpage */
 	if (!get_pteptr(&init_mm, bootpage, &pte))
@@ -309,30 +309,6 @@
 }


-/* Allocate some memory from the dual ported ram.  We may want to
- * enforce alignment restrictions, but right now everyone is a good
- * citizen.
- */
-uint
-m8xx_cpm_dpalloc(uint size)
-{
-	uint	retloc;
-
-	if ((dp_alloc_base + size) >= dp_alloc_top)
-		return(CPM_DP_NOSPACE);
-
-	retloc = dp_alloc_base;
-	dp_alloc_base += size;
-
-	return(retloc);
-}
-
-uint
-m8xx_cpm_dpalloc_index(void)
-{
-	return dp_alloc_base;
-}
-
 /* We also own one page of host buffer space for the allocation of
  * UART "fifos" and the like.
  */
@@ -379,4 +355,92 @@
 	else
 		*bp = (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
 						CPM_BRG_EN | CPM_BRG_DIV16;
+}
+
+/********************************************************************************
+
+  dpalloc
+
+********************************************************************************/
+
+static spinlock_t cpm_dpmem_lock;
+/* 16 blocks should be enough to satisfy all requests
+   until the memory subsystem goes up... */
+static rh_block_t cpm_boot_dpmem_rh_block[16];
+static rh_info_t cpm_dpmem_info;
+
+/********************************************************************************/
+
+#define CPM_DPMEM_ALIGNMENT	8
+
+void m8xx_cpm_dpinit(void)
+{
+	cpm8xx_t *cp = &((immap_t *)IMAP_ADDR)->im_cpm;
+
+	spin_lock_init(&cpm_dpmem_lock);
+
+	/* initialize the info header */
+	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
+			sizeof(cpm_boot_dpmem_rh_block)/sizeof(cpm_boot_dpmem_rh_block[0]),
+			cpm_boot_dpmem_rh_block);
+
+	/* attach the usable dpmem area */
+
+	/* XXX this is actually crap. CPM_DATAONLY_BASE & CPM_DATAONLY_SIZE is only
+	 * XXX a subset of the available dpram. It varies with the processor & the
+	 * XXX microcode patches activated. But the following should be at least safe.
+	 */
+	rh_attach_region(&cpm_dpmem_info, cp->cp_dpmem + CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+}
+
+void *m8xx_cpm_dpalloc(int size)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return start;
+}
+
+int m8xx_cpm_dpfree(void *addr)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	ret = rh_free(&cpm_dpmem_info, addr);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return ret;
+}
+
+void *m8xx_cpm_dpalloc_fixed(void *addr, int size)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	start = rh_alloc_fixed(&cpm_dpmem_info, addr, size, "commproc");
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return start;
+}
+
+void m8xx_cpm_dpdump(void)
+{
+	rh_dump(&cpm_dpmem_info);
+}
+
+
+int m8xx_cpm_dpram_offset(void *addr)
+{
+	return (u_char *)addr - ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem;
+}
+
+void *m8xx_cpm_dpram_addr(int offset)
+{
+	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
 }
--- linuxppc_2.5/arch/ppc/lib/rheap.c	Thu Jan  1 02:00:00 1970
+++ linuxppc_2.5-intracom/arch/ppc/lib/rheap.c	Tue Jun  8 11:27:32 2004
@@ -0,0 +1,688 @@
+/*
+ * Remote Heap
+ *
+ * Pantelis Antoniou <panto@intracom.gr>
+ * INTRACOM S.A. Greece
+ *
+ */
+
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <asm/rheap.h>
+
+/********************************************************************************/
+
+/* fixup a list_head, needed when copying lists */
+/* if the pointers fall between s and e, apply the delta */
+/* assumes that sizeof(struct list_head *) == sizeof(unsigned long *) */
+static inline void fixup(unsigned long s, unsigned long e, int d, struct list_head *l)
+{
+	unsigned long *pp;
+
+	pp = (unsigned long *)&l->next;
+	if (*pp >= s && *pp < e)
+		*pp += d;
+
+	pp = (unsigned long *)&l->prev;
+	if (*pp >= s && *pp < e)
+		*pp += d;
+}
+
+/* grow the allocated blocks */
+static int grow(rh_info_t *info, int max_blocks)
+{
+	rh_block_t *block, *blk;
+	int i, new_blocks;
+	int delta;
+	unsigned long blks, blke;
+
+	if (max_blocks <= info->max_blocks)
+		return -EINVAL;
+
+	new_blocks = max_blocks - info->max_blocks;
+
+	block = kmalloc(sizeof(rh_block_t) * max_blocks, GFP_KERNEL);
+	if (block == NULL)
+		return -ENOMEM;
+
+	if (info->max_blocks > 0) {
+
+		/* copy old block area */
+		memcpy(block, info->block, sizeof(rh_block_t) * info->max_blocks);
+
+		delta = (char *)block - (char *)info->block;
+
+		/* and fixup list pointers */
+		blks = (unsigned long)info->block;
+		blke = (unsigned long)(info->block + info->max_blocks);
+
+		for (i = 0, blk = block; i < info->max_blocks; i++, blk++)
+			fixup(blks, blke, delta, &blk->list);
+
+		fixup(blks, blke, delta, &info->empty_list);
+		fixup(blks, blke, delta, &info->free_list);
+		fixup(blks, blke, delta, &info->taken_list);
+
+		/* free the old allocated memory */
+		if ((info->flags & RHIF_STATIC_BLOCK) == 0)
+			kfree(info->block);
+	}
+
+	info->block = block;
+	info->empty_slots += new_blocks;
+	info->max_blocks = max_blocks;
+	info->flags &= ~RHIF_STATIC_BLOCK;
+
+	/* add all new blocks to the free list */
+	for (i = 0, blk = block + info->max_blocks; i < new_blocks; i++, blk++)
+		list_add(&blk->list, &info->empty_list);
+
+	return 0;
+}
+
+/* assure at least the required amount of empty slots
+   if this function causes a grow in the block area
+   the all pointers kept to the block area are invalid!
+*/
+static int assure_empty(rh_info_t *info, int slots)
+{
+	int max_blocks;
+
+	/* this function is not meant to be used to grow uncontrollably */
+	if (slots >= 4)
+		return -EINVAL;
+
+	/* enough space */
+	if (info->empty_slots >= slots)
+		return 0;
+
+	/* next 16 sized block */
+	max_blocks = ((info->max_blocks + slots) + 15) & ~15;
+
+	return grow(info, max_blocks);
+}
+
+static rh_block_t *get_slot(rh_info_t *info)
+{
+	rh_block_t *blk;
+
+	/* if no more free slots, and failure to extend */
+	/* XXX you should have called assure_empty before */
+	if (info->empty_slots == 0) {
+		printk(KERN_ERR "rh: out of slots; crash is imminent.\n");
+		return NULL;
+	}
+
+	/* get empty slot to use */
+	blk = list_entry(info->empty_list.next, rh_block_t, list);
+	list_del_init(&blk->list);
+	info->empty_slots--;
+
+	/* initialize */
+	blk->start = NULL;
+	blk->size = 0;
+	blk->owner = NULL;
+
+	return blk;
+}
+
+static inline void release_slot(rh_info_t *info, rh_block_t *blk)
+{
+	list_add(&blk->list, &info->empty_list);
+	info->empty_slots++;
+}
+
+static void attach_free_block(rh_info_t *info, rh_block_t *blkn)
+{
+	rh_block_t *blk;
+	rh_block_t *before;
+	rh_block_t *after;
+	rh_block_t *next;
+	int size;
+	unsigned long s, e, bs, be;
+	struct list_head *l;
+
+	/* we assume that they are aligned properly */
+	size = blkn->size;
+	s = (unsigned long)blkn->start;
+	e = s + size;
+
+	/* find the blocks immediately before and after the given one (if any) */
+	before = NULL;
+	after = NULL;
+	next = NULL;
+
+	list_for_each(l, &info->free_list) {
+		blk = list_entry(l, rh_block_t, list);
+
+		bs = (unsigned long)blk->start;
+		be = bs + blk->size;
+
+		if (next == NULL && s >= bs)
+			next = blk;
+
+		if (be == s)
+			before = blk;
+
+		if (e == bs)
+			after = blk;
+
+		/* if both are not null, break now */
+		if (before != NULL && after != NULL)
+			break;
+	}
+
+	/* now check if they are really adjacent */
+	if (before != NULL && s != (unsigned long)before->start + before->size)
+		before = NULL;
+
+	if (after != NULL && e != (unsigned long)after->start)
+		after = NULL;
+
+	/* no coalescing; list insert and return */
+	if (before == NULL && after == NULL) {
+
+		if (next != NULL)
+			list_add(&blkn->list, &next->list);
+		else
+			list_add(&blkn->list, &info->free_list);
+
+		return;
+	}
+
+	/* we don't need it anymore */
+	release_slot(info, blkn);
+
+	/* grow the before block */
+	if (before != NULL && after == NULL) {
+		before->size += size;
+		return;
+	}
+
+	/* grow the after block backwards */
+	if (before == NULL && after != NULL) {
+		(int8_t *)after->start -= size;
+		after->size += size;
+		return;
+	}
+
+	/* grow the before block, and release the after block */
+	before->size += size + after->size;
+	list_del(&after->list);
+	release_slot(info, after);
+}
+
+static void attach_taken_block(rh_info_t *info, rh_block_t *blkn)
+{
+	rh_block_t *blk;
+	struct list_head *l;
+
+	/* find the block immediately before the given one (if any) */
+	list_for_each(l, &info->taken_list) {
+		blk = list_entry(l, rh_block_t, list);
+		if (blk->start > blkn->start) {
+			list_add_tail(&blkn->list, &blk->list);
+			return;
+		}
+	}
+
+	list_add_tail(&blkn->list, &info->taken_list);
+}
+
+/**********************************************************************/
+
+/* Create a remote heap dynamically.
+   Note that no memory for the blocks are allocated.
+   It will upon the first allocation
+*/
+rh_info_t *rh_create(unsigned int alignment)
+{
+	rh_info_t *info;
+
+	/* alignment must be a power of two */
+	if ((alignment & (alignment - 1)) != 0)
+		return NULL;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL)
+		return NULL;
+
+	info->alignment = alignment;
+
+	/* initially everything is empty */
+	info->block = NULL;
+	info->max_blocks = 0;
+	info->empty_slots = 0;
+	info->flags = 0;
+
+	INIT_LIST_HEAD(&info->empty_list);
+	INIT_LIST_HEAD(&info->free_list);
+	INIT_LIST_HEAD(&info->taken_list);
+
+	return info;
+}
+
+/* Destroy a dynamically created remote heap
+   Deallocate only if the areas are not static
+*/
+void rh_destroy(rh_info_t *info)
+{
+	if ((info->flags & RHIF_STATIC_BLOCK) == 0 && info->block != NULL)
+		kfree(info->block);
+
+	if ((info->flags & RHIF_STATIC_INFO) == 0)
+		kfree(info);
+}
+
+/********************************************************************************/
+
+/* Initialize in place a remote heap info block.
+   This is needed to support operation very early in the startup of the
+   kernel, when it is not yet safe to call kmalloc.
+*/
+void rh_init(rh_info_t *info, unsigned int alignment, int max_blocks, rh_block_t *block)
+{
+	int i;
+	rh_block_t *blk;
+
+	/* alignment must be a power of two */
+	if ((alignment & (alignment - 1)) != 0)
+		return;
+
+	info->alignment = alignment;
+
+	/* initially everything is empty */
+	info->block = block;
+	info->max_blocks = max_blocks;
+	info->empty_slots = max_blocks;
+	info->flags = RHIF_STATIC_INFO | RHIF_STATIC_BLOCK;
+
+	INIT_LIST_HEAD(&info->empty_list);
+	INIT_LIST_HEAD(&info->free_list);
+	INIT_LIST_HEAD(&info->taken_list);
+
+	/* add all new blocks to the free list */
+	for (i = 0, blk = block; i < max_blocks; i++, blk++)
+		list_add(&blk->list, &info->empty_list);
+}
+
+/********************************************************************************/
+
+/* Attach a free memory region, coalesces regions if adjuscent */
+int rh_attach_region(rh_info_t *info, void *start, int size)
+{
+	rh_block_t *blk;
+	unsigned long s, e, m;
+	int r;
+
+	/* the region must be aligned */
+	s = (unsigned long)start;
+	e = s + size;
+	m = info->alignment - 1;
+
+	/* round start up */
+	s = (s + m) & ~m;
+
+	/* round end down */
+	e = e & ~m;
+
+	/* take final values */
+	start = (void *)s;
+	size = (int)(e - s);
+
+	/* grow the blocks, if needed */
+	r = assure_empty(info, 1);
+	if (r < 0)
+		return r;
+
+	blk = get_slot(info);
+	blk->start = start;
+	blk->size = size;
+	blk->owner = NULL;
+
+	attach_free_block(info, blk);
+
+	return 0;
+}
+
+/* Detatch given address range, splits free block if needed. */
+void *rh_detach_region(rh_info_t *info, void *start, int size)
+{
+	struct list_head *l;
+	rh_block_t *blk, *newblk;
+	unsigned long s, e, m, bs, be;
+
+	/* validate size */
+	if (size <= 0)
+		return NULL;
+
+	/* the region must be aligned */
+	s = (unsigned long)start;
+	e = s + size;
+	m = info->alignment - 1;
+
+	/* round start up */
+	s = (s + m) & ~m;
+
+	/* round end down */
+	e = e & ~m;
+
+	if (assure_empty(info, 1) < 0)
+		return NULL;
+
+	blk = NULL;
+	list_for_each(l, &info->free_list) {
+		blk = list_entry(l, rh_block_t, list);
+		/* the range must lie entirely inside one free block */
+		bs = (unsigned long)blk->start;
+		be = (unsigned long)blk->start + blk->size;
+		if (s >= bs && e <= be)
+			break;
+		blk = NULL;
+	}
+
+	if (blk == NULL)
+		return NULL;
+
+	/* perfect fit */
+	if (bs == s && be == e) {
+		/* delete from free list, release slot */
+		list_del(&blk->list);
+		release_slot(info, blk);
+		return (void *)s;
+	}
+
+	/* blk still in free list, with updated start and/or size */
+	if (bs == s || be == e) {
+		if (bs == s)
+			(int8_t *)blk->start += size;
+		blk->size  -= size;
+
+	} else {
+		/* the front free fragment */
+		blk->size = s - bs;
+
+		/* the back free fragment */
+		newblk = get_slot(info);
+		newblk->start = (void *)e;
+		newblk->size = be - e;
+
+		list_add(&newblk->list, &blk->list);
+	}
+
+	return (void *)s;
+}
+
+/********************************************************************************/
+
+void *rh_alloc(rh_info_t *info, int size, const char *owner)
+{
+	struct list_head *l;
+	rh_block_t *blk;
+	rh_block_t *newblk;
+	void *start;
+
+	/* validate size */
+	if (size <= 0)
+		return NULL;
+
+	/* align to configured alignment */
+	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
+
+	if (assure_empty(info, 1) < 0)
+		return NULL;
+
+	blk = NULL;
+	list_for_each(l, &info->free_list) {
+		blk = list_entry(l, rh_block_t, list);
+		if (size <= blk->size)
+			break;
+		blk = NULL;
+	}
+
+	if (blk == NULL)
+		return NULL;
+
+	/* just fits */
+	if (blk->size == size) {
+		/* move from free list to taken list */
+		list_del(&blk->list);
+		blk->owner = owner;
+		start = blk->start;
+
+		attach_taken_block(info, blk);
+
+		return start;
+	}
+
+	newblk = get_slot(info);
+	newblk->start = blk->start;
+	newblk->size  = size;
+	newblk->owner = owner;
+
+	/* blk still in free list, with updated start, size */
+	(int8_t *)blk->start += size;
+	blk->size  -= size;
+
+	start = newblk->start;
+
+	attach_taken_block(info, newblk);
+
+	return start;
+}
+
+/* allocate at precisely the given address */
+void *rh_alloc_fixed(rh_info_t *info, void *start, int size, const char *owner)
+{
+	struct list_head *l;
+	rh_block_t *blk, *newblk1, *newblk2;
+	unsigned long s, e, m, bs, be;
+
+	/* validate size */
+	if (size <= 0)
+		return NULL;
+
+	/* the region must be aligned */
+	s = (unsigned long)start;
+	e = s + size;
+	m = info->alignment - 1;
+
+	/* round start up */
+	s = (s + m) & ~m;
+
+	/* round end down */
+	e = e & ~m;
+
+	if (assure_empty(info, 2) < 0)
+		return NULL;
+
+	blk = NULL;
+	list_for_each(l, &info->free_list) {
+		blk = list_entry(l, rh_block_t, list);
+		/* the range must lie entirely inside one free block */
+		bs = (unsigned long)blk->start;
+		be = (unsigned long)blk->start + blk->size;
+		if (s >= bs && e <= be)
+			break;
+	}
+
+	if (blk == NULL)
+		return NULL;
+
+	/* perfect fit */
+	if (bs == s && be == e) {
+		/* move from free list to taken list */
+		list_del(&blk->list);
+		blk->owner = owner;
+
+		start = blk->start;
+		attach_taken_block(info, blk);
+
+		return start;
+
+	}
+
+	/* blk still in free list, with updated start and/or size */
+	if (bs == s || be == e) {
+		if (bs == s)
+			(int8_t *)blk->start += size;
+		blk->size  -= size;
+
+	} else {
+		/* the front free fragment */
+		blk->size = s - bs;
+
+		/* the back free fragment */
+		newblk2 = get_slot(info);
+		newblk2->start = (void *)e;
+		newblk2->size = be - e;
+
+		list_add(&newblk2->list, &blk->list);
+	}
+
+	newblk1 = get_slot(info);
+	newblk1->start = (void *)s;
+	newblk1->size  = e - s;
+	newblk1->owner = owner;
+
+	start = newblk1->start;
+	attach_taken_block(info, newblk1);
+
+	return start;
+}
+
+int rh_free(rh_info_t *info, void *start)
+{
+	rh_block_t *blk, *blk2;
+	struct list_head *l;
+	int size;
+
+	/* linear search for block */
+
+	blk = NULL;
+	list_for_each(l, &info->taken_list) {
+		blk2 = list_entry(l, rh_block_t, list);
+		if (start < blk2->start)
+			break;
+		blk = blk2;
+	}
+
+	if (blk == NULL || start > (blk->start + blk->size))
+		return -EINVAL;
+
+	/* remove from taken list */
+	list_del(&blk->list);
+
+	/* get size of freed block */
+	size = blk->size;
+	attach_free_block(info, blk);
+
+	return size;
+}
+
+int rh_get_stats(rh_info_t *info, int what, int max_stats, rh_stats_t *stats)
+{
+	rh_block_t *blk;
+	struct list_head *l;
+	struct list_head *h;
+	int nr;
+
+	switch (what) {
+
+	case RHGS_FREE:
+		h = &info->free_list;
+		break;
+
+	case RHGS_TAKEN:
+		h = &info->taken_list;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* linear search for block */
+	nr = 0;
+	list_for_each(l, h) {
+		blk = list_entry(l, rh_block_t, list);
+		if (stats != NULL && nr < max_stats) {
+			stats->start = blk->start;
+			stats->size = blk->size;
+			stats->owner = blk->owner;
+			stats++;
+		}
+		nr++;
+	}
+
+	return nr;
+}
+
+int rh_set_owner(rh_info_t *info, void *start, const char *owner)
+{
+	rh_block_t *blk, *blk2;
+	struct list_head *l;
+	int size;
+
+	/* linear search for block */
+	blk = NULL;
+	list_for_each(l, &info->taken_list) {
+		blk2 = list_entry(l, rh_block_t, list);
+		if (start < blk2->start)
+			break;
+		blk = blk2;
+	}
+
+	if (blk == NULL || start > (blk->start + blk->size))
+		return -EINVAL;
+
+	blk->owner = owner;
+
+	return size;
+}
+
+/********************************************************************************/
+
+void rh_dump(rh_info_t *info)
+{
+	static rh_stats_t st[32];	/* XXX maximum 32 blocks */
+	int maxnr;
+	int i, nr;
+
+	maxnr = sizeof(st) / sizeof(st[0]);
+
+	printk(KERN_INFO
+		"info @0x%p (%d slots empty / %d max)\n",
+		info, info->empty_slots, info->max_blocks);
+
+	printk(KERN_INFO "  Free:\n");
+	nr = rh_get_stats(info, RHGS_FREE, maxnr, st);
+	if (nr > maxnr)
+		nr = maxnr;
+	for (i = 0; i < nr; i++)
+		printk(KERN_INFO
+			"    0x%p-0x%p (%u)\n",
+			st[i].start, (int8_t *)st[i].start + st[i].size, st[i].size);
+	printk(KERN_INFO "\n");
+
+	printk(KERN_INFO "  Taken:\n");
+	nr = rh_get_stats(info, RHGS_TAKEN, maxnr, st);
+	if (nr > maxnr)
+		nr = maxnr;
+	for (i = 0; i < nr; i++)
+		printk(KERN_INFO
+			"    0x%p-0x%p (%u) %s\n",
+			st[i].start, (int8_t *)st[i].start + st[i].size, st[i].size,
+			st[i].owner != NULL ? st[i].owner : "");
+	printk(KERN_INFO "\n");
+}
+
+void rh_dump_blk(rh_info_t *info, rh_block_t *blk)
+{
+	printk(KERN_INFO
+		"blk @0x%p: 0x%p-0x%p (%u)\n",
+		blk, blk->start, (int8_t *)blk->start + blk->size, blk->size);
+}
--- linuxppc_2.5/drivers/serial/cpm_uart/cpm_uart_cpm1.c	Tue Jun  8 12:26:29 2004
+++ linuxppc_2.5-intracom/drivers/serial/cpm_uart/cpm_uart_cpm1.c	Tue Jun  8 12:18:42 2004
@@ -129,6 +129,7 @@
 int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 {
 	int dpmemsz, memsz;
+	u8 *dp_mem;
 	uint dp_addr;
 	u8 *mem_addr;
 	dma_addr_t dma_addr;
@@ -136,12 +137,13 @@
 	pr_debug("CPM uart[%d]:allocbuf\n", pinfo->port.line);

 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
-	dp_addr = m8xx_cpm_dpalloc(dpmemsz);
-	if (dp_addr == CPM_DP_NOSPACE) {
+	dp_mem = m8xx_cpm_dpalloc(dpmemsz);
+	if (dp_mem == NULL) {
 		printk(KERN_ERR
 		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
 	}
+	dp_addr = m8xx_cpm_dpram_offset(dp_mem);

 	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
 	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
@@ -155,7 +157,7 @@
 	/* We cant really from memory allocated via cpm2_dpalloc,
 	 * fix this if in the future we can */
 	if (mem_addr == NULL) {
-		/* XXX cpm_dpalloc does not yet free */
+		m8xx_cpm_dpfree(dp_mem);
 		printk(KERN_ERR
 		       "cpm_uart_cpm1.c: could not allocate coherent memory\n");
 		return -ENOMEM;
@@ -169,7 +171,7 @@
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
 						       * pinfo->rx_fifosize);

-	pinfo->rx_bd_base = (volatile cbd_t *)(DPRAM_BASE + dp_addr);
+	pinfo->rx_bd_base = dp_mem;
 	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;

 	return 0;
@@ -183,7 +185,7 @@
 					 pinfo->tx_fifosize), pinfo->mem_addr,
 			  pinfo->dma_addr);

-	/* XXX cannot free dpmem yet */
+	m8xx_cpm_dpfree(m8xx_cpm_dpram_addr(pinfo->dp_addr));
 }

 /* Setup any dynamic params in the uart desc */
--- linuxppc_2.5/include/asm-ppc/commproc.h	Tue Jun  8 12:26:55 2004
+++ linuxppc_2.5-intracom/include/asm-ppc/commproc.h	Tue Jun  8 12:18:42 2004
@@ -677,11 +677,14 @@
 		void (*handler)(void *, struct pt_regs *regs), void *dev_id);
 extern void cpm_free_handler(int vec);

-extern uint m8xx_cpm_dpalloc(uint size);
-extern int  m8xx_cpm_dpfree(uint offset);
-extern uint m8xx_cpm_dpalloc_fixed(uint offset, uint size);
-extern void m8xx_cpm_dpdump(void);
+extern void *m8xx_cpm_dpalloc(int size);
+extern int   m8xx_cpm_dpfree(void *addr);
+extern void *m8xx_cpm_dpalloc_fixed(void *addr, int size);
+extern void  m8xx_cpm_dpdump(void);
+extern int   m8xx_cpm_dpram_offset(void *addr);
+extern void *m8xx_cpm_dpram_addr(int offset);

+/* these must die! */
 extern uint m8xx_cpm_hostalloc(uint size);
 extern int  m8xx_cpm_hostfree(uint start);
 extern void m8xx_cpm_hostdump(void);
--- linuxppc_2.5/include/asm-ppc/rheap.h	Thu Jan  1 02:00:00 1970
+++ linuxppc_2.5-intracom/include/asm-ppc/rheap.h	Tue Jun  8 11:24:46 2004
@@ -0,0 +1,92 @@
+/*
+ * Remote Heap
+ *
+ * Pantelis Antoniou <panto@intracom.gr>
+ * INTRACOM S.A. Greece
+ *
+ * Header file for the implementation of a remote heap.
+ *
+ * Remote means that we don't touch the memory that the heap
+ * points to. Normal heap implementations use the memory
+ * they manage to place their list. We cannot do that
+ * because the memory we manage may have special
+ * properties, for example it is uncachable or of
+ * different endianess.
+ *
+ */
+
+#ifndef RHEAP_H
+#define RHEAP_H
+
+#include <linux/list.h>
+
+/********************************************************************************/
+
+typedef struct _rh_block {
+	struct list_head list;
+	void *start;
+	int size;
+	const char *owner;
+} rh_block_t;
+
+typedef struct _rh_info {
+	unsigned int alignment;
+	int max_blocks;
+	int empty_slots;
+	rh_block_t *block;
+	struct list_head empty_list;
+	struct list_head free_list;
+	struct list_head taken_list;
+	unsigned int flags;
+} rh_info_t;
+
+#define RHIF_STATIC_INFO	0x1
+#define RHIF_STATIC_BLOCK	0x2
+
+typedef struct rh_stats_t {
+	void *start;
+	int size;
+	const char *owner;
+} rh_stats_t;
+
+#define RHGS_FREE	0
+#define RHGS_TAKEN	1
+
+/********************************************************************************/
+
+/* create a remote heap dynamically */
+rh_info_t *rh_create(unsigned int alignment);
+
+/* destroy a remote heap, created by rh_create() */
+void rh_destroy(rh_info_t *info);
+
+/* initialize in place a remote info block */
+void rh_init(rh_info_t *info, unsigned int alignment, int max_blocks, rh_block_t *block);
+
+/* attach a free region to manage */
+int rh_attach_region(rh_info_t *info, void *start, int size);
+
+/* detach a free region */
+void *rh_detach_region(rh_info_t *info, void *start, int size);
+
+/* allocate the given size from the remote heap */
+void *rh_alloc(rh_info_t *info, int size, const char *owner);
+
+/* allocate the given size from the given address */
+void *rh_alloc_fixed(rh_info_t *info, void *start, int size, const char *owner);
+
+/* free the allocated area */
+int rh_free(rh_info_t *info, void *start);
+
+/* get stats for debugging purposes */
+int rh_get_stats(rh_info_t *info, int what, int max_stats, rh_stats_t *stats);
+
+/* simple dump of remote heap info */
+void rh_dump(rh_info_t *info);
+
+/* set owner of taken block */
+int rh_set_owner(rh_info_t *info, void *start, const char *owner);
+
+/********************************************************************************/
+
+#endif

--------------070304020103040100040702--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
