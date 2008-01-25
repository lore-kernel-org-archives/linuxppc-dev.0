Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>, <cbe-oss-dev@ozlabs.org>
Message-Id: <9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
In-Reply-To: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/3] Cell IOMMU static mapping support
Date: Fri, 25 Jan 2008 21:45:07 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Citing "release early release often", I'm posting this now as a mega-patch
to get people looking at it. I'll try to split it up and make it look a
little prettier before submitting it.

The intent of this patch is to setup (on certain machines) a "static" IOMMU
mapping of all of memory, to reduce the overhead of the IOMMU. If anyone has
a better name than "static" I'm all ears.

So instead of having an IOMMU window that we use to temporarily map things
in and out of DMA'able space, at boot we create a 1:1 mapping for all of
memory. This obviously only works for devices that can do 64-bit DMA.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |  318 ++++++++++++++++++++++++++++++++---
 1 files changed, 295 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 9223559..935d4e6 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -147,6 +147,10 @@ struct cbe_iommu {
 static struct cbe_iommu iommus[NR_IOMMUS];
 static int cbe_nr_iommus;
 
+static unsigned long cell_dma_direct_offset;
+struct dma_mapping_ops cell_dma_static_ops;
+static unsigned long cell_dma_static_base;
+
 static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
 		long n_ptes)
 {
@@ -306,22 +310,64 @@ static int cell_iommu_find_ioc(int nid, unsigned long *base)
 	return -ENODEV;
 }
 
-static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long size)
+static void cell_iommu_setup_static_ptab(struct cbe_iommu *iommu,
+	struct device_node *np, unsigned long dbase, unsigned long dsize,
+	unsigned long sbase, unsigned long ssize)
+{
+	unsigned long ioid, prot, base_pte, uaddr, *io_pte;
+	const unsigned int *p;
+	int i;
+
+	cell_dma_static_base = sbase;
+
+	p = of_get_property(np, "ioid", NULL);
+	ioid = p ? *p : 0;
+
+	prot = 0xc48UL << (52 + 4 * DMA_BIDIRECTIONAL);
+
+	base_pte = (prot & (IOPTE_PP_W | IOPTE_PP_R))
+		    | IOPTE_M | IOPTE_SO_RW | (ioid & IOPTE_IOID_Mask);
+
+	/* convert from bytes into ptab indices */
+	dbase = dbase >> IOMMU_PAGE_SHIFT;
+	dsize = dsize >> IOMMU_PAGE_SHIFT;
+	sbase = sbase >> IOMMU_PAGE_SHIFT;
+	ssize = ssize >> IOMMU_PAGE_SHIFT;
+
+	io_pte = iommu->ptab;
+
+	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", ssize, sbase);
+
+	uaddr = 0;
+	for (i = sbase; i < sbase + ssize; i++, uaddr += IOMMU_PAGE_SIZE) {
+		/* Don't touch the dynamic region */
+		if (i >= dbase && i < (dbase + dsize)) {
+			pr_debug("iommu: static/dynamic overlap, skipping\n");
+			continue;
+		}
+		io_pte[i] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
+	}
+
+	mb();
+}
+
+static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
+		unsigned long dbase, unsigned long dsize,
+		unsigned long sbase, unsigned long ssize)
 {
-	struct page *page;
-	int ret, i;
 	unsigned long reg, segments, pages_per_segment, ptab_size, stab_size,
-		      n_pte_pages, xlate_base;
-	unsigned int virq;
+		      n_pte_pages, end, base, size, offset;
+	struct page *page;
+	int i;
 
-	if (cell_iommu_find_ioc(iommu->nid, &xlate_base))
-		panic("%s: missing IOC register mappings for node %d\n",
-		      __FUNCTION__, iommu->nid);
+	end = max(dbase + dsize, sbase + ssize);
+	base = dbase;
+	if (ssize != 0)
+		base = min(sbase, dbase);
 
-	iommu->xlate_regs = ioremap(xlate_base, IOC_Reg_Size);
-	iommu->cmd_regs = iommu->xlate_regs + IOC_IOCmd_Offset;
+	size = end - base;
 
-	segments = size >> IO_SEGMENT_SHIFT;
+	segments = end >> IO_SEGMENT_SHIFT;
 	pages_per_segment = 1ull << IO_PAGENO_BITS;
 
 	pr_debug("%s: iommu[%d]: segments: %lu, pages per segment: %lu\n",
@@ -372,12 +418,29 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long siz
 		__unknown_page_size_error();
 	}
 
+	pr_debug("iommu: stab init i = 0x%lx end = 0x%lx\n",
+		 base >> IO_SEGMENT_SHIFT, end >> IO_SEGMENT_SHIFT);
+
 	pr_debug("Setting up IOMMU stab:\n");
-	for (i = 0; i * (1ul << IO_SEGMENT_SHIFT) < size; i++) {
-		iommu->stab[i] = reg |
-			(__pa(iommu->ptab) + n_pte_pages * IOMMU_PAGE_SIZE * i);
-		pr_debug("\t[%d] 0x%016lx\n", i, iommu->stab[i]);
+	for (i = base >> IO_SEGMENT_SHIFT; i < segments; i++) {
+		offset = n_pte_pages * IOMMU_PAGE_SIZE * i;
+		iommu->stab[i] = reg | (__pa(iommu->ptab) + offset);
+		pr_debug("\t[%d] 0x%016lx (offset %lx)\n", i, iommu->stab[i], offset);
 	}
+}
+
+static void cell_iommu_enable_hardware(struct cbe_iommu *iommu)
+{
+	int ret;
+	unsigned long reg, xlate_base;
+	unsigned int virq;
+
+	if (cell_iommu_find_ioc(iommu->nid, &xlate_base))
+		panic("%s: missing IOC register mappings for node %d\n",
+		      __FUNCTION__, iommu->nid);
+
+	iommu->xlate_regs = ioremap(xlate_base, IOC_Reg_Size);
+	iommu->cmd_regs = iommu->xlate_regs + IOC_IOCmd_Offset;
 
 	/* ensure that the STEs have updated */
 	mb();
@@ -407,6 +470,13 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long siz
 	out_be64(iommu->cmd_regs + IOC_IOCmd_Cfg, reg);
 }
 
+static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
+	unsigned long base, unsigned long size)
+{
+	cell_iommu_setup_page_tables(iommu, base, size, 0, 0);
+	cell_iommu_enable_hardware(iommu);
+}
+
 #if 0/* Unused for now */
 static struct iommu_window *find_window(struct cbe_iommu *iommu,
 		unsigned long offset, unsigned long size)
