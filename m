Message-ID: <3E006C94.2090503@intracom.gr>
Date: Wed, 18 Dec 2002 14:39:48 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: New style dpalloc/hostalloc routines (diff).
Content-Type: multipart/mixed;
 boundary="------------080200060901040700000000"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080200060901040700000000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry forgot to attach the patch.


--------------080200060901040700000000
Content-Type: text/plain;
 name="new_cpm_alloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new_cpm_alloc.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1190  -> 1.1191
#	arch/ppc/8xx_io/Makefile	1.8     -> 1.9
#	arch/ppc/8xx_io/commproc.c	1.19    -> 1.20
#	arch/ppc/kernel/ppc_ksyms.c	1.106   -> 1.107
#	include/asm-ppc/commproc.h	1.4     -> 1.5
#	arch/ppc/8xx_io/Config.in	1.10    -> 1.11
#	               (new)	        -> 1.1     arch/ppc/8xx_io/rheap.c
#	               (new)	        -> 1.1     arch/ppc/8xx_io/rheap.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/18	panto@macpanto.intranet.gr	1.1191
# Add support for new style dpalloc/hostalloc routines
# which properly manage memory, and permit their use in modules.
# --------------------------------------------
#
diff -Nru a/arch/ppc/8xx_io/Config.in b/arch/ppc/8xx_io/Config.in
--- a/arch/ppc/8xx_io/Config.in	Wed Dec 18 14:27:45 2002
+++ b/arch/ppc/8xx_io/Config.in	Wed Dec 18 14:27:45 2002
@@ -36,5 +36,11 @@
 bool 'Copy-Back Data Cache (else Writethrough)' CONFIG_8xx_COPYBACK
 bool 'CPU6 Silicon Errata (860 Pre Rev. C)' CONFIG_8xx_CPU6
 bool 'I2C/SPI Microcode Patch' CONFIG_UCODE_PATCH
+# Support new type of routines, usable from modules
+bool 'Use new type dpalloc routines()' CONFIG_NEW_DPALLOC
+bool 'Use new type hostalloc routines()' CONFIG_NEW_HOSTALLOC
+if [ "$CONFIG_NEW_DPALLOC" = "y" -o "$CONFIG_NEW_HOSTALLOC" = "y" ]; then
+  define_bool CONFIG_CPM_RHEAP y
+fi

 endmenu
diff -Nru a/arch/ppc/8xx_io/Makefile b/arch/ppc/8xx_io/Makefile
--- a/arch/ppc/8xx_io/Makefile	Wed Dec 18 14:27:45 2002
+++ b/arch/ppc/8xx_io/Makefile	Wed Dec 18 14:27:45 2002
@@ -17,5 +17,6 @@
 obj-$(CONFIG_SCC_ENET)	+= enet.o
 obj-$(CONFIG_UCODE_PATCH) += micropatch.o
 obj-$(CONFIG_HTDMSOUND) += cs4218_tdm.o
+obj-$(CONFIG_CPM_RHEAP)		+= rheap.o

 include $(TOPDIR)/Rules.make
diff -Nru a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
--- a/arch/ppc/8xx_io/commproc.c	Wed Dec 18 14:27:45 2002
+++ b/arch/ppc/8xx_io/commproc.c	Wed Dec 18 14:27:45 2002
@@ -38,12 +38,27 @@
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>

+#include <linux/slab.h>
+#include "rheap.h"
+
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);

+#ifndef CONFIG_NEW_DPALLOC
 static	uint	dp_alloc_base;	/* Starting offset in DP ram */
 static	uint	dp_alloc_top;	/* Max offset + 1 */
+#else
+/* needed for dpalloc_index */
+static uint faked_dp_alloc_base;
+void new_m8xx_cpm_dpinit(void);
+#endif
+
+#ifndef CONFIG_NEW_HOSTALLOC
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
+#else
+void new_m8xx_cpm_hostinit(uint bootpage);
+#endif
+
 cpm8xx_t	*cpmp;		/* Pointer to comm processor space */

 /* CPM interrupt vector functions.
@@ -59,11 +74,10 @@

 #if 1
 void
-m8xx_cpm_reset()
+m8xx_cpm_reset(uint page)
 {
 	volatile immap_t	 *imp;
 	volatile cpm8xx_t	*commproc;
-	pte_t			*pte;

 	imp = (immap_t *)IMAP_ADDR;
 	commproc = (cpm8xx_t *)&imp->im_cpm;
@@ -88,16 +102,26 @@
 	 */
 	imp->im_siu_conf.sc_sdcr = 1;

