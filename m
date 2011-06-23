Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75674B6F83
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 06:22:10 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <lethal@linux-sh.org>, <linux-fbdev@vger.kernel.org>, <agust@denx.de>,
	<yorksun@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] fsl-diu-fb: remove check for pixel clock ranges
Date: Thu, 23 Jun 2011 15:20:26 -0500
Message-ID: <1308860426-17920-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale DIU framebuffer driver defines two constants, MIN_PIX_CLK and
MAX_PIX_CLK, that are supposed to represent the lower and upper limits of
the pixel clock.  These values, however, are true only for one platform
clock rate (533MHz) and only for the MPC8610.  So the actual range for
the pixel clock is chip-specific, which means the current values are almost
always wrong.  The chance of an out-of-range pixel clock being used are also
remote.

Rather than try to detect an out-of-range clock in the DIU driver, we depend
on the board-specific pixel clock function (e.g. p1022ds_set_pixel_clock)
to clamp the pixel clock to a supported value.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   16 ----------------
 include/linux/fsl-diu-fb.h |    6 ------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index bedf5be..0acc7d6 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -555,8 +555,6 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 static int fsl_diu_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info)
 {
-	unsigned long htotal, vtotal;
-
 	pr_debug("check_var xres: %d\n", var->xres);
 	pr_debug("check_var yres: %d\n", var->yres);
 
@@ -635,20 +633,6 @@ static int fsl_diu_check_var(struct fb_var_screeninfo *var,
 
 		break;
 	}
-	/* If the pixclock is below the minimum spec'd value then set to
-	 * refresh rate for 60Hz since this is supported by most monitors.
-	 * Refer to Documentation/fb/ for calculations.
-	 */
-	if ((var->pixclock < MIN_PIX_CLK) || (var->pixclock > MAX_PIX_CLK)) {
-		htotal = var->xres + var->right_margin + var->hsync_len +
-		    var->left_margin;
-		vtotal = var->yres + var->lower_margin + var->vsync_len +
-		    var->upper_margin;
-		var->pixclock = (vtotal * htotal * 6UL) / 100UL;
-		var->pixclock = KHZ2PICOS(var->pixclock);
-		pr_debug("pixclock set for 60Hz refresh = %u ps\n",
-			var->pixclock);
-	}
 
 	var->height = -1;
 	var->width = -1;
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index 781d467..daa9952 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -24,12 +24,6 @@
  * See mpc8610fb_set_par(), map_video_memory(), and unmap_video_memory()
  */
 #define MEM_ALLOC_THRESHOLD (1024*768*4+32)
-/* Minimum value that the pixel clock can be set to in pico seconds
- * This is determined by platform clock/3 where the minimum platform
- * clock is 533MHz. This gives 5629 pico seconds.
- */
-#define MIN_PIX_CLK 5629
-#define MAX_PIX_CLK 96096
 
 #include <linux/types.h>
 
-- 
1.7.3.4
