Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96B8BDDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:22:44 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: rework dma-noncoherent to use generic vmalloc layer
	(2nd rev)
Date: Thu, 12 Feb 2009 23:22:35 +0300
Message-Id: <1234470155-6489-1-git-send-email-yanok@emcraft.com>
Cc: wd@denx.de, dzu@denx.de, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch rewrites consistent dma allocations support to use vmalloc
layer to allocate virtual memory space from vmalloc pool and get rid
of CONFIG_CONSISTENT_{START,SIZE}.
I still use VM_IOREMAP flag for these allocations (I'll try to post
patch adding separate VM_COHERENT_DMA flag to lkml later).
Now I save pages array in vm_struct pages field and use
__builtin_return_address(1) as 'caller' argument to get usefull info
in /proc/vmallocinfo:
-bash-3.2# cat /proc/vmallocinfo
0xe1000000-0xe1002000    8192 __ioremap+0x184/0x194 ioremap
[...]
0xe1f90000-0xe1f96000   24576 PrimeIocFifos+0x3a8/0x550 pages=5 ioremap
0xe1fa0000-0xe1fb1000   69632 __ioremap+0x184/0x194 ioremap
0xe1fc0000-0xe1fd1000   69632 __ioremap+0x184/0x194 ioremap
0xe2000000-0xe2f01000 15732736 __ioremap+0x184/0x194 ioremap
0xe2f32000-0xe2f34000    8192 __ioremap+0x184/0x194 ioremap
0xe2f38000-0xe2f3d000   20480 __ioremap+0x184/0x194 ioremap
0xe2f40000-0xe2f46000   24576 PrimeIocFifos+0x3a8/0x550 pages=5 ioremap
0xe2f80000-0xe3e81000 15732736 __ioremap+0x184/0x194 ioremap
0xe3f00000-0xe3f48000  294912 PrimeIocFifos+0x204/0x550 pages=71 ioremap
0xe3f80000-0xe3fc8000  294912 PrimeIocFifos+0x204/0x550 pages=71 ioremap
0xe3fe0000-0xe3fe6000   24576 bdx_fifo_init+0x8c/0x12c pages=5 ioremap
0xe3fe8000-0xe3fee000   24576 bdx_fifo_init+0x8c/0x12c pages=5 ioremap
0xe3fef000-0xe3ff8000   36864 bdx_open+0x10c/0x60c pages=8 vmalloc
0xe4000000-0xe4006000   24576 bdx_fifo_init+0x8c/0x12c pages=5 ioremap
0xe4007000-0xe400f000   32768 bdx_open+0x1f0/0x60c pages=7 vmalloc
0xe4010000-0xe401a000   40960 bdx_fifo_init+0x8c/0x12c pages=9 ioremap

(those ioremaps with pages=)

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/Kconfig               |   25 ---
 arch/powerpc/lib/dma-noncoherent.c |  299 +++++++-----------------------------
 2 files changed, 53 insertions(+), 271 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 74cc312..ecae53f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -815,31 +815,6 @@ config TASK_SIZE
 	default "0x80000000" if PPC_PREP || PPC_8xx
 	default "0xc0000000"
 