+#ifndef CONFIG_NEW_DPALLOC
 	/* Reclaim the DP memory for our use.
 	*/
 	dp_alloc_base = CPM_DATAONLY_BASE;
 	dp_alloc_top = dp_alloc_base + CPM_DATAONLY_SIZE;
+#else
+	faked_dp_alloc_base = CPM_DATAONLY_BASE;
+	new_m8xx_cpm_dpinit();
+#endif
+
+#ifdef CONFIG_NEW_HOSTALLOC
+	new_m8xx_cpm_hostinit(0);
+#endif

 	/* Tell everyone where the comm processor resides.
 	*/
 	cpmp = (cpm8xx_t *)commproc;
 }

+#ifndef CONFIG_NEW_HOSTALLOC
 /* We used to do this earlier, but have to postpone as long as possible
  * to ensure the kernel VM is now running.
  */
@@ -111,13 +135,17 @@
 	host_buffer = (uint)consistent_alloc(GFP_KERNEL, PAGE_SIZE, &physaddr);
 	host_end = host_buffer + PAGE_SIZE;
 }
+#endif
+
 #else
 void
 m8xx_cpm_reset(uint host_page_addr)
 {
 	volatile immap_t	 *imp;
 	volatile cpm8xx_t	*commproc;
+#ifndef CONFIG_NEW_HOSTALLOC
 	pte_t			*pte;
+#endif

 	imp = (immap_t *)IMAP_ADDR;
 	commproc = (cpm8xx_t *)&imp->im_cpm;
@@ -142,11 +170,16 @@
 	*/
 	imp->im_siu_conf.sc_sdcr = 1;

+#ifndef CONFIG_NEW_DPALLOC
 	/* Reclaim the DP memory for our use.
 	*/
 	dp_alloc_base = CPM_DATAONLY_BASE;
 	dp_alloc_top = dp_alloc_base + CPM_DATAONLY_SIZE;
+#else
+	new_m8xx_cpm_dpinit();
+#endif

+#ifndef CONFIG_NEW_HOSTALLOC
 	/* Set the host page for allocation.
 	*/
 	host_buffer = host_page_addr;	/* Host virtual page address */
@@ -162,6 +195,9 @@
 	else {
 		panic("Huh?  No CPM host page?");
 	}
+#else
+	new_m8xx_cpm_hostinit(host_page_addr);
+#endif

 	/* Tell everyone where the comm processor resides.
 	*/
@@ -261,6 +297,7 @@
 	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr &= ~(1 << vec);
 }

+#ifndef CONFIG_NEW_DPALLOC
 /* Allocate some memory from the dual ported ram.  We may want to
  * enforce alignment restrictions, but right now everyone is a good
  * citizen.
@@ -285,6 +322,9 @@
 	return dp_alloc_base;
 }

+#endif
+
+#ifndef CONFIG_NEW_HOSTALLOC
 /* We also own one page of host buffer space for the allocation of
  * UART "fifos" and the like.
  */
@@ -306,6 +346,7 @@

 	return(retloc);
 }
