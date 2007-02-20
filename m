Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id AB611DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 21:42:06 +1100 (EST)
Date: Tue, 20 Feb 2007 11:42:04 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4 (final?)] ps3fb: thread updates
In-Reply-To: <Pine.LNX.4.62.0702201133080.6407@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702201141000.20432@pademelon.sonytel.be>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
	<20070216163811.GB32051@lst.de>
	<Pine.LNX.4.62.0702161832200.22939@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702191505510.32160@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702201133080.6407@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3fb: Replace the kernel_thread and the semaphore by a proper kthread, which is
simply woken up when the screen must be updated

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.20/drivers/video/ps3fb.c
@@ -32,6 +32,7 @@
 #include <linux/ioctl.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 #include <linux/fb.h>
@@ -129,7 +130,6 @@ struct ps3fb_priv {
 	u64 context_handle, memory_handle;
 	void *xdr_ea;
 	struct gpu_driver_info *dinfo;
-	struct semaphore sem;
 	u32 res_index;
 
 	u64 vblank_count;	/* frame count */
@@ -139,6 +139,8 @@ struct ps3fb_priv {
 	atomic_t ext_flip;	/* on/off flip with vsync */
 	atomic_t f_count;	/* fb_open count */
 	int is_blanked;
+	int is_kicked;
+	struct task_struct *task;
 };
 static struct ps3fb_priv ps3fb;
 
@@ -805,11 +807,13 @@ static int ps3fb_ioctl(struct fb_info *i
 
 static int ps3fbd(void *arg)
 {
-	daemonize("ps3fbd");
-	for (;;) {
-		down(&ps3fb.sem);
-		if (atomic_read(&ps3fb.ext_flip) == 0)
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (ps3fb.is_kicked) {
+			ps3fb.is_kicked = 0;
 			ps3fb_sync(0);	/* single buffer */
+		}
+		schedule();
 	}
 	return 0;
 }
@@ -830,8 +834,11 @@ static irqreturn_t ps3fb_vsync_interrupt
 	if (v1 & (1 << GPU_INTR_STATUS_VSYNC_1)) {
 		/* VSYNC */
 		ps3fb.vblank_count = head->vblank_count;
-		if (!ps3fb.is_blanked)
-			up(&ps3fb.sem);
+		if (ps3fb.task && !ps3fb.is_blanked &&
+		    !atomic_read(&ps3fb.ext_flip)) {
+			ps3fb.is_kicked = 1;
+			wake_up_process(ps3fb.task);
+		}
 		wake_up_interruptible(&ps3fb.wait_vsync);
 	}
 
@@ -968,6 +975,7 @@ static int __init ps3fb_probe(struct pla
 	u64 xdr_lpar;
 	int status;
 	unsigned long offset;
+	struct task_struct *task;
 
 	/* get gpu context handle */
 	status = lv1_gpu_memory_allocate(DDR_SIZE, 0, 0, 0, 0,
@@ -1050,9 +1058,18 @@ static int __init ps3fb_probe(struct pla
 	       "fb%d: PS3 frame buffer device, using %ld KiB of video memory\n",
 	       info->node, ps3fb_videomemory.size >> 10);
 
-	kernel_thread(ps3fbd, info, CLONE_KERNEL);
+	task = kthread_run(ps3fbd, info, "ps3fbd");
+	if (IS_ERR(task)) {
+		retval = PTR_ERR(task);
+		goto err_unregister_framebuffer;
+	}
+
+	ps3fb.task = task;
+
 	return 0;
 
+err_unregister_framebuffer:
+	unregister_framebuffer(info);
 err_fb_dealloc:
 	fb_dealloc_cmap(&info->cmap);
 err_framebuffer_release:
@@ -1083,6 +1100,11 @@ void ps3fb_cleanup(void)
 {
 	int status;
 
+	if (ps3fb.task) {
+		struct task_struct *task = ps3fb.task;
+		ps3fb.task = NULL;
+		kthread_stop(task);
+	}
 	if (ps3fb.irq_no) {
 		free_irq(ps3fb.irq_no, ps3fb.dev);
 		ps3_free_irq(ps3fb.irq_no);
@@ -1195,7 +1217,6 @@ static int __init ps3fb_init(void)
 
 	atomic_set(&ps3fb.f_count, -1);	/* fbcon opens ps3fb */
 	atomic_set(&ps3fb.ext_flip, 0);	/* for flip with vsync */
-	init_MUTEX(&ps3fb.sem);
 	init_waitqueue_head(&ps3fb.wait_vsync);
 	ps3fb.num_frames = 1;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
