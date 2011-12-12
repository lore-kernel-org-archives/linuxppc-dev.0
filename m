Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E0113B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 15:57:56 +1100 (EST)
Message-ID: <1323665859.19891.16.camel@pasglop>
Subject: [PATCH] block/swim3: Locking fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 12 Dec 2011 15:57:39 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The old PowerMac swim3 driver has some "interesting" locking issues,
using a private lock and failing to lock the queue before completing
requests, which triggered WARN_ONs among others.

This rips out the private lock, makes everything operate under the
block queue lock, and generally makes things simpler.

We used to also share a queue between the two possible instances which
was problematic since we might pick the wrong controller in some cases,
so make the queue and the current request per-instance and use
queuedata to point to our private data which is a lot cleaner.

We still share the queue lock but then, it's nearly impossible to actually
use 2 swim3's simultaneously: one would need to have a Wallstreet
PowerBook, the only machine afaik with two of these on the motherboard,
and populate both hotswap bays with a floppy drive (the machine ships
only with one), so nobody cares...

While at it, add a little fix to clear up stale interrupts when loading
the driver or plugging a floppy drive in a bay.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/block/swim3.c |  362 +++++++++++++++++++++++++++++--------------------
 1 files changed, 215 insertions(+), 147 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index ae3e167..89ddab1 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -16,6 +16,8 @@
  * handle GCR disks
  */
 
+#undef DEBUG
+
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -36,13 +38,11 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 
-static DEFINE_MUTEX(swim3_mutex);
-static struct request_queue *swim3_queue;
-static struct gendisk *disks[2];
-static struct request *fd_req;
-
 #define MAX_FLOPPIES	2
 
