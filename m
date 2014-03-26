Return-Path: <Jason.Jin@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CC7D6140085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 05:23:56 +1100 (EST)
From: Jason Jin <Jason.Jin@freescale.com>
To: <b07421@freescale.com>, <timur@tabi.org>
Subject: [PATCH 1/2] video/fsl: make the diu driver work without platform hooks
Date: Thu, 27 Mar 2014 01:41:43 +0800
Message-ID: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 r58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

make the diu driver work without platform hooks.

So far the DIU driver does not have a mechanism to do the
board specific initialization. So on some platforms,
such as P1022, 8610 and 5121, The board specific initialization
is implmented in the platform file such p10222_ds.

This board sepecific initialization mechanism is not feasible i
for corenet platform as the corenet platform file is a
abstraction of serveral platforms.

However, the DIU is already initialized in u-boot and we can
rely on the settings in u-boot for corenet platform, the only
issue is that when DIU wake up from the deepsleep, some of the
board specific initialization will lost, such as the pixel clock
setting.

This patch try to make the diu work on the platform without board
specific initialization such as corenet(T1040 so far), and rely on
the board initialization in u-boot. The following patch will try to
fix the pixel clock saving issue for deepsleep.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
---
 drivers/video/fsl-diu-fb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index e8758b9..4640846 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -479,7 +479,10 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
 			port = FSL_DIU_PORT_DLVDS;
 	}
 
-	return diu_ops.valid_monitor_port(port);
+	if (diu_ops.valid_monitor_port)
+		return diu_ops.valid_monitor_port(port);
+	else
+		return port;
 }
 
 /*
@@ -846,7 +849,11 @@ static void update_lcdc(struct fb_info *info)
 
 	out_be32(&hw->vsyn_para, temp);
 
-	diu_ops.set_pixel_clock(var->pixclock);
+	/*if there is platform function for pixel clock setting, use it.
+	 * otherwise we rely on the settings in u-boot.
+	 */
+	if (diu_ops.set_pixel_clock)
+		diu_ops.set_pixel_clock(var->pixclock);
 
 #ifndef CONFIG_PPC_MPC512x
 	/*
-- 
1.8.0
