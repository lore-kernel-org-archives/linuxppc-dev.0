Date: Fri, 4 Jul 2003 12:46:16 +0200
From: Jasper Spaans <jasper@vs19.net>
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: cleanup of linux-2.5/drivers/block/swim3.c
Message-ID: <20030704104616.GA29229@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hello,

Attached is a patch which should solve compilation issues related to the new
irqhandler interface, and the deprecation of cli()/sti() for the
swim3-driver.

Can you take a look, and possibly, apply this? (I don't have any hardware to
test this on, however it compiles)

VrGr,
--
Jasper Spaans [not on the linuxppc-dev list, so please Cc me]


<==          ``Got no clue? Too bad for you''          ==>
<==                                                    ==>
--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="swim3.c.diff"

--- linux-2.5-ppc/drivers/block/swim3.c	2003-07-04 12:36:52.000000000 +0200
+++ linux-2.5-ppc/drivers/block/swim3.c-new	2003-07-04 12:32:32.000000000 +0200
@@ -26,6 +26,9 @@
 #include <linux/ioctl.h>
 #include <linux/blk.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
@@ -234,7 +237,7 @@
 static void scan_timeout(unsigned long data);
 static void seek_timeout(unsigned long data);
 static void xfer_timeout(unsigned long data);
-static void swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 /*static void fd_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs);*/
 static int grab_drive(struct floppy_state *fs, enum swim_state state,
 		      int interruptible);
@@ -300,7 +303,6 @@
 			continue;
 		start_request(&floppy_states[i]);
 	}
-	sti();
 }

 static void start_request(struct floppy_state *fs)
@@ -359,9 +361,7 @@
 static void set_timeout(struct floppy_state *fs, int nticks,
 			void (*proc)(unsigned long))
 {
-	unsigned long flags;
-
-	save_flags(flags); cli();
+	spin_lock_irq(&swim3_lock);
 	if (fs->timeout_pending)
 		del_timer(&fs->timeout);
 	fs->timeout.expires = jiffies + nticks;
@@ -369,7 +369,7 @@
 	fs->timeout.data = (unsigned long) fs;
 	add_timer(&fs->timeout);
 	fs->timeout_pending = 1;
-	restore_flags(flags);
+	spin_unlock_irq(&swim3_lock);
 }

 static inline void scan_track(struct floppy_state *fs)
@@ -605,7 +605,7 @@
 	start_request(fs);
 }

-static void swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct floppy_state *fs = (struct floppy_state *) dev_id;
 	volatile struct swim3 *sw = fs->swim3;
@@ -613,6 +613,9 @@
 	int stat, resid;
 	struct dbdma_regs *dr;
 	struct dbdma_cmd *cp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&swim3_lock, flags);

 	err = in_8(&sw->error);
 	intr = in_8(&sw->intr);
@@ -742,7 +745,13 @@
 		break;
 	default:
 		printk(KERN_ERR "swim3: don't know what to do in state %d\n", fs->state);
+#if 0
+		spin_unlock_irqrestore(&swim3_lock, flags);
+		return IRQ_NONE;
+#endif
 	}
+	spin_unlock_irqrestore(&swim3_lock, flags);
+	return IRQ_HANDLED;
 }

 /*
@@ -754,16 +763,14 @@
 static int grab_drive(struct floppy_state *fs, enum swim_state state,
 		      int interruptible)
 {
-	unsigned long flags;
-
-	save_flags(flags);
-	cli();
+	spin_lock_irq(&swim3_lock);
+
 	if (fs->state != idle) {
 		++fs->wanted;
 		while (fs->state != available) {
 			if (interruptible && signal_pending(current)) {
 				--fs->wanted;
-				restore_flags(flags);
+				spin_unlock_irq(&swim3_lock);
 				return -EINTR;
 			}
 			interruptible_sleep_on(&fs->wait);
@@ -771,19 +778,17 @@
 		--fs->wanted;
 	}
 	fs->state = state;
-	restore_flags(flags);
+	spin_unlock_irq(&swim3_lock);
 	return 0;
 }

 static void release_drive(struct floppy_state *fs)
 {
-	unsigned long flags;
+	spin_lock_irq(&swim3_lock);

-	save_flags(flags);
-	cli();
 	fs->state = idle;
 	start_request(fs);
-	restore_flags(flags);
+	spin_unlock_irq(&swim3_lock);
 }

 static int fd_eject(struct floppy_state *fs)
@@ -959,10 +964,6 @@
 	return ret;
 }

-static void floppy_off(unsigned int nr)
-{
-}
-
 static struct block_device_operations floppy_fops = {
 	.open		= floppy_open,
 	.release	= floppy_release,

--oyUTqETQ0mS9luUI--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
