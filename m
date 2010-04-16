Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0421B7F2C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 16:58:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3G6wNTj025474
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 23:58:23 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3G77Rab009363
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 02:07:28 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] fsl_msi: enable msi sharing through AMP OSes
Date: Fri, 16 Apr 2010 15:34:37 +0800
Message-Id: <1271403278-30091-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1271403278-30091-2-git-send-email-leoli@freescale.com>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271403278-30091-2-git-send-email-leoli@freescale.com>
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

Make a single PCIe MSI bank shareable through CAMP OSes. The number of
MSI used by each core can be configured by dts file.

Signed-off-by: Zhao Chenhui <b26998@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c    |    8 +++++++-
 arch/powerpc/sysdev/msi_bitmap.c |    4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index c46db75..ec5bdb4 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -266,6 +266,8 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	const u32 *p;
 	struct fsl_msi_feature *features = match->data;
 	struct fsl_msi_cascade_data *cascade_data = NULL;
+	int len;
+	u32 offset;
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
@@ -325,6 +327,10 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		err = -EINVAL;
 		goto error_out;
 	}
+	offset = 0;
+	p = of_get_property(dev->node, "msi-available-ranges", &len);
+	if (p)
+		offset = *p / IRQS_PER_MSI_REG;
 
 	count /= sizeof(u32);
 	for (i = 0; i < count / 2; i++) {
@@ -341,7 +347,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 				err = -ENOMEM;
 				goto error_out;
 			}
-			cascade_data->index = i;
+			cascade_data->index = i + offset;
 			cascade_data->data = msi;
 			set_irq_data(virt_msir, (void *)cascade_data);
 			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 5a32cbe..b41db96 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -95,8 +95,8 @@ int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp)
 	/* Format is: (<u32 start> <u32 count>)+ */
 	len /= 2 * sizeof(u32);
 	for (i = 0; i < len; i++, p += 2) {
-		for (j = 0; j < *(p + 1); j++)
-			bitmap_release_region(bmp->bitmap, *p + j, 0);
+		for (j = *p; j < *(p + 1); j++)
+			bitmap_release_region(bmp->bitmap, j, 0);
 	}
 
 	spin_unlock(&bmp->lock);
-- 
1.6.6-rc1.GIT
