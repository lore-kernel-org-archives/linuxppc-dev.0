Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id D9E53B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Dec 2009 18:30:26 +1100 (EST)
Subject: [PATCH] viodasd.c: Remove VIOD_KERN_<level> macros for printks
From: Joe Perches <joe@perches.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Dec 2009 23:22:59 -0800
Message-ID: <1261552979.1923.6.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use #define pr_fmt(fmt) "viod: " fmt
Remove #define VIOD_KERN_WARNING and VIOD_KERN_INFO
Convert printk(VIOD_KERN_<level> to pr_<level>
Coalesce long format strings

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

 drivers/block/viodasd.c |   86 +++++++++++++++++++---------------------------
 1 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index a8c8b56..1b3def1 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -28,6 +28,9 @@
  * All disk operations are performed by sending messages back and forth to
  * the OS/400 partition.
  */
+
+#define pr_fmt(fmt) "viod: " fmt
+
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -63,9 +66,6 @@ MODULE_LICENSE("GPL");
 
 #define VIOD_VERS		"1.64"
 
-#define VIOD_KERN_WARNING	KERN_WARNING "viod: "
-#define VIOD_KERN_INFO		KERN_INFO "viod: "
-
 enum {
 	PARTITION_SHIFT = 3,
 	MAX_DISKNO = HVMAXARCHITECTEDVIRTUALDISKS,
@@ -156,7 +156,7 @@ static int viodasd_open(struct block_device *bdev, fmode_t mode)
 			((u64)DEVICE_NO(d) << 48) | ((u64)flags << 32),
 			0, 0, 0);
 	if (hvrc != 0) {
-		printk(VIOD_KERN_WARNING "HV open failed %d\n", (int)hvrc);
+		pr_warning("HV open failed %d\n", (int)hvrc);
 		return -EIO;
 	}
 
@@ -167,9 +167,8 @@ static int viodasd_open(struct block_device *bdev, fmode_t mode)
 		const struct vio_error_entry *err =
 			vio_lookup_rc(viodasd_err_table, we.sub_result);
 
-		printk(VIOD_KERN_WARNING
-				"bad rc opening disk: %d:0x%04x (%s)\n",
-				(int)we.rc, we.sub_result, err->msg);
+		pr_warning("bad rc opening disk: %d:0x%04x (%s)\n",
+			   (int)we.rc, we.sub_result, err->msg);
 		return -EIO;
 	}
 
@@ -195,8 +194,7 @@ static int viodasd_release(struct gendisk *disk, fmode_t mode)
 			((u64)DEVICE_NO(d) << 48) /* | ((u64)flags << 32) */,
 			0, 0, 0);
 	if (hvrc != 0)
-		printk(VIOD_KERN_WARNING "HV close call failed %d\n",
-				(int)hvrc);
+		pr_warning("HV close call failed %d\n", (int)hvrc);
 	return 0;
 }
 
@@ -288,8 +286,7 @@ static int send_request(struct request *req)
 		bevent = (struct vioblocklpevent *)
 			vio_get_event_buffer(viomajorsubtype_blockio);
 		if (bevent == NULL) {
-			printk(VIOD_KERN_WARNING
-			       "error allocating disk event buffer\n");
+			pr_warning("error allocating disk event buffer\n");
 			goto error_ret;
 		}
 
@@ -333,9 +330,8 @@ static int send_request(struct request *req)
 	}
 
 	if (hvrc != HvLpEvent_Rc_Good) {
-		printk(VIOD_KERN_WARNING
-		       "error sending disk event to OS/400 (rc %d)\n",
-		       (int)hvrc);
+		pr_warning("error sending disk event to OS/400 (rc %d)\n",
+			   (int)hvrc);
 		goto error_ret;
 	}
 	spin_unlock_irqrestore(&viodasd_spinlock, flags);
@@ -402,7 +398,7 @@ retry:
 			((u64)dev_no << 48) | ((u64)flags<< 32),
 			0, 0, 0);
 	if (hvrc != 0) {
-		printk(VIOD_KERN_WARNING "bad rc on HV open %d\n", (int)hvrc);
+		pr_warning("bad rc on HV open %d\n", (int)hvrc);
 		return 0;
 	}
 
@@ -416,9 +412,8 @@ retry:
 		goto retry;
 	}
 	if (we.max_disk > (MAX_DISKNO - 1)) {
-		printk_once(VIOD_KERN_INFO
-			"Only examining the first %d of %d disks connected\n",
-			MAX_DISKNO, we.max_disk + 1);
+		printk_once(KERN_INFO pr_fmt("Only examining the first %d of %d disks connected\n"),
+			    MAX_DISKNO, we.max_disk + 1);
 	}
 
 	/* Send the close event to OS/400.  We DON'T expect a response */
