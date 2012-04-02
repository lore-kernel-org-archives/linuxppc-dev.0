Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 15922B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 22:02:11 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 40/69] TTY: hvcs, add tty_port
Date: Mon,  2 Apr 2012 13:54:24 +0200
Message-Id: <1333367693-3244-41-git-send-email-jslaby@suse.cz>
In-Reply-To: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
References: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
Cc: jirislaby@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And use count from there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvcs.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 3436436..a049ced 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -261,6 +261,7 @@ static DEFINE_SPINLOCK(hvcs_pi_lock);
 
 /* One vty-server per hvcs_struct */
 struct hvcs_struct {
+	struct tty_port port;
 	spinlock_t lock;
 
 	/*
@@ -270,7 +271,6 @@ struct hvcs_struct {
 	unsigned int index;
 
 	struct tty_struct *tty;
-	int open_count;
 
 	/*
 	 * Used to tell the driver kernel_thread what operations need to take
@@ -422,7 +422,7 @@ static ssize_t hvcs_vterm_state_store(struct device *dev, struct device_attribut
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 
-	if (hvcsd->open_count > 0) {
+	if (hvcsd->port.count > 0) {
 		spin_unlock_irqrestore(&hvcsd->lock, flags);
 		printk(KERN_INFO "HVCS: vterm state unchanged.  "
 				"The hvcs device node is still in use.\n");
@@ -789,7 +789,7 @@ static int __devinit hvcs_probe(
 	if (!hvcsd)
 		return -ENODEV;
 
-
+	tty_port_init(&hvcsd->port);
 	spin_lock_init(&hvcsd->lock);
 	/* Automatically incs the refcount the first time */
 	kref_init(&hvcsd->kref);
@@ -1138,7 +1138,7 @@ static int hvcs_open(struct tty_struct *tty, struct file *filp)
 		if ((retval = hvcs_partner_connect(hvcsd)))
 			goto error_release;
 
-	hvcsd->open_count = 1;
+	hvcsd->port.count = 1;
 	hvcsd->tty = tty;
 	tty->driver_data = hvcsd;
 
@@ -1172,7 +1172,7 @@ fast_open:
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 	kref_get(&hvcsd->kref);
-	hvcsd->open_count++;
+	hvcsd->port.count++;
 	hvcsd->todo_mask |= HVCS_SCHED_READ;
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 
@@ -1216,7 +1216,7 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 	hvcsd = tty->driver_data;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
-	if (--hvcsd->open_count == 0) {
+	if (--hvcsd->port.count == 0) {
 
 		vio_disable_interrupts(hvcsd->vdev);
 
@@ -1242,10 +1242,10 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 		free_irq(irq, hvcsd);
 		kref_put(&hvcsd->kref, destroy_hvcs_struct);
 		return;
-	} else if (hvcsd->open_count < 0) {
+	} else if (hvcsd->port.count < 0) {
 		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d"
 				" is missmanaged.\n",
-		hvcsd->vdev->unit_address, hvcsd->open_count);
+		hvcsd->vdev->unit_address, hvcsd->port.count);
 	}
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
@@ -1261,7 +1261,7 @@ static void hvcs_hangup(struct tty_struct * tty)
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 	/* Preserve this so that we know how many kref refs to put */
-	temp_open_count = hvcsd->open_count;
+	temp_open_count = hvcsd->port.count;
 
 	/*
 	 * Don't kref put inside the spinlock because the destruction
@@ -1276,7 +1276,7 @@ static void hvcs_hangup(struct tty_struct * tty)
 	hvcsd->tty->driver_data = NULL;
 	hvcsd->tty = NULL;
 
-	hvcsd->open_count = 0;
+	hvcsd->port.count = 0;
 
 	/* This will drop any buffered data on the floor which is OK in a hangup
 	 * scenario. */
@@ -1347,7 +1347,7 @@ static int hvcs_write(struct tty_struct *tty,
 	 * the middle of a write operation?  This is a crummy place to do this
 	 * but we want to keep it all in the spinlock.
 	 */
-	if (hvcsd->open_count <= 0) {
+	if (hvcsd->port.count <= 0) {
 		spin_unlock_irqrestore(&hvcsd->lock, flags);
 		return -ENODEV;
 	}
@@ -1421,7 +1421,7 @@ static int hvcs_write_room(struct tty_struct *tty)
 {
 	struct hvcs_struct *hvcsd = tty->driver_data;
 
-	if (!hvcsd || hvcsd->open_count <= 0)
+	if (!hvcsd || hvcsd->port.count <= 0)
 		return 0;
 
 	return HVCS_BUFF_LEN - hvcsd->chars_in_buffer;
-- 
1.7.9.2
