Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfJVk2VsrzDsjP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 22:15:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sfJVj5Rmjz9sQw
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:41 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LCDOJi026225
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:15:39 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25khh8wmq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:15:39 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 17:45:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 14DB2E0067
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 17:44:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LCFTLk6684752
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 17:45:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LCFQnF009412
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 17:45:28 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 4/4] drivers/pci/hotplug: Support surprise hotplug
Date: Wed, 21 Sep 2016 22:15:30 +1000
In-Reply-To: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1474460130-8316-5-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This supports PCI surprise hotplug. The design is highlighted as
below:

   * The PCI slot's surprise hotplug capability is exposed through
     device node property "ibm,slot-surprise-pluggable", meaning
     PCI surprise hotplug will be disabled if skiboot doesn't support
     it yet.
   * The interrupt because of presence or link state change is raised
     on surprise hotplug event. One event is allocated and queued to
     the PCI slot for workqueue to pick it up and process in serialized
     fashion. The code flow for surprise hotplug is same to that for
     managed hotplug except: the affected PEs are put into frozen state
     to avoid unexpected EEH error reporting in surprise hot remove path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-pci.h |   9 ++
 drivers/pci/hotplug/pnv_php.c      | 219 +++++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 0cbd813..4ccd2b4 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -48,6 +48,12 @@ void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu);
 
 #endif
 
