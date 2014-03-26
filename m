Return-Path: <Jason.Jin@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 35AAF1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 05:24:02 +1100 (EST)
From: Jason Jin <Jason.Jin@freescale.com>
To: <b07421@freescale.com>, <timur@tabi.org>
Subject: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
Date: Thu, 27 Mar 2014 01:41:44 +0800
Message-ID: <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
In-Reply-To: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 r58472@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For sleep, The diu module will power off and when
wake up for initialization will need.

Some platform such as the corenet plafrom does not provide
the DIU board sepecific initialization, but rely on the
DIU initializtion in u-boot. then the pixel clock resume will
be an issuel on this platform, This patch save the pixel clock
for diu before enter the deepsleep and then restore it after
resume, the extra pixelclock register information will be needed
in this situation.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
v2: clean up the resume function based on Timur's comments.
Add the pixel clock saving for the platforms without board sepecific
initializaton.

 drivers/video/fsl-diu-fb.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4640846..fbdd166 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -372,6 +372,7 @@ struct fsl_diu_data {
 	unsigned int irq;
 	enum fsl_diu_monitor_port monitor_port;
 	struct diu __iomem *diu_reg;
+	void __iomem *pixelclk_ptr;
 	spinlock_t reg_lock;
 	u8 dummy_aoi[4 * 4 * 4];
 	struct diu_ad dummy_ad __aligned(8);
@@ -383,6 +384,7 @@ struct fsl_diu_data {
 	__le16 blank_cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	uint8_t edid_data[EDID_LENGTH];
 	bool has_edid;
+	u32 saved_pixel_clock;
 } __aligned(32);
 
 /* Determine the DMA address of a member of the fsl_diu_data structure */
@@ -1625,19 +1627,47 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 {
 	struct fsl_diu_data *data;
+	struct resource res;
+	int ret;
 
+	ret = 0;
 	data = dev_get_drvdata(&ofdev->dev);
 	disable_lcdc(data->fsl_diu_info);
 
-	return 0;
+	if (!diu_ops.set_pixel_clock) {
+		data->saved_pixel_clock = 0;
+		if (of_address_to_resource(ofdev->dev.of_node, 1, &res))
+			pr_err(KERN_ERR "No pixel clock set func and no pixel node!\n");
+		else {
+			data->pixelclk_ptr =
+				devm_ioremap(&ofdev->dev, res.start, resource_size(&res));
+			if (!data->pixelclk_ptr) {
+				pr_err(KERN_ERR "fslfb: could not map pixelclk register!\n");
+				ret = -ENOMEM;
+			} else
+				data->saved_pixel_clock = in_be32(data->pixelclk_ptr);
+		}
+	}
+
+	return ret;
 }
 
 static int fsl_diu_resume(struct platform_device *ofdev)
 {
 	struct fsl_diu_data *data;
+	unsigned int i;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info);
+	if (!diu_ops.set_pixel_clock && data->pixelclk_ptr)
+		out_be32(data->pixelclk_ptr, data->saved_pixel_clock);
+
+	fsl_diu_enable_interrupts(data);
+	update_lcdc(data->fsl_diu_info);
+
+	for (i = 0; i < NUM_AOIS; i++) {
+		if (data->mfb[i].count)
+			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
+	}
 
 	return 0;
 }
-- 
1.8.0
