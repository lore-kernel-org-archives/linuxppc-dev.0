Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EA791A0AE4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 19:55:25 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v4 06/16] powerpc/powernv: Split out set MSI IRQ chip code
Date: Wed,  8 Oct 2014 19:54:55 +1100
Message-Id: <1412758505-23495-7-git-send-email-mikey@neuling.org>
In-Reply-To: <1412758505-23495-1-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Some of the MSI IRQ code in pnv_pci_ioda_msi_setup() is generically useful so
split it out.

This will be used by some of the cxl PCIe code later.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 42 ++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index df241b1..baf3de6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1306,14 +1306,35 @@ static void pnv_ioda2_msi_eoi(struct irq_data *d)
 	icp_native_eoi(d);
 }
 
+
+static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
+{
+	struct irq_data *idata;
+	struct irq_chip *ichip;
+
+	if (phb->type != PNV_PHB_IODA2)
+		return;
+
+	if (!phb->ioda.irq_chip_init) {
+		/*
+		 * First time we setup an MSI IRQ, we need to setup the
+		 * corresponding IRQ chip to route correctly.
+		 */
+		idata = irq_get_irq_data(virq);
+		ichip = irq_data_get_irq_chip(idata);
+		phb->ioda.irq_chip_init = 1;
+		phb->ioda.irq_chip = *ichip;
+		phb->ioda.irq_chip.irq_eoi = pnv_ioda2_msi_eoi;
+	}
+	irq_set_chip(virq, &phb->ioda.irq_chip);
+}
+
 static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int hwirq, unsigned int virq,
 				  unsigned int is_64, struct msi_msg *msg)
 {
 	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
 	struct pci_dn *pdn = pci_get_pdn(dev);
-	struct irq_data *idata;
-	struct irq_chip *ichip;
 	unsigned int xive_num = hwirq - phb->msi_base;
 	__be32 data;
 	int rc;
@@ -1365,22 +1386,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	}
 	msg->data = be32_to_cpu(data);
 
-	/*
-	 * Change the IRQ chip for the MSI interrupts on PHB3.
-	 * The corresponding IRQ chip should be populated for
-	 * the first time.
-	 */
-	if (phb->type == PNV_PHB_IODA2) {
-		if (!phb->ioda.irq_chip_init) {
-			idata = irq_get_irq_data(virq);
-			ichip = irq_data_get_irq_chip(idata);
-			phb->ioda.irq_chip_init = 1;
-			phb->ioda.irq_chip = *ichip;
-			phb->ioda.irq_chip.irq_eoi = pnv_ioda2_msi_eoi;
-		}
-
-		irq_set_chip(virq, &phb->ioda.irq_chip);
-	}
+	set_msi_irq_chip(phb, virq);
 
 	pr_devel("%s: %s-bit MSI on hwirq %x (xive #%d),"
 		 " address=%x_%08x data=%x PE# %d\n",
-- 
1.9.1
