Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
In-Reply-To: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 8/8] Cell IOMMU fixed mapping support
Date: Wed, 30 Jan 2008 01:14:03 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for setting up a fixed IOMMU mapping on certain
cell machines. For 64-bit devices this avoids the performance overhead of
mapping and unmapping pages at runtime. 32-bit devices are unable to use
the fixed mapping.

The fixed mapping is established at boot, and maps all of physical memory
1:1 into device space at some offset. On machines with < 30 GB of memory
we setup the fixed mapping immediately above the normal IOMMU window.

For example a machine with 4GB of memory would end up with the normal
IOMMU window from 0-2GB and the fixed mapping window from 2GB to 6GB. In
this case a 64-bit device wishing to DMA to 1GB would be told to DMA to
3GB, plus any offset required by firmware. The firmware offset is encoded
in the "dma-ranges" property.

On machines with 30GB or more of memory, we are unable to place the fixed
mapping above the normal IOMMU window as we would run out of address space.
Instead we move the normal IOMMU window to coincide with the hash page
table, this region does not need to be part of the fixed mapping as no
device should ever be DMA'ing to it. We then setup the fixed mapping
from 0 to 32GB.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |  241 ++++++++++++++++++++++++++++++++++-
 1 files changed, 240 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 3baade1..56c69cc 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -523,6 +523,9 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
 
 static unsigned long cell_dma_direct_offset;
 
+static unsigned long dma_iommu_fixed_base;
+struct dma_mapping_ops dma_iommu_fixed_ops;
+
 static void cell_dma_dev_setup_iommu(struct device *dev)
 {
 	struct iommu_window *window;
@@ -545,11 +548,16 @@ static void cell_dma_dev_setup_iommu(struct device *dev)
 	archdata->dma_data = &window->table;
 }
 
+static void cell_dma_dev_setup_static(struct device *dev);
+
 static void cell_dma_dev_setup(struct device *dev)
 {
 	struct dev_archdata *archdata = &dev->archdata;
 
-	if (get_pci_dma_ops() == &dma_iommu_ops)
+	/* Order is important here, these are not mutually exclusive */
+	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
+		cell_dma_dev_setup_static(dev);
+	else if (get_pci_dma_ops() == &dma_iommu_ops)
 		cell_dma_dev_setup_iommu(dev);
 	else if (get_pci_dma_ops() == &dma_direct_ops)
 		archdata->dma_data = (void *)cell_dma_direct_offset;
@@ -752,6 +760,234 @@ static int __init cell_iommu_init_disabled(void)
 	return 0;
 }
 
