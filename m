Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BA49DDF4C
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:10:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m88J9vpb002777
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:09:59 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m88J9uVl020120
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 14:09:57 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
Date: Mon,  8 Sep 2008 14:09:55 -0500
Message-Id: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We essentially adopt the 64-bit dma code, with some changes to support
32-bit systems, including HIGHMEM.  dma functions on 32-bit are now
invoked via accessor functions which call the correct op for a device based
on archdata dma_ops.  If there is no archdata dma_ops, this defaults
to dma_direct_ops.

In addition, the dma_map/unmap_page functions are added to dma_ops
because we can't just fall back on map/unmap_single when HIGHMEM is
enabled. In the case of dma_direct_*, we stop using map/unmap_single
and just use the page version - this saves a lot of ugly
ifdeffing.  We leave map/unmap_single in the dma_ops definition,
though, because they are needed by the iommu code, which does not
implement map/unmap_page.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/include/asm/dma-mapping.h |  178 +++++++++----------------------
 arch/powerpc/include/asm/machdep.h     |    5 +-
 arch/powerpc/include/asm/pci.h         |   14 ++-
 arch/powerpc/kernel/Makefile           |    4 +-
 arch/powerpc/kernel/dma.c              |   69 ++++++++----
 arch/powerpc/kernel/pci-common.c       |   48 +++++++++
 arch/powerpc/kernel/pci_32.c           |    7 ++
 arch/powerpc/kernel/pci_64.c           |   46 --------
 8 files changed, 166 insertions(+), 205 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index c7ca45f..bd2b2b7 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -44,8 +44,6 @@ extern void __dma_sync_page(struct page *page, unsigned long offset,
 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
-#ifdef CONFIG_PPC64
-
 static inline unsigned long device_to_mask(struct device *dev)
 {
 	if (dev->dma_mask && *dev->dma_mask)
@@ -76,8 +74,24 @@ struct dma_mapping_ops {
 				struct dma_attrs *attrs);
 	int		(*dma_supported)(struct device *dev, u64 mask);
 	int		(*set_dma_mask)(struct device *dev, u64 dma_mask);
+	dma_addr_t 	(*map_page)(struct device *dev, struct page *page,
+				unsigned long offset, size_t size,
+				enum dma_data_direction direction,
+				struct dma_attrs *attrs);
+	void		(*unmap_page)(struct device *dev,
+				dma_addr_t dma_address, size_t size,
+				enum dma_data_direction direction,
+				struct dma_attrs *attrs);
 };
 
+/*
+ * Available generic sets of operations
+ */
+#ifdef CONFIG_PPC64
+extern struct dma_mapping_ops dma_iommu_ops;
+#endif
+extern struct dma_mapping_ops dma_direct_ops;
+
 static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
 {
 	/* We don't handle the NULL dev case for ISA for now. We could
@@ -85,8 +99,16 @@ static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
 	 * only ISA DMA device we support is the floppy and we have a hack
 	 * in the floppy driver directly to get a device for us.
 	 */
-	if (unlikely(dev == NULL || dev->archdata.dma_ops == NULL))
+
+	if (unlikely(dev == NULL) || dev->archdata.dma_ops == NULL) {
+#ifdef CONFIG_PPC64
 		return NULL;
+#else
+		/* Use default on 32-bit if dma_ops is not set up */
+		return &dma_direct_ops;
+#endif
+	}
+
 	return dev->archdata.dma_ops;
 }
 
@@ -132,7 +154,14 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	return dma_ops->map_single(dev, cpu_addr, size, direction, attrs);
+
+	if (dma_ops->map_single)
+		return dma_ops->map_single(dev, cpu_addr, size, direction,
+					   attrs);
+
+	return dma_ops->map_page(dev, virt_to_page(cpu_addr),
+				 (unsigned long)cpu_addr % PAGE_SIZE, size,
+				 direction, attrs);
 }
 
 static inline void dma_unmap_single_attrs(struct device *dev,
@@ -144,7 +173,13 @@ static inline void dma_unmap_single_attrs(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->unmap_single(dev, dma_addr, size, direction, attrs);
+
+	if (dma_ops->unmap_single) {
+		dma_ops->unmap_single(dev, dma_addr, size, direction, attrs);
+		return;
+	}
+
+	dma_ops->unmap_page(dev, dma_addr, size, direction, attrs);
 }
 
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
@@ -156,8 +191,13 @@ static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
+
+	if (dma_ops->map_page)
+		return dma_ops->map_page(dev, page, offset, size, direction,
+					 attrs);
+
 	return dma_ops->map_single(dev, page_address(page) + offset, size,
-			direction, attrs);
+				   direction, attrs);
 }
 
 static inline void dma_unmap_page_attrs(struct device *dev,
@@ -169,6 +209,12 @@ static inline void dma_unmap_page_attrs(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
+
+	if (dma_ops->unmap_page) {
+		dma_ops->unmap_page(dev, dma_address, size, direction, attrs);
+		return;
+	}
+
 	dma_ops->unmap_single(dev, dma_address, size, direction, attrs);
 }
 
@@ -253,126 +299,6 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	dma_unmap_sg_attrs(dev, sg, nhwentries, direction, NULL);
 }
 
