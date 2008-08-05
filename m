Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <ec0bec2634b58a0ace998c095030489c946a462a.1217977742.git.michael@ellerman.id.au>
In-Reply-To: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
References: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] powerpc: Convert the FSL MSI code to use msi_bitmap
Date: Wed,  6 Aug 2008 09:10:02 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is 90% straight forward, although we have to change a few
printk format strings as well because of the change in type of hwirq.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/fsl_msi.c |  103 ++++++-----------------------------------
 arch/powerpc/sysdev/fsl_msi.h |    5 +-
 2 files changed, 17 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index d49fa99..f25ce81 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -14,7 +14,6 @@
  */
 #include <linux/irq.h>
 #include <linux/bootmem.h>
-#include <linux/bitmap.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/of_platform.h>
@@ -67,96 +66,22 @@ static struct irq_host_ops fsl_msi_host_ops = {
 	.map = fsl_msi_host_map,
 };
 
-static irq_hw_number_t fsl_msi_alloc_hwirqs(struct fsl_msi *msi, int num)
-{
-	unsigned long flags;
-	int order = get_count_order(num);
-	int offset;
-
-	spin_lock_irqsave(&msi->bitmap_lock, flags);
-
-	offset = bitmap_find_free_region(msi->fsl_msi_bitmap,
-					NR_MSI_IRQS, order);
-
-	spin_unlock_irqrestore(&msi->bitmap_lock, flags);
-
-	pr_debug("%s: allocated 0x%x (2^%d) at offset 0x%x\n",
-		__func__, num, order, offset);
-
-	return offset;
-}
-
-static void fsl_msi_free_hwirqs(struct fsl_msi *msi, int offset, int num)
-{
-	unsigned long flags;
-	int order = get_count_order(num);
-
-	pr_debug("%s: freeing 0x%x (2^%d) at offset 0x%x\n",
-		__func__, num, order, offset);
-
-	spin_lock_irqsave(&msi->bitmap_lock, flags);
-	bitmap_release_region(msi->fsl_msi_bitmap, offset, order);
-	spin_unlock_irqrestore(&msi->bitmap_lock, flags);
-}
-
-static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi)
-{
-	int i;
-	int len;
-	const u32 *p;
-
-	bitmap_allocate_region(msi->fsl_msi_bitmap, 0,
-		       get_count_order(NR_MSI_IRQS));
-
-	p = of_get_property(msi->irqhost->of_node, "msi-available-ranges",
-			    &len);
-
-	if (!p) {
-		/* No msi-available-ranges property,
-		 * All the 256 MSI interrupts can be used
-		 */
-		fsl_msi_free_hwirqs(msi, 0, 0x100);
-		return 0;
-	}
-
-	if ((len % (2 * sizeof(u32))) != 0) {
-		printk(KERN_WARNING "fsl_msi: Malformed msi-available-ranges "
-		       "property on %s\n", msi->irqhost->of_node->full_name);
-		return -EINVAL;
-	}
-
-	/* Format is: (<u32 start> <u32 count>)+ */
-	len /= 2 * sizeof(u32);
-	for (i = 0; i < len; i++, p += 2)
-		fsl_msi_free_hwirqs(msi, *p, *(p + 1));
-
-	return 0;
-}
-
 static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 {
 	int rc;
-	int size = BITS_TO_LONGS(NR_MSI_IRQS) * sizeof(u32);
 
-	msi_data->fsl_msi_bitmap = kzalloc(size, GFP_KERNEL);
+	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
+			      msi_data->irqhost->of_node);
+	if (rc)
+		return rc;
 
-	if (msi_data->fsl_msi_bitmap == NULL) {
-		pr_debug("%s: ENOMEM allocating allocator bitmap!\n",
-				__func__);
-		return -ENOMEM;
+	rc = msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
+	if (rc < 0) {
+		msi_bitmap_free(&msi_data->bitmap);
+		return rc;
 	}
 
-	rc = fsl_msi_free_dt_hwirqs(msi_data);
-	if (rc)
-		goto out_free;
-
 	return 0;
-out_free:
-	kfree(msi_data->fsl_msi_bitmap);
-
-	msi_data->fsl_msi_bitmap = NULL;
-	return rc;
-
 }
 
 static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
@@ -176,7 +101,8 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 		if (entry->irq == NO_IRQ)
 			continue;
 		set_irq_msi(entry->irq, NULL);
-		fsl_msi_free_hwirqs(msi_data, virq_to_hw(entry->irq), 1);
+		msi_bitmap_free_hwirqs(&msi_data->bitmap,
+				       virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
 	}
 
@@ -198,15 +124,14 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 
 static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-	irq_hw_number_t hwirq;
-	int rc;
+	int rc, hwirq;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	struct fsl_msi *msi_data = fsl_msi;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		hwirq = fsl_msi_alloc_hwirqs(msi_data, 1);
+		hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		if (hwirq < 0) {
 			rc = hwirq;
 			pr_debug("%s: fail allocating msi interrupt\n",
@@ -217,9 +142,9 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		virq = irq_create_mapping(msi_data->irqhost, hwirq);
 
 		if (virq == NO_IRQ) {
-			pr_debug("%s: fail mapping hwirq 0x%lx\n",
+			pr_debug("%s: fail mapping hwirq 0x%x\n",
 					__func__, hwirq);
-			fsl_msi_free_hwirqs(msi_data, hwirq, 1);
+			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 			rc = -ENOSPC;
 			goto out_free;
 		}
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 6574550..331c7e7 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -13,6 +13,8 @@
 #ifndef _POWERPC_SYSDEV_FSL_MSI_H
 #define _POWERPC_SYSDEV_FSL_MSI_H
 
+#include <asm/msi_bitmap.h>
+
 #define NR_MSI_REG		8
 #define IRQS_PER_MSI_REG	32
 #define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
@@ -31,8 +33,7 @@ struct fsl_msi {
 	void __iomem *msi_regs;
 	u32 feature;
 
-	unsigned long *fsl_msi_bitmap;
-	spinlock_t bitmap_lock;
+	struct msi_bitmap bitmap;
 };
 
 #endif /* _POWERPC_SYSDEV_FSL_MSI_H */
-- 
1.5.5
