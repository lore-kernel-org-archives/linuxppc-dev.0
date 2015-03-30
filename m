Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476471A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 14:10:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Replace mem_init_done with slab_is_available()
Date: Mon, 30 Mar 2015 14:10:37 +1100
Message-Id: <1427685037-2585-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a powerpc specific global called mem_init_done which is "set on
boot once kmalloc can be called".

But that's not *quite* true. We set it at the bottom of mem_init(), and
rely on the fact that mm_init() calls kmem_cache_init() immediately
after that, and nothing is running in parallel.

So replace it with the generic and 100% correct slab_is_available().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h         | 1 -
 arch/powerpc/kernel/pci-common.c         | 2 +-
 arch/powerpc/kernel/rtas.c               | 4 ++--
 arch/powerpc/lib/alloc.c                 | 2 +-
 arch/powerpc/mm/mem.c                    | 3 ---
 arch/powerpc/mm/pgtable_32.c             | 9 ++++-----
 arch/powerpc/mm/pgtable_64.c             | 4 ++--
 arch/powerpc/platforms/cell/celleb_pci.c | 2 +-
 8 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index fbdf18cf954c..e9d384cbd021 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -7,7 +7,6 @@
 extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
-extern int mem_init_done;	/* set on boot once kmalloc can be called */
 extern unsigned long long memory_limit;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c938158..bcf618bfff1e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -76,7 +76,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	list_add_tail(&phb->list_node, &hose_list);
 	spin_unlock(&hose_spinlock);
 	phb->dn = dev;
-	phb->is_dynamic = mem_init_done;
+	phb->is_dynamic = slab_is_available();
 #ifdef CONFIG_PPC64
 	if (dev) {
 		int nid = of_node_to_nid(dev);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 21c45a2d0706..fffdef2962eb 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -401,7 +401,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 			buf = altbuf;
 		} else {
 			buf = rtas_err_buf;
-			if (mem_init_done)
+			if (slab_is_available())
 				buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
 		}
 		if (buf)
@@ -461,7 +461,7 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 
 	if (buff_copy) {
 		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
-		if (mem_init_done)
+		if (slab_is_available())
 			kfree(buff_copy);
 	}
 	return ret;
diff --git a/arch/powerpc/lib/alloc.c b/arch/powerpc/lib/alloc.c
index 4a6c2cf890d9..60b0b3fc8fc1 100644
--- a/arch/powerpc/lib/alloc.c
+++ b/arch/powerpc/lib/alloc.c
@@ -10,7 +10,7 @@ void * __init_refok zalloc_maybe_bootmem(size_t size, gfp_t mask)
 {
 	void *p;
 
-	if (mem_init_done)
+	if (slab_is_available())
 		p = kzalloc(size, mask);
 	else {
 		p = memblock_virt_alloc(size, 0);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b7285a5870f8..45fda71feb27 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -61,7 +61,6 @@
 #define CPU_FTR_NOEXECUTE	0
 #endif
 
-int mem_init_done;
 unsigned long long memory_limit;
 
 #ifdef CONFIG_HIGHMEM
@@ -377,8 +376,6 @@ void __init mem_init(void)
 	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
 		VMALLOC_START, VMALLOC_END);
 #endif /* CONFIG_PPC32 */
-
-	mem_init_done = 1;
 }
 
 void free_initmem(void)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 03b1a3b0fbd5..57b41f8b7053 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -110,9 +110,8 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 __init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte;
-	extern int mem_init_done;
 
-	if (mem_init_done) {
+	if (slab_is_available()) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	} else {
 		pte = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
@@ -219,7 +218,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (mem_init_done && (p < virt_to_phys(high_memory)) &&
+	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %pf\n",
 		       (unsigned long long)p, __builtin_return_address(0));
@@ -247,7 +246,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	if ((v = p_mapped_by_tlbcam(p)))
 		goto out;
 
-	if (mem_init_done) {
+	if (slab_is_available()) {
 		struct vm_struct *area;
 		area = get_vm_area_caller(size, VM_IOREMAP, caller);
 		if (area == 0)
@@ -266,7 +265,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
 		err = map_page(v+i, p+i, flags);
 	if (err) {
-		if (mem_init_done)
+		if (slab_is_available())
 			vunmap((void *)v);
 		return NULL;
 	}
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 6957cc1ca0a7..ece5124d1946 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -231,7 +231,7 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	if ((size == 0) || (paligned == 0))
 		return NULL;
 
-	if (mem_init_done) {
+	if (slab_is_available()) {
 		struct vm_struct *area;
 
 		area = __get_vm_area_caller(size, VM_IOREMAP,
@@ -315,7 +315,7 @@ void __iounmap(volatile void __iomem *token)
 {
 	void *addr;
 
-	if (!mem_init_done)
+	if (!slab_is_available())
 		return;
 	
 	addr = (void *) ((unsigned long __force)
diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 3ce70ded2d6a..fd30e0a19420 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -392,7 +392,7 @@ static int __init celleb_setup_fake_pci_device(struct device_node *node,
 	return 0;
 
 error:
-	if (mem_init_done) {
+	if (slab_is_available()) {
 		if (config && *config)
 			kfree(*config);
 		if (res && *res)
-- 
2.1.0