+#endif

 /* Set a baud rate generator.  This needs lots of work.  There are
  * four BRGs, any of which can be wired to any channel.
@@ -334,3 +375,352 @@
 		*bp = (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
 						CPM_BRG_EN | CPM_BRG_DIV16;
 }
+
+#ifdef CONFIG_NEW_DPALLOC
+
+/********************************************************************************
+
+  dpalloc
+
+********************************************************************************/
+
+uint
+m8xx_cpm_dpalloc(uint size)
+{
+	volatile cpm8xx_t *cp = &((volatile immap_t *)IMAP_ADDR)->im_cpm;
+	u_char *start;
+	uint ret;
+
+	start = new_m8xx_cpm_dpalloc(size, "commproc");
+	if (start == NULL)
+		return(CPM_DP_NOSPACE);
+
+	ret = start - (u_char *)cp->cp_dpmem;
+
+	if (ret + size > faked_dp_alloc_base)
+		faked_dp_alloc_base = ret + size;
+
+	return ret;
+}
+
+/* XXX this is really weird, not called from anywhere in the kernel. */
+uint
+m8xx_cpm_dpalloc_index(void)
+{
+	return faked_dp_alloc_base;
+}
+
+
+static spinlock_t cpm_dpmem_lock;
+static rh_block_t cpm_boot_dpmem_rh_block[16];	/* start with 16 blocks */
+static rh_info_t cpm_dpmem_info;
+
+/********************************************************************************/
+
+#define CPM_DPMEM_ALIGNMENT	8
+
+void new_m8xx_cpm_dpinit(void)
+{
+	volatile cpm8xx_t *cp = &((volatile immap_t *)IMAP_ADDR)->im_cpm;
+
+	spin_lock_init(&cpm_dpmem_lock);
+
+	/* initialize the info header */
+	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
+			sizeof(cpm_boot_dpmem_rh_block)/sizeof(cpm_boot_dpmem_rh_block[0]),
+			cpm_boot_dpmem_rh_block);
+
+	/* attach the usable dpmem area */
+	rh_attach_region(&cpm_dpmem_info, (u_char *)cp->cp_dpmem + CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+}
+
+void *new_m8xx_cpm_dpalloc(unsigned int size, const char *owner)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	start = rh_alloc(&cpm_dpmem_info, size, owner);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return start;
+}
+
+int new_m8xx_cpm_dpfree(void *start)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	ret = rh_free(&cpm_dpmem_info, start);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return ret;
+}
+
+void *new_m8xx_cpm_dpalloc_fixed(void *start, int size, const char *owner)
+{
+	void *ret = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	ret = rh_alloc_fixed(&cpm_dpmem_info, start, size, owner);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return ret;
+}
+
+void new_m8xx_cpm_dpdump(void)
+{
+	rh_dump(&cpm_dpmem_info);
+}
+
+#endif
+
+#ifdef CONFIG_NEW_HOSTALLOC
+
+/********************************************************************************
+
+  hostalloc
+
+********************************************************************************/
+
+uint
+m8xx_cpm_hostalloc(uint size)
+{
+	return (uint)new_m8xx_cpm_hostalloc(size, "commproc");
+}
+
+typedef struct cpm_hostmem_block {
+	struct list_head list;
+	int order;
+	int num_pages;
+	int size;
+	int allocated;
+	ulong va;
+	pte_t pte[1];	/* at least one */
+	/* more follow */
+} cpm_hostmem_block_t;
+
+static uint cpm_bootpage;
+static rh_block_t cpm_boot_hostmem_rh_block[8];	/* start with 8 blocks */
+static rh_info_t cpm_hostmem_info;
+
+static spinlock_t cpm_hostmem_lock;
+static struct list_head cpm_hostmem_list;
+
+/********************************************************************************/
+
+static cpm_hostmem_block_t *hostmem_block_create(int reqsize)
+{
+	int i, order, num_pages, size;
+	ulong va;
+	pte_t *pte;
+	cpm_hostmem_block_t *hb;
+
+	order = get_order(reqsize);
+	num_pages = 1 << order;
+	size = num_pages << PAGE_SHIFT;
+
+	hb = kmalloc(sizeof(*hb) + sizeof(pte_t) * num_pages, GFP_KERNEL);
+	if (hb == NULL)
+		return NULL;
+
+	/* now get the actual pages */
+	va = __get_dma_pages(GFP_KERNEL, order);
+	if (va == 0) {
+		kfree(hb);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&hb->list);
+	hb->order = order;
+	hb->num_pages = num_pages;
+	hb->size = size;
+	hb->allocated = 0;
+	hb->va = va;
+
+	/* ensure no cache lines in use */
+	invalidate_dcache_range(va, va + size);
+
+	/* chase the PTEs and mark them uncached. */
+	for (i = 0; i < num_pages; i++, va += PAGE_SIZE) {
+		if (get_pteptr(&init_mm, va, &pte) == 0) {
+			BUG();
+			return NULL;
+		}
+		/* save old pte value */
+		pte_val(hb->pte[i]) = pte_val(*pte);
+
+		/* and make it uncachable */
+		pte_val(*pte) |= _PAGE_NO_CACHE;
+
+		flush_tlb_page(find_vma(&init_mm, va), va);
+	}
+
+	return hb;
+}
+
+static int hostmem_block_destroy(cpm_hostmem_block_t *hb)
+{
+	int i;
+	ulong va;
+	pte_t *pte;
+
+	if (hb == NULL)
+		return -EINVAL;
+
+	if (in_interrupt())
+		BUG();
+
+	/* restore PTEs to former values */
+	for (i = 0, va = hb->va; i < hb->num_pages; i++, va += PAGE_SIZE) {
+		if (get_pteptr(&init_mm, va, &pte) == 0) {
+			BUG();
+			return -EINVAL;
+		}
+		/* restore previous pte value */
+		pte_val(*pte) = pte_val(hb->pte[i]);
+		flush_tlb_page(find_vma(&init_mm, va), va);
+	}
+
+	free_pages(hb->va, hb->order);
+
+	kfree(hb);
+
+	return 0;
+}
+
+/********************************************************************************/
+
+#define CPM_HOSTMEM_ALIGNMENT	16
+
+void new_m8xx_cpm_hostinit(uint bootpage)
+{
+	pte_t *pte;
+
+	if (bootpage != 0) {
+		/* get the PTE for the bootpage */
+		if (!get_pteptr(&init_mm, bootpage, &pte))
+			panic("get_pteptr failed\n");
+
+		/* and make it uncachable */
+		pte_val(*pte) |= _PAGE_NO_CACHE;
+		flush_tlb_page(init_mm.mmap, bootpage);
+	}
+
+	spin_lock_init(&cpm_hostmem_lock);
+	INIT_LIST_HEAD(&cpm_hostmem_list);
+
+	/* initialize the info header */
+	rh_init(&cpm_hostmem_info, CPM_HOSTMEM_ALIGNMENT,
+			sizeof(cpm_boot_hostmem_rh_block)/sizeof(cpm_boot_hostmem_rh_block[0]),
+			cpm_boot_hostmem_rh_block);
+
+	/* attach as free memory the bootpage to satisfy early allocations */
+	if (bootpage != 0)
+		rh_attach_region(&cpm_hostmem_info, (void *)bootpage, PAGE_SIZE);
+
+	/* please note that the initial bootpage is NOT in the hostmem block list */
+	/* so keep it around just in case */
+	cpm_bootpage = bootpage;
+}
+
+void *new_m8xx_cpm_hostalloc(unsigned int size, const char *owner)
+{
+	void *ret;
+	static cpm_hostmem_block_t *hb;
+	struct list_head *l;
+	unsigned long flags;
+
+	/* align size */
+	/* size = (size + CPM_HOSTMEM_ALIGNMENT - 1) & ~(CPM_HOSTMEM_ALIGNMENT - 1); */
+
+	spin_lock_irqsave(&cpm_hostmem_lock, flags);
+
+	/* try to get it from already present free list */
+	ret = rh_alloc(&cpm_hostmem_info, size, owner);
+	if (ret != NULL)
+		goto out;
+	spin_unlock_irqrestore(&cpm_hostmem_lock, flags);
+
+	/* no memory, grow hostmem list */
+	hb = hostmem_block_create(size);
+	if (hb == NULL)
+		return NULL;
+
+	spin_lock_irqsave(&cpm_hostmem_lock, flags);
+
+	/* attach free memory region */
+	if (rh_attach_region(&cpm_hostmem_info, (void *)hb->va, hb->size) < 0) {
+		hostmem_block_destroy(hb);
+		goto out;
+	}
+
+	/* append to list */
+	list_add(&hb->list, &cpm_hostmem_list);
+
+	/* and retry, hopefully this will succeed */
+	ret = rh_alloc(&cpm_hostmem_info, size, owner);
+out:
+	if (ret != NULL) {
+		list_for_each(l, &cpm_hostmem_list) {
+			hb = list_entry(l, cpm_hostmem_block_t, list);
+			if (hb->va <= (uint)ret && hb->va + size > (uint)ret) {
+				hb->allocated += size;
+				break;
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&cpm_hostmem_lock, flags);
+
+	return ret;
+}
+
+int new_m8xx_cpm_hostfree(void *start)
+{
+	int size;
+	static cpm_hostmem_block_t *hb, *hbfound;
+	struct list_head *l;
+	unsigned long flags;
+
+	hbfound = NULL;
+
+	spin_lock_irqsave(&cpm_hostmem_lock, flags);
+
+	size = rh_free(&cpm_hostmem_info, start);
+	if (size > 0) {
+		/* update allocated space counter, and destroy page(s) if zero */
+		list_for_each(l, &cpm_hostmem_list) {
+			hb = list_entry(l, cpm_hostmem_block_t, list);
+			if (hb->va <= (uint)start && hb->va + size > (uint)start) {
+				hb->allocated -= size;
+				if (hb->allocated == 0) {
+					list_del(&hb->list);
+					rh_detach_region(&cpm_hostmem_info, (void *)hb->va, hb->size);
+					hbfound = hb;
+				}
+				break;
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&cpm_hostmem_lock, flags);
+
+	/* if the block was detached destroy it */
+	if (hbfound != NULL)
+		hostmem_block_destroy(hbfound);
+
+	return size;
+}
+
+void new_m8xx_cpm_hostdump(void)
+{
+	extern void rh_dump(rh_info_t *info);
+
+	rh_dump(&cpm_hostmem_info);
+}
+
+#endif
+
diff -Nru a/arch/ppc/8xx_io/rheap.c b/arch/ppc/8xx_io/rheap.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/8xx_io/rheap.c	Wed Dec 18 14:27:45 2002
@@ -0,0 +1,657 @@
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
+#include "rheap.h"
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
+	printk(KERN_INFO "info @0x%p (%d slots empty / %d max)\n", info, info->empty_slots, info->max_blocks);
+
+	printk(KERN_INFO "  Free:\n");
+	nr = rh_get_stats(info, RHGS_FREE, maxnr, st);
+	if (nr > maxnr)
+		nr = maxnr;
+	for (i = 0; i < nr; i++)
+		printk(KERN_INFO "    0x%p-0x%p (%u)\n", st[i].start, (int8_t *)st[i].start + st[i].size, st[i].size);
+	printk(KERN_INFO "\n");
+
+	printk(KERN_INFO "  Taken:\n");
+	nr = rh_get_stats(info, RHGS_TAKEN, maxnr, st);
+	if (nr > maxnr)
+		nr = maxnr;
+	for (i = 0; i < nr; i++)
+		printk(KERN_INFO "    0x%p-0x%p (%u) %s\n", st[i].start, (int8_t *)st[i].start + st[i].size, st[i].size,
+				st[i].owner != NULL ? st[i].owner : "");
+	printk(KERN_INFO "\n");
+}
+
+void rh_dump_blk(rh_info_t *info, rh_block_t *blk)
+{
+	printk(KERN_INFO "blk @0x%p: 0x%p-0x%p (%u)\n", blk, blk->start, (int8_t *)blk->start + blk->size, blk->size);
+}
diff -Nru a/arch/ppc/8xx_io/rheap.h b/arch/ppc/8xx_io/rheap.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/8xx_io/rheap.h	Wed Dec 18 14:27:45 2002
@@ -0,0 +1,89 @@
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
+/********************************************************************************/
+
+#endif
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Wed Dec 18 14:27:45 2002
+++ b/arch/ppc/kernel/ppc_ksyms.c	Wed Dec 18 14:27:45 2002
@@ -357,6 +357,17 @@
 EXPORT_SYMBOL(__res);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
+#ifdef CONFIG_NEW_DPALLOC
+EXPORT_SYMBOL(new_m8xx_cpm_dpalloc);
+EXPORT_SYMBOL(new_m8xx_cpm_dpfree);
+EXPORT_SYMBOL(new_m8xx_cpm_dpalloc_fixed);
+EXPORT_SYMBOL(new_m8xx_cpm_dpdump);
+#endif
+#ifdef CONFIG_NEW_HOSTALLOC
+EXPORT_SYMBOL(new_m8xx_cpm_hostalloc);
+EXPORT_SYMBOL(new_m8xx_cpm_hostfree);
+EXPORT_SYMBOL(new_m8xx_cpm_hostdump);
+#endif
 #endif /* CONFIG_8xx */
 #if defined(CONFIG_8xx) || defined(CONFIG_8260)
 EXPORT_SYMBOL(request_8xxirq);
diff -Nru a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
--- a/include/asm-ppc/commproc.h	Wed Dec 18 14:27:45 2002
+++ b/include/asm-ppc/commproc.h	Wed Dec 18 14:27:45 2002
@@ -797,4 +797,17 @@
 		void (*handler)(void *, struct pt_regs *regs), void *dev_id);
 extern void cpm_free_handler(int vec);

+#ifdef CONFIG_NEW_DPALLOC
+extern void *new_m8xx_cpm_dpalloc(unsigned int size, const char *owner);
+extern int   new_m8xx_cpm_dpfree(void *start);
+extern void *new_m8xx_cpm_dpalloc_fixed(void *start, int size, const char *owner);
+extern void  new_m8xx_cpm_dpdump(void);
+#endif
+
+#ifdef CONFIG_NEW_HOSTALLOC
+extern void *new_m8xx_cpm_hostalloc(unsigned int size, const char *owner);
+extern int   new_m8xx_cpm_hostfree(void *start);
+extern void  new_m8xx_cpm_hostdump(void);
+#endif
+
 #endif /* __CPM_8XX__ */

--------------080200060901040700000000--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
