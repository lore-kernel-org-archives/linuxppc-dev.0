Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BD401B71A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:17 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 07/33] ps3fb: Remove useless debug checks in ps3fb_shutdown()
Date: Wed, 10 Jun 2009 16:38:42 +0200
Message-Id: <1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/ps3fb.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index e00c1df..ce0f873 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1247,7 +1247,6 @@ err:
 
 static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 {
-	int status;
 	struct fb_info *info = dev->core.driver_data;
 
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
@@ -1271,17 +1270,8 @@ static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 		info = dev->core.driver_data = NULL;
 	}
 	iounmap((u8 __force __iomem *)ps3fb.dinfo);
-
-	status = lv1_gpu_context_free(ps3fb.context_handle);
-	if (status)
-		dev_dbg(&dev->core, "lv1_gpu_context_free failed: %d\n",
-			status);
-
-	status = lv1_gpu_memory_free(ps3fb.memory_handle);
-	if (status)
-		dev_dbg(&dev->core, "lv1_gpu_memory_free failed: %d\n",
-			status);
-
+	lv1_gpu_context_free(ps3fb.context_handle);
+	lv1_gpu_memory_free(ps3fb.memory_handle);
 	ps3_close_hv_device(dev);
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
 
-- 
1.6.2.4
