From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16005.35950.570218.844672@nanango.paulus.ozlabs.org>
Date: Sat, 29 Mar 2003 23:07:10 +1100 (EST)
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
In-Reply-To: <16004.27866.270601.561756@gargle.gargle.HOWL>
References: <16004.27866.270601.561756@gargle.gargle.HOWL>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mikael Pettersson writes:

> With 2.4 kernels, writes to floppy are about a factor of 10 slower
> on my PowerMac 4400 than they are with 2.2 kernels.
>
> The cause for this is a poll-loop in swim3.c which doesn't exist
> in the 2.2 version. The patch below reverts that change, and
> restores floppy write performance to 2.2 levels. I've built many
> boot floppies with this modified driver w/o any problems.

This finally prodded me to look at the mach driver.  I've hacked the
linux swim3 driver to do things in a more similar fashion to what the
mach driver does.  It now seems to not get stuck on the dreaded 04
error and generally seems a lot more robust.  Try this patch and let
me know how it goes.

Paul.

diff -urN linuxppc_2_4/drivers/block/swim3.c pmac/drivers/block/swim3.c
--- linuxppc_2_4/drivers/block/swim3.c	2002-06-04 20:50:30.000000000 +1000
+++ pmac/drivers/block/swim3.c	2003-03-29 22:59:09.000000000 +1100
@@ -146,7 +146,7 @@
 #define RELAX		3	/* also eject in progress */
 #define READ_DATA_0	4
 #define TWOMEG_DRIVE	5
-#define SINGLE_SIDED	6
+#define SINGLE_SIDED	6	/* drive or diskette is 4MB type? */
 #define DRIVE_PRESENT	7
 #define DISK_IN		8
 #define WRITE_PROT	9
@@ -186,6 +186,7 @@
 	int	req_sector;	/* sector number ditto */
 	int	scount;		/* # sectors we're transferring at present */
 	int	retries;
+	int	settle_time;
 	int	secpercyl;	/* disk geometry information */
 	int	secpertrack;
 	int	total_secs;
@@ -205,6 +206,8 @@
 static struct floppy_state floppy_states[MAX_FLOPPIES];
 static int floppy_count = 0;

+static char swim3_buf[2048];
+
 static unsigned short write_preamble[] = {
 	0x4e4e, 0x4e4e, 0x4e4e, 0x4e4e, 0x4e4e,	/* gap field */
 	0, 0, 0, 0, 0, 0,			/* sync field */
@@ -233,6 +236,7 @@
 static void act(struct floppy_state *fs);
 static void scan_timeout(unsigned long data);
 static void seek_timeout(unsigned long data);
+static void settle_timeout(unsigned long data);
 static void xfer_timeout(unsigned long data);
 static void swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 /*static void fd_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs);*/
@@ -275,7 +279,6 @@
 	udelay(2);
 	out_8(&sw->select, sw->select & ~LSTRB);
 	udelay(1);
-	out_8(&sw->select, RELAX);
 }

 static int swim3_readbit(struct floppy_state *fs, int bit)
@@ -284,9 +287,8 @@
 	int stat;

 	swim3_select(fs, bit);
-	udelay(10);
+	udelay(1);
 	stat = in_8(&sw->status);
-	out_8(&sw->select, RELAX);
 	return (stat & DATA) == 0;
 }

@@ -377,13 +379,13 @@
 static inline void scan_track(struct floppy_state *fs)
 {
 	volatile struct swim3 *sw = fs->swim3;
-	int xx;

 	swim3_select(fs, READ_DATA_0);
-	xx = sw->intr;		/* clear SEEN_SECTOR bit */
+	in_8(&sw->intr);		/* clear SEEN_SECTOR bit */
+	in_8(&sw->error);
+	out_8(&sw->intr_enable, SEEN_SECTOR);
 	out_8(&sw->control_bis, DO_ACTION);
 	/* enable intr when track found */
-	out_8(&sw->intr_enable, ERROR_INTR | SEEN_SECTOR);
 	set_timeout(fs, HZ, scan_timeout);	/* enable timeout */
 }

