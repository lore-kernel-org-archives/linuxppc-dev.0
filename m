Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl3c06ZxQzDsfq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:44 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T5m5O4022210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:43 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ruyvt213-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:43 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 15:51:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E947D2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T5pclV52035720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T5pc5o029560
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 7/7] drivers/pci/hotplug: Support surprise hotplug in
 powernv driver
Date: Thu, 29 Sep 2016 15:52:05 +1000
In-Reply-To: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1475128325-5367-8-git-send-email-gwshan@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/pnv-pci.h |   2 +
 drivers/pci/hotplug/pnv_php.c      | 212 +++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 0cbd813..17e89dd 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -60,6 +60,8 @@ struct pnv_php_slot {
 #define PNV_PHP_STATE_POPULATED		2
 #define PNV_PHP_STATE_OFFLINE		3
 	int				state;
+	int				irq;
+	struct workqueue_struct		*wq;
 	struct device_node		*dn;
 	struct pci_dev			*pdev;
 	struct pci_bus			*bus;
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 96ccb7f..7dba35c 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -22,6 +22,12 @@
 #define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
 #define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
 
+struct pnv_php_event {
+	bool			added;
+	struct pnv_php_slot	*php_slot;
+	struct work_struct	work;
+};
+
 static LIST_HEAD(pnv_php_slot_list);
 static DEFINE_SPINLOCK(pnv_php_lock);
 
@@ -29,12 +35,40 @@ static void pnv_php_register(struct device_node *dn);
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
 	kfree(php_slot);
 }
@@ -610,6 +644,179 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
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
+	/* Freeze the removed PE to avoid unexpected error reporting */
+	if (!added) {
+		pchild = list_first_entry_or_null(&php_slot->bus->devices,
+						  struct pci_dev, bus_list);
+		edev = pchild ? pci_dev_to_eeh_dev(pchild) : NULL;
+		pe = edev ? edev->pe : NULL;
+		if (pe) {
+			eeh_serialize_lock(&flags);
+			eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+			eeh_serialize_unlock(flags);
+			eeh_pe_set_option(pe, EEH_OPT_FREEZE_PE);
+		}
+	}
+
+	/* The PE is left in frozen state if the event is missed. It's
+	 * fine as the PCI devices (PE) aren't functional any more.
+	 */
+	event = kzalloc(sizeof(*event), GFP_ATOMIC);
+	if (!event) {
+		dev_warn(&pdev->dev, "PCI slot [%s] missed hotplug event 0x%04x\n",
+			 php_slot->name, sts);
+		return IRQ_HANDLED;
+	}
+
+	dev_info(&pdev->dev, "PCI slot [%s] %s (IRQ: %d)\n",
+		 php_slot->name, added ? "added" : "removed", irq);
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
@@ -637,6 +844,11 @@ static int pnv_php_register_one(struct device_node *dn)
 	if (ret)
 		goto unregister_slot;
 
+	/* Enable interrupt if the slot supports surprise hotplug */
+	ret = of_property_read_u32(dn, "ibm,slot-surprise-pluggable", &prop32);
+	if (!ret && prop32)
+		pnv_php_enable_irq(php_slot);
+
 	return 0;
 
 unregister_slot:
-- 
2.1.0
