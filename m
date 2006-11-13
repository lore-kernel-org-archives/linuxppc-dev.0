Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0DE8567D3F
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:43:23 +1100 (EST)
Date: Mon, 13 Nov 2006 14:43:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: improve viodasd initialisation
Message-Id: <20061113144317.7418633b.sfr@canb.auug.org.au>
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

On error, make sure that we undo all necessary operations.

This also gets rid of a must_check warning.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/viodasd.c |   49 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 36 insertions(+), 13 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index ec5a1b9..e19ba4e 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -759,6 +759,8 @@ static struct vio_driver viodasd_driver
 	}
 };
 
+static int need_delete_probe;
+
 /*
  * Initialize the whole device driver.  Handle module and non-module
  * versions
@@ -773,46 +775,67 @@ static int __init viodasd_init(void)
 
 	if (viopath_hostLp == HvLpIndexInvalid) {
 		printk(VIOD_KERN_WARNING "invalid hosting partition\n");
-		return -EIO;
+		rc = -EIO;
+		goto early_fail;
 	}
 
 	printk(VIOD_KERN_INFO "vers " VIOD_VERS ", hosting partition %d\n",
 			viopath_hostLp);
 
         /* register the block device */
-	if (register_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME)) {
+	rc =  register_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
+	if (rc) {
 		printk(VIOD_KERN_WARNING
 				"Unable to get major number %d for %s\n",
 				VIODASD_MAJOR, VIOD_GENHD_NAME);
-		return -EIO;
+		goto early_fail;
 	}
 	/* Actually open the path to the hosting partition */
-	if (viopath_open(viopath_hostLp, viomajorsubtype_blockio,
-				VIOMAXREQ + 2)) {
+	rc = viopath_open(viopath_hostLp, viomajorsubtype_blockio,
+				VIOMAXREQ + 2);
+	if (rc) {
 		printk(VIOD_KERN_WARNING
 		       "error opening path to host partition %d\n",
 		       viopath_hostLp);
-		unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
-		return -EIO;
+		goto unregister_blk;
 	}
 
 	/* Initialize our request handler */
 	vio_setHandler(viomajorsubtype_blockio, handle_block_event);
 
 	rc = vio_register_driver(&viodasd_driver);
-	if (rc == 0)
-		driver_create_file(&viodasd_driver.driver, &driver_attr_probe);
+	if (rc) {
+		printk(VIOD_KERN_WARNING "vio_register_driver failed\n");
+		goto unset_handler;
+	}
+
+	/*
+	 * If this call fails, it just means that we cannot dynamically
+	 * add virtual disks, but the driver will still work fine for
+	 * all existing disk, so ignore the failure.
+	 */
+	if (!driver_create_file(&viodasd_driver.driver, &driver_attr_probe))
+		need_delete_probe = 1;
+
+	return 0;
+
+unset_handler:
+	vio_clearHandler(viomajorsubtype_blockio);
+	viopath_close(viopath_hostLp, viomajorsubtype_blockio, VIOMAXREQ + 2);
+unregister_blk:
+	unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
+early_fail:
 	return rc;
 }
 module_init(viodasd_init);
 
-void viodasd_exit(void)
+void __exit viodasd_exit(void)
 {
-	driver_remove_file(&viodasd_driver.driver, &driver_attr_probe);
+	if (need_delete_probe)
+		driver_remove_file(&viodasd_driver.driver, &driver_attr_probe);
 	vio_unregister_driver(&viodasd_driver);
 	vio_clearHandler(viomajorsubtype_blockio);
-	unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
 	viopath_close(viopath_hostLp, viomajorsubtype_blockio, VIOMAXREQ + 2);
+	unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
 }
-
 module_exit(viodasd_exit);
-- 
1.4.3.3