-/*
- * Available generic sets of operations
- */
-extern struct dma_mapping_ops dma_iommu_ops;
-extern struct dma_mapping_ops dma_direct_ops;
-
-#else /* CONFIG_PPC64 */
-
-#define dma_supported(dev, mask)	(1)
-
-static inline int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = dma_mask;
-
-	return 0;
-}
-
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t * dma_handle,
-				       gfp_t gfp)
-{
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	return __dma_alloc_coherent(size, dma_handle, gfp);
-#else
-	void *ret;
-	/* ignore region specifiers */
-	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
-	if (dev == NULL || dev->coherent_dma_mask < 0xffffffff)
-		gfp |= GFP_DMA;
-
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_bus(ret);
-	}
-
-	return ret;
-#endif
-}
-
-static inline void
-dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-		  dma_addr_t dma_handle)
-{
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	__dma_free_coherent(size, vaddr);
-#else
-	free_pages((unsigned long)vaddr, get_order(size));
-#endif
-}
-
-static inline dma_addr_t
-dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
-{
-	BUG_ON(direction == DMA_NONE);
-
-	__dma_sync(ptr, size, direction);
-
-	return virt_to_bus(ptr);
-}
-
-static inline void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-				    size_t size,
-				    enum dma_data_direction direction)
-{
-	/* We do nothing. */
-}
-
-static inline dma_addr_t
-dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
-{
-	BUG_ON(direction == DMA_NONE);
-
-	__dma_sync_page(page, offset, size, direction);
-
-	return page_to_bus(page) + offset;
-}
-
-static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-				  size_t size,
-				  enum dma_data_direction direction)
-{
-	/* We do nothing. */
-}
-
-static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-	   enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	BUG_ON(direction == DMA_NONE);
-
-	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
-		sg->dma_address = page_to_bus(sg_page(sg)) + sg->offset;
-	}
-
-	return nents;
-}
-
-static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-				int nhwentries,
-				enum dma_data_direction direction)
-{
-	/* We don't do anything here. */
-}
-
-#endif /* CONFIG_PPC64 */
-
 static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 893aafd..2740c44 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -88,8 +88,6 @@ struct machdep_calls {
 	unsigned long	(*tce_get)(struct iommu_table *tbl,
 				    long index);
 	void		(*tce_flush)(struct iommu_table *tbl);
-	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
-	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
 
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags);
@@ -101,6 +99,9 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
+	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
+	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
+
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
 	void		(*init_early)(void);
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index a05a942..0e52c78 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -60,6 +60,14 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+#ifdef CONFIG_PCI
+extern void set_pci_dma_ops(struct dma_mapping_ops *dma_ops);
+extern struct dma_mapping_ops *get_pci_dma_ops(void);
+#else	/* CONFIG_PCI */
+#define set_pci_dma_ops(d)
+#define get_pci_dma_ops()	NULL
+#endif
+
 #ifdef CONFIG_PPC64
 
 /*
@@ -70,9 +78,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define PCI_DISABLE_MWI
 
 #ifdef CONFIG_PCI
-extern void set_pci_dma_ops(struct dma_mapping_ops *dma_ops);
-extern struct dma_mapping_ops *get_pci_dma_ops(void);
-
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -89,9 +94,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 	*strat = PCI_DMA_BURST_MULTIPLE;
 	*strategy_parameter = cacheline_size;
 }
-#else	/* CONFIG_PCI */
-#define set_pci_dma_ops(d)
-#define get_pci_dma_ops()	NULL
 #endif
 
 #else /* 32-bit */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 45570fe..98f5282 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -68,10 +68,10 @@ extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= time.o prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o \