@@ -491,7 +561,60 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
 	return NULL;
 }
 
-static unsigned long cell_dma_direct_offset;
+u64 cell_iommu_get_static_address(struct device *dev)
+{
+	struct device_node *tmp, *np = dev->archdata.of_node;
+	const u32 *ranges = NULL;
+	int i, len, best;
+	u32 pci_space;
+	u64 pci_addr, parent_addr, cpu_addr, size, best_size;
+
+	of_node_get(np);
+	ranges = of_get_property(np, "dma-ranges", &len);
+	while (!ranges && np) {
+		tmp = of_get_parent(np);
+		of_node_put(np);
+		np = tmp;
+		ranges = of_get_property(np, "dma-ranges", &len);
+	}
+
+	if (!ranges) {
+		pr_debug("iommu: no dma-ranges\n");
+		pci_addr = OF_BAD_ADDR;
+		goto out;
+	}
+
+	len /= 4;
+	best = -1;
+	best_size = 0;
+	i = 0;
+	while (i < len) {
+		pci_space = ranges[i];
+		pci_addr = of_read_number(ranges + i + 1, 2);
+		parent_addr = of_read_number(ranges + i + 3, 2);
+		size = of_read_number(ranges + i + 5, 2);
+		cpu_addr = of_translate_dma_address(np, ranges + i + 3);
+
+		if (cpu_addr == 0 && size > best_size) {
+			best = i;
+			best_size = size;
+		}
+
+		i += 7;
+	}
+
+	if (best == -1) {
+		pr_debug("iommu: no suitable range found!\n");
+		pci_addr = OF_BAD_ADDR;
+	} else {
+		pr_debug("iommu: passthrough range is %d\n", best);
+		pci_addr = of_read_number(ranges + best + 1, 2);
+	}
+
+out:
+	of_node_put(np);
+	return pci_addr;
+}
 
 static void cell_dma_dev_setup(struct device *dev)
 {
@@ -499,9 +622,16 @@ static void cell_dma_dev_setup(struct device *dev)
 	struct cbe_iommu *iommu;
 	struct dev_archdata *archdata = &dev->archdata;
 
-	if (get_pci_dma_ops() == &dma_direct_ops) {
+	if (get_dma_ops(dev) == &dma_direct_ops) {
 		archdata->dma_data = (void *)cell_dma_direct_offset;
 		return;
+	} else if (get_dma_ops(dev) == &cell_dma_static_ops) {
+		u64 addr;
+		addr  = cell_iommu_get_static_address(dev);
+		addr += cell_dma_static_base;
+		pr_debug("iommu: addr = %lx\n", addr);
+		archdata->dma_data = (void *)addr;
+		return;
 	}
 
 	/* Current implementation uses the first window available in that
@@ -565,10 +695,9 @@ static int __init cell_iommu_get_window(struct device_node *np,
 	return 0;
 }
 
-static void __init cell_iommu_init_one(struct device_node *np, unsigned long offset)
+static struct cbe_iommu *cell_iommu_alloc(struct device_node *np)
 {
 	struct cbe_iommu *iommu;
-	unsigned long base, size;
 	int nid, i;
 
 	/* Get node ID */
@@ -576,7 +705,7 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
 	if (nid < 0) {
 		printk(KERN_ERR "iommu: failed to get node for %s\n",
 		       np->full_name);
-		return;
+		return NULL;
 	}
 	pr_debug("iommu: setting up iommu for node %d (%s)\n",
 		 nid, np->full_name);
@@ -588,11 +717,10 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
 	 * ignore that for now. We might want to completely get rid of the
 	 * multiple window support since the cell iommu supports per-page ioids
 	 */
-
 	if (cbe_nr_iommus >= NR_IOMMUS) {
 		printk(KERN_ERR "iommu: too many IOMMUs detected ! (%s)\n",
 		       np->full_name);
-		return;
+		return NULL;
 	}
 
 	/* Init base fields */
@@ -603,6 +731,16 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
 	snprintf(iommu->name, sizeof(iommu->name), "iommu%d", i);
 	INIT_LIST_HEAD(&iommu->windows);
 
+	return iommu;
+}
+
+static void __init cell_iommu_init_one(struct device_node *np, unsigned long offset)
+{
+	struct cbe_iommu *iommu;
+	unsigned long base, size;
+
+	iommu = cell_iommu_alloc(np);
+
 	/* Obtain a window for it */
 	cell_iommu_get_window(np, &base, &size);
 
@@ -610,7 +748,7 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
 		 base, base + size - 1);
 
 	/* Initialize the hardware */
-	cell_iommu_setup_hardware(iommu, size);
+	cell_iommu_setup_hardware(iommu, base, size);
 
 	/* Setup the iommu_table */
 	cell_iommu_setup_window(iommu, np, base, size,
@@ -643,6 +781,14 @@ static void __init cell_disable_iommus(void)
 
 		iounmap(xregs);
 	}
+
+#if 0
+	for (i = 0; i < cbe_nr_iommus; i++) {
+		/* todo free stuff */
+	}
+#endif
+
+	cbe_nr_iommus = 0;
 }
 
 static int __init cell_iommu_init_disabled(void)
