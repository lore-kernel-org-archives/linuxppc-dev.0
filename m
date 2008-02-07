Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B8CADDEFF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 11:36:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m170aJNm000899
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 17:36:19 -0700 (MST)
Received: from monty.am.freescale.net (monty.am.freescale.net [10.82.19.26])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m170aIHK025472
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 18:36:18 -0600 (CST)
Received: from monty.am.freescale.net (localhost.localdomain [127.0.0.1])
	by monty.am.freescale.net (8.14.2/8.14.2) with ESMTP id m170WCkp001711
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 18:32:12 -0600
Received: from localhost (bgill@localhost)
	by monty.am.freescale.net (8.14.2/8.14.2/Submit) with ESMTP id
	m170WCoE001708
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 18:32:12 -0600
Date: Wed, 6 Feb 2008 18:32:12 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Reorg of 32-bit dma code
Message-ID: <Pine.LNX.4.64.0802061802310.1616@monty.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I've been looking at converting 32-bit powerpc's DMA code over to the 
64-bit method, where there is a dma_ops structure inside archdata
that tells us which operations a device should use for DMA.  I'll be 
needing this shortly because I need to implement swiotlb to deal with 
PCI and large amounts of RAM on 32-bit systems that support 36-bit
physical addressing. (Yes, I know.  Fun for me.  Woohoo.)

Anyway, I have an initial booting first pass, and wanted to get some 
feedback.  What I've done at this point is to make dma_64 common to both 
architectures (will rename it when I send a real patch...).  The 
dma_direct_* functions have been changed to work on both 32/64, and the 
old dma_* functionality in dma-mapping.h has been removed.   For now, to 
avoid whacking on every 32-bit platform, the get_dma_ops() function has 
been changed to return &dma_direct_ops if the device pointer exists but 
the dma_ops field is NULL.   I'm not sure if this needs to be ifdef'd for 
64-bit?

I've copied a bit of code over from pci_64.c into pci_common.c - some of 
it isn't in use yet but will be once I start doing actual setup in the 
platform code. pcibios_setup_new_device() becomes common as well.  I've 
also temporarily hacked the 32-bit code to set archdata.dma_data to 
PCI_DRAM_OFFSET, so we can eliminate the use of virt_to_bus() and instead 
use the 64-bit method, which gets rid of some ugly ifdefs in the dma code.  

That's really about it - the preliminary patch is below - clearly it will 
need some cleanup, but I wanted to post early and often.  Any feedback or 
suggestions on cleaning this up are greatly appreciated. 

Thanks!
-Becky

-----------

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ebf8d16..34a6a82 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -55,10 +55,10 @@ extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= time.o prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o \
+				   udbg.o misc.o io.o dma_64.o\
 				   misc_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
-obj-$(CONFIG_PPC64)		+= dma_64.o iommu.o
+obj-$(CONFIG_PPC64)		+= iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma_64.c
index 8423907..0199a3b 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -8,9 +8,11 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <asm/bug.h>
-#include <asm/iommu.h>
 #include <asm/abs_addr.h>
 
+#ifdef CONFIG_PPC64
+#include <asm/iommu.h>
+
 /*
  * Generic iommu implementation
  */
@@ -108,6 +110,8 @@ struct dma_mapping_ops dma_iommu_ops = {
 	.dma_supported	= dma_iommu_dma_supported,
 };
 EXPORT_SYMBOL(dma_iommu_ops);
+#endif /* CONFIG_PPC64 */
+
 
 /*
  * Generic direct DMA implementation
@@ -126,14 +130,28 @@ static unsigned long get_dma_direct_offset(struct device *dev)
 static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
 {
-	struct page *page;
 	void *ret;
+
+#ifdef CONFIG_PPC64
+	struct page *page;
 	int node = dev->archdata.numa_node;
 
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
 		return NULL;
 	ret = page_address(page);
+#else
+	/* ignore region specifiers */
+	flag  &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+	if (dev == NULL || dev->coherent_dma_mask < 0xffffffff)
+		flag |= GFP_DMA;
+
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (ret == NULL) 
+		return NULL;
+#endif
+
 	memset(ret, 0, size);
 	*dma_handle = virt_to_abs(ret) + get_dma_direct_offset(dev);
 
