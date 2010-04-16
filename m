Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 309D9B7DF0
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 16:58:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3G6wJma025460
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 23:58:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o3G6wMKP008122
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 01:58:23 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] fsl_msi: enable msi allocation in all banks
Date: Fri, 16 Apr 2010 15:34:36 +0800
Message-Id: <1271403278-30091-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1271403278-30091-1-git-send-email-leoli@freescale.com>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
Cc: Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhao Chenhui <b26998@freescale.com>

Put all fsl_msi banks in a linked list. The list of banks then can be
traversed when allocating new msi interrupts.

Signed-off-by: Zhao Chenhui <b26998@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   29 ++++++++++++++++++++++-------
 arch/powerpc/sysdev/fsl_msi.h |    2 ++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 716862f..c46db75 100644
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
@@ -143,15 +145,26 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct msi_msg msg;
 	struct fsl_msi *msi_data;
 
+	if (list_empty(&msi_head)) {
+		pr_debug("%s: msi init error\n", __func__);
+		rc = -EFAULT;
+		goto out_free;
+	}
+
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		msi_data = get_irq_chip_data(entry->irq);
 
-		hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
-		if (hwirq < 0) {
-			rc = hwirq;
-			pr_debug("%s: fail allocating msi interrupt\n",
-					__func__);
-			goto out_free;
+		list_for_each_entry(msi_data, &msi_head, list) {
+
+			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
+			if (hwirq >= 0)
+				break;
+
+			if (list_is_last(&msi_data->list, &msi_head)) {
+				rc = hwirq;
+				pr_debug("%s: fail allocating msi interrupt\n",
+						__func__);
+				goto out_free;
+			}
 		}
 
 		virq = irq_create_mapping(msi_data->irqhost, hwirq);
@@ -335,6 +348,8 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
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
