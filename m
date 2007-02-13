Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Feb 2007 11:46:06 +1100
Subject: [PATCH 1/3] spufs: remove need for struct page for SPEs
In-Reply-To: <1171327564.314011.545768742379.qpush@grosgo>
Message-Id: <20070213004616.90897DDF0D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the need for struct page for SPE local store
and registers from spufs. It also makes the locking much more
obvious and no longer relying on the truncate logic black magic
for protecting against races between unmap_mapping_range() and
new pages faulted in. It does so by switching to a nopfn() handler
and using the new vm_insert_pfn() to setup the PTEs itself while
holding a lock on the SPE.

The nice thing is that this patch actually removes a lot more code
than it adds :-)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig                     |    2 
 arch/powerpc/platforms/cell/spu_manage.c |  102 ++++++--------------------
 arch/powerpc/platforms/cell/spufs/file.c |  121 ++++++++++++++-----------------
 3 files changed, 80 insertions(+), 145 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/file.c	2007-02-13 11:18:57.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spufs/file.c	2007-02-13 11:22:21.000000000 +1100
@@ -95,14 +95,12 @@ spufs_mem_write(struct file *file, const
 	return ret;
 }
 
-static struct page *
-spufs_mem_mmap_nopage(struct vm_area_struct *vma,
-		      unsigned long address, int *type)
+static unsigned long spufs_mem_mmap_nopfn(struct vm_area_struct *vma,
+					  unsigned long address)
 {
-	struct page *page = NOPAGE_SIGBUS;
-
 	struct spu_context *ctx = vma->vm_file->private_data;
-	unsigned long offset = address - vma->vm_start;
+	unsigned long pfn, offset = address - vma->vm_start;
+
 	offset += vma->vm_pgoff << PAGE_SHIFT;
 
 	spu_acquire(ctx);
@@ -110,24 +108,22 @@ spufs_mem_mmap_nopage(struct vm_area_str
 	if (ctx->state == SPU_STATE_SAVED) {
 		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 							& ~_PAGE_NO_CACHE);
-		page = vmalloc_to_page(ctx->csa.lscsa->ls + offset);
+		pfn = vmalloc_to_pfn(ctx->csa.lscsa->ls + offset);
 	} else {
 		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-							| _PAGE_NO_CACHE);
-		page = pfn_to_page((ctx->spu->local_store_phys + offset)
-				   >> PAGE_SHIFT);
+					     | _PAGE_NO_CACHE);
+		pfn = (ctx->spu->local_store_phys + offset) >> PAGE_SHIFT;
 	}
-	spu_release(ctx);
+	vm_insert_pfn(vma, address, pfn);
 
-	if (type)
-		*type = VM_FAULT_MINOR;
+	spu_release(ctx);
 
-	page_cache_get(page);
-	return page;
+	return NOPFN_REFAULT;
 }
 
+
 static struct vm_operations_struct spufs_mem_mmap_vmops = {
-	.nopage = spufs_mem_mmap_nopage,
+	.nopfn = spufs_mem_mmap_nopfn,
 };
 
 static int
@@ -136,7 +132,7 @@ spufs_mem_mmap(struct file *file, struct
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE);
 
@@ -152,49 +148,42 @@ static const struct file_operations spuf
 	.mmap    = spufs_mem_mmap,
 };
 