+static DEFINE_MUTEX(swim3_mutex);
+static struct gendisk *disks[MAX_FLOPPIES];
+
 enum swim_state {
 	idle,
 	locating,
@@ -177,7 +177,6 @@ struct swim3 {
 
 struct floppy_state {
 	enum swim_state	state;
-	spinlock_t lock;
 	struct swim3 __iomem *swim3;	/* hardware registers */
 	struct dbdma_regs __iomem *dma;	/* DMA controller registers */
 	int	swim3_intr;	/* interrupt number for SWIM3 */
@@ -204,8 +203,20 @@ struct floppy_state {
 	int	wanted;
 	struct macio_dev *mdev;
 	char	dbdma_cmd_space[5 * sizeof(struct dbdma_cmd)];
+	int	index;
+	struct request *cur_req;
 };
 
+#define swim3_err(fmt, arg...)	dev_err(&fs->mdev->ofdev.dev, "[fd%d] " fmt, fs->index, arg)
+#define swim3_warn(fmt, arg...)	dev_warn(&fs->mdev->ofdev.dev, "[fd%d] " fmt, fs->index, arg)
+#define swim3_info(fmt, arg...)	dev_info(&fs->mdev->ofdev.dev, "[fd%d] " fmt, fs->index, arg)
+
+#ifdef DEBUG
+#define swim3_dbg(fmt, arg...)	dev_dbg(&fs->mdev->ofdev.dev, "[fd%d] " fmt, fs->index, arg)
+#else
+#define swim3_dbg(fmt, arg...)	do { } while(0)
+#endif
+
 static struct floppy_state floppy_states[MAX_FLOPPIES];
 static int floppy_count = 0;
 static DEFINE_SPINLOCK(swim3_lock);
@@ -224,17 +235,8 @@ static unsigned short write_postamble[] = {
 	0, 0, 0, 0, 0, 0
 };
 
-static void swim3_select(struct floppy_state *fs, int sel);
-static void swim3_action(struct floppy_state *fs, int action);
-static int swim3_readbit(struct floppy_state *fs, int bit);
-static void do_fd_request(struct request_queue * q);
-static void start_request(struct floppy_state *fs);
-static void set_timeout(struct floppy_state *fs, int nticks,
-			void (*proc)(unsigned long));
-static void scan_track(struct floppy_state *fs);
 static void seek_track(struct floppy_state *fs, int n);
 static void init_dma(struct dbdma_cmd *cp, int cmd, void *buf, int count);
-static void setup_transfer(struct floppy_state *fs);
 static void act(struct floppy_state *fs);
 static void scan_timeout(unsigned long data);
 static void seek_timeout(unsigned long data);
@@ -254,18 +256,21 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 					unsigned int clearing);
 static int floppy_revalidate(struct gendisk *disk);
 
-static bool swim3_end_request(int err, unsigned int nr_bytes)
+static bool swim3_end_request(struct floppy_state *fs, int err, unsigned int nr_bytes)
 {
-	if (__blk_end_request(fd_req, err, nr_bytes))
-		return true;
+	struct request *req = fs->cur_req;
+	int rc;
 
-	fd_req = NULL;
-	return false;
-}
+	swim3_dbg("  end request, err=%d nr_bytes=%d, cur_req=%p\n",
+		  err, nr_bytes, req);
 
-static bool swim3_end_request_cur(int err)
-{
-	return swim3_end_request(err, blk_rq_cur_bytes(fd_req));
+	if (err)
+		nr_bytes = blk_rq_cur_bytes(req);
+	rc = __blk_end_request(req, err, nr_bytes);
+	if (rc)
+		return true;
+	fs->cur_req = NULL;
+	return false;
 }
 
 static void swim3_select(struct floppy_state *fs, int sel)
@@ -303,50 +308,53 @@ static int swim3_readbit(struct floppy_state *fs, int bit)
 	return (stat & DATA) == 0;
 }
 
-static void do_fd_request(struct request_queue * q)
-{
-	int i;
-
-	for(i=0; i<floppy_count; i++) {
-		struct floppy_state *fs = &floppy_states[i];
-		if (fs->mdev->media_bay &&
-		    check_media_bay(fs->mdev->media_bay) != MB_FD)
-			continue;
-		start_request(fs);
-	}
-}
-
 static void start_request(struct floppy_state *fs)
 {
 	struct request *req;
 	unsigned long x;
 
+	swim3_dbg("start request, initial state=%d\n", fs->state);
+
 	if (fs->state == idle && fs->wanted) {
 		fs->state = available;
 		wake_up(&fs->wait);
 		return;
 	}
 	while (fs->state == idle) {
-		if (!fd_req) {
-			fd_req = blk_fetch_request(swim3_queue);
-			if (!fd_req)
+		swim3_dbg("start request, idle loop, cur_req=%p\n", fs->cur_req);
+		if (!fs->cur_req) {
+			fs->cur_req = blk_fetch_request(disks[fs->index]->queue);
+			swim3_dbg("  fetched request %p\n", fs->cur_req);
+			if (!fs->cur_req)
 				break;
 		}
-		req = fd_req;
-#if 0
-		printk("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%u buf=%p\n",
-		       req->rq_disk->disk_name, req->cmd,
-		       (long)blk_rq_pos(req), blk_rq_sectors(req), req->buffer);
-		printk("           errors=%d current_nr_sectors=%u\n",
-		       req->errors, blk_rq_cur_sectors(req));
+		req = fs->cur_req;
+
+		if (fs->mdev->media_bay &&
+		    check_media_bay(fs->mdev->media_bay) != MB_FD) {
+			swim3_dbg("%s", "  media bay absent, dropping req\n");
+			swim3_end_request(fs, -ENODEV, 0);
+			continue;
+		}
+
+#if 0 /* This is really too verbose */
+		swim3_dbg("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%u buf=%p\n",
+			  req->rq_disk->disk_name, req->cmd,
+			  (long)blk_rq_pos(req), blk_rq_sectors(req),
+			  req->buffer);
+		swim3_dbg("           errors=%d current_nr_sectors=%u\n",
+			  req->errors, blk_rq_cur_sectors(req));
 #endif
 
 		if (blk_rq_pos(req) >= fs->total_secs) {
-			swim3_end_request_cur(-EIO);
+			swim3_dbg("  pos out of bounds (%ld, max is %ld)\n",
+				  (long)blk_rq_pos(req), (long)fs->total_secs);
+			swim3_end_request(fs, -EIO, 0);
 			continue;
 		}
 		if (fs->ejected) {
-			swim3_end_request_cur(-EIO);
+			swim3_dbg("%s", "  disk ejected\n");
+			swim3_end_request(fs, -EIO, 0);
 			continue;
 		}
 
@@ -354,7 +362,8 @@ static void start_request(struct floppy_state *fs)
 			if (fs->write_prot < 0)
 				fs->write_prot = swim3_readbit(fs, WRITE_PROT);
 			if (fs->write_prot) {
-				swim3_end_request_cur(-EIO);
+				swim3_dbg("%s", "  try to write, disk write protected\n");
+				swim3_end_request(fs, -EIO, 0);
 				continue;
 			}
 		}
@@ -369,7 +378,6 @@ static void start_request(struct floppy_state *fs)
 		x = ((long)blk_rq_pos(req)) % fs->secpercyl;
 		fs->head = x / fs->secpertrack;
 		fs->req_sector = x % fs->secpertrack + 1;
-		fd_req = req;
 		fs->state = do_transfer;
 		fs->retries = 0;
 
@@ -377,12 +385,14 @@ static void start_request(struct floppy_state *fs)
 	}
 }
 
+static void do_fd_request(struct request_queue * q)
+{
+	start_request(q->queuedata);
+}
+
 static void set_timeout(struct floppy_state *fs, int nticks,
 			void (*proc)(unsigned long))
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&fs->lock, flags);
 	if (fs->timeout_pending)
 		del_timer(&fs->timeout);
 	fs->timeout.expires = jiffies + nticks;