-config CONSISTENT_START_BOOL
-	bool "Set custom consistent memory pool address"
-	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
-	help
-	  This option allows you to set the base virtual address
-	  of the consistent memory pool.  This pool of virtual
-	  memory is used to make consistent memory allocations.
-
-config CONSISTENT_START
-	hex "Base virtual address of consistent memory pool" if CONSISTENT_START_BOOL
-	default "0xfd000000" if (NOT_COHERENT_CACHE && 8xx)
-	default "0xff100000" if NOT_COHERENT_CACHE
-
-config CONSISTENT_SIZE_BOOL
-	bool "Set custom consistent memory pool size"
-	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
-	help
-	  This option allows you to set the size of the
-	  consistent memory pool.  This pool of virtual memory
-	  is used to make consistent memory allocations.
-
-config CONSISTENT_SIZE
-	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
-	default "0x00200000" if NOT_COHERENT_CACHE
-
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index b7dc4c1..2e321a9 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -29,121 +29,11 @@
 #include <linux/types.h>
 #include <linux/highmem.h>
 #include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
 
 /*
- * This address range defaults to a value that is safe for all
- * platforms which currently set CONFIG_NOT_COHERENT_CACHE. It
- * can be further configured for specific applications under
- * the "Advanced Setup" menu. -Matt
- */
-#define CONSISTENT_BASE	(CONFIG_CONSISTENT_START)
-#define CONSISTENT_END	(CONFIG_CONSISTENT_START + CONFIG_CONSISTENT_SIZE)
-#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-
-/*
- * This is the page table (2MB) covering uncached, DMA consistent allocations
- */
-static pte_t *consistent_pte;
-static DEFINE_SPINLOCK(consistent_lock);
-
-/*
- * VM region handling support.
- *
- * This should become something generic, handling VM region allocations for
- * vmalloc and similar (ioremap, module space, etc).
- *
- * I envisage vmalloc()'s supporting vm_struct becoming:
- *
- *  struct vm_struct {
- *    struct vm_region	region;
- *    unsigned long	flags;
- *    struct page	**pages;
- *    unsigned int	nr_pages;
- *    unsigned long	phys_addr;
- *  };
- *
- * get_vm_area() would then call vm_region_alloc with an appropriate
- * struct vm_region head (eg):
- *
- *  struct vm_region vmalloc_head = {
- *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
- *	.vm_start	= VMALLOC_START,
- *	.vm_end		= VMALLOC_END,
- *  };
- *
- * However, vmalloc_head.vm_start is variable (typically, it is dependent on
- * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
- * would have to initialise this each time prior to calling vm_region_alloc().
- */
-struct ppc_vm_region {
-	struct list_head	vm_list;
-	unsigned long		vm_start;
-	unsigned long		vm_end;
-};
-
-static struct ppc_vm_region consistent_head = {
-	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
-	.vm_start	= CONSISTENT_BASE,
-	.vm_end		= CONSISTENT_END,
-};
-
-static struct ppc_vm_region *
-ppc_vm_region_alloc(struct ppc_vm_region *head, size_t size, gfp_t gfp)
-{
-	unsigned long addr = head->vm_start, end = head->vm_end - size;
-	unsigned long flags;
-	struct ppc_vm_region *c, *new;
-
-	new = kmalloc(sizeof(struct ppc_vm_region), gfp);
-	if (!new)
-		goto out;
-
-	spin_lock_irqsave(&consistent_lock, flags);
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if ((addr + size) < addr)
-			goto nospc;
-		if ((addr + size) <= c->vm_start)
-			goto found;
-		addr = c->vm_end;
-		if (addr > end)
-			goto nospc;
-	}
-
- found:
-	/*
-	 * Insert this entry _before_ the one we found.
-	 */
-	list_add_tail(&new->vm_list, &c->vm_list);
-	new->vm_start = addr;
-	new->vm_end = addr + size;
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	return new;
-
- nospc:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	kfree(new);
- out:
-	return NULL;
-}
-
-static struct ppc_vm_region *ppc_vm_region_find(struct ppc_vm_region *head, unsigned long addr)
-{
-	struct ppc_vm_region *c;
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if (c->vm_start == addr)
-			goto out;
-	}
-	c = NULL;
- out:
-	return c;
-}
-
-/*
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
  */
@@ -151,21 +41,21 @@ void *
 __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 {
 	struct page *page;
-	struct ppc_vm_region *c;
 	unsigned long order;
+	int i;
+	unsigned int nr_pages = PAGE_ALIGN(size)>>PAGE_SHIFT;
+	unsigned int array_size = nr_pages * sizeof(struct page *);
+	struct page **pages;
+	struct page *end;
 	u64 mask = 0x00ffffff, limit; /* ISA default */
+	struct vm_struct *area;
 
-	if (!consistent_pte) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
-		dump_stack();
-		return NULL;
-	}
-
+	BUG_ON(!mem_init_done);
 	size = PAGE_ALIGN(size);
 	limit = (mask + 1) & ~mask;