@@ -703,6 +849,129 @@ static int __init cell_iommu_init_disabled(void)
 	return 0;
 }
 
+static int cell_dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
+{
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+
+	if (dma_mask == DMA_BIT_MASK(64)) {
+		if (cell_iommu_get_static_address(dev) == OF_BAD_ADDR)
+			dev_dbg(dev, "iommu: 64-bit OK, but bad addr\n");
+		else {
+			dev_dbg(dev, "iommu: 64-bit OK, using direct ops\n");
+			set_dma_ops(dev, &cell_dma_static_ops);
+			cell_dma_dev_setup(dev);
+		}
+	} else {
+		dev_dbg(dev, "iommu: < 64-bit, using default ops\n");
+		set_dma_ops(dev, get_pci_dma_ops());
+	}
+
+	*dev->dma_mask = dma_mask;
+
+	return 0;
+}
+
+static int __init cell_iommu_static_init(void)
+{
+	unsigned long dbase, dsize, sbase, ssize, hbase, hend;
+	struct cbe_iommu *iommu;
+	struct device_node *np;
+
+	/* The static mapping is only supported on axon machines */
+	np = of_find_node_by_name(NULL, "axon");
+	if (!np) {
+		pr_debug("iommu: static mapping disabled, no axons found\n");
+		return -1;
+	}
+
+	/* The default setup is to have the static mapping sit after the
+	 * dynamic region, so find the top of the largest IOMMU window
+	 * on any axon, then add the size of RAM and that's our max value.
+	 * If that is > 32GB we have to do other shennanigans.
+	 */
+	sbase = 0;
+	for_each_node_by_name(np, "axon") {
+		cell_iommu_get_window(np, &dbase, &dsize);
+		sbase = max(sbase, dbase + dsize);
+	}
+
+	sbase = _ALIGN_UP(sbase, 1 << IO_SEGMENT_SHIFT);
+	ssize = lmb_phys_mem_size();
+
+	if ((sbase + ssize) <= 0x800000000)
+		hbase = 0; /* use the device tree window */
+	else {
+		/* If we're over 32 GB we need to cheat. We can't map all of
+		 * RAM with the static mapping, and also fit the dynamic
+		 * region. So try to place the dynamic region where the hash
+		 * table sits, drivers never need to DMA to it, we don't
+		 * need a static mapping for that area.
+		 */
+		if (!htab_address) {
+			pr_debug("iommu: htab is NULL, on LPAR? Huh?\n");
+			return -1;
+		}
+		hbase = __pa(htab_address);
+		hend  = hbase + htab_size_bytes;
+
+		/* The window must start and end on a segment boundary */
+		if ((hbase != _ALIGN_UP(hbase, 1 << IO_SEGMENT_SHIFT)) ||
+		    (hend != _ALIGN_UP(hend, 1 << IO_SEGMENT_SHIFT))) {
+			pr_debug("iommu: hash window not segment aligned\n");
+			return -1;
+		}
+
+		/* Check the hash window fits inside the real DMA window */
+		for_each_node_by_name(np, "axon") {
+			cell_iommu_get_window(np, &dbase, &dsize);
+
+			if (hbase < dbase || (hend > (dbase + dsize))) {
+				pr_debug("iommu: hash window doesn't fit in"
+					 "real DMA window\n");
+				return -1;
+			}
+		}
+
+		sbase = 0;
+	}
+
+	/* Setup the dynamic regions */
+	for_each_node_by_name(np, "axon") {
+		iommu = cell_iommu_alloc(np);
+		if (!iommu) {
+			pr_debug("iommu: couldn't allocate iommu\n");
+			cell_disable_iommus();
+			return -1;
+		}
+
+		if (hbase == 0)
+			cell_iommu_get_window(np, &dbase, &dsize);
+		else {
+			dbase = hbase;
+			dsize = htab_size_bytes;
+		}
+
+		pr_debug("iommu: setting up %d, dynamic window %lx-%lx " \
+			 "static window %lx-%lx\n", iommu->nid, dbase,
+			 dbase + dsize, sbase, sbase + ssize);
+
+		cell_iommu_setup_page_tables(iommu, dbase, dsize, sbase, ssize);
+		cell_iommu_setup_static_ptab(iommu, np, dbase, dsize,
+					     sbase, ssize);
+		cell_iommu_enable_hardware(iommu);
+		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
+	}
+
+	cell_dma_static_ops = dma_direct_ops;
+	cell_dma_static_ops.set_dma_mask = cell_dma_set_mask_and_switch;
+
+	dma_iommu_ops.set_dma_mask = cell_dma_set_mask_and_switch;
+	set_pci_dma_ops(&dma_iommu_ops);
+
+	return 0;
+}
+
 static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
@@ -722,6 +991,9 @@ static int __init cell_iommu_init(void)
 	ppc_md.tce_build = tce_build_cell;
 	ppc_md.tce_free = tce_free_cell;
 
+	if (cell_iommu_static_init() == 0)
+		goto bail;
+
 	/* Create an iommu for each /axon node.  */
 	for_each_node_by_name(np, "axon") {
 		if (np->parent == NULL || np->parent->parent != NULL)
-- 
1.5.2.rc1.1884.g59b20
