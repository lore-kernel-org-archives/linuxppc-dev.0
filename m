Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0136.outbound.protection.outlook.com [157.56.111.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD6B11A1D94
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:59:36 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <timur@tabi.org>
CC: <scottwood@freescale.com>, <Jason.Jin@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-fbdev@vger.kernel.org>, "Wang
 Dongsheng" <dongsheng.wang@freescale.com>
Subject: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU
 module
Date: Fri, 14 Aug 2015 13:54:09 +0800
Message-ID: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
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

From: Jason Jin <Jason.Jin@freescale.com>

For deep sleep, the diu module will power off, when wake up
from the deep sleep, the registers need to be reinitialized.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v2*
Changes:
- int i -> unsigned int i.

Rmove:
- struct mfb_info *mfbi;

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 7fa2e6f..b335c1a 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1628,9 +1628,16 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
 	struct fsl_diu_data *data;
+	unsigned int i;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info);
+
+	fsl_diu_enable_interrupts(data);
+	update_lcdc(data->fsl_diu_info);
+	for (i = 0; i < NUM_AOIS; i++) {
+		if (data->mfb[i].count)
+			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
+	}
 
 	return 0;
 }
-- 
2.1.0.27.g96db324