+struct pnv_php_event {
+	bool			added;
+	struct pnv_php_slot	*php_slot;
+	struct work_struct	work;
+};
+
 struct pnv_php_slot {
 	struct hotplug_slot		slot;
 	struct hotplug_slot_info	slot_info;
@@ -60,6 +66,9 @@ struct pnv_php_slot {
 #define PNV_PHP_STATE_POPULATED		2
 #define PNV_PHP_STATE_OFFLINE		3
 	int				state;
+	int				irq;
+	struct workqueue_struct		*wq;
+	struct pnv_php_event		*event;
 	struct device_node		*dn;
 	struct pci_dev			*pdev;
 	struct pci_bus			*bus;
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 21f1f9d..0358aa7 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -30,13 +30,42 @@ static void pnv_php_register(struct device_node *dn);
 static void pnv_php_unregister_one(struct device_node *dn);
 static void pnv_php_unregister(struct device_node *dn);
 
+static void pnv_php_disable_irq(struct pnv_php_slot *php_slot)
+{
+	struct pci_dev *pdev = php_slot->pdev;
+	u16 ctrl;
+
+	if (php_slot->irq > 0) {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
+		ctrl &= ~(PCI_EXP_SLTCTL_HPIE |
+			  PCI_EXP_SLTCTL_PDCE |
+			  PCI_EXP_SLTCTL_DLLSCE);
+		pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
+
+		free_irq(php_slot->irq, php_slot);
+		php_slot->irq = 0;
+	}
+
+	if (php_slot->wq) {
+		destroy_workqueue(php_slot->wq);
+		php_slot->wq = NULL;
+	}
+
+	if (pdev->msix_enabled)
+		pci_disable_msix(pdev);
+	else if (pdev->msi_enabled)
+		pci_disable_msi(pdev);
+}
+
 static void pnv_php_free_slot(struct kref *kref)
 {
 	struct pnv_php_slot *php_slot = container_of(kref,
 					struct pnv_php_slot, kref);
 
 	WARN_ON(!list_empty(&php_slot->children));
+	pnv_php_disable_irq(php_slot);
 	kfree(php_slot->name);
+	kfree(php_slot->event);
 	kfree(php_slot);
 }
 
@@ -536,9 +565,16 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	if (unlikely(!php_slot))
 		return NULL;
 
+	php_slot->event = kzalloc(sizeof(struct pnv_php_event), GFP_KERNEL);
+	if (unlikely(!php_slot->event)) {
+		kfree(php_slot);
+		return NULL;
+	}
+
 	php_slot->name = kstrdup(label, GFP_KERNEL);
 	if (unlikely(!php_slot->name)) {
 		kfree(php_slot);
+		kfree(php_slot->event);
 		return NULL;
 	}
 
@@ -616,6 +652,184 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 	return 0;
 }
 
+static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
+{
+	struct pci_dev *pdev = php_slot->pdev;
+	struct msix_entry entry;
+	int nr_entries, ret;
+	u16 pcie_flag;
+
+	/* Get total number of MSIx entries */
+	nr_entries = pci_msix_vec_count(pdev);
+	if (nr_entries < 0)
+		return nr_entries;
+
+	/* Check hotplug MSIx entry is in range */
+	pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &pcie_flag);
+	entry.entry = (pcie_flag & PCI_EXP_FLAGS_IRQ) >> 9;
+	if (entry.entry >= nr_entries)
+		return -ERANGE;
+
+	/* Enable MSIx */
+	ret = pci_enable_msix_exact(pdev, &entry, 1);
+	if (ret) {
+		dev_warn(&pdev->dev, "Error %d enabling MSIx\n", ret);
+		return ret;
+	}
+
+	return entry.vector;
+}
+
+static void pnv_php_event_handler(struct work_struct *work)
+{
+	struct pnv_php_event *event =
+		container_of(work, struct pnv_php_event, work);
+	struct pnv_php_slot *php_slot = event->php_slot;
+
+	if (event->added)
+		pnv_php_enable_slot(&php_slot->slot);
+	else
+		pnv_php_disable_slot(&php_slot->slot);
+
+	kfree(event);
+}
+
+static irqreturn_t pnv_php_interrupt(int irq, void *data)
+{
+	struct pnv_php_slot *php_slot = data;
+	struct pci_dev *pchild, *pdev = php_slot->pdev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct pnv_php_event *event;
+	u16 sts, lsts;
+	u8 presence;
+	bool added;
+	unsigned long flags;
+	int ret;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
+	sts &= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
+	if (sts & PCI_EXP_SLTSTA_DLLSC) {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lsts);
+		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
+	} else if (sts & PCI_EXP_SLTSTA_PDC) {
+		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
+		if (!ret)
+			return IRQ_HANDLED;
+		added = !!(presence == OPAL_PCI_SLOT_PRESENT);
+	} else {
+		return IRQ_NONE;
+	}
+
+	/* We need freeze the PE in PCI hot remove case. The event that
+	 * was allocated in advanced is used. The time to allocate the
+	 * memory for the event is saved so that we can freeze the PE
+	 * quikly as possible.
+	 */
+	event = php_slot->event;
+	php_slot->event = NULL;
+	if (unlikely(!event))
+		event = kzalloc(sizeof(*event), GFP_ATOMIC);
+	if (unlikely(!event)) {
+		dev_warn(&pdev->dev, "PCI slot [%s] missed hotplug event 0x%04x\n",
+			 php_slot->name, sts);
+		return IRQ_HANDLED;
+	}
+
+	if (!added) {
+		pchild = list_first_entry_or_null(&php_slot->bus->devices,
+						  struct pci_dev, bus_list);
+		edev = pchild ? pci_dev_to_eeh_dev(pchild) : NULL;
+		pe = edev ? edev->pe : NULL;
+		if (likely(pe)) {
+			eeh_serialize_lock(&flags);
+			eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+			eeh_serialize_unlock(flags);
+			eeh_pe_set_option(pe, EEH_OPT_FREEZE_PE);
+		}
+	}
+
+	dev_info(&pdev->dev, "PCI slot [%s] %s (IRQ: %d)\n",
+		 php_slot->name, added ? "added" : "removed", irq);
+	php_slot->event = kzalloc(sizeof(*event), GFP_ATOMIC);
+	INIT_WORK(&event->work, pnv_php_event_handler);
+	event->added = added;
+	event->php_slot = php_slot;
+	queue_work(php_slot->wq, &event->work);
+
+	return IRQ_HANDLED;
+}
+
+static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
+{
+	struct pci_dev *pdev = php_slot->pdev;
+	u16 sts, ctrl;
+	int ret;
+
+	/* Allocate workqueue */
+	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
+	if (!php_slot->wq) {
+		dev_warn(&pdev->dev, "Cannot alloc workqueue\n");
+		pnv_php_disable_irq(php_slot);
+		return;
+	}
+
+	/* Clear pending interrupts */
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
+	sts |= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
+
+	/* Request the interrupt */
+	ret = request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
+			  php_slot->name, php_slot);
+	if (ret) {
+		pnv_php_disable_irq(php_slot);
+		dev_warn(&pdev->dev, "Error %d enabling IRQ %d\n", ret, irq);
+		return;
+	}
+
+	/* Enable the interrupts */
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
+	ctrl |= (PCI_EXP_SLTCTL_HPIE |
+		 PCI_EXP_SLTCTL_PDCE |
+		 PCI_EXP_SLTCTL_DLLSCE);
+	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
+
+	/* The interrupt is initialized successfully when @irq is valid */
+	php_slot->irq = irq;
+}
+
+static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
+{
+	struct pci_dev *pdev = php_slot->pdev;
+	int irq, ret;
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_warn(&pdev->dev, "Error %d enabling device\n", ret);
+		return;
+	}
+
+	pci_set_master(pdev);
+
+	/* Enable MSIx interrupt */
+	irq = pnv_php_enable_msix(php_slot);
+	if (irq > 0) {
+		pnv_php_init_irq(php_slot, irq);
+		return;
+	}
+
+	/* Use MSI if MSIx doesn't work. Fail back to legacy INTx
+	 * if MSI doesn't work either
+	 */
+	ret = pci_enable_msi(pdev);
+	if (!ret || pdev->irq) {
+		irq = pdev->irq;
+		pnv_php_init_irq(php_slot, irq);
+	}
+}
+
 static int pnv_php_register_one(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot;
@@ -643,6 +857,11 @@ static int pnv_php_register_one(struct device_node *dn)
 	if (unlikely(ret))
 		goto unregister_slot;
 
+	/* Enable interrupt if the slot supports surprise hotplug */
+	prop32 = of_get_property(dn, "ibm,slot-surprise-pluggable", NULL);
+	if (prop32 && of_read_number(prop32, 1))
+		pnv_php_enable_irq(php_slot);
+
 	return 0;
 
 unregister_slot:
-- 
2.1.0
