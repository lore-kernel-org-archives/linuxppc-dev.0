Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2369C67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7B420870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7B420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FkHC1TsBzDqfG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Fk575PmHzDqc8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 17:18:19 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 48913AE80496;
 Thu, 13 Dec 2018 01:18:15 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v5 09/20] powerpc/powernv/pseries: Rework device adding
 to IOMMU groups
Date: Thu, 13 Dec 2018 17:17:23 +1100
Message-Id: <20181213061734.16651-10-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213061734.16651-1-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The powernv platform registers IOMMU groups and adds devices to them
from the pci_controller_ops::setup_bridge() hook except one case when
virtual functions (SRIOV VFs) are added from a bus notifier.

The pseries platform registers IOMMU groups from
the pci_controller_ops::dma_bus_setup() hook and adds devices from
the pci_controller_ops::dma_dev_setup() hook. The very same bus notifier
used for powernv does not add devices for pseries though as
__of_scan_bus() adds devices first, then it does the bus/dev DMA setup.

Both platforms use iommu_add_device() which takes a device and expects
it to have a valid IOMMU table struct with an iommu_table_group pointer
which in turn points the iommu_group struct (which represents
an IOMMU group). Although the helper seems easy to use, it relies on
some pre-existing device configuration and associated data structures
which it does not really need.

This simplifies iommu_add_device() to take the table_group pointer
directly. Pseries already has a table_group pointer handy and the bus
notified is not used anyway. For powernv, this copies the existing bus
notifier, makes it work for powernv only which means an easy way of
getting to the table_group pointer. This was tested on VFs but should
also support physical PCI hotplug.

Since iommu_add_device() receives the table_group pointer directly,
pseries does not do TCE cache invalidation (the hypervisor does) nor
allow multiple groups per a VFIO container (in other words sharing
an IOMMU table between partitionable endpoints), this removes
iommu_table_group_link from pseries.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/iommu.h          | 12 ++---
 arch/powerpc/kernel/iommu.c               | 58 ++---------------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 +---
 arch/powerpc/platforms/powernv/pci.c      | 43 ++++++++++++++++-
 arch/powerpc/platforms/pseries/iommu.c    | 46 +++++++++---------
 5 files changed, 74 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index a8aeac0..e847ff6 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -215,9 +215,9 @@ struct iommu_table_group {
 
 extern void iommu_register_group(struct iommu_table_group *table_group,
 				 int pci_domain_number, unsigned long pe_num);
-extern int iommu_add_device(struct device *dev);
+extern int iommu_add_device(struct iommu_table_group *table_group,
+		struct device *dev);
 extern void iommu_del_device(struct device *dev);
-extern int __init tce_iommu_bus_notifier_init(void);
 extern long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
 		unsigned long entry, unsigned long *hpa,
 		enum dma_data_direction *direction);
