Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C73191A1BFB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 68C2D3578058
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D7mu59768962
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:15 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764CbHN001262
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:41 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 25/42] powerpc/powernv: Use PCI slot reset infrastructure
Date: Thu,  6 Aug 2015 14:11:30 +1000
Message-Id: <1438834307-26960-26-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The skiboot firmware might provide the capability of resetting PCI
slot by property "ibm,reset-by-firmware" on the PCI slot associated
device node. The patch checks on the property and route the reset
to firmware if the property exists. Otherwise, we fail back to the
old path as before.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 44 +++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 0350dab..7be2ebf 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -843,7 +843,7 @@ out:
 	return 0;
 }
 
-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -894,6 +894,48 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
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
+	if (rc > 0)
+		rc = pnv_eeh_poll(id);
+
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+}
+
 static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, int pos,
 				     u16 mask, bool af_flr_rst)
 {
-- 
2.1.0
