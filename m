Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0D8FB70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:16 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/33] ps3fb: Correct handling of device opening in
	ps3fb_probe()
Date: Wed, 10 Jun 2009 16:38:44 +0200
Message-Id: <1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

  - ps3_open_hv_device() returns a standard error value,
  - Add missing call to ps3_close_hv_device() in the error path.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/ps3fb.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index a745018..542ffc3 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -985,7 +985,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 {
 	struct fb_info *info;
 	struct ps3fb_par *par;
-	int retval = -ENOMEM;
+	int retval;
 	u64 ddr_lpar = 0;
 	u64 lpar_dma_control = 0;
 	u64 lpar_driver_info = 0;
@@ -1003,8 +1003,8 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 		return -ENOMEM;
 	}
 
-	status = ps3_open_hv_device(dev);
-	if (status) {
+	retval = ps3_open_hv_device(dev);
+	if (retval) {
 		dev_err(&dev->core, "%s: ps3_open_hv_device failed\n",
 			__func__);
 		goto err;
@@ -1027,7 +1027,8 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 			"%s: lv1_gpu_context_attribute DISPLAY_SYNC failed: "
 			"%d\n",
 			__func__, status);
-		goto err;
+		retval = -ENODEV;
+		goto err_close_device;
 	}
 #endif
 #ifdef HEAD_B
@@ -1040,7 +1041,8 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 			"%s: lv1_gpu_context_attribute DISPLAY_SYNC failed: "
 			"%d\n",
 			__func__, status);
-		goto err;
+		retval = -ENODEV;
+		goto err_close_device;
 	}
 #endif
 
@@ -1057,7 +1059,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	if (status) {
 		dev_err(&dev->core, "%s: lv1_gpu_memory_allocate failed: %d\n",
 			__func__, status);
-		goto err;
+		goto err_close_device;
 	}
 	dev_dbg(&dev->core, "ddr:lpar:0x%llx\n", ddr_lpar);
 
@@ -1221,6 +1223,8 @@ err_gpu_context_free:
 	lv1_gpu_context_free(ps3fb.context_handle);
 err_gpu_memory_free:
 	lv1_gpu_memory_free(ps3fb.memory_handle);
+err_close_device:
+	ps3_close_hv_device(dev);
 err:
 	return retval;
 }
-- 
1.6.2.4
