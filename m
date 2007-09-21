Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 53E81DDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:41:16 +1000 (EST)
Date: Fri, 21 Sep 2007 14:39:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 10/11] [POWERPC] Clean up vio.h
Message-Id: <20070921143954.3b707ab5.sfr@canb.auug.org.au>
In-Reply-To: <20070921143841.37ad2a2f.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
	<20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
	<20070921143446.ad55d494.sfr@canb.auug.org.au>
	<20070921143540.75f3becf.sfr@canb.auug.org.au>
	<20070921143647.7ceebabc.sfr@canb.auug.org.au>
	<20070921143750.4114b0b5.sfr@canb.auug.org.au>
	<20070921143841.37ad2a2f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove vio_dma_ops declaration (since it no longer exists) and some
unused fields from struct vio_driver.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c |   11 -----------
 include/asm-powerpc/vio.h |    5 -----
 2 files changed, 0 insertions(+), 16 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index aec5fff..cb22a35 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -135,16 +135,6 @@ static int vio_bus_remove(struct device *dev)
 	return 1;
 }
 
-/* convert from struct device to struct vio_dev and pass to driver. */
-static void vio_bus_shutdown(struct device *dev)
-{
-	struct vio_dev *viodev = to_vio_dev(dev);
-	struct vio_driver *viodrv = to_vio_driver(dev->driver);
-
-	if (dev->driver && viodrv->shutdown)
-		viodrv->shutdown(viodev);
-}
-
 /**
  * vio_register_driver: - Register a new vio driver
  * @drv:	The vio_driver structure to be registered.
@@ -361,7 +351,6 @@ static struct bus_type vio_bus_type = {
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
 	.remove = vio_bus_remove,
-	.shutdown = vio_bus_shutdown,
 };
 
 /**
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 598d111..9204c15 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -53,17 +53,12 @@ struct vio_dev {
 };
 
 struct vio_driver {
-	struct list_head node;
 	const struct vio_device_id *id_table;
 	int (*probe)(struct vio_dev *dev, const struct vio_device_id *id);
 	int (*remove)(struct vio_dev *dev);
-	void (*shutdown)(struct vio_dev *dev);
-	unsigned long driver_data;
 	struct device_driver driver;
 };
 
-extern struct dma_mapping_ops vio_dma_ops;
-
 extern int vio_register_driver(struct vio_driver *drv);
 extern void vio_unregister_driver(struct vio_driver *drv);
 
-- 
1.5.3.2
