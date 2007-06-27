Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59F60DE016
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:35 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] [POWERPC] Move common PCI code out of pci_32/pci_64
Date: Wed, 27 Jun 2007 13:19:17 -0500
Message-Id: <11829683733835-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683713322-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
	<11829683663762-git-send-email-galak@kernel.crashing.org>
	<11829683691025-git-send-email-galak@kernel.crashing.org>
	<11829683713322-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved the low hanging fruit that was either identical or close
to it between ppc32 & ppc64 for PCI into pci-common.c

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |  314 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |  294 -----------------------------------
 arch/powerpc/kernel/pci_64.c     |  309 -------------------------------------
 3 files changed, 314 insertions(+), 603 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 3ca8cfb..b518b88 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -51,3 +51,317 @@ int pci_domain_nr(struct pci_bus *bus)
 }
 
 EXPORT_SYMBOL(pci_domain_nr);
+
+#ifdef CONFIG_PPC_OF
+static ssize_t pci_show_devspec(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev;
+	struct device_node *np;
+
+	pdev = to_pci_dev (dev);
+	np = pci_device_to_OF_node(pdev);
+	if (np == NULL || np->full_name == NULL)
+		return 0;
+	return sprintf(buf, "%s", np->full_name);
+}
+static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
+#endif /* CONFIG_PPC_OF */
+
+/* Add sysfs properties */
+void pcibios_add_platform_entries(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PPC_OF
+	device_create_file(&pdev->dev, &dev_attr_devspec);
+#endif /* CONFIG_PPC_OF */
+}
+
+char __init *pcibios_setup(char *str)
+{
+	return str;
+}
+
+/*
+ * Reads the interrupt pin to determine if interrupt is use by card.
+ * If the interrupt is used, then gets the interrupt line from the
+ * openfirmware and sets it in the pci_dev and pci_config line.
+ */
+int pci_read_irq_line(struct pci_dev *pci_dev)
+{
+	struct of_irq oirq;
+	unsigned int virq;
+
+	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
+
+#ifdef DEBUG
+	memset(&oirq, 0xff, sizeof(oirq));
+#endif
+	/* Try to get a mapping from the device-tree */
+	if (of_irq_map_pci(pci_dev, &oirq)) {
+		u8 line, pin;
+
+		/* If that fails, lets fallback to what is in the config
+		 * space and map that through the default controller. We
+		 * also set the type to level low since that's what PCI
+		 * interrupts are. If your platform does differently, then
+		 * either provide a proper interrupt tree or don't use this
+		 * function.
+		 */
+		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
+			return -1;
+		if (pin == 0)
+			return -1;
+		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
+		    line == 0xff) {
+			return -1;
+		}
+		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
+
+		virq = irq_create_mapping(NULL, line);
+		if (virq != NO_IRQ)
+			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
+	} else {
+		DBG(" -> got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
+		    oirq.size, oirq.specifier[0], oirq.specifier[1],
+		    oirq.controller->full_name);
+
+		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
+					     oirq.size);
+	}
+	if(virq == NO_IRQ) {
+		DBG(" -> failed to map !\n");
+		return -1;
+	}
+
+	DBG(" -> mapped to linux irq %d\n", virq);
+
+	pci_dev->irq = virq;
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_read_irq_line);
+
+/*
+ * Platform support for /proc/bus/pci/X/Y mmap()s,
+ * modelled on the sparc64 implementation by Dave Miller.
+ *  -- paulus.
+ */
+
+/*
+ * Adjust vm_pgoff of VMA such that it is the physical page offset
+ * corresponding to the 32-bit pci bus offset for DEV requested by the user.
+ *
+ * Basically, the user finds the base address for his device which he wishes
+ * to mmap.  They read the 32-bit value from the config space base register,
+ * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
+ * offset parameter of mmap on /proc/bus/pci/XXX for that device.
+ *
+ * Returns negative error code on failure, zero on success.
+ */
+static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
+					       resource_size_t *offset,
+					       enum pci_mmap_state mmap_state)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	unsigned long io_offset = 0;
+	int i, res_bit;
+
+	if (hose == 0)
+		return NULL;		/* should never happen */
+
+	/* If memory, add on the PCI bridge address offset */
+	if (mmap_state == pci_mmap_mem) {
+#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
+		*offset += hose->pci_mem_offset;
+#endif
+		res_bit = IORESOURCE_MEM;
+	} else {
+		io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+		*offset += io_offset;
+		res_bit = IORESOURCE_IO;
+	}
+
+	/*
+	 * Check that the offset requested corresponds to one of the
+	 * resources of the device.
+	 */
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		struct resource *rp = &dev->resource[i];
+		int flags = rp->flags;
+
+		/* treat ROM as memory (should be already) */
+		if (i == PCI_ROM_RESOURCE)
+			flags |= IORESOURCE_MEM;
+
+		/* Active and same type? */
+		if ((flags & res_bit) == 0)
+			continue;
+
+		/* In the range of this resource? */
+		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
+			continue;
+
+		/* found it! construct the final physical address */
+		if (mmap_state == pci_mmap_io)
+			*offset += hose->io_base_phys - io_offset;
+		return rp;
+	}
+
+	return NULL;
+}
+
+/*
+ * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
+ * device mapping.
+ */
+static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
+				      pgprot_t protection,
+				      enum pci_mmap_state mmap_state,
+				      int write_combine)
+{
+	unsigned long prot = pgprot_val(protection);
+
+	/* Write combine is always 0 on non-memory space mappings. On
+	 * memory space, if the user didn't pass 1, we check for a
+	 * "prefetchable" resource. This is a bit hackish, but we use
+	 * this to workaround the inability of /sysfs to provide a write
+	 * combine bit
+	 */
+	if (mmap_state != pci_mmap_mem)
+		write_combine = 0;
+	else if (write_combine == 0) {
+		if (rp->flags & IORESOURCE_PREFETCH)
+			write_combine = 1;
+	}
+
+	/* XXX would be nice to have a way to ask for write-through */
+	prot |= _PAGE_NO_CACHE;
+	if (write_combine)
+		prot &= ~_PAGE_GUARDED;
+	else
+		prot |= _PAGE_GUARDED;
+
+	return __pgprot(prot);
+}
+
+/*
+ * This one is used by /dev/mem and fbdev who have no clue about the
+ * PCI device, it tries to find the PCI device first and calls the
+ * above routine
+ */
+pgprot_t pci_phys_mem_access_prot(struct file *file,
+				  unsigned long pfn,
+				  unsigned long size,
+				  pgprot_t protection)
+{
+	struct pci_dev *pdev = NULL;
+	struct resource *found = NULL;
+	unsigned long prot = pgprot_val(protection);
+	unsigned long offset = pfn << PAGE_SHIFT;
+	int i;
+
+	if (page_is_ram(pfn))
+		return __pgprot(prot);
+
+	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+
+	for_each_pci_dev(pdev) {
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+			struct resource *rp = &pdev->resource[i];
+			int flags = rp->flags;
+
+			/* Active and same type? */
+			if ((flags & IORESOURCE_MEM) == 0)
+				continue;
+			/* In the range of this resource? */
+			if (offset < (rp->start & PAGE_MASK) ||
+			    offset > rp->end)
+				continue;
+			found = rp;
+			break;
+		}
+		if (found)
+			break;
+	}
+	if (found) {
+		if (found->flags & IORESOURCE_PREFETCH)
+			prot &= ~_PAGE_GUARDED;
+		pci_dev_put(pdev);
+	}
+
+	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
+
+	return __pgprot(prot);
+}
+
+
+/*
+ * Perform the actual remap of the pages for a PCI device mapping, as
+ * appropriate for this architecture.  The region in the process to map
+ * is described by vm_start and vm_end members of VMA, the base physical
+ * address is found in vm_pgoff.
+ * The pci device structure is provided so that architectures may make mapping
+ * decisions on a per-device or per-bus basis.
+ *
+ * Returns a negative error code on failure, zero on success.
+ */
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	resource_size_t offset = vma->vm_pgoff << PAGE_SHIFT;
+	struct resource *rp;
+	int ret;
+
+	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
+	if (rp == NULL)
+		return -EINVAL;
+
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
+	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
+						  vma->vm_page_prot,
+						  mmap_state, write_combine);
+
+	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+
+	return ret;
+}
+
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  resource_size_t *start, resource_size_t *end)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	resource_size_t offset = 0;
+
+	if (hose == NULL)
+		return;
+
+	if (rsrc->flags & IORESOURCE_IO)
+		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+
+	/* We pass a fully fixed up address to userland for MMIO instead of
+	 * a BAR value because X is lame and expects to be able to use that
+	 * to pass to /dev/mem !
+	 *
+	 * That means that we'll have potentially 64 bits values where some
+	 * userland apps only expect 32 (like X itself since it thinks only
+	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
+	 * 32 bits CHRPs :-(
+	 *
+	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
+	 * has been fixed (and the fix spread enough), we can re-enable the
+	 * 2 lines below and pass down a BAR value to userland. In that case
+	 * we'll also have to re-enable the matching code in
+	 * __pci_mmap_make_offset().
+	 *
+	 * BenH.
+	 */
+#if 0
+	else if (rsrc->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+#endif
+
+	*start = rsrc->start - offset;
+	*end = rsrc->end - offset;
+}
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index c81ffa2..3dd931e 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1028,34 +1028,12 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-static ssize_t pci_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev;
-	struct device_node *np;
-
-	pdev = to_pci_dev (dev);
-	np = pci_device_to_OF_node(pdev);
-	if (np == NULL || np->full_name == NULL)
-		return 0;
-	return sprintf(buf, "%s", np->full_name);
-}
-static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-
 #else /* CONFIG_PPC_OF */
 void pcibios_make_OF_bus_map(void)
 {
 }
 #endif /* CONFIG_PPC_OF */
 
