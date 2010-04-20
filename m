Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2ABBEB7D0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 21:44:25 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3KBi8IC015982 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 04:44:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3KBrs2r014673
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 06:53:59 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/5] fsl_msi: enable msi sharing through AMP OSes
Date: Tue, 20 Apr 2010 20:20:46 +0800
Message-Id: <1271766048-19272-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1271766048-19272-2-git-send-email-leoli@freescale.com>
References: <1271766048-19272-1-git-send-email-leoli@freescale.com>
	<1271766048-19272-2-git-send-email-leoli@freescale.com>
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
index 712f934..61e97cb 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -262,6 +262,8 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	const u32 *p;
 	struct fsl_msi_feature *features = match->data;
 	struct fsl_msi_cascade_data *cascade_data = NULL;
+	int len;
+	u32 offset;
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
@@ -321,6 +323,10 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		err = -EINVAL;
 		goto error_out;
 	}
+	offset = 0;
+	p = of_get_property(dev->node, "msi-available-ranges", &len);
+	if (p)
+		offset = *p / IRQS_PER_MSI_REG;
 
 	count /= sizeof(u32);
 	for (i = 0; i < count / 2; i++) {
@@ -337,7 +343,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
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
