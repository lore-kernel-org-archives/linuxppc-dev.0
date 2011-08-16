Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29C1FB6F8A
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 19:25:14 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd/nand: Don't add disabled nand flash devices
Date: Tue, 16 Aug 2011 17:27:35 +0800
Message-ID: <1313486855-15233-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nand flash nodes with the property status="disabled" are not
usable and so avoid adding "disabled" nand flash devices with
the system.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 33d8aad..8212c12 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -1,6 +1,6 @@
 /* Freescale Enhanced Local Bus Controller NAND driver
  *
- * Copyright © 2006-2007, 2010 Freescale Semiconductor
+ * Copyright © 2006-2007, 2010-2011 Freescale Semiconductor
  *
  * Authors: Nick Spence <nick.spence@freescale.com>,
  *          Scott Wood <scottwood@freescale.com>
@@ -849,6 +849,9 @@ static int __devinit fsl_elbc_nand_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct device_node *node = pdev->dev.of_node;
 
+	if (!of_device_is_available(node))
+		return -ENODEV;
+
 	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
 		return -ENODEV;
 	lbc = fsl_lbc_ctrl_dev->regs;
-- 
1.5.6.5