@@ -398,12 +400,14 @@
 		swim3_action(fs, SEEK_NEGATIVE);
 		sw->nseek = -n;
 	}
-	fs->expect_cyl = (fs->cur_cyl > 0)? fs->cur_cyl + n: -1;
+	fs->expect_cyl = (fs->cur_cyl >= 0)? fs->cur_cyl + n: -1;
 	swim3_select(fs, STEP);
-	out_8(&sw->control_bis, DO_SEEK);
+	in_8(&sw->error);
 	/* enable intr when seek finished */
-	out_8(&sw->intr_enable, ERROR_INTR | SEEK_DONE);
-	set_timeout(fs, HZ/2, seek_timeout);	/* enable timeout */
+	out_8(&sw->intr_enable, SEEK_DONE);
+	out_8(&sw->control_bis, DO_SEEK);
+	set_timeout(fs, 3*HZ, seek_timeout);	/* enable timeout */
+	fs->settle_time = 0;
 }

 static inline void init_dma(struct dbdma_cmd *cp, int cmd,
@@ -451,18 +455,21 @@
 	}
 	++cp;
 	out_le16(&cp->command, DBDMA_STOP);
+	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
+	in_8(&sw->error);
+	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
+	if (CURRENT->cmd == WRITE)
+		out_8(&sw->control_bis, WRITE_SECTORS);
+	in_8(&sw->intr);
 	out_le32(&dr->control, (RUN << 16) | RUN);
-	out_8(&sw->control_bis,
-	      (CURRENT->cmd == WRITE? WRITE_SECTORS: 0) | DO_ACTION);
 	/* enable intr when transfer complete */
