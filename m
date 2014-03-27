Return-Path: <Jason.Jin@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7792140088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 23:19:38 +1100 (EST)
From: Jason Jin <Jason.Jin@freescale.com>
To: <b07421@freescale.com>, <timur@tabi.org>
Subject: [PATCH 1/2] video/fsl: Fix the sleep function for FSL DIU module
Date: Thu, 27 Mar 2014 19:37:22 +0800
Message-ID: <1395920242-1004-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 r58472@freescale.com, jason.jin@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For deep sleep, the diu module will power off, when wake up from the deep
sleep, more registers need to be reinitialized.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
---
V2: Coding style clean up based on Timur's comments.

 drivers/video/fsl-diu-fb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index e8758b9..4bc4730 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1628,9 +1628,15 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
 	struct fsl_diu_data *data;
+	unsigned int i;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info);
+	fsl_diu_enable_interrupts(data);
+	update_lcdc(data->fsl_diu_info);
+	for (i = 0; i < NUM_AOIS; i++) {
+		if (data->mfb[i].count)
+			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
+	}
 
 	return 0;
 }
-- 
1.8.0