@@ -432,17 +427,15 @@ retry:
 			((u64)dev_no << 48) | ((u64)flags << 32),
 			0, 0, 0);
 	if (hvrc != 0) {
-		printk(VIOD_KERN_WARNING
-		       "bad rc sending event to OS/400 %d\n", (int)hvrc);
+		pr_warning("bad rc sending event to OS/400 %d\n", (int)hvrc);
 		return 0;
 	}
 
 	if (d->dev == NULL) {
 		/* this is when we reprobe for new disks */
 		if (vio_create_viodasd(dev_no) == NULL) {
-			printk(VIOD_KERN_WARNING
-				"cannot allocate virtual device for disk %d\n",
-				dev_no);
+			pr_warning("cannot allocate virtual device for disk %d\n",
+				   dev_no);
 			return 0;
 		}
 		/*
@@ -457,15 +450,13 @@ retry:
 	spin_lock_init(&d->q_lock);
 	q = blk_init_queue(do_viodasd_request, &d->q_lock);
 	if (q == NULL) {
-		printk(VIOD_KERN_WARNING "cannot allocate queue for disk %d\n",
-				dev_no);
+		pr_warning("cannot allocate queue for disk %d\n", dev_no);
 		return 0;
 	}
 	g = alloc_disk(1 << PARTITION_SHIFT);
 	if (g == NULL) {
-		printk(VIOD_KERN_WARNING
-				"cannot allocate disk structure for disk %d\n",
-				dev_no);
+		pr_warning("cannot allocate disk structure for disk %d\n",
+			   dev_no);
 		blk_cleanup_queue(q);
 		return 0;
 	}
@@ -489,13 +480,12 @@ retry:
 	g->driverfs_dev = d->dev;
 	set_capacity(g, d->size >> 9);
 
-	printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
-			"CHS=%d/%d/%d sector size %d%s\n",
-			dev_no, (unsigned long)(d->size >> 9),
-			(unsigned long)(d->size >> 20),
-			(int)d->cylinders, (int)d->tracks,
-			(int)d->sectors, (int)d->bytes_per_sector,
-			d->read_only ? " (RO)" : "");
+	pr_info("disk %d: %lu sectors (%lu MB) CHS=%d/%d/%d sector size %d%s\n",
+		dev_no, (unsigned long)(d->size >> 9),
+		(unsigned long)(d->size >> 20),
+		(int)d->cylinders, (int)d->tracks,
+		(int)d->sectors, (int)d->bytes_per_sector,
+		d->read_only ? " (RO)" : "");
 
 	/* register us in the global list */
 	add_disk(g);
@@ -580,8 +570,8 @@ static int viodasd_handle_read_write(struct vioblocklpevent *bevent)
 	if (error) {
 		const struct vio_error_entry *err;
 		err = vio_lookup_rc(viodasd_err_table, bevent->sub_result);
-		printk(VIOD_KERN_WARNING "read/write error %d:0x%04x (%s)\n",
-				event->xRc, bevent->sub_result, err->msg);
+		pr_warning("read/write error %d:0x%04x (%s)\n",
+			   event->xRc, bevent->sub_result, err->msg);
 		num_sect = blk_rq_sectors(req);
 	}
 	qlock = req->q->queue_lock;
@@ -606,8 +596,7 @@ static void handle_block_event(struct HvLpEvent *event)
 		return;
 	/* First, we should NEVER get an int here...only acks */
 	if (hvlpevent_is_int(event)) {
-		printk(VIOD_KERN_WARNING
-		       "Yikes! got an int in viodasd event handler!\n");
+		pr_warning("Yikes! got an int in viodasd event handler!\n");
 		if (hvlpevent_need_ack(event)) {
 			event->xRc = HvLpEvent_Rc_InvalidSubtype;
 			HvCallEvent_ackLpEvent(event);
@@ -650,7 +639,7 @@ static void handle_block_event(struct HvLpEvent *event)
 		break;
 
 	default:
-		printk(VIOD_KERN_WARNING "invalid subtype!");
+		pr_warning("invalid subtype!");
 		if (hvlpevent_need_ack(event)) {
 			event->xRc = HvLpEvent_Rc_InvalidSubtype;
 			HvCallEvent_ackLpEvent(event);
@@ -739,29 +728,26 @@ static int __init viodasd_init(void)
 		vio_set_hostlp();
 
 	if (viopath_hostLp == HvLpIndexInvalid) {
-		printk(VIOD_KERN_WARNING "invalid hosting partition\n");
+		pr_warning("invalid hosting partition\n");
 		rc = -EIO;
 		goto early_fail;
 	}
 
-	printk(VIOD_KERN_INFO "vers " VIOD_VERS ", hosting partition %d\n",
-			viopath_hostLp);
+	pr_info("vers " VIOD_VERS ", hosting partition %d\n", viopath_hostLp);
 
         /* register the block device */
 	rc =  register_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
 	if (rc) {
-		printk(VIOD_KERN_WARNING
-				"Unable to get major number %d for %s\n",
-				VIODASD_MAJOR, VIOD_GENHD_NAME);
+		pr_warning("Unable to get major number %d for %s\n",
+			   VIODASD_MAJOR, VIOD_GENHD_NAME);
 		goto early_fail;
 	}
 	/* Actually open the path to the hosting partition */
 	rc = viopath_open(viopath_hostLp, viomajorsubtype_blockio,
 				VIOMAXREQ + 2);
 	if (rc) {
-		printk(VIOD_KERN_WARNING
-		       "error opening path to host partition %d\n",
-		       viopath_hostLp);
+		pr_warning("error opening path to host partition %d\n",
+			   viopath_hostLp);
 		goto unregister_blk;
 	}
 
@@ -770,7 +756,7 @@ static int __init viodasd_init(void)
 
 	rc = vio_register_driver(&viodasd_driver);
 	if (rc) {
-		printk(VIOD_KERN_WARNING "vio_register_driver failed\n");
+		pr_warning("vio_register_driver failed\n");
 		goto unset_handler;
 	}
 
