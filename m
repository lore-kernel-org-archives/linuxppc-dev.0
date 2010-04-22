Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13434B7D16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 17:55:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3M7smQx007572 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 00:54:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3M843rj009129
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 03:04:05 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/5] fsl_msi: enable msi allocation in all banks
Date: Thu, 22 Apr 2010 16:31:36 +0800
Message-Id: <1271925099-29100-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1271925099-29100-1-git-send-email-leoli@freescale.com>
References: <1271925099-29100-1-git-send-email-leoli@freescale.com>
Cc: Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Put all fsl_msi banks in a linked list. The list of banks then can be
traversed when allocating new msi interrupts.  Also fix failing path
of fsl_setup_msi_irqs().

Signed-off-by: Zhao Chenhui <b26998@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   14 +++++++++++---
 arch/powerpc/sysdev/fsl_msi.h |    2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 93a638a..b7ea19a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -24,6 +24,8 @@
 #include <asm/mpic.h>
 #include "fsl_msi.h"
 
+LIST_HEAD(msi_head);
+
 struct fsl_msi_feature {
 	u32 fsl_pic_ip;
 	u32 msiir_offset;
@@ -137,16 +139,19 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 
 static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-	int rc, hwirq = NO_IRQ;
+	int rc, hwirq = -ENOMEM;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	struct fsl_msi *msi_data;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		msi_data = get_irq_chip_data(entry->irq);
+		list_for_each_entry(msi_data, &msi_head, list) {
+			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
+			if (hwirq >= 0)
+				break;
+		}
 
-		hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		if (hwirq < 0) {
 			rc = hwirq;
 			pr_debug("%s: fail allocating msi interrupt\n",
@@ -172,6 +177,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	return 0;
 
 out_free:
+	/* free by the caller of this function */
 	return rc;
 }
 
@@ -336,6 +342,8 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		}
 	}
 
+	list_add_tail(&msi->list, &msi_head);
+
 	/* The multiple setting ppc_md.setup_msi_irqs will not harm things */
 	if (!ppc_md.setup_msi_irqs) {
 		ppc_md.setup_msi_irqs = fsl_setup_msi_irqs;
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 331c7e7..8fc5523 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -34,6 +34,8 @@ struct fsl_msi {
 	u32 feature;
 
 	struct msi_bitmap bitmap;
+
+	struct list_head list;          /* support multiple MSI banks */
 };
 
 #endif /* _POWERPC_SYSDEV_FSL_MSI_H */
-- 
1.6.6-rc1.GIT
