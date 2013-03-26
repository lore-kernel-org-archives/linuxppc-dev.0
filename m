Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D93272C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 15:05:51 +1100 (EST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI hardware
 errata
Date: Tue, 26 Mar 2013 11:28:47 +0800
Message-ID: <1364268527-32068-2-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1364268527-32068-1-git-send-email-hongtao.jia@freescale.com>
References: <1364268527-32068-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, hongtao.jia@freescale.com
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
 arch/powerpc/sysdev/fsl_msi.c | 47 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 178c994..d2f8040 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -28,6 +28,8 @@
 #include "fsl_msi.h"
 #include "fsl_pci.h"
 
+#define MSI_HW_ERRATA_ENDIAN 0x00000010
+
 static LIST_HEAD(msi_head);
 
 struct fsl_msi_feature {
@@ -98,8 +100,18 @@ static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 
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
@@ -142,7 +154,17 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
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
@@ -361,6 +383,15 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	return 0;
 }
 
+/* MPIC version 2.0 has erratum PIC1 */
+static int mpic_has_errata(void)
+{
+	if (mpic_primary_get_version() == 0x0200)
+		return 1;
+
+	return 0;
+}
+
 static const struct of_device_id fsl_of_msi_ids[];
 static int fsl_of_msi_probe(struct platform_device *dev)
 {
@@ -423,6 +454,16 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 
 	msi->feature = features->fsl_pic_ip;
 
+	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) == FSL_PIC_IP_MPIC) {
+		rc = mpic_has_errata();
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
-- 
1.8.0