+				   udbg.o misc.o io.o dma.o \
 				   misc_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
-obj-$(CONFIG_PPC64)		+= dma.o dma-iommu.o iommu.o
+obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 124f867..41fdd48 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -16,21 +16,30 @@
  * This implementation supports a per-device offset that can be applied if
  * the address at which memory is visible to devices is not 0. Platform code
  * can set archdata.dma_data to an unsigned long holding the offset. By
- * default the offset is zero.
+ * default the offset is PCI_DRAM_OFFSET.
  */
 
 static unsigned long get_dma_direct_offset(struct device *dev)
 {
-	return (unsigned long)dev->archdata.dma_data;
+	if (dev)
+		return (unsigned long)dev->archdata.dma_data;
+
+	return PCI_DRAM_OFFSET;
 }
 
-static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag)
+void *dma_direct_alloc_coherent(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flag)
 {
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	return __dma_alloc_coherent(size, dma_handle, flag);
+#else
 	struct page *page;
 	void *ret;
 	int node = dev_to_node(dev);
 
+	/* ignore region specifiers */
+	flag  &= ~(__GFP_HIGHMEM);
+
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
 		return NULL;
@@ -39,27 +48,17 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 	*dma_handle = virt_to_abs(ret) + get_dma_direct_offset(dev);
 
 	return ret;
+#endif
 }
 
-static void dma_direct_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle)
+void dma_direct_free_coherent(struct device *dev, size_t size,
+			      void *vaddr, dma_addr_t dma_handle)
 {
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	__dma_free_coherent(size, vaddr);
+#else
 	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static dma_addr_t dma_direct_map_single(struct device *dev, void *ptr,
-					size_t size,
-					enum dma_data_direction direction,
-					struct dma_attrs *attrs)
-{
-	return virt_to_abs(ptr) + get_dma_direct_offset(dev);
-}
-
-static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
-				    size_t size,
-				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
-{
+#endif
 }
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
@@ -85,20 +84,44 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
 
 static int dma_direct_dma_supported(struct device *dev, u64 mask)
 {
+#ifdef CONFIG_PPC64
 	/* Could be improved to check for memory though it better be
 	 * done via some global so platforms can set the limit in case
 	 * they have limited DMA windows
 	 */
 	return mask >= DMA_32BIT_MASK;
+#else
+	return 1;
+#endif
+}
+
+static inline dma_addr_t dma_direct_map_page(struct device *dev,
+					     struct page *page,
+					     unsigned long offset,
+					     size_t size,
+					     enum dma_data_direction dir,
+					     struct dma_attrs *attrs)
+{
+	BUG_ON(dir == DMA_NONE);
+	__dma_sync_page(page, offset, size, dir);
+	return page_to_phys(page) + offset + get_dma_direct_offset(dev);
+}
+
+static inline void dma_direct_unmap_page(struct device *dev,
+					 dma_addr_t dma_address,
+					 size_t size,
+					 enum dma_data_direction direction,
+					 struct dma_attrs *attrs)
+{
 }
 
 struct dma_mapping_ops dma_direct_ops = {
 	.alloc_coherent	= dma_direct_alloc_coherent,
 	.free_coherent	= dma_direct_free_coherent,
-	.map_single	= dma_direct_map_single,
-	.unmap_single	= dma_direct_unmap_single,
 	.map_sg		= dma_direct_map_sg,
 	.unmap_sg	= dma_direct_unmap_sg,
 	.dma_supported	= dma_direct_dma_supported,
+	.map_page	= dma_direct_map_page,
+	.unmap_page	= dma_direct_unmap_page,
 };
 EXPORT_SYMBOL(dma_direct_ops);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ea0c61e..52ccfed 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -56,6 +56,34 @@ resource_size_t isa_mem_base;
 /* Default PCI flags is 0 */
 unsigned int ppc_pci_flags;
 
+static struct dma_mapping_ops *pci_dma_ops;
+
+void set_pci_dma_ops(struct dma_mapping_ops *dma_ops)
+{
+	pci_dma_ops = dma_ops;
+}
+
+struct dma_mapping_ops *get_pci_dma_ops(void)
+{
+	return pci_dma_ops;
+}
+EXPORT_SYMBOL(get_pci_dma_ops);
+
+int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
+{
+	return dma_set_mask(&dev->dev, mask);
+}
+
+int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
+{
+	int rc;
+
+	rc = dma_set_mask(&dev->dev, mask);
+	dev->dev.coherent_dma_mask = dev->dma_mask;
+
+	return rc;
+}
+
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
@@ -180,6 +208,26 @@ char __devinit *pcibios_setup(char *str)
 	return str;
 }
 
