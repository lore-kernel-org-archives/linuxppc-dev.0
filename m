Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 133A1B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 17:55:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3M7slZi007563 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 00:54:57 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3M843rh009129
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 03:04:04 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/5] fsl_msi: fix the conflict of virt_msir's chip_data
Date: Thu, 22 Apr 2010 16:31:35 +0800
Message-Id: <1271925099-29100-1-git-send-email-leoli@freescale.com>
Cc: Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In fsl_of_msi_probe(), the virt_msir's chip_data have been stored
the pointer to struct mpic. We add a struct fsl_msi_cascade_data
to store the pointer to struct fsl_msi and msir_index in hanler_data.
Otherwise, the pointer to struct mpic will be over-written, and will
cause problem when calling eoi() of the irq.

Signed-off-by: Zhao Chenhui <b26998@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ad453ca..93a638a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -21,6 +21,7 @@
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
+#include <asm/mpic.h>
 #include "fsl_msi.h"
 
 struct fsl_msi_feature {
@@ -28,6 +29,10 @@ struct fsl_msi_feature {
 	u32 msiir_offset;
 };
 
+struct fsl_msi_cascade_data {
+	struct fsl_msi *msi_data;
+	int index;
+};
 
 static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
 {
@@ -101,7 +106,7 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		if (entry->irq == NO_IRQ)
 			continue;
-		msi_data = get_irq_chip_data(entry->irq);
+		msi_data = get_irq_data(entry->irq);
 		set_irq_msi(entry->irq, NULL);
 		msi_bitmap_free_hwirqs(&msi_data->bitmap,
 				       virq_to_hw(entry->irq), 1);
@@ -132,7 +137,7 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 
 static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-	int rc, hwirq;
+	int rc, hwirq = NO_IRQ;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
@@ -158,6 +163,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			rc = -ENOSPC;
 			goto out_free;
 		}
+		set_irq_data(virq, msi_data);
 		set_irq_msi(virq, entry);
 
 		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
@@ -172,11 +178,15 @@ out_free:
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq;
-	struct fsl_msi *msi_data = get_irq_chip_data(irq);
+	struct fsl_msi *msi_data;
 	int msir_index = -1;
 	u32 msir_value = 0;
 	u32 intr_index;
 	u32 have_shift = 0;
+	struct fsl_msi_cascade_data *cascade_data;
+
+	cascade_data = (struct fsl_msi_cascade_data *)get_irq_data(irq);
+	msi_data = cascade_data->msi_data;
 
 	spin_lock(&desc->lock);
 	if ((msi_data->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
@@ -191,7 +201,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	if (unlikely(desc->status & IRQ_INPROGRESS))
 		goto unlock;
 
-	msir_index = (int)desc->handler_data;
+	msir_index = cascade_data->index;
 
 	if (msir_index >= NR_MSI_REG)
 		cascade_irq = NO_IRQ;
@@ -243,6 +253,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	int virt_msir;
 	const u32 *p;
 	struct fsl_msi_feature *features = match->data;
+	struct fsl_msi_cascade_data *cascade_data = NULL;
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
@@ -309,9 +320,19 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 			break;
 		virt_msir = irq_of_parse_and_map(dev->node, i);
 		if (virt_msir != NO_IRQ) {
-			set_irq_data(virt_msir, (void *)i);
+			cascade_data = kzalloc(
+					sizeof(struct fsl_msi_cascade_data),
+					GFP_KERNEL);
+			if (!cascade_data) {
+				dev_err(&dev->dev,
+					"No memory for MSI cascade data\n");
+				err = -ENOMEM;
+				goto error_out;
+			}
+			cascade_data->index = i;
+			cascade_data->msi_data = msi;
+			set_irq_data(virt_msir, (void *)cascade_data);
 			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
-			set_irq_chip_data(virt_msir, msi);
 		}
 	}
 
-- 
1.6.6-rc1.GIT