@@ -146,10 +164,29 @@ static void dma_direct_free_coherent(struct device *dev, size_t size,
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
+/* 
+ * Version of dma_direct_[alloc/free]_coherent for non-coherent devices or
+ * processors. 
+ */
+#ifdef CONFIG_NOT_COHERENT_CACHE
+static void *dma_direct_alloc_noncoherent(struct device *dev, size_t size,
+				       dma_addr_t *dma_handle, gfp_t flag)
+{
+	return __dma_alloc_coherent(size, dma_handle, flag);
+}
+
+static void dma_direct_free_noncoherent(struct device *dev, size_t size,
+				     void *vaddr, dma_addr_t dma_handle)
+{
+	__dma_free_coherent(size, vaddr);
+}
+#endif
+
 static dma_addr_t dma_direct_map_single(struct device *dev, void *ptr,
 					size_t size,
 					enum dma_data_direction direction)
 {
+	__dma_sync(ptr, size, direction);
 	return virt_to_abs(ptr) + get_dma_direct_offset(dev);
 }
 
@@ -180,16 +217,25 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
 
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
 }
 
 struct dma_mapping_ops dma_direct_ops = {
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	.alloc_coherent	= dma_direct_alloc_noncoherent,
+	.free_coherent	= dma_direct_free_noncoherent,
+#else
 	.alloc_coherent	= dma_direct_alloc_coherent,
 	.free_coherent	= dma_direct_free_coherent,
+#endif
 	.map_single	= dma_direct_map_single,
 	.unmap_single	= dma_direct_unmap_single,
 	.map_sg		= dma_direct_map_sg,
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 980fe32..35d5b87 100644
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
@@ -180,6 +208,36 @@ char __devinit *pcibios_setup(char *str)
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
+	/* Hack for now until the platforms do setup correctly.
+	 * This value is *only* good in the generic dma_direct code,
+	 * setting of this needs to be done by plat code based on which
+	 * set of dma_ops it has.  Since we only currently use
+	 * dma_direct_ops on ppc32, this works for now.
+	 */
+	sd->dma_data = (void *)PCI_DRAM_OFFSET;
+#endif
+
+#ifdef CONFIG_NUMA
+	sd->numa_node = pcibus_to_node(dev->bus);
+#else
+	sd->numa_node = -1;
+#endif
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
index 5275074..2a5487c 100644
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
@@ -548,26 +519,6 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
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
-#ifdef CONFIG_NUMA
-	sd->numa_node = pcibus_to_node(dev->bus);
-#else
-	sd->numa_node = -1;
-#endif
-	if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
-}
-EXPORT_SYMBOL(pcibios_setup_new_device);
-
 void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index bbefb69..b177bac 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -43,9 +43,10 @@ extern void __dma_sync_page(struct page *page, unsigned long offset,
 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
-#ifdef CONFIG_PPC64
+extern struct dma_mapping_ops dma_direct_ops;
+
 /*
- * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
+ * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO, etc.
  */
 struct dma_mapping_ops {
 	void *		(*alloc_coherent)(struct device *dev, size_t size,
@@ -71,8 +72,18 @@ static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
 	 * only ISA DMA device we support is the floppy and we have a hack
 	 * in the floppy driver directly to get a device for us.
 	 */
-	if (unlikely(dev == NULL || dev->archdata.dma_ops == NULL))
+	if (unlikely(dev == NULL))
 		return NULL;
+
+	/* Some legacy devices don't support archdata dma ops. 
+	 * Assume those devices can use dma_direct_ops.
+	 * This also serves as a default for 32-bit platforms
+	 * on which all devices use the direct ops and so we haven't
+	 * set up the archdata dma_ops.
+	 */
+	if (dev->archdata.dma_ops == NULL)
+		return &dma_direct_ops;
+
 	return dev->archdata.dma_ops;
 }
 
@@ -192,121 +203,6 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
  * Available generic sets of operations
  */
 extern struct dma_mapping_ops dma_iommu_ops;
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
 
 static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 0872ec2..7652495 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -85,8 +85,6 @@ struct machdep_calls {
 	unsigned long	(*tce_get)(struct iommu_table *tbl,
 				    long index);
 	void		(*tce_flush)(struct iommu_table *tbl);
-	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
-	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
 
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags);
@@ -98,6 +96,9 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
+	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
+	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
+
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
 	void		(*init_early)(void);
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index a05a942..0e52c78 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
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
