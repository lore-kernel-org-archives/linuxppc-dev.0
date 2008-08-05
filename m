Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <fcff33bb1b4821af916593744dce0e4a149f1170.1217977742.git.michael@ellerman.id.au>
In-Reply-To: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
References: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] powerpc: Convert the MPIC MSI code to use msi_bitmap
Date: Wed,  6 Aug 2008 09:10:03 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This effects the U3 MSI code as well as the PASEMI MSI code. We keep
some of the MPIC routines as helpers, and also the U3 best-guess
reservation logic. The rest is replaced by the generic code.

And a few printk format changes due to hwirq type change.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/mpic.h       |    4 +-
 arch/powerpc/sysdev/mpic.h            |    2 -
 arch/powerpc/sysdev/mpic_msi.c        |  123 +++++----------------------------
 arch/powerpc/sysdev/mpic_pasemi_msi.c |   24 ++++---
 arch/powerpc/sysdev/mpic_u3msi.c      |   22 +++---
 5 files changed, 44 insertions(+), 131 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index fe566a3..34d9ac4 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -5,6 +5,7 @@
 #include <linux/irq.h>
 #include <linux/sysdev.h>
 #include <asm/dcr.h>
+#include <asm/msi_bitmap.h>
 
 /*
  * Global registers
@@ -301,8 +302,7 @@ struct mpic
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	spinlock_t		bitmap_lock;
-	unsigned long		*hwirq_bitmap;
+	struct msi_bitmap	msi_bitmap;
 #endif
 
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index fbf8a26..6209c62 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -14,8 +14,6 @@
 #ifdef CONFIG_PCI_MSI
 extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq);
 extern int mpic_msi_init_allocator(struct mpic *mpic);
-extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num);
-extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num);
 extern int mpic_u3msi_init(struct mpic *mpic);
 extern int mpic_pasemi_msi_init(struct mpic *mpic);
 #else
diff --git a/arch/powerpc/sysdev/mpic_msi.c b/arch/powerpc/sysdev/mpic_msi.c
index de3e5e8..1d44eee 100644
--- a/arch/powerpc/sysdev/mpic_msi.c
+++ b/arch/powerpc/sysdev/mpic_msi.c
@@ -15,59 +15,17 @@
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
+#include <asm/msi_bitmap.h>
 
 #include <sysdev/mpic.h>
 
-static void __mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq)
-{
-	pr_debug("mpic: reserving hwirq 0x%lx\n", hwirq);
-	bitmap_allocate_region(mpic->hwirq_bitmap, hwirq, 0);
-}
-
 void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq)
 {
-	unsigned long flags;
-
 	/* The mpic calls this even when there is no allocator setup */
-	if (!mpic->hwirq_bitmap)
+	if (!mpic->msi_bitmap.bitmap)
 		return;
 
-	spin_lock_irqsave(&mpic->bitmap_lock, flags);
-	__mpic_msi_reserve_hwirq(mpic, hwirq);
-	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
-}
-
-irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num)
-{
-	unsigned long flags;
-	int offset, order = get_count_order(num);
-
-	spin_lock_irqsave(&mpic->bitmap_lock, flags);
-	/*
-	 * This is fast, but stricter than we need. We might want to add
-	 * a fallback routine which does a linear search with no alignment.
-	 */
-	offset = bitmap_find_free_region(mpic->hwirq_bitmap, mpic->irq_count,
-					 order);
-	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
-
-	pr_debug("mpic: allocated 0x%x (2^%d) at offset 0x%x\n",
-		 num, order, offset);
-
-	return offset;
-}
-
-void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num)
-{
-	unsigned long flags;
-	int order = get_count_order(num);
-
-	pr_debug("mpic: freeing 0x%x (2^%d) at offset 0x%x\n",
-		 num, order, offset);
-
-	spin_lock_irqsave(&mpic->bitmap_lock, flags);
-	bitmap_release_region(mpic->hwirq_bitmap, offset, order);
-	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
+	msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, hwirq);
 }
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
@@ -83,13 +41,13 @@ static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
 
 	/* Reserve source numbers we know are reserved in the HW */
 	for (i = 0;   i < 8;   i++)
