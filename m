Return-Path: <Jason.Jin@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7DFC140088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 23:20:23 +1100 (EST)
From: Jason Jin <Jason.Jin@freescale.com>
To: <b07421@freescale.com>, <timur@tabi.org>
Subject: [PATCH 2/2] Make the diu driver work without board level initilization
Date: Thu, 27 Mar 2014 19:38:07 +0800
Message-ID: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 r58472@freescale.com, jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far the DIU driver does not have a mechanism to do the
board specific initialization. So on some platforms,
such as P1022, 8610 and 5121, The board specific initialization
is implmented in the platform file such p10222_ds.

Actually, the DIU is already intialized in the u-boot, the pin sharing
and the signal routing are also set in u-boot. So we can leverage that
in kernel driver to avoid board sepecific initialization, especially
for the corenet platform, which is the abstraction for serveral
platfroms.

The potential problem is that when the system wakeup from the deep
sleep, some platform settings may need to be re-initialized. The CPLD
and FPGA settings will be kept, but the pixel clock register which
usually locate at the global utility space need to be reinitialized.

Generally, the pixel clock setting was implemented in the platform
file, But the pixel clock register itself should be part of the DIU
module, And for P1022,8610 and T1040, the pixel clock register have the
same structure, So we can consider to move the pixel clock setting
from the platform to the diu driver. This patch provide the options
set the pixel clock in the diu driver. But the original platform pixel
clock setting stil can be used for P1022,8610 and 512x without any
update. To implement the pixel clock setting in the diu driver. the
following update in the diu dts node was needed.
display:display@180000 {
	compatible = "fsl,t1040-diu", "fsl,diu";
-	reg = <0x180000 1000>;
+	reg = <0x180000 1000 0xfc028 4>;
+	pixclk = <0 255 0>;
 	interrupts = <74 2 0 0>;
}
The 0xfc028 is the offset for pixel clock register. the 3 segment of
the pixclk stand for the PXCKDLYDIR, the max of PXCK and the PXCKDLY
which will be used by the pixel clock register setting.

This was tested on T1040 platform. For other platform, the original
node together with the platform settings still can work.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
---
V2: Remove the pixel clock register saving for suspend.
add the pixel clock setting in driver.

 drivers/video/fsl-diu-fb.c | 61 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4bc4730..792038f 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -50,6 +50,7 @@
 #define INT_PARERR	0x08	/* Display parameters error interrupt */
 #define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
 
+#define PIXCLKCR_PXCKEN 0x80000000
 /*
  * List of supported video modes
  *
@@ -372,6 +373,8 @@ struct fsl_diu_data {
 	unsigned int irq;
 	enum fsl_diu_monitor_port monitor_port;
 	struct diu __iomem *diu_reg;
+	void __iomem *pixelclk_reg;
+	u32 pixclkcr[3];
 	spinlock_t reg_lock;
 	u8 dummy_aoi[4 * 4 * 4];
 	struct diu_ad dummy_ad __aligned(8);
@@ -479,7 +482,10 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
 			port = FSL_DIU_PORT_DLVDS;
 	}
 
-	return diu_ops.valid_monitor_port(port);
+	if (diu_ops.valid_monitor_port)
+		return diu_ops.valid_monitor_port(port);
+	else
+		return port;
 }
 
 /*
@@ -798,6 +804,35 @@ static void set_fix(struct fb_info *info)
 	fix->ypanstep = 1;
 }
 
+static void set_pixel_clock(struct fsl_diu_data *data, unsigned int pixclock)
+{
+	unsigned long freq;
+	u64 temp;
+	u32 pxclk;
+	u32 pxclkdl_dir, pxckmax, pxclk_delay;
+
+	/* Convert pixclock from a wavelength to a frequency */
+	temp = 1000000000000ULL;
+	do_div(temp, pixclock);
+	freq = temp;
+
+	pxclkdl_dir = data->pixclkcr[0] << 30;
+	pxckmax =  data->pixclkcr[1];
+	pxclk_delay = data->pixclkcr[2] << 8;
+
+	/*
+	 * 'pxclk' is the ratio of the platform clock to the pixel clock.
+	 * This number is programmed into the PIXCLKCR register, and the valid
+	 * range of values is 2- pxckmax.
+	 */
+	pxclk = DIV_ROUND_CLOSEST(fsl_get_sys_freq(), freq);
+	pxclk = clamp_t(u32, pxclk, 2, pxckmax);
+
+	out_be32(data->pixelclk_reg, 0);
+	out_be32(data->pixelclk_reg, PIXCLKCR_PXCKEN
+			| pxclkdl_dir | (pxclk << 16) | pxclk_delay);
+}
+
 static void update_lcdc(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &info->var;
@@ -846,7 +881,13 @@ static void update_lcdc(struct fb_info *info)
 
 	out_be32(&hw->vsyn_para, temp);
 
-	diu_ops.set_pixel_clock(var->pixclock);
+	/* If the pixel clock setting function can not be used on the platform,
+	 * then use the platform one.
+	 */
+	if (diu_ops.set_pixel_clock)
+		diu_ops.set_pixel_clock(var->pixclock);
+	else
+		set_pixel_clock(data, var->pixclock);
 
 #ifndef CONFIG_PPC_MPC512x
 	/*
@@ -1752,6 +1793,22 @@ static int fsl_diu_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	if (!diu_ops.set_pixel_clock) {
+		data->pixelclk_reg = of_iomap(np, 1);
+		if (!data->pixelclk_reg) {
+			dev_err(&pdev->dev, "Cannot map pixelclk registers, please \
+				provide the diu_ops for pixclk setting instead.\n");
+			ret = -EFAULT;
+			goto error;
+		}
+		/*Get the pixclkcr settings: PXCKDLYDIR; MAXPXCK, PXCKDLY*/
+		ret = of_property_read_u32_array(np, "pixclk", data->pixclkcr, 3);
+		if (ret) {
+			dev_err(&pdev->dev, "Cannot get pixelclk registers information.\n");
+			goto error;
+		}
+	}
+
 	/* Get the IRQ of the DIU */
 	data->irq = irq_of_parse_and_map(np, 0);
 
-- 
1.8.0