-static struct page *spufs_ps_nopage(struct vm_area_struct *vma,
+static unsigned long spufs_ps_nopfn(struct vm_area_struct *vma,
 				    unsigned long address,
-				    int *type, unsigned long ps_offs,
+				    unsigned long ps_offs,
 				    unsigned long ps_size)
 {
-	struct page *page = NOPAGE_SIGBUS;
-	int fault_type = VM_FAULT_SIGBUS;
 	struct spu_context *ctx = vma->vm_file->private_data;
-	unsigned long offset = address - vma->vm_start;
-	unsigned long area;
+	unsigned long area, offset = address - vma->vm_start;
 	int ret;
 
 	offset += vma->vm_pgoff << PAGE_SHIFT;
 	if (offset >= ps_size)
-		goto out;
+		return NOPFN_SIGBUS;
 
+	/* error here usually means a signal.. we might want to test
+	 * the error code more precisely though
+	 */
 	ret = spu_acquire_runnable(ctx);
 	if (ret)
-		goto out;
+		return NOPFN_REFAULT;
 
 	area = ctx->spu->problem_phys + ps_offs;
-	page = pfn_to_page((area + offset) >> PAGE_SHIFT);
-	fault_type = VM_FAULT_MINOR;
-	page_cache_get(page);
-
+	vm_insert_pfn(vma, address, (area + offset) >> PAGE_SHIFT);
 	spu_release(ctx);
 
-      out:
-	if (type)
-		*type = fault_type;
-
-	return page;
+	return NOPFN_REFAULT;
 }
 
 #if SPUFS_MMAP_4K
-static struct page *spufs_cntl_mmap_nopage(struct vm_area_struct *vma,
-					   unsigned long address, int *type)
+static unsigned long spufs_cntl_mmap_nopfn(struct vm_area_struct *vma,
+					   unsigned long address)
 {
-	return spufs_ps_nopage(vma, address, type, 0x4000, 0x1000);
+	return spufs_ps_nopfn(vma, address, 0x4000, 0x1000);
 }
 
 static struct vm_operations_struct spufs_cntl_mmap_vmops = {
-	.nopage = spufs_cntl_mmap_nopage,
+	.nopfn = spufs_cntl_mmap_nopfn,
 };
 
 /*
@@ -205,7 +194,7 @@ static int spufs_cntl_mmap(struct file *
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -791,23 +780,23 @@ static ssize_t spufs_signal1_write(struc
 	return 4;
 }
 
-static struct page *spufs_signal1_mmap_nopage(struct vm_area_struct *vma,
-					      unsigned long address, int *type)
+static unsigned long spufs_signal1_mmap_nopfn(struct vm_area_struct *vma,
+					      unsigned long address)
 {
 #if PAGE_SIZE == 0x1000
-	return spufs_ps_nopage(vma, address, type, 0x14000, 0x1000);
+	return spufs_ps_nopfn(vma, address, 0x14000, 0x1000);
 #elif PAGE_SIZE == 0x10000
 	/* For 64k pages, both signal1 and signal2 can be used to mmap the whole
 	 * signal 1 and 2 area
 	 */
-	return spufs_ps_nopage(vma, address, type, 0x10000, 0x10000);
+	return spufs_ps_nopfn(vma, address, 0x10000, 0x10000);
 #else
 #error unsupported page size
 #endif
 }
 
 static struct vm_operations_struct spufs_signal1_mmap_vmops = {
-	.nopage = spufs_signal1_mmap_nopage,
+	.nopfn = spufs_signal1_mmap_nopfn,
 };
 
 static int spufs_signal1_mmap(struct file *file, struct vm_area_struct *vma)