-		__mpic_msi_reserve_hwirq(mpic, i);
+		msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, i);
 
 	for (i = 42;  i < 46;  i++)
-		__mpic_msi_reserve_hwirq(mpic, i);
+		msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, i);
 
 	for (i = 100; i < 105; i++)
-		__mpic_msi_reserve_hwirq(mpic, i);
+		msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, i);
 
 	np = NULL;
 	while ((np = of_find_all_nodes(np))) {
@@ -99,7 +57,7 @@ static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
 		while (of_irq_map_one(np, index++, &oirq) == 0) {
 			ops->xlate(mpic->irqhost, NULL, oirq.specifier,
 						oirq.size, &hwirq, &flags);
-			__mpic_msi_reserve_hwirq(mpic, hwirq);
+			msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, hwirq);
 		}
 	}
 
@@ -112,70 +70,25 @@ static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
 }
 #endif
 
-static int mpic_msi_reserve_dt_hwirqs(struct mpic *mpic)
-{
-	int i, len;
-	const u32 *p;
-
-	p = of_get_property(mpic->irqhost->of_node,
-			    "msi-available-ranges", &len);
-	if (!p) {
-		pr_debug("mpic: no msi-available-ranges property found on %s\n",
-			  mpic->irqhost->of_node->full_name);
-		return -ENODEV;
-	}
-
-	if (len % 8 != 0) {
-		printk(KERN_WARNING "mpic: Malformed msi-available-ranges "
-		       "property on %s\n", mpic->irqhost->of_node->full_name);
-		return -EINVAL;
-	}
-
-	bitmap_allocate_region(mpic->hwirq_bitmap, 0,
-			       get_count_order(mpic->irq_count));
-
-	/* Format is: (<u32 start> <u32 count>)+ */
-	len /= sizeof(u32);
-	for (i = 0; i < len / 2; i++, p += 2)
-		mpic_msi_free_hwirqs(mpic, *p, *(p + 1));
-
-	return 0;
-}
-
 int mpic_msi_init_allocator(struct mpic *mpic)
 {
-	int rc, size;
-
-	BUG_ON(mpic->hwirq_bitmap);
-	spin_lock_init(&mpic->bitmap_lock);
+	int rc;
 
-	size = BITS_TO_LONGS(mpic->irq_count) * sizeof(long);
-	pr_debug("mpic: allocator bitmap size is 0x%x bytes\n", size);
+	rc = msi_bitmap_alloc(&mpic->msi_bitmap, mpic->irq_count,
+			      mpic->irqhost->of_node);
+	if (rc)
+		return rc;
 
-	mpic->hwirq_bitmap = alloc_maybe_bootmem(size, GFP_KERNEL);
-
-	if (!mpic->hwirq_bitmap) {
-		pr_debug("mpic: ENOMEM allocating allocator bitmap!\n");
-		return -ENOMEM;
-	}
-
-	memset(mpic->hwirq_bitmap, 0, size);
-
-	rc = mpic_msi_reserve_dt_hwirqs(mpic);
-	if (rc) {
+	rc = msi_bitmap_reserve_dt_hwirqs(&mpic->msi_bitmap);
+	if (rc > 0) {
 		if (mpic->flags & MPIC_U3_HT_IRQS)
 			rc = mpic_msi_reserve_u3_hwirqs(mpic);
 
-		if (rc)
-			goto out_free;
+		if (rc) {
+			msi_bitmap_free(&mpic->msi_bitmap);
+			return rc;
+		}
 	}
 
 	return 0;
-
- out_free:
-	if (mem_init_done)
-		kfree(mpic->hwirq_bitmap);
-
-	mpic->hwirq_bitmap = NULL;
-	return rc;
 }
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 68aff60..656cb77 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -22,6 +22,7 @@
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
+#include <asm/msi_bitmap.h>
 
 #include "mpic.h"
 
@@ -81,8 +82,8 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
 			continue;
 
 		set_irq_msi(entry->irq, NULL);
-		mpic_msi_free_hwirqs(msi_mpic, virq_to_hw(entry->irq),
-				     ALLOC_CHUNK);
+		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
+				       virq_to_hw(entry->irq), ALLOC_CHUNK);
 		irq_dispose_mapping(entry->irq);
 	}
 
