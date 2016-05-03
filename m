Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhvf0zbKzDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:33:33 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:27 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C9157394005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:53:18 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNItW36175918
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:18 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNIxY031814
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:22 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 14/22] powerpc/powernv: Use PCI slot reset infrastructure
Date: Tue,  3 May 2016 23:22:45 +1000
Message-Id: <1462281773-26438-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The (OPAL) firmware might provide the PCI slot reset capability
which is identified by property "ibm,reset-by-firmware" on the
PCI slot associated device node.

This routes the reset request to firmware if "ibm,reset-by-firmware"
exists in the PCI slot device node. Otherwise, the reset is done
inside kernel as before.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3b17033..1ea78e5 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -36,6 +36,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/opal.h>
 #include <asm/ppc-pci.h>
+#include <asm/pnv-pci.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -815,7 +816,7 @@ out:
 	return 0;
 }
 
-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -866,6 +867,44 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct device_node *dn = pci_device_to_OF_node(pdev);
+	uint64_t id = PCI_SLOT_ID(phb->opal_id,
+				  (pdev->bus->number << 8) | pdev->devfn);
+	uint8_t scope;
+	int64_t rc;
+
+	/* Hot reset to the bus if firmware cannot handle */
+	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
+		return __pnv_eeh_bridge_reset(pdev, option);
+
+	switch (option) {
+	case EEH_RESET_FUNDAMENTAL:
+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_HOT:
+		scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	default:
+		dev_dbg(&pdev->dev, "%s: Unsupported reset %d\n",
+			__func__, option);
+		return -EINVAL;
+	}
+
+	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
+	if (rc <= OPAL_SUCCESS)
+		goto out;
+
+	rc = pnv_eeh_poll(id);
+out:
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
-- 
2.1.0
