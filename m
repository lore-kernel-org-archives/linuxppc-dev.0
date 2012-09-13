Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D9CE2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 18:04:28 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpc85xx:Update interrupt handling for IFC controller
Date: Thu, 13 Sep 2012 13:34:11 +0530
Message-ID: <1347523451-7843-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IFC may have one or two interrupts.  If two interrupt specifiers are present,
the first is the "common" interrupt (CM_EVTER_STAT), and the second is the NAND
interrupt (NAND_EVTER_STAT).
If there is only one, that interrupt reports both types of event.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git branch next 

 arch/powerpc/sysdev/fsl_ifc.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_ifc.c b/arch/powerpc/sysdev/fsl_ifc.c
index b31f19f..097cc9d2 100644
--- a/arch/powerpc/sysdev/fsl_ifc.c
+++ b/arch/powerpc/sysdev/fsl_ifc.c
@@ -244,12 +244,6 @@ static int __devinit fsl_ifc_ctrl_probe(struct platform_device *dev)
 	/* get the nand machine irq */
 	fsl_ifc_ctrl_dev->nand_irq =
 			irq_of_parse_and_map(dev->dev.of_node, 1);
-	if (fsl_ifc_ctrl_dev->nand_irq == NO_IRQ) {
-		dev_err(&dev->dev, "failed to get irq resource "
-						"for NAND Machine\n");
-		ret = -ENODEV;
-		goto err;
-	}
 
 	fsl_ifc_ctrl_dev->dev = &dev->dev;
 
@@ -267,12 +261,14 @@ static int __devinit fsl_ifc_ctrl_probe(struct platform_device *dev)
 		goto err_irq;
 	}
 
-	ret = request_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_nand_irq, 0,
-			  "fsl-ifc-nand", fsl_ifc_ctrl_dev);
-	if (ret != 0) {
-		dev_err(&dev->dev, "failed to install irq (%d)\n",
-			fsl_ifc_ctrl_dev->nand_irq);
-		goto err_nandirq;
+	if (fsl_ifc_ctrl_dev->nand_irq) {
+		ret = request_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_nand_irq,
+				0, "fsl-ifc-nand", fsl_ifc_ctrl_dev);
+		if (ret != 0) {
+			dev_err(&dev->dev, "failed to install irq (%d)\n",
+				fsl_ifc_ctrl_dev->nand_irq);
+			goto err_nandirq;
+		}
 	}
 
 	return 0;
-- 
1.7.9.5
