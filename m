Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A86AB72D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:24 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 20/33] ps3: ps3flash - Use ps3_system_bus_[gs]et_drvdata()
	instead of direct access
Date: Wed, 10 Jun 2009 16:38:55 +0200
Message-Id: <1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/char/ps3flash.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index afbe456..184e6ed 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -108,7 +108,7 @@ static ssize_t ps3flash_read(struct file *file, char __user *buf, size_t count,
 			     loff_t *pos)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
-	struct ps3flash_private *priv = dev->sbd.core.driver_data;
+	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 size, start_sector, end_sector, offset;
 	ssize_t sectors_read;
 	size_t remaining, n;
@@ -173,7 +173,7 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *pos)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
-	struct ps3flash_private *priv = dev->sbd.core.driver_data;
+	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 size, chunk_sectors, start_write_sector, end_write_sector,
 	    end_read_sector, start_read_sector, head, tail, offset;
 	ssize_t res;
@@ -366,7 +366,7 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 		goto fail;
 	}
 
-	dev->sbd.core.driver_data = priv;
+	ps3_system_bus_set_drvdata(&dev->sbd, priv);
 	mutex_init(&priv->mutex);
 
 	dev->bounce_size = ps3flash_bounce_buffer.size;
@@ -392,7 +392,7 @@ fail_teardown:
 	ps3stor_teardown(dev);
 fail_free_priv:
 	kfree(priv);
-	dev->sbd.core.driver_data = NULL;
+	ps3_system_bus_set_drvdata(&dev->sbd, NULL);
 fail:
 	ps3flash_dev = NULL;
 	return error;
@@ -404,8 +404,8 @@ static int ps3flash_remove(struct ps3_system_bus_device *_dev)
 
 	misc_deregister(&ps3flash_misc);
 	ps3stor_teardown(dev);
-	kfree(dev->sbd.core.driver_data);
-	dev->sbd.core.driver_data = NULL;
+	kfree(ps3_system_bus_get_drvdata(&dev->sbd));
+	ps3_system_bus_set_drvdata(&dev->sbd, NULL);
 	ps3flash_dev = NULL;
 	return 0;
 }
-- 
1.6.2.4
