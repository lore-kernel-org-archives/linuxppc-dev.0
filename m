Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A94D21A0C10
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:53 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:53 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7C88C2BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDgaT55378064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDHEF030289
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 41/50] powerpc/powernv: Use firmware PCI slot reset
 infrastructure
Date: Thu,  5 Nov 2015 00:12:41 +1100
Message-Id: <1446642770-4681-42-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The skiboot firmware might provide the PCI slot reset capability
which is identified by property "ibm,reset-by-firmware" on the
PCI slot associated device node.

This checks the property. If it exists, the reset request is routed
to firmware. Otherwise, the reset is done by kernel as before.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e533535..086d153 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -801,7 +801,7 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 	return ret;
 }
 
-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -852,6 +852,45 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct device_node *dn = pdev ? pci_device_to_OF_node(pdev) : NULL;
+	uint64_t id = (0x1ul << 60);
+	uint8_t scope;
+	int64_t rc;
+
+	/*
+	 * If the firmware can't handle it, we will issue hot reset
+	 * on the secondary bus despite the requested reset type.
+	 */
+	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
+		return __pnv_eeh_bridge_reset(pdev, option);
+
+	/* The firmware can handle the request */
+	switch (option) {
+	case EEH_RESET_HOT:
+		scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_FUNDAMENTAL:
+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	default:
+		dev_warn(&pdev->dev, "%s: Unsupported reset %d\n",
+			 __func__, option);
+		return -EINVAL;
+	}
+
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+	id |= (pdev->bus->number << 24) | (pdev->devfn << 16) | phb->opal_id;
+	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
+	return pnv_pci_poll(id, rc, NULL);
+}
+
 static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
 {
 	int *freset = data;
-- 
2.1.0