-/* Add sysfs properties */
-void pcibios_add_platform_entries(struct pci_dev *pdev)
-{
-#ifdef CONFIG_PPC_OF
-	device_create_file(&pdev->dev, &dev_attr_devspec);
-#endif /* CONFIG_PPC_OF */
-}
-
-
 #ifdef CONFIG_PPC_PMAC
 /*
  * This set of routines checks for PCI<->PCI bridges that have closed
@@ -1390,11 +1368,6 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-char __init *pcibios_setup(char *str)
-{
-	return str;
-}
-
 /* the next one is stolen from the alpha port... */
 void __init
 pcibios_update_irq(struct pci_dev *dev, int irq)
@@ -1403,64 +1376,6 @@ pcibios_update_irq(struct pci_dev *dev, int irq)
 	/* XXX FIXME - update OF device tree node interrupt property */
 }
 
-#ifdef CONFIG_PPC_MERGE
-/* XXX This is a copy of the ppc64 version. This is temporary until we start
- * merging the 2 PCI layers
- */
-/*
- * Reads the interrupt pin to determine if interrupt is use by card.
- * If the interrupt is used, then gets the interrupt line from the
- * openfirmware and sets it in the pci_dev and pci_config line.
- */
-int pci_read_irq_line(struct pci_dev *pci_dev)
-{
-	struct of_irq oirq;
-	unsigned int virq;
-
-	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
-
-	/* Try to get a mapping from the device-tree */
-	if (of_irq_map_pci(pci_dev, &oirq)) {
-		u8 line, pin;
-
-		/* If that fails, lets fallback to what is in the config
-		 * space and map that through the default controller. We
-		 * also set the type to level low since that's what PCI
-		 * interrupts are. If your platform does differently, then
-		 * either provide a proper interrupt tree or don't use this
-		 * function.
-		 */
-		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
-			return -1;
-		if (pin == 0)
-			return -1;
-		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
-		    line == 0xff) {
-			return -1;
-		}
-		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
-
-		virq = irq_create_mapping(NULL, line);
-		if (virq != NO_IRQ)
-			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
-	} else {
-		DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
-		    oirq.size, oirq.specifier[0], oirq.controller->full_name);
-
-		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
-					     oirq.size);
-	}
-	if(virq == NO_IRQ) {
-		DBG(" -> failed to map !\n");
-		return -1;
-	}
-	pci_dev->irq = virq;
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_read_irq_line);
-#endif /* CONFIG_PPC_MERGE */
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	u16 cmd, old_cmd;
@@ -1503,176 +1418,6 @@ pci_bus_to_hose(int bus)
 	return NULL;
 }
 
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       resource_size_t *offset,
-					       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long io_offset = 0;
-	int i, res_bit;
-
-	if (hose == 0)
-		return NULL;		/* should never happen */
-
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-		*offset += hose->pci_mem_offset;
-#endif
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = hose->io_base_virt - (void __iomem *)_IO_BASE;
-		*offset += io_offset;
-		res_bit = IORESOURCE_IO;
-	}
-
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i == PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) == 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
-		return rp;
-	}
-
-	return NULL;
-}
-
-/*
- * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
- * device mapping.
- */
-static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
-				      pgprot_t protection,
-				      enum pci_mmap_state mmap_state,
-				      int write_combine)
-{
-	unsigned long prot = pgprot_val(protection);
-
-	/* Write combine is always 0 on non-memory space mappings. On
-	 * memory space, if the user didn't pass 1, we check for a
-	 * "prefetchable" resource. This is a bit hackish, but we use
-	 * this to workaround the inability of /sysfs to provide a write
-	 * combine bit
-	 */
-	if (mmap_state != pci_mmap_mem)
-		write_combine = 0;
-	else if (write_combine == 0) {
-		if (rp->flags & IORESOURCE_PREFETCH)
-			write_combine = 1;
-	}
-
-	/* XXX would be nice to have a way to ask for write-through */
-	prot |= _PAGE_NO_CACHE;
-	if (write_combine)
-		prot &= ~_PAGE_GUARDED;
-	else
-		prot |= _PAGE_GUARDED;
-
-	return __pgprot(prot);
-}
-
-/*
- * This one is used by /dev/mem and fbdev who have no clue about the
- * PCI device, it tries to find the PCI device first and calls the
- * above routine
- */
-pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long pfn,
-				  unsigned long size,
-				  pgprot_t protection)
-{
-	struct pci_dev *pdev = NULL;
-	struct resource *found = NULL;
-	unsigned long prot = pgprot_val(protection);
-	unsigned long offset = pfn << PAGE_SHIFT;
-	int i;
-
-	if (page_is_ram(pfn))
-		return __pgprot(prot);
-
-	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
-
-	for_each_pci_dev(pdev) {
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-			struct resource *rp = &pdev->resource[i];
-			int flags = rp->flags;
-
-			/* Active and same type? */
-			if ((flags & IORESOURCE_MEM) == 0)
-				continue;
-			/* In the range of this resource? */
-			if (offset < (rp->start & PAGE_MASK) ||
-			    offset > rp->end)
-				continue;
-			found = rp;
-			break;
-		}
-		if (found)
-			break;
-	}
-	if (found) {
-		if (found->flags & IORESOURCE_PREFETCH)
-			prot &= ~_PAGE_GUARDED;
-		pci_dev_put(pdev);
-	}
-
-	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
-
-	return __pgprot(prot);
-}
-
-
-/*
- * Perform the actual remap of the pages for a PCI device mapping, as
- * appropriate for this architecture.  The region in the process to map
- * is described by vm_start and vm_end members of VMA, the base physical
- * address is found in vm_pgoff.
- * The pci device structure is provided so that architectures may make mapping
- * decisions on a per-device or per-bus basis.
- *
- * Returns a negative error code on failure, zero on success.
- */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine)
-{
-	resource_size_t offset = vma->vm_pgoff << PAGE_SHIFT;
-	struct resource *rp;
-	int ret;
-
-	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-	if (rp == NULL)
-		return -EINVAL;
-
-	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
-						  vma->vm_page_prot,
-						  mmap_state, write_combine);
-
-	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
-
-	return ret;
-}
-
 /* Provide information on locations of various I/O regions in physical
  * memory.  Do this on a per-card basis so that we choose the right
  * root bridge.
@@ -1715,45 +1460,6 @@ long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
 	return result;
 }
 
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-			  const struct resource *rsrc,
-			  resource_size_t *start, resource_size_t *end)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t offset = 0;
-
-	if (hose == NULL)
-		return;
-
-	if (rsrc->flags & IORESOURCE_IO)
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	/* We pass a fully fixed up address to userland for MMIO instead of
-	 * a BAR value because X is lame and expects to be able to use that
-	 * to pass to /dev/mem !
-	 *
-	 * That means that we'll have potentially 64 bits values where some
-	 * userland apps only expect 32 (like X itself since it thinks only
-	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
-	 * 32 bits CHRPs :-(
-	 *
-	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
-	 * has been fixed (and the fix spread enough), we can re-enable the
-	 * 2 lines below and pass down a BAR value to userland. In that case
-	 * we'll also have to re-enable the matching code in
-	 * __pci_mmap_make_offset().
-	 *
-	 * BenH.
-	 */
-#if 0
-	else if (rsrc->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-#endif
-
-	*start = rsrc->start - offset;
-	*end = rsrc->end - offset;
-}
-
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller* hose = hose_head;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 23494fe..7a9a4fc 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -601,11 +601,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-char __init *pcibios_setup(char *str)
-{
-	return str;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	u16 cmd, oldcmd;
@@ -647,211 +642,6 @@ int pci_proc_domain(struct pci_bus *bus)
 	}
 }
 
