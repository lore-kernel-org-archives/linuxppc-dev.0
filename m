Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 370B11A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:15 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:14 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 36E982CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N35uQd65208458
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:05:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36C9h018501
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 09/18] powerpc/spapr: vfio: Implement spapr_tce_iommu_ops
Date: Wed, 23 Jul 2014 13:05:55 +1000
Message-Id: <1406084764-24685-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modern IBM POWERPC systems support multiple IOMMU tables per PHB
so we need a more reliable way (compared to container_of()) to get
a PE pointer from the iommu_table struct pointer used in IOMMU functions.

At the moment IOMMU group data points to an iommu_table struct. This
introduces a spapr_tce_iommu_group struct which keeps an iommu_owner
and a spapr_tce_iommu_ops struct. For IODA, iommu_owner is a pointer to
the pnv_ioda_pe struct, for others it is still a pointer to
the iommu_table struct. The ops structs correspond to the type which
iommu_owner points to.

At the moment a get_table() callback is the only one. It returns
an iommu_table for a bus address.

As the IOMMU group data pointer points to variable type instead of
iommu_table, VFIO SPAPR TCE driver is fixed to use new type.
This changes the tce_container struct to keep iommu_group instead of
iommu_table.

So, it was:
- iommu_table points to iommu_group via iommu_table::it_group;
- iommu_group points to iommu_table via iommu_group_get_iommudata();