-	if ((limit && size >= limit) || size >= (CONSISTENT_END - CONSISTENT_BASE)) {
-		printk(KERN_WARNING "coherent allocation too big (requested %#x mask %#Lx)\n",
-		       size, mask);
+	if (limit && size >= limit) {
+		printk(KERN_WARNING "coherent allocation too big (requested "
+				"%#x mask %#Lx)\n", size, mask);
 		return NULL;
 	}
 
@@ -178,6 +68,8 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 	if (!page)
 		goto no_page;
 
+	end = page + (1 << order);
+
 	/*
 	 * Invalidate any data that might be lurking in the
 	 * kernel direct-mapped region for device DMA.
@@ -188,48 +80,55 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 		flush_dcache_range(kaddr, kaddr + size);
 	}
 
+	split_page(page, order);
+
 	/*
-	 * Allocate a virtual address in the consistent mapping region.
+	 * Set the "dma handle"
 	 */
-	c = ppc_vm_region_alloc(&consistent_head, size,
-			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
-	if (c) {
-		unsigned long vaddr = c->vm_start;
-		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(vaddr);
-		struct page *end = page + (1 << order);
-
-		split_page(page, order);
-
-		/*
-		 * Set the "dma handle"
-		 */
-		*handle = page_to_phys(page);
+	*handle = page_to_phys(page);
+
+	area = get_vm_area_caller(size, VM_IOREMAP,
+			__builtin_return_address(1));
+	if (!area)
+		goto out_free_pages;
+
+	if (array_size > PAGE_SIZE) {
+		pages = vmalloc(array_size);
+		area->flags |= VM_VPAGES;
+	} else {
+		pages = kmalloc(array_size, GFP_KERNEL);
+	}
+	if (!pages)
+		goto out_free_area;
 
-		do {
-			BUG_ON(!pte_none(*pte));
+	area->pages = pages;
+	area->nr_pages = nr_pages;
 
-			SetPageReserved(page);
-			set_pte_at(&init_mm, vaddr,
-				   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
-			page++;
-			pte++;
-			vaddr += PAGE_SIZE;
-		} while (size -= PAGE_SIZE);
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
 
-		/*
-		 * Free the otherwise unused pages.
-		 */
-		while (page < end) {
-			__free_page(page);
-			page++;
-		}
+	if (map_vm_area(area, pgprot_noncached(PAGE_KERNEL), &pages))
+		goto out_unmap;
 
-		return (void *)c->vm_start;
+	/*
+	 * Free the otherwise unused pages.
+	 */
+	page += nr_pages;
+	while (page < end) {
+		__free_page(page);
+		page++;
 	}
 
+	return area->addr;
+out_unmap:
+	vunmap(area->addr);
+	goto out_free_pages;
+out_free_area:
+	free_vm_area(area);
+out_free_pages:
 	if (page)
 		__free_pages(page, order);
- no_page:
+no_page:
 	return NULL;
 }
 EXPORT_SYMBOL(__dma_alloc_coherent);
@@ -239,104 +138,12 @@ EXPORT_SYMBOL(__dma_alloc_coherent);
  */
 void __dma_free_coherent(size_t size, void *vaddr)
 {
-	struct ppc_vm_region *c;
-	unsigned long flags, addr;
-	pte_t *ptep;
-
-	size = PAGE_ALIGN(size);
-
-	spin_lock_irqsave(&consistent_lock, flags);
-
-	c = ppc_vm_region_find(&consistent_head, (unsigned long)vaddr);
-	if (!c)
-		goto no_area;
-
-	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
-		       __func__, c->vm_end - c->vm_start, size);
-		dump_stack();
-		size = c->vm_end - c->vm_start;
-	}
-
-	ptep = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
-	addr = c->vm_start;
-	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-		unsigned long pfn;
-
-		ptep++;
-		addr += PAGE_SIZE;
+	vfree(vaddr);
 
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-				ClearPageReserved(page);
-
-				__free_page(page);
-				continue;
-			}
-		}
-
-		printk(KERN_CRIT "%s: bad page in kernel page table\n",
-		       __func__);
-	} while (size -= PAGE_SIZE);
-
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-
-	list_del(&c->vm_list);
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
-	kfree(c);
-	return;
-
- no_area:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
-	       __func__, vaddr);
-	dump_stack();
 }
 EXPORT_SYMBOL(__dma_free_coherent);
 
 /*
- * Initialise the consistent memory allocation.
- */
-static int __init dma_alloc_init(void)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int ret = 0;
-
-	do {
-		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
-		pud = pud_alloc(&init_mm, pgd, CONSISTENT_BASE);
-		pmd = pmd_alloc(&init_mm, pud, CONSISTENT_BASE);
-		if (!pmd) {
-			printk(KERN_ERR "%s: no pmd tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-
-		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
-		if (!pte) {
-			printk(KERN_ERR "%s: no pte tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-
-		consistent_pte = pte;
-	} while (0);
-
-	return ret;
-}
-
-core_initcall(dma_alloc_init);
-
-/*
  * make an area consistent.
  */
 void __dma_sync(void *vaddr, size_t size, int direction)
-- 
1.6.0.6
