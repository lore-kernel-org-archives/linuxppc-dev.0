Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtwX3GZczDrLf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:44:28 +1000 (AEST)
Received: by mail-pg0-f66.google.com with SMTP id y129so4334852pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:44:28 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ide: pmac: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:07 -0500
Message-Id: <20170718214339.7774-27-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/ide/pmac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 0c5d3a99468e..c5b902b86b44 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1145,8 +1145,8 @@ static int pmac_ide_macio_attach(struct macio_dev *mdev,
 		return -ENOMEM;

 	if (macio_resource_count(mdev) == 0) {
-		printk(KERN_WARNING "ide-pmac: no address for %s\n",
-				    mdev->ofdev.dev.of_node->full_name);
+		printk(KERN_WARNING "ide-pmac: no address for %pOF\n",
+				    mdev->ofdev.dev.of_node);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
@@ -1154,7 +1154,7 @@ static int pmac_ide_macio_attach(struct macio_dev *mdev,
 	/* Request memory resource for IO ports */
 	if (macio_request_resource(mdev, 0, "ide-pmac (ports)")) {
 		printk(KERN_ERR "ide-pmac: can't request MMIO resource for "
-				"%s!\n", mdev->ofdev.dev.of_node->full_name);
+				"%pOF!\n", mdev->ofdev.dev.of_node);
 		rc = -EBUSY;
 		goto out_free_pmif;
 	}
@@ -1165,8 +1165,8 @@ static int pmac_ide_macio_attach(struct macio_dev *mdev,
 	 * where that happens though...
 	 */
 	if (macio_irq_count(mdev) == 0) {
-		printk(KERN_WARNING "ide-pmac: no intrs for device %s, using "
-				    "13\n", mdev->ofdev.dev.of_node->full_name);
+		printk(KERN_WARNING "ide-pmac: no intrs for device %pOF, using "
+				    "13\n", mdev->ofdev.dev.of_node);
 		irq = irq_create_mapping(NULL, 13);
 	} else
 		irq = macio_irq(mdev, 0);
@@ -1183,8 +1183,8 @@ static int pmac_ide_macio_attach(struct macio_dev *mdev,
 	if (macio_resource_count(mdev) >= 2) {
 		if (macio_request_resource(mdev, 1, "ide-pmac (dma)"))
 			printk(KERN_WARNING "ide-pmac: can't request DMA "
-					    "resource for %s!\n",
-					    mdev->ofdev.dev.of_node->full_name);
+					    "resource for %pOF!\n",
+					    mdev->ofdev.dev.of_node);
 		else
 			pmif->dma_regs = ioremap(macio_resource_start(mdev, 1), 0x1000);
 	} else
@@ -1274,7 +1274,7 @@ static int pmac_ide_pci_attach(struct pci_dev *pdev,

 	if (pci_enable_device(pdev)) {
 		printk(KERN_WARNING "ide-pmac: Can't enable PCI device for "
-				    "%s\n", np->full_name);
+				    "%pOF\n", np);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
@@ -1282,7 +1282,7 @@ static int pmac_ide_pci_attach(struct pci_dev *pdev,

 	if (pci_request_regions(pdev, "Kauai ATA")) {
 		printk(KERN_ERR "ide-pmac: Cannot obtain PCI resources for "
-				"%s\n", np->full_name);
+				"%pOF\n", np);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
--
2.11.0