now it is:
- iommu_table points to iommu_group via iommu_table::it_group;
- iommu_group points to spapr_tce_iommu_group via
iommu_group_get_iommudata();
- spapr_tce_iommu_group points to either (depending on .get_table()):
	- iommu_table;
	- pnv_ioda_pe;

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h            |   6 ++
 arch/powerpc/include/asm/tce.h              |  13 ++++
 arch/powerpc/kernel/iommu.c                 |  31 +++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c   |  37 ++++++++-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   1 +
 arch/powerpc/platforms/powernv/pci.c        |   2 +-
 arch/powerpc/platforms/pseries/iommu.c      |  10 ++-
 drivers/vfio/vfio_iommu_spapr_tce.c         | 112 +++++++++++++++++++++-------
 8 files changed, 177 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index d8fb3fa..fb2c884 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -112,13 +112,19 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
  */
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
+
+struct spapr_tce_iommu_ops;
 #ifdef CONFIG_IOMMU_API
 extern void iommu_register_group(struct iommu_table *tbl,
+				 void *iommu_owner,
+				 struct spapr_tce_iommu_ops *ops,
 				 int pci_domain_number, unsigned long pe_num);
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
 #else
 static inline void iommu_register_group(struct iommu_table *tbl,
+					void *iommu_owner,
+					struct spapr_tce_iommu_ops *ops,
 					int pci_domain_number,
 					unsigned long pe_num)
 {
diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index 743f36b..a697681 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -50,5 +50,18 @@
 #define TCE_PCI_READ		0x1		/* read from PCI allowed */
 #define TCE_VB_WRITE		0x1		/* write from VB allowed */
 
+struct spapr_tce_iommu_group;
+
+struct spapr_tce_iommu_ops {
+	struct iommu_table *(*get_table)(
+			struct spapr_tce_iommu_group *data,
+			phys_addr_t addr);
+};
+
+struct spapr_tce_iommu_group {
+	void *iommu_owner;
+	struct spapr_tce_iommu_ops *ops;
+};
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_TCE_H */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index f84f799..b207332 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -877,24 +877,49 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
  */
 static void group_release(void *iommu_data)
 {
-	struct iommu_table *tbl = iommu_data;
-	tbl->it_group = NULL;
+	kfree(iommu_data);
 }
 
+static struct iommu_table *spapr_tce_get_default_table(
+		struct spapr_tce_iommu_group *data, phys_addr_t addr)
+{
+	struct iommu_table *tbl = data->iommu_owner;
+
+	if ((addr >> tbl->it_page_shift) < tbl->it_size)
+		return tbl;
+
+	return NULL;
+}
+
+static struct spapr_tce_iommu_ops spapr_tce_default_ops = {
+	.get_table = spapr_tce_get_default_table
+};
+
 void iommu_register_group(struct iommu_table *tbl,
+		void *iommu_owner, struct spapr_tce_iommu_ops *ops,
 		int pci_domain_number, unsigned long pe_num)
 {
 	struct iommu_group *grp;
 	char *name;
+	struct spapr_tce_iommu_group *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->iommu_owner = iommu_owner ? iommu_owner : tbl;
+	data->ops = ops ? ops : &spapr_tce_default_ops;
 
 	grp = iommu_group_alloc();
 	if (IS_ERR(grp)) {
 		pr_warn("powerpc iommu api: cannot create new group, err=%ld\n",
 				PTR_ERR(grp));
+		kfree(data);
 		return;
 	}
+
 	tbl->it_group = grp;
-	iommu_group_set_iommudata(grp, tbl, group_release);
+	iommu_group_set_iommudata(grp, data, group_release);
 	name = kasprintf(GFP_KERNEL, "domain%d-pe%lx",
 			pci_domain_number, pe_num);
 	if (!name)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 48e2358..8152e30 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/memblock.h>
+#include <linux/iommu.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -594,6 +595,31 @@ static void pnv_pci_ioda2_tce_invalidate_32(struct iommu_table *tbl,
 	pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
 }
 
+static bool pnv_pci_ioda_check_addr(struct iommu_table *tbl, __u64 start_addr)
+{
+	unsigned long entry = start_addr >> tbl->it_page_shift;
+	unsigned long start = tbl->it_offset;
+	unsigned long end = start + tbl->it_size;
+
+	return (start <= entry) && (entry < end);
+}
+
+static struct iommu_table *pnv_ioda1_iommu_get_table(
+		struct spapr_tce_iommu_group *data,
+		phys_addr_t addr)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+
+	if (pnv_pci_ioda_check_addr(&pe->tce32_table, addr))
+		return &pe->tce32_table;
+
+	return NULL;
+}
+
+static struct spapr_tce_iommu_ops pnv_pci_ioda1_ops = {
+	.get_table = pnv_ioda1_iommu_get_table,
+};
+
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -672,7 +698,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_PAIR);
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+	iommu_register_group(tbl, pe, &pnv_pci_ioda1_ops,
+			phb->hose->global_number, pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
@@ -736,8 +763,13 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 
 	/* Enable bypass by default */
 	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+
 }
 