@@ -815,7 +804,7 @@ static int spufs_signal1_mmap(struct fil
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -899,23 +888,23 @@ static ssize_t spufs_signal2_write(struc
 }
 
 #if SPUFS_MMAP_4K
-static struct page *spufs_signal2_mmap_nopage(struct vm_area_struct *vma,
-					      unsigned long address, int *type)
+static unsigned long spufs_signal2_mmap_nopfn(struct vm_area_struct *vma,
+					      unsigned long address)
 {
 #if PAGE_SIZE == 0x1000
-	return spufs_ps_nopage(vma, address, type, 0x1c000, 0x1000);
+	return spufs_ps_nopfn(vma, address, 0x1c000, 0x1000);
 #elif PAGE_SIZE == 0x10000
 	/* For 64k pages, both signal1 and signal2 can be used to mmap the whole
 	 * signal 1 and 2 area
 	 */
-	return spufs_ps_nopage(vma, address, type, 0x10000, 0x10000);
+	return spufs_ps_nopfn(vma, address, 0x10000, 0x10000);
 #else
 #error unsupported page size
 #endif
 }
 
 static struct vm_operations_struct spufs_signal2_mmap_vmops = {
-	.nopage = spufs_signal2_mmap_nopage,
+	.nopfn = spufs_signal2_mmap_nopfn,
 };
 
 static int spufs_signal2_mmap(struct file *file, struct vm_area_struct *vma)
@@ -923,7 +912,7 @@ static int spufs_signal2_mmap(struct fil
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -1000,14 +989,14 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_ty
 					spufs_signal2_type_set, "%llu");
 
 #if SPUFS_MMAP_4K
-static struct page *spufs_mss_mmap_nopage(struct vm_area_struct *vma,
-					   unsigned long address, int *type)
+static unsigned long spufs_mss_mmap_nopfn(struct vm_area_struct *vma,
+					  unsigned long address)
 {
-	return spufs_ps_nopage(vma, address, type, 0x0000, 0x1000);
+	return spufs_ps_nopfn(vma, address, 0x0000, 0x1000);
 }
 
 static struct vm_operations_struct spufs_mss_mmap_vmops = {
-	.nopage = spufs_mss_mmap_nopage,
+	.nopfn = spufs_mss_mmap_nopfn,
 };
 
 /*
@@ -1018,7 +1007,7 @@ static int spufs_mss_mmap(struct file *f
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -1042,14 +1031,14 @@ static const struct file_operations spuf
 	.mmap	 = spufs_mss_mmap,
 };
 
-static struct page *spufs_psmap_mmap_nopage(struct vm_area_struct *vma,
-					   unsigned long address, int *type)
+static unsigned long spufs_psmap_mmap_nopfn(struct vm_area_struct *vma,
+					    unsigned long address)
 {
-	return spufs_ps_nopage(vma, address, type, 0x0000, 0x20000);
+	return spufs_ps_nopfn(vma, address, 0x0000, 0x20000);
 }
 
 static struct vm_operations_struct spufs_psmap_mmap_vmops = {
-	.nopage = spufs_psmap_mmap_nopage,
+	.nopfn = spufs_psmap_mmap_nopfn,
 };
 
 /*
@@ -1060,7 +1049,7 @@ static int spufs_psmap_mmap(struct file 
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -1083,14 +1072,14 @@ static const struct file_operations spuf
 
 
 #if SPUFS_MMAP_4K
-static struct page *spufs_mfc_mmap_nopage(struct vm_area_struct *vma,
-					   unsigned long address, int *type)
+static unsigned long spufs_mfc_mmap_nopfn(struct vm_area_struct *vma,
+					  unsigned long address)
 {
-	return spufs_ps_nopage(vma, address, type, 0x3000, 0x1000);
+	return spufs_ps_nopfn(vma, address, 0x3000, 0x1000);
 }
 
 static struct vm_operations_struct spufs_mfc_mmap_vmops = {
-	.nopage = spufs_mfc_mmap_nopage,
+	.nopfn = spufs_mfc_mmap_nopfn,
 };
 
 /*
@@ -1101,7 +1090,7 @@ static int spufs_mfc_mmap(struct file *f
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2007-02-13 11:21:21.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2007-02-13 11:22:21.000000000 +1100
@@ -880,7 +880,7 @@ config ARCH_SPARSEMEM_ENABLE
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on (SMP && PPC_PSERIES) || PPC_CELL
+	depends on (SMP && PPC_PSERIES) || PPC_PS3
 
 config ARCH_POPULATES_NODE_MAP
 	def_bool y
Index: linux-cell/arch/powerpc/platforms/cell/spu_manage.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spu_manage.c	2007-02-13 11:25:59.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spu_manage.c	2007-02-13 11:29:56.000000000 +1100
@@ -59,63 +59,6 @@ static u64 __init find_spu_unit_number(s
 	return 0;
 }
 
-static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
-		const char *prop)
-{
-	const struct address_prop {
-		unsigned long address;
-		unsigned int len;
-	} __attribute__((packed)) *p;
-	int proplen;
-
-	unsigned long start_pfn, nr_pages;
-	struct pglist_data *pgdata;
-	struct zone *zone;
-	int ret;
-
-	p = get_property(spe, prop, &proplen);
-	WARN_ON(proplen != sizeof (*p));
-
-	start_pfn = p->address >> PAGE_SHIFT;
-	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	pgdata = NODE_DATA(spu->node);
-	zone = pgdata->node_zones;
-
-	ret = __add_pages(zone, start_pfn, nr_pages);
-
-	return ret;
-}
-
-static void __iomem * __init map_spe_prop(struct spu *spu,
-		struct device_node *n, const char *name)
-{
-	const struct address_prop {
-		unsigned long address;
-		unsigned int len;
-	} __attribute__((packed)) *prop;
-
-	const void *p;
-	int proplen;
-	void __iomem *ret = NULL;
-	int err = 0;
-
-	p = get_property(n, name, &proplen);
-	if (proplen != sizeof (struct address_prop))
-		return NULL;
-
-	prop = p;
-
-	err = cell_spuprop_present(spu, n, name);
-	if (err && (err != -EEXIST))
-		goto out;
-
-	ret = ioremap(prop->address, prop->len);
-
- out:
-	return ret;
-}
-
 static void spu_unmap(struct spu *spu)
 {
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
@@ -157,6 +100,23 @@ static int __init spu_map_interrupts_old
 	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
 }
 
+static void __iomem * __init spu_map_prop_old(struct spu *spu,
+					      struct device_node *n,
+					      const char *name)
+{
+	const struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *prop;
+	int proplen;
+
+	prop = get_property(n, name, &proplen);
+	if (prop == NULL || proplen != sizeof (struct address_prop))
+		return NULL;
+
+	return ioremap(prop->address, prop->len);
+}
+
 static int __init spu_map_device_old(struct spu *spu)
 {
 	struct device_node *node = spu->devnode;
@@ -175,7 +135,7 @@ static int __init spu_map_device_old(str
 
 	/* we use local store as ram, not io memory */
 	spu->local_store = (void __force *)
-		map_spe_prop(spu, node, "local-store");
+		spu_map_prop_old(spu, node, "local-store");
 	if (!spu->local_store)
 		goto out;
 
@@ -184,16 +144,16 @@ static int __init spu_map_device_old(str
 		goto out_unmap;
 	spu->problem_phys = *(unsigned long *)prop;
 
-	spu->problem = map_spe_prop(spu, node, "problem");
+	spu->problem = spu_map_prop_old(spu, node, "problem");
 	if (!spu->problem)
 		goto out_unmap;
 
-	spu->priv2 = map_spe_prop(spu, node, "priv2");
+	spu->priv2 = spu_map_prop_old(spu, node, "priv2");
 	if (!spu->priv2)
 		goto out_unmap;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
-		spu->priv1 = map_spe_prop(spu, node, "priv1");
+		spu->priv1 = spu_map_prop_old(spu, node, "priv1");
 		if (!spu->priv1)
 			goto out_unmap;
 	}
@@ -245,34 +205,20 @@ static int spu_map_resource(struct spu *
 			    void __iomem** virt, unsigned long *phys)
 {
 	struct device_node *np = spu->devnode;
-	unsigned long start_pfn, nr_pages;
-	struct pglist_data *pgdata;
-	struct zone *zone;
 	struct resource resource = { };
 	unsigned long len;
 	int ret;
 
 	ret = of_address_to_resource(np, nr, &resource);
 	if (ret)
-		goto out;
-
+		return ret;
 	if (phys)
 		*phys = resource.start;
 	len = resource.end - resource.start + 1;
 	*virt = ioremap(resource.start, len);
 	if (!*virt)
-		ret = -EINVAL;
-
-	start_pfn = resource.start >> PAGE_SHIFT;
-	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	pgdata = NODE_DATA(spu->node);
-	zone = pgdata->node_zones;
-
-	ret = __add_pages(zone, start_pfn, nr_pages);
-
-out:
-	return ret;
+		return -EINVAL;
+	return 0;
 }
 
 static int __init spu_map_device(struct spu *spu)
