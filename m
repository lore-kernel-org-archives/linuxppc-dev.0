Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7V606W12zDr21
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Dec 2017 01:56:24 +1100 (AEDT)
To: linux-pci@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Kees Cook <keescook@chromium.org>,
 Keith Busch <keith.busch@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pci/hotplug: Delete error messages for a failed memory
 allocation in four functions
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <dc3922b4-50f6-e7fa-482f-18e6ff5d905f@users.sourceforge.net>
Date: Fri, 29 Dec 2017 15:55:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2017 15:47:00 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pci/hotplug/pciehp_hpc.c  | 5 ++---
 drivers/pci/hotplug/pnv_php.c     | 8 +-------
 drivers/pci/hotplug/shpchp_core.c | 5 ++---
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7bab0606f1a9..ed27635ec740 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -838,10 +838,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 	struct pci_dev *pdev = dev->port;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl) {
-		dev_err(&dev->device, "%s: Out of memory\n", __func__);
+	if (!ctrl)
 		goto abort;
-	}
+
 	ctrl->pcie = dev;
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
 
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 74f6a17e4614..4ab318a0800d 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -266,7 +266,6 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	fdt1 = kzalloc(0x10000, GFP_KERNEL);
 	if (!fdt1) {
 		ret = -ENOMEM;
-		dev_warn(&php_slot->pdev->dev, "Cannot alloc FDT blob\n");
 		goto out;
 	}
 
@@ -280,8 +279,6 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
 	if (!fdt) {
 		ret = -ENOMEM;
-		dev_warn(&php_slot->pdev->dev, "Cannot %d bytes memory\n",
-			 fdt_totalsize(fdt1));
 		goto free_fdt1;
 	}
 
@@ -756,11 +753,8 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 	 * fine as the PCI devices (PE) aren't functional any more.
 	 */
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
-	if (!event) {
-		dev_warn(&pdev->dev, "PCI slot [%s] missed hotplug event 0x%04x\n",
-			 php_slot->name, sts);
+	if (!event)
 		return IRQ_HANDLED;
-	}
 
 	dev_info(&pdev->dev, "PCI slot [%s] %s (IRQ: %d)\n",
 		 php_slot->name, added ? "added" : "removed", irq);
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 7bfb87bd2b7e..2f2b87acf179 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -305,10 +305,9 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENODEV;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl) {
-		dev_err(&pdev->dev, "%s: Out of memory\n", __func__);
+	if (!ctrl)
 		goto err_out_none;
-	}
+
 	INIT_LIST_HEAD(&ctrl->slot_list);
 
 	rc = shpc_init(ctrl, pdev);
-- 
2.15.1
