Return-Path: <raghav@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0140.outbound.protection.outlook.com [157.56.110.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01F861A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 21:46:51 +1100 (AEDT)
From: Raghav Dogra <raghav@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <oss@buserror.net>, <prabhakar.kushwaha@nxp.com>, Raghav Dogra
 <raghav@freescale.com>
Subject: [PATCH 1/3] driver/memory: Removal of deprecated NO_IRQ
Date: Mon, 1 Feb 2016 16:16:36 +0530
Message-ID: <1454323598-5149-1-git-send-email-raghav@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replacing the NO_IRQ macro with 0. If there is no interrupt,
returned value will be 0 regardless of what NO_IRQ is defined.

Signed-off-by: Raghav Dogra <raghav@freescale.com>
---
This patchset is dependent on the IFC deep sleep patch:
https://patchwork.ozlabs.org/patch/564785/

 drivers/memory/fsl_ifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index f5186fa..054809e 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -262,7 +262,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 
 	/* get the Controller level irq */
 	fsl_ifc_ctrl_dev->irq = irq_of_parse_and_map(dev->dev.of_node, 0);
-	if (fsl_ifc_ctrl_dev->irq == NO_IRQ) {
+	if (fsl_ifc_ctrl_dev->irq == 0) {
 		dev_err(&dev->dev, "failed to get irq resource "
 							"for IFC\n");
 		ret = -ENODEV;
-- 
1.9.1