+static u64 cell_iommu_get_fixed_address(struct device *dev)
+{
+	u64 cpu_addr, size, best_size, pci_addr = OF_BAD_ADDR;
+	struct device_node *tmp, *np;
+	const u32 *ranges = NULL;
+	int i, len, best;
+
+	np = dev->archdata.of_node;
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
+		dev_dbg(dev, "iommu: no dma-ranges found\n");
+		goto out;
+	}
+
+	len /= sizeof(u32);
+
+	/* dma-ranges format:
+	 * 1 cell:  pci space
+	 * 2 cells: pci address
+	 * 2 cells: parent address
+	 * 2 cells: size
+	 */
+	for (i = 0, best = -1, best_size = 0; i < len; i += 7) {
+		cpu_addr = of_translate_dma_address(np, ranges +i + 3);
+		size = of_read_number(ranges + i + 5, 2);
+
+		if (cpu_addr == 0 && size > best_size) {
+			best = i;
+			best_size = size;
+		}
+	}
+
+	if (best >= 0)
+		pci_addr = of_read_number(ranges + best + 1, 2);
+	else
+		dev_dbg(dev, "iommu: no suitable range found!\n");
+
+out:
+	of_node_put(np);
+
+	return pci_addr;
+}
+
+static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
+{
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+
+	if (dma_mask == DMA_BIT_MASK(64)) {
+		if (cell_iommu_get_fixed_address(dev) == OF_BAD_ADDR)
+			dev_dbg(dev, "iommu: 64-bit OK, but bad addr\n");
+		else {
+			dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
+			set_dma_ops(dev, &dma_iommu_fixed_ops);
+			cell_dma_dev_setup(dev);
+		}
+	} else {
+		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
+		set_dma_ops(dev, get_pci_dma_ops());
+	}
+
+	*dev->dma_mask = dma_mask;
+
+	return 0;
+}
+
+static void cell_dma_dev_setup_static(struct device *dev)
+{
+	struct dev_archdata *archdata = &dev->archdata;
+	u64 addr;
+
+	addr = cell_iommu_get_fixed_address(dev) + dma_iommu_fixed_base;
+	archdata->dma_data = (void *)addr;
+
+	dev_dbg(dev, "iommu: fixed addr = %lx\n", addr);
+}
+
+static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
+	struct device_node *np, unsigned long dbase, unsigned long dsize,
+	unsigned long fbase, unsigned long fsize)
+{
+	unsigned long base_pte, uaddr, *io_pte;
+	int i;
+
+	dma_iommu_fixed_base = fbase;
+
+	/* convert from bytes into page table indices */
+	dbase = dbase >> IOMMU_PAGE_SHIFT;
+	dsize = dsize >> IOMMU_PAGE_SHIFT;
+	fbase = fbase >> IOMMU_PAGE_SHIFT;
+	fsize = fsize >> IOMMU_PAGE_SHIFT;
+
+	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
+
+	io_pte = iommu->ptab;
+	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW
+		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
+
+	uaddr = 0;
+	for (i = fbase; i < fbase + fsize; i++, uaddr += IOMMU_PAGE_SIZE) {
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
+static int __init cell_iommu_fixed_mapping_init(void)
+{
+	unsigned long dbase, dsize, fbase, fsize, hbase, hend;
+	struct cbe_iommu *iommu;
+	struct device_node *np;
+
+	/* The fixed mapping is only supported on axon machines */
+	np = of_find_node_by_name(NULL, "axon");
+	if (!np) {
+		pr_debug("iommu: fixed mapping disabled, no axons found\n");
+		return -1;
+	}
+
+	/* The default setup is to have the fixed mapping sit after the
+	 * dynamic region, so find the top of the largest IOMMU window
+	 * on any axon, then add the size of RAM and that's our max value.
+	 * If that is > 32GB we have to do other shennanigans.
+	 */
+	fbase = 0;
+	for_each_node_by_name(np, "axon") {
+		cell_iommu_get_window(np, &dbase, &dsize);
+		fbase = max(fbase, dbase + dsize);
+	}
+
+	fbase = _ALIGN_UP(fbase, 1 << IO_SEGMENT_SHIFT);
+	fsize = lmb_phys_mem_size();
+
+	if ((fbase + fsize) <= 0x800000000)
+		hbase = 0; /* use the device tree window */
+	else {
+		/* If we're over 32 GB we need to cheat. We can't map all of
+		 * RAM with the fixed mapping, and also fit the dynamic
+		 * region. So try to place the dynamic region where the hash
+		 * table sits, drivers never need to DMA to it, we don't
+		 * need a fixed mapping for that area.
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
+		fbase = 0;
+	}
+
+	/* Setup the dynamic regions */
+	for_each_node_by_name(np, "axon") {
+		iommu = cell_iommu_alloc(np);
+		BUG_ON(!iommu);
+
+		if (hbase == 0)
+			cell_iommu_get_window(np, &dbase, &dsize);
+		else {
+			dbase = hbase;
+			dsize = htab_size_bytes;
+		}
+
+		pr_debug("iommu: setting up %d, dynamic window %lx-%lx " \
+			 "fixed window %lx-%lx\n", iommu->nid, dbase,
+			 dbase + dsize, fbase, fbase + fsize);
+
+		cell_iommu_setup_page_tables(iommu, dbase, dsize, fbase, fsize);
+		cell_iommu_setup_fixed_ptab(iommu, np, dbase, dsize,
+					     fbase, fsize);
+		cell_iommu_enable_hardware(iommu);
+		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
+	}
+
+	dma_iommu_fixed_ops = dma_direct_ops;
+	dma_iommu_fixed_ops.set_dma_mask = dma_set_mask_and_switch;
+
+	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
+	set_pci_dma_ops(&dma_iommu_ops);
+
+	printk(KERN_DEBUG "IOMMU fixed mapping established.\n");
+
+	return 0;
+}
+
+static int iommu_fixed_disabled;
+
+static int __init setup_iommu_fixed(char *str)
+{
+	if (strcmp(str, "off") == 0)
+		iommu_fixed_disabled = 1;
+
+	return 1;
+}
+__setup("iommu_fixed=", setup_iommu_fixed);
+
 static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
@@ -771,6 +1007,9 @@ static int __init cell_iommu_init(void)
 	ppc_md.tce_build = tce_build_cell;
 	ppc_md.tce_free = tce_free_cell;
 
+	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() == 0)
+		goto bail;
+
 	/* Create an iommu for each /axon node.  */
 	for_each_node_by_name(np, "axon") {
 		if (np->parent == NULL || np->parent->parent != NULL)
-- 
1.5.3.7.1.g4e596e
