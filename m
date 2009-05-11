Return-Path: <roel.kluin@gmail.com>
Message-ID: <4A087DB9.50305@gmail.com>
Date: Mon, 11 May 2009 21:34:17 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: geoffrey.levand@am.sony.com, Geert.Uytterhoeven@sonycom.com
Subject: [PATCH] ps3: remove driver_data direct access of struct device
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Please review. especially note that I removed a

kfree(dev->sbd.core.driver_data);

Is that correct?

 arch/powerpc/include/asm/ps3.h |    4 ++--
 drivers/char/ps3flash.c        |   11 +++++------
 drivers/scsi/ps3rom.c          |   10 +++++-----
 drivers/video/ps3fb.c          |    6 +++---
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index cdb6fd8..a55717e 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -421,12 +421,12 @@ static inline struct ps3_system_bus_driver *
 static inline void ps3_system_bus_set_driver_data(
 	struct ps3_system_bus_device *dev, void *data)
 {
-	dev->core.driver_data = data;
+	dev_set_drvdata(&dev->core, data);
 }
 static inline void *ps3_system_bus_get_driver_data(
 	struct ps3_system_bus_device *dev)
 {
-	return dev->core.driver_data;
+	return dev_get_drvdata(&dev->core);
 }
 
 /* These two need global scope for get_dma_ops(). */
diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index afbe456..6083032 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -108,7 +108,7 @@ static ssize_t ps3flash_read(struct file *file, char __user *buf, size_t count,
 			     loff_t *pos)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
-	struct ps3flash_private *priv = dev->sbd.core.driver_data;
+	struct ps3flash_private *priv = dev_get_drvdata(&dev->sbd.core);
 	u64 size, start_sector, end_sector, offset;
 	ssize_t sectors_read;
 	size_t remaining, n;
@@ -173,7 +173,7 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *pos)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
-	struct ps3flash_private *priv = dev->sbd.core.driver_data;
+	struct ps3flash_private *priv = dev_get_drvdata(&dev->sbd.core);
 	u64 size, chunk_sectors, start_write_sector, end_write_sector,
 	    end_read_sector, start_read_sector, head, tail, offset;
 	ssize_t res;
@@ -366,7 +366,7 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 		goto fail;
 	}
 
-	dev->sbd.core.driver_data = priv;
+	dev_set_drvdata(&dev->sbd.core, priv);
 	mutex_init(&priv->mutex);
 
 	dev->bounce_size = ps3flash_bounce_buffer.size;
@@ -392,7 +392,7 @@ fail_teardown:
 	ps3stor_teardown(dev);
 fail_free_priv:
 	kfree(priv);
-	dev->sbd.core.driver_data = NULL;
+	dev_set_drvdata(&dev->sbd.core, NULL);
 fail:
 	ps3flash_dev = NULL;
 	return error;
@@ -404,8 +404,7 @@ static int ps3flash_remove(struct ps3_system_bus_device *_dev)
 
 	misc_deregister(&ps3flash_misc);
 	ps3stor_teardown(dev);
-	kfree(dev->sbd.core.driver_data);
-	dev->sbd.core.driver_data = NULL;
+	dev_set_drvdata(&dev->sbd.core, NULL);
 	ps3flash_dev = NULL;
 	return 0;
 }
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index ca0dd33..f2f840a 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -299,7 +299,7 @@ static irqreturn_t ps3rom_interrupt(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	host = dev->sbd.core.driver_data;
+	host = dev_get_drvdata(&dev->sbd.core);
 	priv = shost_priv(host);
 	cmd = priv->curr_cmd;
 
@@ -387,7 +387,7 @@ static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
 	}
 
 	priv = shost_priv(host);
-	dev->sbd.core.driver_data = host;
+	dev_set_drvdata(&dev->sbd.core, host);
 	priv->dev = dev;
 
 	/* One device/LUN per SCSI bus */
@@ -407,7 +407,7 @@ static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
 
 fail_host_put:
 	scsi_host_put(host);
-	dev->sbd.core.driver_data = NULL;
+	dev_set_drvdata(&dev->sbd.core, NULL);
 fail_teardown:
 	ps3stor_teardown(dev);
 fail_free_bounce:
@@ -418,12 +418,12 @@ fail_free_bounce:
 static int ps3rom_remove(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
-	struct Scsi_Host *host = dev->sbd.core.driver_data;
+	struct Scsi_Host *host = dev_get_drvdata(&dev->sbd.core);
 
 	scsi_remove_host(host);
 	ps3stor_teardown(dev);
 	scsi_host_put(host);
-	dev->sbd.core.driver_data = NULL;
+	dev_set_drvdata(&dev->sbd.core, NULL);
 	kfree(dev->bounce_buf);
 	return 0;
 }
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index e00c1df..55f4250 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1210,7 +1210,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	if (retval < 0)
 		goto err_fb_dealloc;
 
-	dev->core.driver_data = info;
+	dev_set_drvdata(&dev->core, info);
 
 	dev_info(info->device, "%s %s, using %u KiB of video memory\n",
 		 dev_driver_string(info->dev), dev_name(info->dev),
@@ -1248,7 +1248,7 @@ err:
 static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 {
 	int status;
-	struct fb_info *info = dev->core.driver_data;
+	struct fb_info *info = dev_get_drvdata(&dev->core);
 
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
 
@@ -1268,7 +1268,7 @@ static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
-		info = dev->core.driver_data = NULL;
+		info = dev_set_drvdata(&dev->core, NULL);
 	}
 	iounmap((u8 __force __iomem *)ps3fb.dinfo);
 