-/*
- * Platform support for /proc/bus/pci/X/Y mmap()s,
- * modelled on the sparc64 implementation by Dave Miller.
- *  -- paulus.
- */
-
-/*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       resource_size_t *offset,
-					       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long io_offset = 0;
-	int i, res_bit;
-
-	if (hose == 0)
-		return NULL;		/* should never happen */
-
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-		*offset += hose->pci_mem_offset;
-#endif
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		*offset += io_offset;
-		res_bit = IORESOURCE_IO;
-	}
-
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i == PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) == 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-		       	*offset += hose->io_base_phys - io_offset;
-		return rp;
-	}
-
-	return NULL;
-}
-
-/*
- * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
- * device mapping.
- */
-static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
-				      pgprot_t protection,
-				      enum pci_mmap_state mmap_state,
-				      int write_combine)
-{
-	unsigned long prot = pgprot_val(protection);
-
-	/* Write combine is always 0 on non-memory space mappings. On
-	 * memory space, if the user didn't pass 1, we check for a
-	 * "prefetchable" resource. This is a bit hackish, but we use
-	 * this to workaround the inability of /sysfs to provide a write
-	 * combine bit
-	 */
-	if (mmap_state != pci_mmap_mem)
-		write_combine = 0;
-	else if (write_combine == 0) {
-		if (rp->flags & IORESOURCE_PREFETCH)
-			write_combine = 1;
-	}
-
-	/* XXX would be nice to have a way to ask for write-through */
-	prot |= _PAGE_NO_CACHE;
-	if (write_combine)
-		prot &= ~_PAGE_GUARDED;
-	else
-		prot |= _PAGE_GUARDED;
-
-	return __pgprot(prot);
-}
-
-/*
- * This one is used by /dev/mem and fbdev who have no clue about the
- * PCI device, it tries to find the PCI device first and calls the
- * above routine
- */
-pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long pfn,
-				  unsigned long size,
-				  pgprot_t protection)
-{
-	struct pci_dev *pdev = NULL;
-	struct resource *found = NULL;
-	unsigned long prot = pgprot_val(protection);
-	unsigned long offset = pfn << PAGE_SHIFT;
-	int i;
-
-	if (page_is_ram(pfn))
-		return __pgprot(prot);
-
-	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
-
-	for_each_pci_dev(pdev) {
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-			struct resource *rp = &pdev->resource[i];
-			int flags = rp->flags;
-
-			/* Active and same type? */
-			if ((flags & IORESOURCE_MEM) == 0)
-				continue;
-			/* In the range of this resource? */
-			if (offset < (rp->start & PAGE_MASK) ||
-			    offset > rp->end)
-				continue;
-			found = rp;
-			break;
-		}
-		if (found)
-			break;
-	}
-	if (found) {
-		if (found->flags & IORESOURCE_PREFETCH)
-			prot &= ~_PAGE_GUARDED;
-		pci_dev_put(pdev);
-	}
-
-	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
-
-	return __pgprot(prot);
-}
-
-
-/*
- * Perform the actual remap of the pages for a PCI device mapping, as
- * appropriate for this architecture.  The region in the process to map
- * is described by vm_start and vm_end members of VMA, the base physical
- * address is found in vm_pgoff.
- * The pci device structure is provided so that architectures may make mapping
- * decisions on a per-device or per-bus basis.
- *
- * Returns a negative error code on failure, zero on success.
- */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	resource_size_t offset = vma->vm_pgoff << PAGE_SHIFT;
-	struct resource *rp;
-	int ret;
-
-	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-	if (rp == NULL)
-		return -EINVAL;
-
-	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
-						  vma->vm_page_prot,
-						  mmap_state, write_combine);
-
-	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
-
-	return ret;
-}
-
-static ssize_t pci_show_devspec(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev;
-	struct device_node *np;
-
-	pdev = to_pci_dev (dev);
-	np = pci_device_to_OF_node(pdev);
-	if (np == NULL || np->full_name == NULL)
-		return 0;
-	return sprintf(buf, "%s", np->full_name);
-}
-static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-
-void pcibios_add_platform_entries(struct pci_dev *pdev)
-{
-	device_create_file(&pdev->dev, &dev_attr_devspec);
-}
-
 void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
 					    struct device_node *dev, int prim)
 {
@@ -1167,105 +957,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-/*
- * Reads the interrupt pin to determine if interrupt is use by card.
- * If the interrupt is used, then gets the interrupt line from the 
- * openfirmware and sets it in the pci_dev and pci_config line.
- */
-int pci_read_irq_line(struct pci_dev *pci_dev)
-{
-	struct of_irq oirq;
-	unsigned int virq;
-
-	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
-
-#ifdef DEBUG
-	memset(&oirq, 0xff, sizeof(oirq));
-#endif
-	/* Try to get a mapping from the device-tree */
-	if (of_irq_map_pci(pci_dev, &oirq)) {
-		u8 line, pin;
-
-		/* If that fails, lets fallback to what is in the config
-		 * space and map that through the default controller. We
-		 * also set the type to level low since that's what PCI
-		 * interrupts are. If your platform does differently, then
-		 * either provide a proper interrupt tree or don't use this
-		 * function.
-		 */
-		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
-			return -1;
-		if (pin == 0)
-			return -1;
-		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
-		    line == 0xff) {
-			return -1;
-		}
-		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
-
-		virq = irq_create_mapping(NULL, line);
-		if (virq != NO_IRQ)
-			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
-	} else {
-		DBG(" -> got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
-		    oirq.size, oirq.specifier[0], oirq.specifier[1],
-		    oirq.controller->full_name);
-
-		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
-					     oirq.size);
-	}
-	if(virq == NO_IRQ) {
-		DBG(" -> failed to map !\n");
-		return -1;
-	}
-
-	DBG(" -> mapped to linux irq %d\n", virq);
-
-	pci_dev->irq = virq;
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_read_irq_line);
-
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-			  const struct resource *rsrc,
-			  resource_size_t *start, resource_size_t *end)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t offset = 0;
-
-	if (hose == NULL)
-		return;
-
-	if (rsrc->flags & IORESOURCE_IO)
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	/* We pass a fully fixed up address to userland for MMIO instead of
-	 * a BAR value because X is lame and expects to be able to use that
-	 * to pass to /dev/mem !
-	 *
-	 * That means that we'll have potentially 64 bits values where some
-	 * userland apps only expect 32 (like X itself since it thinks only
-	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
-	 * 32 bits CHRPs :-(
-	 *
-	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
-	 * has been fixed (and the fix spread enough), we can re-enable the
-	 * 2 lines below and pass down a BAR value to userland. In that case
-	 * we'll also have to re-enable the matching code in
-	 * __pci_mmap_make_offset().
-	 *
-	 * BenH.
-	 */
-#if 0
-	else if (rsrc->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-#endif
-
-	*start = rsrc->start - offset;
-	*end = rsrc->end - offset;
-}
-
 struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
 {
 	if (!have_of)
-- 
1.5.2.1