+void __devinit pcibios_setup_new_device(struct pci_dev *dev)
+{
+	struct dev_archdata *sd = &dev->dev.archdata;
+
+	sd->of_node = pci_device_to_OF_node(dev);
+
+	DBG("PCI: device %s OF node: %s\n", pci_name(dev),
+	    sd->of_node ? sd->of_node->full_name : "<none>");
+
+	sd->dma_ops = pci_dma_ops;
+#ifdef CONFIG_PPC32
+	sd->dma_data = (void *)PCI_DRAM_OFFSET;
+#endif
+	set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+	if (ppc_md.pci_dma_dev_setup)
+		ppc_md.pci_dma_dev_setup(dev);
+}
+EXPORT_SYMBOL(pcibios_setup_new_device);
+
 /*
  * Reads the interrupt pin to determine if interrupt is use by card.
  * If the interrupt is used, then gets the interrupt line from the
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 88db4ff..174b77e 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -424,6 +424,7 @@ void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 	unsigned long io_offset;
 	struct resource *res;
 	int i;
+	struct pci_dev *dev;
 
 	/* Hookup PHB resources */
 	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
@@ -457,6 +458,12 @@ void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 			bus->resource[i+1] = res;
 		}
 	}
+
+	if (ppc_md.pci_dma_bus_setup)
+		ppc_md.pci_dma_bus_setup(bus);
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		pcibios_setup_new_device(dev);
 }
 
 /* the next one is stolen from the alpha port... */
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 1f75bf0..8247cff 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -52,35 +52,6 @@ EXPORT_SYMBOL(pci_io_base);
 
 LIST_HEAD(hose_list);
 
-static struct dma_mapping_ops *pci_dma_ops;
-
-void set_pci_dma_ops(struct dma_mapping_ops *dma_ops)
-{
-	pci_dma_ops = dma_ops;
-}
-
-struct dma_mapping_ops *get_pci_dma_ops(void)
-{
-	return pci_dma_ops;
-}
-EXPORT_SYMBOL(get_pci_dma_ops);
-
-
-int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	return dma_set_mask(&dev->dev, mask);
-}
-
-int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	int rc;
-
-	rc = dma_set_mask(&dev->dev, mask);
-	dev->dev.coherent_dma_mask = dev->dma_mask;
-
-	return rc;
-}
-
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
@@ -548,23 +519,6 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_map_io_space);
 
-void __devinit pcibios_setup_new_device(struct pci_dev *dev)
-{
-	struct dev_archdata *sd = &dev->dev.archdata;
-
-	sd->of_node = pci_device_to_OF_node(dev);
-
-	DBG("PCI: device %s OF node: %s\n", pci_name(dev),
-	    sd->of_node ? sd->of_node->full_name : "<none>");
-
-	sd->dma_ops = pci_dma_ops;
-	set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-	if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
-}
-EXPORT_SYMBOL(pcibios_setup_new_device);
-
 void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-- 
1.5.5.1
