Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNwMd4cXyzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:41 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FNIo9D055559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:23:39 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mssdh1gy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:23:38 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 09:23:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 745C13578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:33 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FNNPv435520512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:33 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FNN0dc025081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:01 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "# v4 . 9+" <stable@vger.kernel.org>
Subject: [PATCH 3/3] pci/hotplug/pnv-php: Disable MSI and PCI device properly
Date: Thu, 16 Feb 2017 10:22:34 +1100
In-Reply-To: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1487200954-14681-4-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_php_disable_irq() can be called in two paths: Bailing path in
pnv_php_enable_irq() or releasing slot. The MSI (or MSIx) interrupts
is disabled unconditionally in pnv_php_disable_irq(). It's wrong
because that might be enabled by drivers other than pnv-php.

This disables MSI (or MSIx) interrupts and the PCI device only if
it was enabled by pnv-php. In the error path of pnv_php_enable_irq(),
we rely on the newly added parameter @disable_device. In the path
of releasing slot, @pnv_php->irq is checked.

Cc: <stable@vger.kernel.org> # v4.9+
Fixes: 360aebd85a4c ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 6d36b76..335a556 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -35,9 +35,11 @@ static void pnv_php_register(struct device_node *dn);
 static void pnv_php_unregister_one(struct device_node *dn);
 static void pnv_php_unregister(struct device_node *dn);
 
-static void pnv_php_disable_irq(struct pnv_php_slot *php_slot)
+static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
+				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
+	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -56,10 +58,14 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot)
 		php_slot->wq = NULL;
 	}
 
-	if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
-	else if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
+	if (disable_device || irq > 0) {
+		if (pdev->msix_enabled)
+			pci_disable_msix(pdev);
+		else if (pdev->msi_enabled)
+			pci_disable_msi(pdev);
+
+		pci_disable_device(pdev);
+	}
 }
 
 static void pnv_php_free_slot(struct kref *kref)
@@ -68,7 +74,7 @@ static void pnv_php_free_slot(struct kref *kref)
 					struct pnv_php_slot, kref);
 
 	WARN_ON(!list_empty(&php_slot->children));
-	pnv_php_disable_irq(php_slot);
+	pnv_php_disable_irq(php_slot, false);
 	kfree(php_slot->name);
 	kfree(php_slot);
 }
@@ -777,7 +783,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
 	if (!php_slot->wq) {
 		dev_warn(&pdev->dev, "Cannot alloc workqueue\n");
-		pnv_php_disable_irq(php_slot);
+		pnv_php_disable_irq(php_slot, true);
 		return;
 	}
 
@@ -799,7 +805,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	ret = request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
 			  php_slot->name, php_slot);
 	if (ret) {
-		pnv_php_disable_irq(php_slot);
+		pnv_php_disable_irq(php_slot, true);
 		dev_warn(&pdev->dev, "Error %d enabling IRQ %d\n", ret, irq);
 		return;
 	}
-- 
2.7.4
