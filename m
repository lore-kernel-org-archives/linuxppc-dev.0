Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 9C25DB70DD
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 10:03:23 +1000 (EST)
Received: by eyh6 with SMTP id 6so4105404eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 17:03:21 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI EDAC
	regspace
Date: Thu, 22 Jul 2010 04:03:12 +0400
Message-Id: <1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
Cc: Doug Thompson <dougthompson@xmission.com>, Dave Jiang <djiang@mvista.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently (as mpc8540-pci) devices are not created on of_platform bus,
mpc85xx_edac can't probe to them. Follow the change to dts trees to bind
not to the main mpc8540-pci node but to special mpc85xx-pci-error nodes,
present on soc bus.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/edac/mpc85xx_edac.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 52ca09b..d5a61b8 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -236,9 +236,6 @@ static int __devinit mpc85xx_pci_err_probe(struct of_device *op,
 		goto err;
 	}
 
-	/* we only need the error registers */
-	r.start += 0xe00;
-
 	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
 					pdata->name)) {
 		printk(KERN_ERR "%s: Error while requesting mem region\n",
@@ -328,12 +325,15 @@ static int mpc85xx_pci_err_remove(struct of_device *op)
 }
 
 static struct of_device_id mpc85xx_pci_err_of_match[] = {
-	{
-	 .compatible = "fsl,mpc8540-pcix",
-	 },
-	{
-	 .compatible = "fsl,mpc8540-pci",
-	},
+	{ .compatible = "fsl,mpc8536-pci-error", },
+	{ .compatible = "fsl,mpc8540-pci-error", },
+	{ .compatible = "fsl,mpc8541-pci-error", },
+	{ .compatible = "fsl,mpc8544-pci-error", },
+	{ .compatible = "fsl,mpc8548-pci-error", },
+	{ .compatible = "fsl,mpc8555-pci-error", },
+	{ .compatible = "fsl,mpc8560-pci-error", },
+	{ .compatible = "fsl,mpc8568-pci-error", },
+	{ .compatible = "fsl,mpc8572-pci-error", },
 	{},
 };
 
-- 
1.7.1