@@ -91,11 +92,10 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
 
 static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-	irq_hw_number_t hwirq;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	int ret;
+	int hwirq;
 
 	pr_debug("pasemi_msi_setup_msi_irqs, pdev %p nvec %d type %d\n",
 		 pdev, nvec, type);
@@ -109,17 +109,19 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		 * few MSIs for someone, but restrictions will apply to how the
 		 * sources can be changed independently.
 		 */
-		ret = mpic_msi_alloc_hwirqs(msi_mpic, ALLOC_CHUNK);
-		hwirq = ret;
-		if (ret < 0) {
+		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap,
+						ALLOC_CHUNK);
+		if (hwirq < 0) {
 			pr_debug("pasemi_msi: failed allocating hwirq\n");
 			return hwirq;
 		}
 
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
 		if (virq == NO_IRQ) {
-			pr_debug("pasemi_msi: failed mapping hwirq 0x%lx\n", hwirq);
-			mpic_msi_free_hwirqs(msi_mpic, hwirq, ALLOC_CHUNK);
+			pr_debug("pasemi_msi: failed mapping hwirq 0x%x\n",
+				  hwirq);
+			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq,
+					       ALLOC_CHUNK);
 			return -ENOSPC;
 		}
 
@@ -133,8 +135,8 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		set_irq_chip(virq, &mpic_pasemi_msi_chip);
 		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
 
-		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%lx) addr 0x%x\n",
-			  virq, hwirq, msg.address_lo);
+		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%x) " \
+			 "addr 0x%x\n", virq, hwirq, msg.address_lo);
 
 		/* Likewise, the device writes [0...511] into the target
 		 * register to generate MSI [512...1023]
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 6e2f868..0a8f5a9 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -16,6 +16,7 @@
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
+#include <asm/msi_bitmap.h>
 
 #include "mpic.h"
 
@@ -101,7 +102,8 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 			continue;
 
 		set_irq_msi(entry->irq, NULL);
-		mpic_msi_free_hwirqs(msi_mpic, virq_to_hw(entry->irq), 1);
+		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
+				       virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
 	}
 
@@ -110,29 +112,27 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-	irq_hw_number_t hwirq;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	u64 addr;
-	int ret;
+	int hwirq;
 
 	addr = find_ht_magic_addr(pdev);
 	msg.address_lo = addr & 0xFFFFFFFF;
 	msg.address_hi = addr >> 32;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		ret = mpic_msi_alloc_hwirqs(msi_mpic, 1);
-		if (ret < 0) {
+		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
+		if (hwirq < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");
-			return ret;
+			return hwirq;
 		}
-		hwirq = ret;
 
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
 		if (virq == NO_IRQ) {
-			pr_debug("u3msi: failed mapping hwirq 0x%lx\n", hwirq);
-			mpic_msi_free_hwirqs(msi_mpic, hwirq, 1);
+			pr_debug("u3msi: failed mapping hwirq 0x%x\n", hwirq);
+			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 			return -ENOSPC;
 		}
 
@@ -140,8 +140,8 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		set_irq_chip(virq, &mpic_u3msi_chip);
 		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
 
-		pr_debug("u3msi: allocated virq 0x%x (hw 0x%lx) addr 0x%lx\n",
-			  virq, hwirq, addr);
+		pr_debug("u3msi: allocated virq 0x%x (hw 0x%x) addr 0x%lx\n",
+			  virq, hwirq, (unsigned long)addr);
 
 		msg.data = hwirq;
 		write_msi_msg(virq, &msg);
-- 
1.5.5
