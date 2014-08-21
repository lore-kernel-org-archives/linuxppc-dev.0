Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D34C81A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 19:34:15 +1000 (EST)
Message-ID: <53F5BD01.3060909@freescale.com>
Date: Thu, 21 Aug 2014 12:33:53 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4][v2] powerpc/fsl_msi: spread msi ints across different
 MSIRs
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allocate msis such that each time a new interrupt is requested,
the SRS (MSIR register select) to be used is allocated in a
round-robin fashion.
The end result is that the msi interrupts will be spread across
distinct MSIRs with the main benefit that now users can set
affinity to each msi int through the mpic irq backing up the
MSIR register.
This is achieved with the help of a newly introduced msi bitmap
api that allows specifying the starting point when searching
for a free msi interrupt.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - re-wrapped commit message
 - fixed weird way of doing a simple A <<= B

 arch/powerpc/include/asm/msi_bitmap.h |  2 ++
 arch/powerpc/sysdev/fsl_msi.c         | 31 ++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_msi.h         |  5 +++++
 arch/powerpc/sysdev/msi_bitmap.c      | 25 +++++++++++++++----------
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include/asm/msi_bitmap.h
index 97ac3f4..96c2f95 100644
--- a/arch/powerpc/include/asm/msi_bitmap.h
+++ b/arch/powerpc/include/asm/msi_bitmap.h
@@ -25,6 +25,8 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num);
 void msi_bitmap_free_hwirqs(struct msi_bitmap *bmp, unsigned int offset,
 			    unsigned int num);
 void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq);
+int msi_bitmap_alloc_hwirqs_from_offset(struct msi_bitmap *bmp, int offset,
+					int num);
 
 int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp);
 
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index e2ee226..37254ef 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -213,6 +213,8 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		 * available interrupt.
 		 */
 		list_for_each_entry(msi_data, &msi_head, list) {
+			int off;
+
 			/*
 			 * If the PCI node has an fsl,msi property, then we
 			 * restrict our search to the corresponding MSI node.
@@ -224,7 +226,28 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			if (phandle && (phandle != msi_data->phandle))
 				continue;
 
-			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
+			/*
+			 * Allocate the msi message so that it fits on distinct
+			 * MSIR registers. Obviously, since MSIR registers are
+			 * limited they will overlap at one point.
+			 *
+			 * Due to the format of the newly introduced MSIIR1 in
+			 * mpic 4.3, consecutive msi message values map to
+			 * distinct MSIRs, thus distinct msi irq cascades, so
+			 * nothing special needs to be done in this case.
+			 * On older mpic versions the chose distinct SRS
+			 * values by aligning the msi message value to the
+			 * SRS field shift.
+			 */
+			if (msi_data->feature & FSL_PIC_FTR_MPIC_4_3) {
+				off = 0;
+			} else {
+				off = atomic_inc_return(&msi_data->msi_alloc_cnt) %
+					msi_data->msir_num;
+				off <<= msi_data->srs_shift;
+			}
+			hwirq = msi_bitmap_alloc_hwirqs_from_offset(
+						&msi_data->bitmap, off, 1);
 			if (hwirq >= 0)
 				break;
 		}
@@ -464,12 +487,17 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 		goto error_out;
 	}
 
+	atomic_set(&msi->msi_alloc_cnt, -1);
+
 	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
 
 	if (of_device_is_compatible(dev->dev.of_node, "fsl,mpic-msi-v4.3") ||
 	    of_device_is_compatible(dev->dev.of_node, "fsl,vmpic-msi-v4.3")) {
 		msi->srs_shift = MSIIR1_SRS_SHIFT;
 		msi->ibs_shift = MSIIR1_IBS_SHIFT;
+		msi->msir_num = NR_MSI_REG_MSIIR1;
+		msi->feature |= FSL_PIC_FTR_MPIC_4_3;
+
 		if (p)
 			dev_warn(&dev->dev, "%s: dose not support msi-available-ranges property\n",
 				__func__);
@@ -487,6 +515,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 
 		msi->srs_shift = MSIIR_SRS_SHIFT;
 		msi->ibs_shift = MSIIR_IBS_SHIFT;
+		msi->msir_num = NR_MSI_REG_MSIIR;
 
 		if (p && len % (2 * sizeof(u32)) != 0) {
 			dev_err(&dev->dev, "%s: Malformed msi-available-ranges property\n",
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 420cfcb..50ec4b0 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -15,6 +15,7 @@
 
 #include <linux/of.h>
 #include <asm/msi_bitmap.h>
+#include <asm/atomic.h>
 
 #define NR_MSI_REG_MSIIR	8  /* MSIIR can index 8 MSI registers */
 #define NR_MSI_REG_MSIIR1	16 /* MSIIR1 can index 16 MSI registers */
@@ -27,6 +28,8 @@
 #define FSL_PIC_IP_IPIC   0x00000002
 #define FSL_PIC_IP_VMPIC  0x00000003
 
+#define FSL_PIC_FTR_MPIC_4_3 0x00000010
+
 struct fsl_msi_cascade_data;
 
 struct fsl_msi {
@@ -37,6 +40,8 @@ struct fsl_msi {
 	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
 	u32 ibs_shift; /* Shift of interrupt bit select */
 	u32 srs_shift; /* Shift of the shared interrupt register select */
+	u32 msir_num; /* Number of available MSIR regs */
+	atomic_t msi_alloc_cnt; /* Counter for MSI hwirq allocations */
 	void __iomem *msi_regs;
 	u32 feature;
 	struct fsl_msi_cascade_data *cascade_array[NR_MSI_REG_MAX];
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 2ff6302..8b7d8fc 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -14,23 +14,28 @@
 #include <asm/msi_bitmap.h>
 #include <asm/setup.h>
 
-int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
+int msi_bitmap_alloc_hwirqs_from_offset(struct msi_bitmap *bmp, int offset,
+					int num)
 {
 	unsigned long flags;
-	int offset, order = get_count_order(num);
+	int index;
+	int order = get_count_order(num);
 
 	spin_lock_irqsave(&bmp->lock, flags);
-	/*
-	 * This is fast, but stricter than we need. We might want to add
-	 * a fallback routine which does a linear search with no alignment.
-	 */
-	offset = bitmap_find_free_region(bmp->bitmap, bmp->irq_count, order);
+	index = bitmap_find_next_zero_area(bmp->bitmap, bmp->irq_count,
+					   offset, num, (1 << order) - 1);
+	bitmap_set(bmp->bitmap, index, num);
 	spin_unlock_irqrestore(&bmp->lock, flags);
 
-	pr_debug("msi_bitmap: allocated 0x%x (2^%d) at offset 0x%x\n",
-		 num, order, offset);
+	pr_debug("msi_bitmap: found %d free bits starting from offset %d at index %d\n",
+		 num, offset, index);
 
-	return offset;
+	return index;
+}
+
+int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
+{
+	return msi_bitmap_alloc_hwirqs_from_offset(bmp, 0, num);
 }
 
 void msi_bitmap_free_hwirqs(struct msi_bitmap *bmp, unsigned int offset,
-- 
1.8.3.1