@@ -228,7 +228,8 @@ static inline void iommu_register_group(struct iommu_table_group *table_group,
 {
 }
 
-static inline int iommu_add_device(struct device *dev)
+static inline int iommu_add_device(struct iommu_table_group *table_group,
+		struct device *dev)
 {
 	return 0;
 }
@@ -236,11 +237,6 @@ static inline int iommu_add_device(struct device *dev)
 static inline void iommu_del_device(struct device *dev)
 {
 }
-
-static inline int __init tce_iommu_bus_notifier_init(void)
-{
-        return 0;
-}
 #endif /* !CONFIG_IOMMU_API */
 
 int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index cbcc615..9d5d109 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1078,11 +1078,8 @@ void iommu_release_ownership(struct iommu_table *tbl)
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
-int iommu_add_device(struct device *dev)
+int iommu_add_device(struct iommu_table_group *table_group, struct device *dev)
 {
-	struct iommu_table *tbl;
-	struct iommu_table_group_link *tgl;
-
 	/*
 	 * The sysfs entries should be populated before
 	 * binding IOMMU group. If sysfs entries isn't
@@ -1098,32 +1095,10 @@ int iommu_add_device(struct device *dev)
 		return -EBUSY;
 	}
 
-	tbl = get_iommu_table_base(dev);
-	if (!tbl) {
-		pr_debug("%s: Skipping device %s with no tbl\n",
-			 __func__, dev_name(dev));
-		return 0;
-	}
-
-	tgl = list_first_entry_or_null(&tbl->it_group_list,
-			struct iommu_table_group_link, next);
-	if (!tgl) {
-		pr_debug("%s: Skipping device %s with no group\n",
-			 __func__, dev_name(dev));
-		return 0;
-	}
 	pr_debug("%s: Adding %s to iommu group %d\n",
-		 __func__, dev_name(dev),
-		 iommu_group_id(tgl->table_group->group));
+		 __func__, dev_name(dev),  iommu_group_id(table_group->group));
 
-	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
-		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
-		       __func__, IOMMU_PAGE_SIZE(tbl),
-		       PAGE_SIZE, dev_name(dev));
-		return -EINVAL;
-	}
-
-	return iommu_group_add_device(tgl->table_group->group, dev);
+	return iommu_group_add_device(table_group->group, dev);
 }
 EXPORT_SYMBOL_GPL(iommu_add_device);
 
@@ -1143,31 +1118,4 @@ void iommu_del_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 EXPORT_SYMBOL_GPL(iommu_del_device);
-
-static int tce_iommu_bus_notifier(struct notifier_block *nb,
-                unsigned long action, void *data)
-{
-        struct device *dev = data;
-
-        switch (action) {
-        case BUS_NOTIFY_ADD_DEVICE:
-                return iommu_add_device(dev);
-        case BUS_NOTIFY_DEL_DEVICE:
-                if (dev->iommu_group)
-                        iommu_del_device(dev);
-                return 0;
-        default:
-                return 0;
-        }
-}
-
-static struct notifier_block tce_iommu_bus_nb = {
-        .notifier_call = tce_iommu_bus_notifier,
-};
-
-int __init tce_iommu_bus_notifier_init(void)
-{
-        bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
-        return 0;
-}
 #endif /* CONFIG_IOMMU_API */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ec4ce35..b86a6e0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1940,7 +1940,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
 		set_dma_offset(&dev->dev, pe->tce_bypass_base);
 		if (add_to_group)
-			iommu_add_device(&dev->dev);
+			iommu_add_device(&pe->table_group, &dev->dev);
 
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
@@ -2526,14 +2526,6 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (!pnv_iommu_bypass_disabled)
 		pnv_pci_ioda2_set_bypass(pe, true);
 
-	/*
-	 * Setting table base here only for carrying iommu_group
-	 * further down to let iommu_add_device() do the job.
-	 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
-	 */
-	if (pe->flags & PNV_IODA_PE_DEV)
-		set_iommu_table_base(&pe->pdev->dev, tbl);
-
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index db230a35..5121fb8 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1127,4 +1127,45 @@ void __init pnv_pci_init(void)
 	set_pci_dma_ops(&dma_iommu_ops);
 }
 
-machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
+static int pnv_tce_iommu_bus_notifier(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct pci_dev *pdev;
+	struct pci_dn *pdn;
+	struct pnv_ioda_pe *pe;
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		pdev = to_pci_dev(dev);
+		pdn = pci_get_pdn(pdev);
+		hose = pci_bus_to_host(pdev->bus);
+		phb = hose->private_data;
+
+		WARN_ON_ONCE(!phb);
+		if (!pdn || pdn->pe_number == IODA_INVALID_PE || !phb)
+			return 0;
+
+		pe = &phb->ioda.pe_array[pdn->pe_number];
+		iommu_add_device(&pe->table_group, dev);
+		return 0;
+	case BUS_NOTIFY_DEL_DEVICE:
+		iommu_del_device(dev);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static struct notifier_block pnv_tce_iommu_bus_nb = {
+	.notifier_call = pnv_tce_iommu_bus_notifier,
+};
+
+static int __init pnv_tce_iommu_bus_notifier_init(void)
+{
+	bus_register_notifier(&pci_bus_type, &pnv_tce_iommu_bus_nb);
+	return 0;
+}
+machine_subsys_initcall_sync(powernv, pnv_tce_iommu_bus_notifier_init);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 2783cb7..8fc8fe0 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -57,7 +57,6 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
 	struct iommu_table *tbl;
-	struct iommu_table_group_link *tgl;
 
 	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
 			   node);
@@ -68,22 +67,13 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 	if (!tbl)
 		goto free_group;
 
-	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
-			node);
-	if (!tgl)
-		goto free_table;
-
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
 	kref_init(&tbl->it_kref);
-	tgl->table_group = table_group;
-	list_add_rcu(&tgl->next, &tbl->it_group_list);
 
 	table_group->tables[0] = tbl;
 
 	return table_group;
 
-free_table:
-	kfree(tbl);
 free_group:
 	kfree(table_group);
 	return NULL;
@@ -93,23 +83,12 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		const char *node_name)
 {
 	struct iommu_table *tbl;
-#ifdef CONFIG_IOMMU_API
-	struct iommu_table_group_link *tgl;
-#endif
 
 	if (!table_group)
 		return;
 
 	tbl = table_group->tables[0];
 #ifdef CONFIG_IOMMU_API
-	tgl = list_first_entry_or_null(&tbl->it_group_list,
-			struct iommu_table_group_link, next);
-
-	WARN_ON_ONCE(!tgl);
-	if (tgl) {
-		list_del_rcu(&tgl->next);
-		kfree(tgl);
-	}
 	if (table_group->group) {
 		iommu_group_put(table_group->group);
 		BUG_ON(table_group->group);
@@ -1216,7 +1195,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	}
 
 	set_iommu_table_base(&dev->dev, pci->table_group->tables[0]);
-	iommu_add_device(&dev->dev);
+	iommu_add_device(pci->table_group, &dev->dev);
 }
 
 static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
@@ -1421,4 +1400,27 @@ static int __init disable_multitce(char *str)
 
 __setup("multitce=", disable_multitce);
 
+static int tce_iommu_bus_notifier(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_DEL_DEVICE:
+		iommu_del_device(dev);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static struct notifier_block tce_iommu_bus_nb = {
+	.notifier_call = tce_iommu_bus_notifier,
+};
+
+static int __init tce_iommu_bus_notifier_init(void)
+{
+	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
+	return 0;
+}
 machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
-- 
2.17.1