-	out_8(&sw->intr_enable, ERROR_INTR | TRANSFER_DONE);
+	out_8(&sw->intr_enable, TRANSFER_DONE);
+	out_8(&sw->control_bis, DO_ACTION);
 	set_timeout(fs, 2*HZ, xfer_timeout);	/* enable timeout */
 }

 static void act(struct floppy_state *fs)
 {
-	volatile struct swim3 *sw = fs->swim3;
-
 	for (;;) {
 		switch (fs->state) {
 		case idle:
@@ -495,20 +502,10 @@
 			return;

 		case settling:
-			/* wait for SEEK_COMPLETE to become true */
-			swim3_select(fs, SEEK_COMPLETE);
-			udelay(10);
-			out_8(&sw->intr_enable, ERROR_INTR | DATA_CHANGED);
-			in_8(&sw->intr);	/* clear DATA_CHANGED */
-			if (in_8(&sw->status) & DATA) {
-				/* seek_complete is not yet true */
-				set_timeout(fs, HZ/2, seek_timeout);
-				return;
-			}
-			out_8(&sw->intr_enable, 0);
-			in_8(&sw->intr);
-			fs->state = locating;
-			break;
+			/* check for SEEK_COMPLETE after 30ms */
+			fs->settle_time = (HZ + 32) / 33;
+			set_timeout(fs, fs->settle_time, settle_timeout);
+			return;

 		case do_transfer:
 			if (fs->cur_cyl != fs->req_cyl) {
@@ -540,7 +537,7 @@
 	volatile struct swim3 *sw = fs->swim3;

 	fs->timeout_pending = 0;
-	out_8(&sw->control_bic, DO_ACTION);
+	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 	out_8(&sw->select, RELAX);
 	out_8(&sw->intr_enable, 0);
 	fs->cur_cyl = -1;
@@ -560,20 +557,34 @@
 	volatile struct swim3 *sw = fs->swim3;

 	fs->timeout_pending = 0;
-	if (fs->state == settling) {
-		printk(KERN_ERR "swim3: MSI sel=%x ctrl=%x stat=%x intr=%x ie=%x\n",
-		       sw->select, sw->control, sw->status, sw->intr, sw->intr_enable);
-	}
 	out_8(&sw->control_bic, DO_SEEK);
 	out_8(&sw->select, RELAX);
 	out_8(&sw->intr_enable, 0);
-	if (fs->state == settling && swim3_readbit(fs, SEEK_COMPLETE)) {
-		/* printk(KERN_DEBUG "swim3: missed settling interrupt\n"); */
+	printk(KERN_ERR "swim3: seek timeout\n");
+	end_request(0);
+	fs->state = idle;
+	start_request(fs);
+}
+
+static void settle_timeout(unsigned long data)
+{
+	struct floppy_state *fs = (struct floppy_state *) data;
+	volatile struct swim3 *sw = fs->swim3;
+
+	fs->timeout_pending = 0;
+	if (swim3_readbit(fs, SEEK_COMPLETE)) {
+		out_8(&sw->select, RELAX);
 		fs->state = locating;
 		act(fs);
 		return;
 	}
-	printk(KERN_ERR "swim3: seek timeout\n");
+	out_8(&sw->select, RELAX);
+	if (fs->settle_time < 2*HZ) {
+		++fs->settle_time;
+		set_timeout(fs, 1, settle_timeout);
+		return;
+	}
+	printk(KERN_ERR "swim3: seek settle timeout\n");
 	end_request(0);
 	fs->state = idle;
 	start_request(fs);
@@ -586,9 +597,13 @@
 	struct dbdma_regs *dr = fs->dma;
 	struct dbdma_cmd *cp = fs->dma_cmd;
 	unsigned long s;
+	int n;

 	fs->timeout_pending = 0;
 	st_le32(&dr->control, RUN << 16);
+	/* We must wait a bit for dbdma to stop */
+	for (n = 0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
+		udelay(1);
 	out_8(&sw->intr_enable, 0);
 	out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 	out_8(&sw->select, RELAX);
@@ -607,6 +622,8 @@
 	start_request(fs);
 }

+static int max_wait_inactive;
+
 static void swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct floppy_state *fs = (struct floppy_state *) dev_id;
@@ -616,18 +633,15 @@
 	struct dbdma_regs *dr;
 	struct dbdma_cmd *cp;

-	err = in_8(&sw->error);
 	intr = in_8(&sw->intr);
-#if 0
-	printk("swim3 intr state=%d intr=%x err=%x\n", fs->state, intr, err);
-#endif
+	err = (intr & ERROR_INTR)? in_8(&sw->error): 0;
 	if ((intr & ERROR_INTR) && fs->state != do_transfer)
 		printk(KERN_ERR "swim3_interrupt, state=%d, cmd=%x, intr=%x, err=%x\n",
 		       fs->state, CURRENT->cmd, intr, err);
 	switch (fs->state) {
 	case locating:
 		if (intr & SEEN_SECTOR) {
-			out_8(&sw->control_bic, DO_ACTION);
+			out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 			out_8(&sw->select, RELAX);
 			out_8(&sw->intr_enable, 0);
 			del_timer(&fs->timeout);
@@ -677,19 +691,33 @@
 	case do_transfer:
 		if ((intr & (ERROR_INTR | TRANSFER_DONE)) == 0)
 			break;
-		dr = fs->dma;
-		cp = fs->dma_cmd;
-		/* We must wait a bit for dbdma to complete */
-		for (n=0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
-			udelay(10);
-		DBDMA_DO_STOP(dr);
 		out_8(&sw->intr_enable, 0);
 		out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 		out_8(&sw->select, RELAX);
 		del_timer(&fs->timeout);
 		fs->timeout_pending = 0;
+		dr = fs->dma;
+		cp = fs->dma_cmd;
 		if (CURRENT->cmd == WRITE)
 			++cp;
+		/*
+		 * Check that the main data transfer has finished.
+		 * On writing, the swim3 sometimes doesn't use
+		 * up all the bytes of the postamble, so we can still
+		 * see DMA active here.  That doesn't matter as long
+		 * as all the sector data has been transferred.
+		 */
+		if ((intr & ERROR_INTR) == 0 && cp->xfer_status == 0) {
+			/* wait a little while for DMA to complete */
+			for (n = 0; n < 100; ++n) {
+				if (cp->xfer_status != 0)
+					break;
+				udelay(1);
+				barrier();
+			}
+		}
+		/* turn off DMA */
+		out_le32(&dr->control, (RUN | PAUSE) << 16);
 		stat = ld_le16(&cp->xfer_status);
 		resid = ld_le16(&cp->res_count);
 		if (intr & ERROR_INTR) {
@@ -796,16 +824,19 @@
 	if (err)
 		return err;
 	swim3_action(fs, EJECT);
-	for (n = 2*HZ; n > 0; --n) {
-		if (swim3_readbit(fs, RELAX))
-			break;
+	for (n = 20; n > 0; --n) {
 		if (signal_pending(current)) {
 			err = -EINTR;
 			break;
 		}
+		swim3_select(fs, RELAX);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(1);
+		if (swim3_readbit(fs, DISK_IN) == 0)
+			break;
 	}
+	swim3_select(fs, RELAX);
+	udelay(150);
 	fs->ejected = 1;
 	release_drive(fs);
 	return err;
@@ -865,29 +896,31 @@
 	if (fs->ref_count == 0) {
 		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
 			return -ENXIO;
-		out_8(&sw->mode, 0x95);
-		out_8(&sw->control_bic, 0xff);
 		out_8(&sw->setup, S_IBM_DRIVE | S_FCLK_DIV2);
+		out_8(&sw->control_bic, 0xff);
+		out_8(&sw->mode, 0x95);
 		udelay(10);
 		out_8(&sw->intr_enable, 0);
 		out_8(&sw->control_bis, DRIVE_ENABLE | INTR_ENABLE);
 		swim3_action(fs, MOTOR_ON);
 		fs->write_prot = -1;
 		fs->cur_cyl = -1;
-		for (n = HZ; n > 0; --n) {
-			if (swim3_readbit(fs, SEEK_COMPLETE))
+		for (n = 0; n < 2 * HZ; ++n) {
+			if (n >= HZ/30 && swim3_readbit(fs, SEEK_COMPLETE))
 				break;
 			if (signal_pending(current)) {
 				err = -EINTR;
 				break;
 			}
+			swim3_select(fs, RELAX);
 			current->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(1);
 		}
 		if (err == 0 && (swim3_readbit(fs, SEEK_COMPLETE) == 0
 				 || swim3_readbit(fs, DISK_IN) == 0))
 			err = -ENXIO;
-		swim3_action(fs, 9);
+		swim3_action(fs, SETMFM);
+		swim3_select(fs, RELAX);

 	} else if (fs->ref_count == -1 || filp->f_flags & O_EXCL)
 		return -EBUSY;
@@ -910,6 +943,7 @@
 		if (fs->ref_count == 0) {
 			swim3_action(fs, MOTOR_OFF);
 			out_8(&sw->control_bic, DRIVE_ENABLE | INTR_ENABLE);
+			swim3_select(fs, RELAX);
 		}
 		return err;
 	}
@@ -936,6 +970,7 @@
 	if (fs->ref_count > 0 && --fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
 		out_8(&sw->control_bic, 0xff);
+		swim3_select(fs, RELAX);
 	}
 	return 0;
 }
@@ -970,15 +1005,17 @@
 	sw = fs->swim3;
 	grab_drive(fs, revalidating, 0);
 	out_8(&sw->intr_enable, 0);
-	out_8(&sw->control_bis, DRIVE_ENABLE | INTR_ENABLE);
-	swim3_action(fs, MOTOR_ON);
+	out_8(&sw->control_bis, DRIVE_ENABLE);
+	swim3_action(fs, MOTOR_ON);	/* necessary? */
 	fs->write_prot = -1;
 	fs->cur_cyl = -1;
+	mdelay(1);
 	for (n = HZ; n > 0; --n) {
 		if (swim3_readbit(fs, SEEK_COMPLETE))
 			break;
 		if (signal_pending(current))
 			break;
+		swim3_select(fs, RELAX);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(1);
 	}
@@ -988,8 +1025,9 @@
 		swim3_action(fs, MOTOR_OFF);
 	else {
 		fs->ejected = 0;
-		swim3_action(fs, 9);
+		swim3_action(fs, SETMFM);
 	}
+	swim3_select(fs, RELAX);

 	release_drive(fs);
 	return ret;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