@@ -390,7 +400,6 @@ static void set_timeout(struct floppy_state *fs, int nticks,
 	fs->timeout.data = (unsigned long) fs;
 	add_timer(&fs->timeout);
 	fs->timeout_pending = 1;
-	spin_unlock_irqrestore(&fs->lock, flags);
 }
 
 static inline void scan_track(struct floppy_state *fs)
@@ -442,40 +451,45 @@ static inline void setup_transfer(struct floppy_state *fs)
 	struct swim3 __iomem *sw = fs->swim3;
 	struct dbdma_cmd *cp = fs->dma_cmd;
 	struct dbdma_regs __iomem *dr = fs->dma;
+	struct request *req = fs->cur_req;
 
-	if (blk_rq_cur_sectors(fd_req) <= 0) {
-		printk(KERN_ERR "swim3: transfer 0 sectors?\n");
+	if (blk_rq_cur_sectors(req) <= 0) {
+		swim3_warn("%s", "Transfer 0 sectors ?\n");
 		return;
 	}
-	if (rq_data_dir(fd_req) == WRITE)
+	if (rq_data_dir(req) == WRITE)
 		n = 1;
 	else {
 		n = fs->secpertrack - fs->req_sector + 1;
-		if (n > blk_rq_cur_sectors(fd_req))
-			n = blk_rq_cur_sectors(fd_req);
+		if (n > blk_rq_cur_sectors(req))
+			n = blk_rq_cur_sectors(req);
 	}
+
+	swim3_dbg("  setup xfer at sect %d (of %d) head %d for %d\n",
+		  fs->req_sector, fs->secpertrack, fs->head, n);
+
 	fs->scount = n;
 	swim3_select(fs, fs->head? READ_DATA_1: READ_DATA_0);
 	out_8(&sw->sector, fs->req_sector);
 	out_8(&sw->nsect, n);
 	out_8(&sw->gap3, 0);
 	out_le32(&dr->cmdptr, virt_to_bus(cp));
-	if (rq_data_dir(fd_req) == WRITE) {
+	if (rq_data_dir(req) == WRITE) {
 		/* Set up 3 dma commands: write preamble, data, postamble */
 		init_dma(cp, OUTPUT_MORE, write_preamble, sizeof(write_preamble));
 		++cp;
-		init_dma(cp, OUTPUT_MORE, fd_req->buffer, 512);
+		init_dma(cp, OUTPUT_MORE, req->buffer, 512);
 		++cp;
 		init_dma(cp, OUTPUT_LAST, write_postamble, sizeof(write_postamble));
 	} else {
-		init_dma(cp, INPUT_LAST, fd_req->buffer, n * 512);
+		init_dma(cp, INPUT_LAST, req->buffer, n * 512);
 	}
 	++cp;
 	out_le16(&cp->command, DBDMA_STOP);
 	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 	in_8(&sw->error);
 	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
-	if (rq_data_dir(fd_req) == WRITE)
+	if (rq_data_dir(req) == WRITE)
 		out_8(&sw->control_bis, WRITE_SECTORS);
 	in_8(&sw->intr);
 	out_le32(&dr->control, (RUN << 16) | RUN);
@@ -488,12 +502,16 @@ static inline void setup_transfer(struct floppy_state *fs)
 static void act(struct floppy_state *fs)
 {
 	for (;;) {
+		swim3_dbg("  act loop, state=%d, req_cyl=%d, cur_cyl=%d\n",
+			  fs->state, fs->req_cyl, fs->cur_cyl);
+
 		switch (fs->state) {
 		case idle:
 			return;		/* XXX shouldn't get here */
 
 		case locating:
 			if (swim3_readbit(fs, TRACK_ZERO)) {
+				swim3_dbg("%s", "    locate track 0\n");
 				fs->cur_cyl = 0;
 				if (fs->req_cyl == 0)
 					fs->state = do_transfer;
@@ -511,7 +529,7 @@ static void act(struct floppy_state *fs)
 				break;
 			}
 			if (fs->req_cyl == fs->cur_cyl) {
-				printk("whoops, seeking 0\n");
+				swim3_warn("%s", "Whoops, seeking 0\n");
 				fs->state = do_transfer;
 				break;
 			}
@@ -527,7 +545,9 @@ static void act(struct floppy_state *fs)
 		case do_transfer:
 			if (fs->cur_cyl != fs->req_cyl) {
 				if (fs->retries > 5) {
-					swim3_end_request_cur(-EIO);
+					swim3_err("Wrong cylinder in transfer, want: %d got %d\n",
+						  fs->req_cyl, fs->cur_cyl);
+					swim3_end_request(fs, -EIO, 0);
 					fs->state = idle;
 					return;
 				}
@@ -542,7 +562,7 @@ static void act(struct floppy_state *fs)
 			return;
 
 		default:
-			printk(KERN_ERR"swim3: unknown state %d\n", fs->state);
+			swim3_err("Unknown state %d\n", fs->state);
 			return;
 		}
 	}
@@ -552,59 +572,75 @@ static void scan_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
 	struct swim3 __iomem *sw = fs->swim3;
+	unsigned long flags;
+
+	swim3_dbg("* scan timeout, state=%d\n", fs->state);
 
+	spin_lock_irqsave(&swim3_lock, flags);
 	fs->timeout_pending = 0;
 	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 	out_8(&sw->select, RELAX);
 	out_8(&sw->intr_enable, 0);
 	fs->cur_cyl = -1;
 	if (fs->retries > 5) {
-		swim3_end_request_cur(-EIO);
+		swim3_end_request(fs, -EIO, 0);
 		fs->state = idle;
 		start_request(fs);
 	} else {
 		fs->state = jogging;
 		act(fs);
 	}
+	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
 static void seek_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
 	struct swim3 __iomem *sw = fs->swim3;
+	unsigned long flags;
+
+	swim3_dbg("* seek timeout, state=%d\n", fs->state);
 
+	spin_lock_irqsave(&swim3_lock, flags);
 	fs->timeout_pending = 0;
 	out_8(&sw->control_bic, DO_SEEK);
 	out_8(&sw->select, RELAX);
 	out_8(&sw->intr_enable, 0);
-	printk(KERN_ERR "swim3: seek timeout\n");
-	swim3_end_request_cur(-EIO);
+	swim3_err("%s", "Seek timeout\n");
+	swim3_end_request(fs, -EIO, 0);
 	fs->state = idle;
 	start_request(fs);
+	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
 static void settle_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
 	struct swim3 __iomem *sw = fs->swim3;
+	unsigned long flags;
+
+	swim3_dbg("* settle timeout, state=%d\n", fs->state);
 
+	spin_lock_irqsave(&swim3_lock, flags);
 	fs->timeout_pending = 0;
 	if (swim3_readbit(fs, SEEK_COMPLETE)) {
 		out_8(&sw->select, RELAX);
 		fs->state = locating;
 		act(fs);
-		return;
+		goto unlock;
 	}
 	out_8(&sw->select, RELAX);
 	if (fs->settle_time < 2*HZ) {
 		++fs->settle_time;
 		set_timeout(fs, 1, settle_timeout);
-		return;
+		goto unlock;
 	}
-	printk(KERN_ERR "swim3: seek settle timeout\n");
-	swim3_end_request_cur(-EIO);
+	swim3_err("%s", "Seek settle timeout\n");
+	swim3_end_request(fs, -EIO, 0);
 	fs->state = idle;
 	start_request(fs);
+ unlock:
+	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
 static void xfer_timeout(unsigned long data)
@@ -612,8 +648,12 @@ static void xfer_timeout(unsigned long data)
 	struct floppy_state *fs = (struct floppy_state *) data;
 	struct swim3 __iomem *sw = fs->swim3;
 	struct dbdma_regs __iomem *dr = fs->dma;
+	unsigned long flags;
 	int n;
 
+	swim3_dbg("* xfer timeout, state=%d\n", fs->state);
+
+	spin_lock_irqsave(&swim3_lock, flags);
 	fs->timeout_pending = 0;
 	out_le32(&dr->control, RUN << 16);
 	/* We must wait a bit for dbdma to stop */
@@ -622,12 +662,13 @@ static void xfer_timeout(unsigned long data)
 	out_8(&sw->intr_enable, 0);
 	out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 	out_8(&sw->select, RELAX);
-	printk(KERN_ERR "swim3: timeout %sing sector %ld\n",
-	       (rq_data_dir(fd_req)==WRITE? "writ": "read"),
-	       (long)blk_rq_pos(fd_req));
-	swim3_end_request_cur(-EIO);
+	swim3_err("Timeout %sing sector %ld\n",
+	       (rq_data_dir(fs->cur_req)==WRITE? "writ": "read"),
+	       (long)blk_rq_pos(fs->cur_req));
+	swim3_end_request(fs, -EIO, 0);
 	fs->state = idle;
 	start_request(fs);
+	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
 static irqreturn_t swim3_interrupt(int irq, void *dev_id)
@@ -638,12 +679,17 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 	int stat, resid;
 	struct dbdma_regs __iomem *dr;
 	struct dbdma_cmd *cp;
+	unsigned long flags;
+	struct request *req = fs->cur_req;
+
+	swim3_dbg("* interrupt, state=%d\n", fs->state);
 
+	spin_lock_irqsave(&swim3_lock, flags);
 	intr = in_8(&sw->intr);
 	err = (intr & ERROR_INTR)? in_8(&sw->error): 0;
 	if ((intr & ERROR_INTR) && fs->state != do_transfer)
-		printk(KERN_ERR "swim3_interrupt, state=%d, dir=%x, intr=%x, err=%x\n",
-		       fs->state, rq_data_dir(fd_req), intr, err);
+		swim3_err("Non-transfer error interrupt: state=%d, dir=%x, intr=%x, err=%x\n",
+			  fs->state, rq_data_dir(req), intr, err);
 	switch (fs->state) {
 	case locating:
 		if (intr & SEEN_SECTOR) {
@@ -653,10 +699,10 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 			del_timer(&fs->timeout);
 			fs->timeout_pending = 0;
 			if (sw->ctrack == 0xff) {
-				printk(KERN_ERR "swim3: seen sector but cyl=ff?\n");
+				swim3_err("%s", "Seen sector but cyl=ff?\n");
 				fs->cur_cyl = -1;
 				if (fs->retries > 5) {
-					swim3_end_request_cur(-EIO);
+					swim3_end_request(fs, -EIO, 0);
 					fs->state = idle;
 					start_request(fs);
 				} else {
@@ -668,8 +714,8 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 			fs->cur_cyl = sw->ctrack;
 			fs->cur_sector = sw->csect;
 			if (fs->expect_cyl != -1 && fs->expect_cyl != fs->cur_cyl)
-				printk(KERN_ERR "swim3: expected cyl %d, got %d\n",
-				       fs->expect_cyl, fs->cur_cyl);
+				swim3_err("Expected cyl %d, got %d\n",
+					  fs->expect_cyl, fs->cur_cyl);
 			fs->state = do_transfer;
 			act(fs);
 		}
@@ -704,7 +750,7 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 		fs->timeout_pending = 0;
 		dr = fs->dma;
 		cp = fs->dma_cmd;
-		if (rq_data_dir(fd_req) == WRITE)
+		if (rq_data_dir(req) == WRITE)
 			++cp;
 		/*
 		 * Check that the main data transfer has finished.
@@ -729,31 +775,32 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 		if (intr & ERROR_INTR) {
 			n = fs->scount - 1 - resid / 512;
 			if (n > 0) {
-				blk_update_request(fd_req, 0, n << 9);
+				blk_update_request(req, 0, n << 9);
 				fs->req_sector += n;
 			}
 			if (fs->retries < 5) {
 				++fs->retries;
 				act(fs);
 			} else {
-				printk("swim3: error %sing block %ld (err=%x)\n",
-				       rq_data_dir(fd_req) == WRITE? "writ": "read",
-				       (long)blk_rq_pos(fd_req), err);
-				swim3_end_request_cur(-EIO);
+				swim3_err("Error %sing block %ld (err=%x)\n",
+				       rq_data_dir(req) == WRITE? "writ": "read",
+				       (long)blk_rq_pos(req), err);
+				swim3_end_request(fs, -EIO, 0);
 				fs->state = idle;
 			}
 		} else {
 			if ((stat & ACTIVE) == 0 || resid != 0) {
 				/* musta been an error */
-				printk(KERN_ERR "swim3: fd dma: stat=%x resid=%d\n", stat, resid);
-				printk(KERN_ERR "  state=%d, dir=%x, intr=%x, err=%x\n",
-				       fs->state, rq_data_dir(fd_req), intr, err);
-				swim3_end_request_cur(-EIO);
+				swim3_err("fd dma error: stat=%x resid=%d\n", stat, resid);
+				swim3_err("  state=%d, dir=%x, intr=%x, err=%x\n",
+					  fs->state, rq_data_dir(req), intr, err);
+				swim3_end_request(fs, -EIO, 0);
 				fs->state = idle;
 				start_request(fs);
 				break;
 			}
-			if (swim3_end_request(0, fs->scount << 9)) {
+			fs->retries = 0;
+			if (swim3_end_request(fs, 0, fs->scount << 9)) {
 				fs->req_sector += fs->scount;
 				if (fs->req_sector > fs->secpertrack) {
 					fs->req_sector -= fs->secpertrack;
@@ -770,8 +817,9 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 			start_request(fs);
 		break;
 	default:
-		printk(KERN_ERR "swim3: don't know what to do in state %d\n", fs->state);
+		swim3_err("Don't know what to do in state %d\n", fs->state);
 	}
+	spin_unlock_irqrestore(&swim3_lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -781,26 +829,31 @@ static void fd_dma_interrupt(int irq, void *dev_id)
 }
 */
 
+/* Called under the mutex to grab exclusive access to a drive */
 static int grab_drive(struct floppy_state *fs, enum swim_state state,
 		      int interruptible)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&fs->lock, flags);
-	if (fs->state != idle) {
+	swim3_dbg("%s", "-> grab drive\n");
+
+	spin_lock_irqsave(&swim3_lock, flags);
+	if (fs->state != idle && fs->state != available) {
 		++fs->wanted;
 		while (fs->state != available) {
+			spin_unlock_irqrestore(&swim3_lock, flags);
 			if (interruptible && signal_pending(current)) {
 				--fs->wanted;
-				spin_unlock_irqrestore(&fs->lock, flags);
 				return -EINTR;
 			}
 			interruptible_sleep_on(&fs->wait);
+			spin_lock_irqsave(&swim3_lock, flags);
 		}
 		--fs->wanted;
 	}
 	fs->state = state;
-	spin_unlock_irqrestore(&fs->lock, flags);
+	spin_unlock_irqrestore(&swim3_lock, flags);
+
 	return 0;
 }
 
@@ -808,10 +861,12 @@ static void release_drive(struct floppy_state *fs)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&fs->lock, flags);
+	swim3_dbg("%s", "-> release drive\n");
+
+	spin_lock_irqsave(&swim3_lock, flags);
 	fs->state = idle;
 	start_request(fs);
-	spin_unlock_irqrestore(&fs->lock, flags);
+	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
 static int fd_eject(struct floppy_state *fs)
@@ -966,6 +1021,7 @@ static int floppy_release(struct gendisk *disk, fmode_t mode)
 {
 	struct floppy_state *fs = disk->private_data;
 	struct swim3 __iomem *sw = fs->swim3;
+
 	mutex_lock(&swim3_mutex);
 	if (fs->ref_count > 0 && --fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
@@ -1031,30 +1087,48 @@ static const struct block_device_operations floppy_fops = {
 	.revalidate_disk= floppy_revalidate,
 };
 
+static void swim3_mb_event(struct macio_dev* mdev, int mb_state)
+{
+	struct floppy_state *fs = macio_get_drvdata(mdev);
+	struct swim3 __iomem *sw = fs->swim3;
+
+	if (!fs)
+		return;
+	if (mb_state != MB_FD)
+		return;
+
+	/* Clear state */
+	out_8(&sw->intr_enable, 0);
+	in_8(&sw->intr);
+	in_8(&sw->error);
+}
+
 static int swim3_add_device(struct macio_dev *mdev, int index)
 {
 	struct device_node *swim = mdev->ofdev.dev.of_node;
 	struct floppy_state *fs = &floppy_states[index];
 	int rc = -EBUSY;
 
+	/* Do this first for message macros */
+	memset(fs, 0, sizeof(*fs));
+	fs->mdev = mdev;
+	fs->index = index;
+
 	/* Check & Request resources */
 	if (macio_resource_count(mdev) < 2) {
-		printk(KERN_WARNING "ifd%d: no address for %s\n",
-		       index, swim->full_name);
+		swim3_err("%s", "No address in device-tree\n");
 		return -ENXIO;
 	}
-	if (macio_irq_count(mdev) < 2) {
-		printk(KERN_WARNING "fd%d: no intrs for device %s\n",
-			index, swim->full_name);
+	if (macio_irq_count(mdev) < 1) {
+		swim3_err("%s", "No interrupt in device-tree\n");
+		return -ENXIO;
 	}
 	if (macio_request_resource(mdev, 0, "swim3 (mmio)")) {
-		printk(KERN_ERR "fd%d: can't request mmio resource for %s\n",
-		       index, swim->full_name);
+		swim3_err("%s", "Can't request mmio resource\n");
 		return -EBUSY;
 	}
 	if (macio_request_resource(mdev, 1, "swim3 (dma)")) {
-		printk(KERN_ERR "fd%d: can't request dma resource for %s\n",
-		       index, swim->full_name);
+		swim3_err("%s", "Can't request dma resource\n");
 		macio_release_resource(mdev, 0);
 		return -EBUSY;
 	}
@@ -1063,22 +1137,18 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 	if (mdev->media_bay == NULL)
 		pmac_call_feature(PMAC_FTR_SWIM3_ENABLE, swim, 0, 1);
 	
-	memset(fs, 0, sizeof(*fs));
-	spin_lock_init(&fs->lock);
 	fs->state = idle;
 	fs->swim3 = (struct swim3 __iomem *)
 		ioremap(macio_resource_start(mdev, 0), 0x200);
 	if (fs->swim3 == NULL) {
-		printk("fd%d: couldn't map registers for %s\n",
-		       index, swim->full_name);
+		swim3_err("%s", "Couldn't map mmio registers\n");
 		rc = -ENOMEM;
 		goto out_release;
 	}
 	fs->dma = (struct dbdma_regs __iomem *)
 		ioremap(macio_resource_start(mdev, 1), 0x200);
 	if (fs->dma == NULL) {
-		printk("fd%d: couldn't map DMA for %s\n",
-		       index, swim->full_name);
+		swim3_err("%s", "Couldn't map dma registers\n");
 		iounmap(fs->swim3);
 		rc = -ENOMEM;
 		goto out_release;
@@ -1090,31 +1160,25 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 	fs->secpercyl = 36;
 	fs->secpertrack = 18;
 	fs->total_secs = 2880;
-	fs->mdev = mdev;
 	init_waitqueue_head(&fs->wait);
 
 	fs->dma_cmd = (struct dbdma_cmd *) DBDMA_ALIGN(fs->dbdma_cmd_space);
 	memset(fs->dma_cmd, 0, 2 * sizeof(struct dbdma_cmd));
 	st_le16(&fs->dma_cmd[1].command, DBDMA_STOP);
 
+	if (mdev->media_bay == NULL || check_media_bay(mdev->media_bay) == MB_FD)
+		swim3_mb_event(mdev, MB_FD);
+
 	if (request_irq(fs->swim3_intr, swim3_interrupt, 0, "SWIM3", fs)) {
-		printk(KERN_ERR "fd%d: couldn't request irq %d for %s\n",
-		       index, fs->swim3_intr, swim->full_name);
+		swim3_err("%s", "Couldn't request interrupt\n");
 		pmac_call_feature(PMAC_FTR_SWIM3_ENABLE, swim, 0, 0);
 		goto out_unmap;
 		return -EBUSY;
 	}
-/*
-	if (request_irq(fs->dma_intr, fd_dma_interrupt, 0, "SWIM3-dma", fs)) {
-		printk(KERN_ERR "Couldn't get irq %d for SWIM3 DMA",
-		       fs->dma_intr);
-		return -EBUSY;
-	}
-*/
 
 	init_timer(&fs->timeout);
 
-	printk(KERN_INFO "fd%d: SWIM3 floppy controller %s\n", floppy_count,
+	swim3_info("SWIM3 floppy controller %s\n",
 		mdev->media_bay ? "in media bay" : "");
 
 	return 0;
@@ -1132,41 +1196,42 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 
 static int __devinit swim3_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
-	int i, rc;
 	struct gendisk *disk;
+	int index, rc;
+
+	index = floppy_count++;
+	if (index >= MAX_FLOPPIES)
+		return -ENXIO;
 
 	/* Add the drive */
-	rc = swim3_add_device(mdev, floppy_count);
+	rc = swim3_add_device(mdev, index);
 	if (rc)
 		return rc;
+	/* Now register that disk. Same comment about failure handling */
+	disk = disks[index] = alloc_disk(1);
+	if (disk == NULL)
+		return -ENOMEM;
+	disk->queue = blk_init_queue(do_fd_request, &swim3_lock);
+	if (disk->queue == NULL) {
+		put_disk(disk);
+		return -ENOMEM;
+	}
+	disk->queue->queuedata = &floppy_states[index];
 
-	/* Now create the queue if not there yet */
-	if (swim3_queue == NULL) {
+	if (index == 0) {
 		/* If we failed, there isn't much we can do as the driver is still
 		 * too dumb to remove the device, just bail out
 		 */
 		if (register_blkdev(FLOPPY_MAJOR, "fd"))
 			return 0;
-		swim3_queue = blk_init_queue(do_fd_request, &swim3_lock);
-		if (swim3_queue == NULL) {
-			unregister_blkdev(FLOPPY_MAJOR, "fd");
-			return 0;
-		}
 	}
 
-	/* Now register that disk. Same comment about failure handling */
-	i = floppy_count++;
-	disk = disks[i] = alloc_disk(1);
-	if (disk == NULL)
-		return 0;
-
 	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = i;
+	disk->first_minor = index;
 	disk->fops = &floppy_fops;
-	disk->private_data = &floppy_states[i];
-	disk->queue = swim3_queue;
+	disk->private_data = &floppy_states[index];
 	disk->flags |= GENHD_FL_REMOVABLE;
-	sprintf(disk->disk_name, "fd%d", i);
+	sprintf(disk->disk_name, "fd%d", index);
 	set_capacity(disk, 2880);
 	add_disk(disk);
 
@@ -1194,6 +1259,9 @@ static struct macio_driver swim3_driver =
 		.of_match_table	= swim3_match,
 	},
 	.probe		= swim3_attach,
+#ifdef CONFIG_PMAC_MEDIABAY
+	.mediabay_event	= swim3_mb_event,
+#endif
 #if 0
 	.suspend	= swim3_suspend,
 	.resume		= swim3_resume,
