Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 53126DDED6
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:04:26 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so240499yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2008 05:04:24 -0700 (PDT)
Date: Fri, 3 Oct 2008 08:03:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Block device for the ISS simulator
Message-ID: <20081003120305.GA2229@yoda.jdub.homelinux.org>
References: <20081003000904.0A812DDEEE@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081003000904.0A812DDEEE@ozlabs.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 10:08:42AM +1000, Benjamin Herrenschmidt wrote:
>+static void iss_blk_setup(struct iss_blk *ib)
>+{
>+	unsigned long flags;
>+	u32 stat;
>+
>+	pr_debug("iss_blk_setup %d\n", ib->devno);
>+
>+	spin_lock_irqsave(&iss_blk_reglock, flags);
>+	out_8(iss_blk_regs->data, 0);
>+	out_be32(&iss_blk_regs->devno, ib->devno);
>+	out_8(&iss_blk_regs->cmd, ISS_BD_CMD_OPEN);
>+	stat = in_be32(&iss_blk_regs->stat);

Should probably use the ioread/iowrite functions instead of raw out/in.
Same comment throughout.

<snip>

>+static void iss_blk_do_request(struct request_queue * q)
>+{
>+	struct iss_blk *ib = q->queuedata;
>+	struct request *req;
>+	int rc = 0;
>+
>+	pr_debug("iss_do_request dev %d\n", ib->devno);
>+
>+	while ((req = elv_next_request(q)) != NULL) {
>+		pr_debug(" -> req @ %p, changed: %d\n", req, ib->changed);
>+		if (ib->changed) {
>+			end_request(req, 0);	/* failure */
>+			continue;
>+		}
>+		switch (rq_data_dir(req)) {
>+		case READ:
>+			rc = __iss_blk_read(ib, req->buffer, req->sector,
>+					    req->current_nr_sectors);
>+			break;
>+		case WRITE:
>+			rc = __iss_blk_write(ib, req->buffer, req->sector,
>+					     req->current_nr_sectors);
>+		};
>+
>+		pr_debug(" -> ending request, rc = %d\n", rc);
>+		if (rc)
>+			end_request(req, 0);	/* failure */
>+		else
>+			end_request(req, 1);	/* success */

Could possibly just do:

end_request(req, (!rc));

<snip>

>+static int __init iss_blk_init(void)
>+{
>+	struct device_node *np;
>+	int i;
>+
>+	pr_debug("iss_regs offsets:\n");
>+	pr_debug("  cmd    : 0x%x\n", offsetof(struct iss_blk_regs, cmd));
>+	pr_debug("  stat   : 0x%x\n", offsetof(struct iss_blk_regs, stat));
>+	pr_debug("  sector : 0x%x\n", offsetof(struct iss_blk_regs, sector));
>+	pr_debug("  count  : 0x%x\n", offsetof(struct iss_blk_regs, count));
>+	pr_debug("  devno  : 0x%x\n", offsetof(struct iss_blk_regs, devno));
>+	pr_debug("  size   : 0x%x\n", offsetof(struct iss_blk_regs, size));
>+	pr_debug("  data   : 0x%x\n", offsetof(struct iss_blk_regs, data));
>+
>+	np = of_find_node_by_path("/iss-block");
>+	if (np == NULL)
>+		return -ENODEV;
>+	iss_blk_regs = of_iomap(np, 0);

of_find_node_by_path increments the refcount for that node.  Need to
do an of_node_put when you are done.

>+	if (iss_blk_regs == NULL) {
>+		pr_err("issblk: Failed to map registers\n");
>+		return -ENOMEM;
>+	}
>+
>+	if (register_blkdev(MAJOR_NR, "iss_blk"))
>+		return -EIO;
>+
>+	spin_lock_init(&iss_blk_qlock);
>+	spin_lock_init(&iss_blk_reglock);
>+
>+	printk(KERN_INFO "ISS Block driver initializing for %d minors\n",
>+	       NUM_ISS_BLK_MINOR);
>+
>+	for (i = 0; i < NUM_ISS_BLK_MINOR; i++) {
>+		struct gendisk *disk = alloc_disk(1);
>+		struct request_queue *q;
>+		struct iss_blk *ib = &iss_blks[i];
>+
>+		if (!disk) {
>+			pr_err("issblk%d: Failed to allocate disk\n", i);
>+			break;
>+		}
>+
>+		q = blk_init_queue(iss_blk_do_request, &iss_blk_qlock);
>+		if (q == NULL) {
>+			pr_err("issblk%d: Failed to init queue\n", i);
>+			put_disk(disk);
>+			break;
>+		}
>+		q->queuedata = ib;
>+
>+		ib->disk = disk;
>+		ib->devno = i;
>+		ib->present = 0;
>+		ib->changed = 0;
>+		ib->capacity = 0;
>+		ib->sectsize = 512;
>+
>+		disk->major = MAJOR_NR;
>+		disk->first_minor = i;
>+		disk->fops = &iss_blk_fops;
>+		disk->private_data = &iss_blks[i];
>+		disk->flags = GENHD_FL_REMOVABLE;
>+		disk->queue = q;
>+		sprintf(disk->disk_name, "issblk%d", i);
>+
>+		iss_blk_setup(ib);
>+
>+		add_disk(disk);
>+	}
>+
>+	return 0;
>+}
>+
>+static void __exit iss_blk_exit(void)
>+{
>+	int i;
>+
>+	unregister_blkdev(MAJOR_NR, "iss_blk");
>+
>+	for (i = 0; i < NUM_ISS_BLK_MINOR; i++) {
>+		struct iss_blk *ib = &iss_blks[i];
>+
>+		if (ib->present) {
>+			out_be32(&iss_blk_regs->devno, ib->devno);
>+			out_8(&iss_blk_regs->cmd, ISS_BD_CMD_CLOSE);
>+		}
>+	}

Shouldn't you unmap iss_blk_regs at this point?

<snip>

>Index: linux-work/drivers/block/Kconfig
>===================================================================
>--- linux-work.orig/drivers/block/Kconfig	2008-07-17 14:43:58.000000000 +1000
>+++ linux-work/drivers/block/Kconfig	2008-09-23 11:12:03.000000000 +1000
>@@ -357,6 +357,10 @@ config BLK_DEV_XIP
> 	  will prevent RAM block device backing store memory from being
> 	  allocated from highmem (only a problem for highmem systems).
> 
>+config BLK_DEV_ISS
>+       bool "Support ISS Simulator Block Device"
>+       default n
>+

Should probably have:

	depends on PPC



josh
