Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 4891D100931
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:38 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <acb4e4d24dc0fdc6e01ee19a7012fb95e10c8247.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:11 -0500
Subject: [PATCH 28/37] powerpc: fsl_msi: use chip_data not handler_data
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

handler_data should be reserved for flow handlers on the dependent
irq, not consumed by the parent irq code that is part of the irq_chip
code.  The msi_data pointer was already set in msidesc->irqhost->hostdata
and being copied to irq_data->chipdata in the msidesc->irqhost->map()
method called via create_irq_mapping, so we can obtain the pointer
from there and free the instance it in teardown_msi_irqs.

Also remove the unnecessary cast of irq_get_handler_data in the
cascade handler, which is the demux flow handler of the parent
msi interrupt.  (This is the expected usage for handler_data).

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/sysdev/fsl_msi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 077776c..067cc88 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -110,7 +110,7 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		if (entry->irq == NO_IRQ)
 			continue;
-		msi_data = irq_get_handler_data(entry->irq);
+		msi_data = irq_get_chip_data(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		msi_bitmap_free_hwirqs(&msi_data->bitmap,
 				       virq_to_hw(entry->irq), 1);
@@ -168,7 +168,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			rc = -ENOSPC;
 			goto out_free;
 		}
-		irq_set_handler_data(virq, msi_data);
+		/* chip_data is msi_data via host->hostdata in host->map() */
 		irq_set_msi_desc(virq, entry);
 
 		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
@@ -193,7 +193,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	u32 have_shift = 0;
 	struct fsl_msi_cascade_data *cascade_data;
 
-	cascade_data = (struct fsl_msi_cascade_data *)irq_get_handler_data(irq);
+	cascade_data = irq_get_handler_data(irq);
 	msi_data = cascade_data->msi_data;
 
 	raw_spin_lock(&desc->lock);
-- 
1.7.0.4
