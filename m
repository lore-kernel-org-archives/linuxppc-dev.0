Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E931C2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 22:09:21 +1100 (EST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V2] powerpc/85xx: workaround for chips with MSI hardware errata
Date: Thu, 14 Mar 2013 18:35:23 +0800
Message-ID: <1363257323-2801-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It causes
that neither MSI nor MSI-X can work fine. This is a workaround to allow
MSI-X to function properly.

Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
Changes for V2:
- Address almost all the comments from Michael Ellerman for V1.
  Here is the link:
  http://patchwork.ozlabs.org/patch/226833/

 arch/powerpc/sysdev/fsl_msi.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 arch/powerpc/sysdev/fsl_msi.h |  2 ++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 178c994..54cb83e 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -98,8 +98,18 @@ static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 
 static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
-	if (type == PCI_CAP_ID_MSIX)
-		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
+	struct fsl_msi *msi;
+
+	if (type == PCI_CAP_ID_MSI) {
+		/*
+		 * MPIC version 2.0 has erratum PIC1. For now MSI
+		 * could not work. So check to prevent MSI from
+		 * being used on the board with this erratum.
+		 */
+		list_for_each_entry(msi, &msi_head, list)
+			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
+				return -EINVAL;
+	}
 
 	return 0;
 }
@@ -142,7 +152,17 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 	msg->address_lo = lower_32_bits(address);
 	msg->address_hi = upper_32_bits(address);
 
-	msg->data = hwirq;
+	/*
+	 * MPIC version 2.0 has erratum PIC1. It causes
+	 * that neither MSI nor MSI-X can work fine.
+	 * This is a workaround to allow MSI-X to function
+	 * properly. It only works for MSI-X, we prevent
+	 * MSI on buggy chips in fsl_msi_check_device().
+	 */
+	if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
+		msg->data = __swab32(hwirq);
+	else
+		msg->data = hwirq;
 
 	pr_debug("%s: allocated srs: %d, ibs: %d\n",
 		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % IRQS_PER_MSI_REG);
@@ -361,6 +381,35 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	return 0;
 }
 
+/* MPIC version 2.0 has erratum PIC1 */
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
+		/* Get the mpic version from block revision register 1 */
+		brr1 = in_be32(reg_base + MPIC_FSL_BRR1);
+		iounmap(reg_base);
+		if ((brr1 & MPIC_FSL_BRR1_VER) == 0x0200)
+			return 1;
+	} else {
+		dev_err(&dev->dev, "MSI can't find his parent mpic node.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static const struct of_device_id fsl_of_msi_ids[];
 static int fsl_of_msi_probe(struct platform_device *dev)
 {
@@ -423,6 +472,16 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 
 	msi->feature = features->fsl_pic_ip;
 
+	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) == FSL_PIC_IP_MPIC) {
+		rc = mpic_has_errata(dev);
+		if (rc > 0) {
+			msi->feature |= MSI_HW_ERRATA_ENDIAN;
+		} else if (rc < 0) {
+			err = rc;
+			goto error_out;
+		}
+	}
+
 	/*
 	 * Remember the phandle, so that we can match with any PCI nodes
 	 * that have an "fsl,msi" property.
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 8225f86..7389e8e 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -25,6 +25,8 @@
 #define FSL_PIC_IP_IPIC   0x00000002
 #define FSL_PIC_IP_VMPIC  0x00000003
 
+#define MSI_HW_ERRATA_ENDIAN 0x00000010
+
 struct fsl_msi {
 	struct irq_domain *irqhost;
 
-- 
1.8.0
