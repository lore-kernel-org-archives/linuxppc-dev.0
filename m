Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D08BB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 17:55:08 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3M7soau007581 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 00:55:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3M843rl009129
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 03:04:07 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/5] fsl_msi: enable msi sharing through AMP OSes
Date: Thu, 22 Apr 2010 16:31:37 +0800
Message-Id: <1271925099-29100-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1271925099-29100-2-git-send-email-leoli@freescale.com>
References: <1271925099-29100-1-git-send-email-leoli@freescale.com>
	<1271925099-29100-2-git-send-email-leoli@freescale.com>
Cc: Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make a single PCIe MSI bank shareable through CAMP OSes. The number of
MSI used by each core can be configured by dts file.

Signed-off-by: Zhao Chenhui <b26998@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index b7ea19a..7c442e2 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -260,6 +260,8 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	const u32 *p;
 	struct fsl_msi_feature *features = match->data;
 	struct fsl_msi_cascade_data *cascade_data = NULL;
+	int len;
+	u32 offset;
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
@@ -319,6 +321,10 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		err = -EINVAL;
 		goto error_out;
 	}
+	offset = 0;
+	p = of_get_property(dev->node, "msi-available-ranges", &len);
+	if (p)
+		offset = *p / IRQS_PER_MSI_REG;
 
 	count /= sizeof(u32);
 	for (i = 0; i < count / 2; i++) {
@@ -335,7 +341,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 				err = -ENOMEM;
 				goto error_out;
 			}
-			cascade_data->index = i;
+			cascade_data->index = i + offset;
 			cascade_data->msi_data = msi;
 			set_irq_data(virt_msir, (void *)cascade_data);
 			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
-- 
1.6.6-rc1.GIT
