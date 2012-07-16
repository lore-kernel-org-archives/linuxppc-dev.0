Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A2CB2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 13:57:15 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: workaround for chips with MSI hareware errata
 to support MSI-X
Date: Mon, 16 Jul 2012 11:35:30 +0800
Message-ID: <1342409730-28340-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: soniccat.liu@gmail.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <soniccat.liu@gmail.com>

The MPIC chip with version 2.0 has a MSI errata (errata PIC1 of mpc8544),
It causes that neither MSI nor MSI-X can work fine. There is a workaround
to allow MSI-X to function properly.

Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/mpic.h |    3 ++
 arch/powerpc/sysdev/fsl_msi.c   |   63 +++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_msi.h   |    3 ++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index c9f698a..a9e4f937 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -110,6 +110,9 @@
 #define 	MPIC_VECPRI_SENSE_MASK			0x00400000
 #define MPIC_IRQ_DESTINATION		0x00010
 
+#define 	MPIC_FSL_BRR1				0x00000
+#define 	MPIC_FSL_BRR1_VER			0x0000ffff
+
 #define MPIC_MAX_IRQ_SOURCES	2048
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 6e097de..f2d340a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -98,8 +98,23 @@ static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 
 static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
+	struct fsl_msi *msi;
+
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
+	else if (type == PCI_CAP_ID_MSI) {
+		/*
+		 * MPIC chip with 2.0 version has erratum PIC1. It
+		 * causes that neither MSI nor MSI-X can work fine.
+		 * There is a workaround to allow MSI-X to function
+		 * properly.
+		 */
+		list_for_each_entry(msi, &msi_head, list) {
+			if ((msi->feature & MSI_HW_ERRATA_MASK)
+						== MSI_HW_ERRATA_ENDIAN)
+				return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -142,7 +157,11 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 	msg->address_lo = lower_32_bits(address);
 	msg->address_hi = upper_32_bits(address);
 
-	msg->data = hwirq;
+	/* See the comment in fsl_msi_check_device() */
+	if ((msi_data->feature & MSI_HW_ERRATA_MASK) == MSI_HW_ERRATA_ENDIAN)
+		msg->data = __swab32(hwirq);
+	else
+		msg->data = hwirq;
 
 	pr_debug("%s: allocated srs: %d, ibs: %d\n",
 		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % IRQS_PER_MSI_REG);
@@ -359,13 +378,43 @@ static int __devinit fsl_msi_setup_hwirq(struct fsl_msi *msi,
 	return 0;
 }
 
+/* MPIC chip with 2.0 version has erratum PIC1 */
+static int mpic_has_errata(struct platform_device *dev)
+{
+	struct device_node *mpic_node;
+
+	mpic_node = of_irq_find_parent(dev->dev.of_node);
+	if (mpic_node) {
+		u32 *reg_base, brr1 = 0;
+		/* Get the PIC reg base */
+		reg_base = of_iomap(mpic_node, 0);
+		of_node_put(mpic_node);
+		if (!reg_base) {
+			dev_err(&dev->dev, "ioremap problem failed.\n");
+			return -EIO;
+		}
+
+		/* Get the mpic chip version from block revision register 1 */
+		brr1 = in_be32(reg_base + MPIC_FSL_BRR1);
+		iounmap(reg_base);
+		if ((brr1 & MPIC_FSL_BRR1_VER) == 0x0200)
+			return 1;
+	} else {
+		dev_err(&dev->dev, "MSI can't find his parent mpic node.\n");
+		of_node_put(mpic_node);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static const struct of_device_id fsl_of_msi_ids[];
 static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 {
 	const struct of_device_id *match;
 	struct fsl_msi *msi;
 	struct resource res;
-	int err, i, j, irq_index, count;
+	int err, i, j, irq_index, count, errata;
 	int rc;
 	const u32 *p;
 	struct fsl_msi_feature *features;
@@ -421,6 +470,16 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 
 	msi->feature = features->fsl_pic_ip;
 
+	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) == FSL_PIC_IP_MPIC) {
+		errata = mpic_has_errata(dev);
+		if (errata > 0) {
+			msi->feature |= MSI_HW_ERRATA_ENDIAN;
+		} else if (errata < 0) {
+			err = errata;
+			goto error_out;
+		}
+	}
+
 	/*
 	 * Remember the phandle, so that we can match with any PCI nodes
 	 * that have an "fsl,msi" property.
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 8225f86..354d546 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -25,6 +25,9 @@
 #define FSL_PIC_IP_IPIC   0x00000002
 #define FSL_PIC_IP_VMPIC  0x00000003
 
+#define MSI_HW_ERRATA_MASK   0x000000F0
+#define MSI_HW_ERRATA_ENDIAN 0x00000010
+
 struct fsl_msi {
 	struct irq_domain *irqhost;
 
-- 
1.7.5.1