+static struct spapr_tce_iommu_ops pnv_pci_ioda2_ops = {
+	.get_table = pnv_ioda1_iommu_get_table,
+};
+
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
@@ -802,7 +834,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+	iommu_register_group(tbl, pe, &pnv_pci_ioda2_ops,
+			phb->hose->global_number, pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 94ce348..b79066d 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -89,6 +89,7 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 	if (phb->p5ioc2.iommu_table.it_map == NULL) {
 		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
 		iommu_register_group(&phb->p5ioc2.iommu_table,
+				NULL, NULL,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
 	}
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1ab0f62..09287c7 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -670,7 +670,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
 				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
 	iommu_init_table(tbl, hose->node);
-	iommu_register_group(tbl, pci_domain_nr(hose->bus), 0);
+	iommu_register_group(tbl, NULL, NULL, pci_domain_nr(hose->bus), 0);
 
 	/* Deal with SW invalidated TCEs when needed (BML way) */
 	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 33b552f..a047754 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -616,7 +616,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 	iommu_table_setparms(pci->phb, dn, tbl);
 	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(tbl, pci_domain_nr(bus), 0);
+	iommu_register_group(tbl, NULL, NULL, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -661,7 +661,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 				   ppci->phb->node);
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
-		iommu_register_group(tbl, pci_domain_nr(bus), 0);
+		iommu_register_group(tbl, NULL, NULL, pci_domain_nr(bus), 0);
 		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
 }
@@ -688,7 +688,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
-		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
+		iommu_register_group(tbl, NULL, NULL,
+				pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base_and_group(&dev->dev,
 					       PCI_DN(dn)->iommu_table);
 		return;
@@ -1104,7 +1105,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 				   pci->phb->node);
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
+		iommu_register_group(tbl, NULL, NULL,
+				pci_domain_nr(pci->phb->bus), 0);
 		pr_debug("  created table: %p\n", pci->iommu_table);
 	} else {
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index c8f7284..1107c70 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -43,7 +43,7 @@ static void tce_iommu_detach_group(void *iommu_data,
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_table *tbl;
+	struct iommu_group *grp;
 	bool enabled;
 };
 
@@ -81,9 +81,14 @@ static long tce_iommu_account_memlimit(struct iommu_table *tbl, bool inc)
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
-	struct iommu_table *tbl = container->tbl;
+	struct iommu_table *tbl;
+	struct spapr_tce_iommu_group *data;
 
-	if (!container->tbl)
+	if (!container->grp)
+		return -ENXIO;
+
+	data = iommu_group_get_iommudata(container->grp);
+	if (!data || !data->iommu_owner || !data->ops->get_table)
 		return -ENXIO;
 
 	if (!current->mm)
@@ -110,6 +115,10 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * that would effectively kill the guest at random points, much better
 	 * enforcing the limit based on the max that the guest can map.
 	 */
+	tbl = data->ops->get_table(data, 0);
+	if (!tbl)
+		return -ENXIO;
+
 	ret = tce_iommu_account_memlimit(tbl, true);
 	if (ret)
 		return ret;
@@ -121,15 +130,26 @@ static int tce_iommu_enable(struct tce_container *container)
 
 static void tce_iommu_disable(struct tce_container *container)
 {
+	struct spapr_tce_iommu_group *data;
+	struct iommu_table *tbl;
+
 	if (!container->enabled)
 		return;
 
 	container->enabled = false;
 
-	if (!container->tbl || !current->mm)
+	if (!container->grp || !current->mm)
 		return;
 
-	tce_iommu_account_memlimit(container->tbl, false);
+	data = iommu_group_get_iommudata(container->grp);
+	if (!data || !data->iommu_owner || !data->ops->get_table)
+		return;
+
+	tbl = data->ops->get_table(data, 0);
+	if (!tbl)
+		return;
+
+	tce_iommu_account_memlimit(tbl, false);
 }
 
 static void *tce_iommu_open(unsigned long arg)
@@ -154,11 +174,11 @@ static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
 
-	WARN_ON(container->tbl && !container->tbl->it_group);
+	WARN_ON(container->grp);
 	tce_iommu_disable(container);
 
-	if (container->tbl && container->tbl->it_group)
-		tce_iommu_detach_group(iommu_data, container->tbl->it_group);
+	if (container->grp)
+		tce_iommu_detach_group(iommu_data, container->grp);
 
 	mutex_destroy(&container->lock);
 
@@ -178,8 +198,17 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl;
+		struct spapr_tce_iommu_group *data;
 
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		data = iommu_group_get_iommudata(container->grp);
+		if (WARN_ON(!data || !data->iommu_owner || !data->ops))
+			return -ENXIO;
+
+		tbl = data->ops->get_table(data, 0);
 		if (WARN_ON(!tbl))
 			return -ENXIO;
 
@@ -203,13 +232,16 @@ static long tce_iommu_ioctl(void *iommu_data,
 	}
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl;
+		struct spapr_tce_iommu_group *data;
 		unsigned long tce, i;
 
-		if (!tbl)
+		if (WARN_ON(!container->grp))
 			return -ENXIO;
 
-		BUG_ON(!tbl->it_group);
+		data = iommu_group_get_iommudata(container->grp);
+		if (WARN_ON(!data || !data->iommu_owner || !data->ops))
+			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
@@ -234,6 +266,11 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
 			tce |= TCE_PCI_WRITE;
 
+		tbl = data->ops->get_table(data, param.iova);
+		if (!tbl)
+			return -ENXIO;
+		BUG_ON(!tbl->it_group);
+
 		ret = iommu_tce_put_param_check(tbl, param.iova, tce);
 		if (ret)
 			return ret;
@@ -256,9 +293,14 @@ static long tce_iommu_ioctl(void *iommu_data,
 	}
 	case VFIO_IOMMU_UNMAP_DMA: {
 		struct vfio_iommu_type1_dma_unmap param;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl;
+		struct spapr_tce_iommu_group *data;
 
-		if (WARN_ON(!tbl))
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		data = iommu_group_get_iommudata(container->grp);
+		if (WARN_ON(!data || !data->iommu_owner || !data->ops))
 			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap,
@@ -277,6 +319,12 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.size & ~IOMMU_PAGE_MASK_4K)
 			return -EINVAL;
 
+		tbl = data->ops->get_table(data, param.iova);
+		if (WARN_ON(!tbl))
+			return -ENXIO;
+
+		BUG_ON(!tbl->it_group);
+
 		ret = iommu_tce_clear_param_check(tbl, param.iova, 0,
 				param.size >> IOMMU_PAGE_SHIFT_4K);
 		if (ret)
@@ -311,16 +359,16 @@ static int tce_iommu_attach_group(void *iommu_data,
 {
 	int ret;
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+	struct iommu_table *tbl;
+	struct spapr_tce_iommu_group *data;
 
-	BUG_ON(!tbl);
 	mutex_lock(&container->lock);
 
 	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
 			iommu_group_id(iommu_group), iommu_group); */
-	if (container->tbl) {
+	if (container->grp) {
 		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, existing id=%d, attaching id=%d\n",
-				iommu_group_id(container->tbl->it_group),
+				iommu_group_id(container->grp),
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
 	} else if (container->enabled) {
@@ -328,9 +376,16 @@ static int tce_iommu_attach_group(void *iommu_data,
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
 	} else {
+		data = iommu_group_get_iommudata(iommu_group);
+		if (WARN_ON(!data || !data->iommu_owner || !data->ops))
+			return -ENXIO;
+
+		tbl = data->ops->get_table(data, 0);
+		BUG_ON(!tbl);
+
 		ret = iommu_take_ownership(tbl);
 		if (!ret)
-			container->tbl = tbl;
+			container->grp = iommu_group;
 	}
 
 	mutex_unlock(&container->lock);
@@ -342,24 +397,31 @@ static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group)
 {
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+	struct iommu_table *tbl;
+	struct spapr_tce_iommu_group *data;
 
-	BUG_ON(!tbl);
 	mutex_lock(&container->lock);
-	if (tbl != container->tbl) {
+	if (iommu_group != container->grp) {
 		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
 				iommu_group_id(iommu_group),
-				iommu_group_id(tbl->it_group));
+				iommu_group_id(container->grp));
 	} else {
 		if (container->enabled) {
 			pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-					iommu_group_id(tbl->it_group));
+					iommu_group_id(container->grp));
 			tce_iommu_disable(container);
 		}
 
 		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
 				iommu_group_id(iommu_group), iommu_group); */
-		container->tbl = NULL;
+		container->grp = NULL;
+
+		data = iommu_group_get_iommudata(iommu_group);
+		BUG_ON(!data || !data->iommu_owner || !data->ops);
+
+		tbl = data->ops->get_table(data, 0);
+		BUG_ON(!tbl);
+
 		iommu_release_ownership(tbl);
 	}
 	mutex_unlock(&container->lock);
-- 
2.0.0
