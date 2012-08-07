Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E2A0F2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 06:02:17 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 41/41] TTY: hvcs, add tty install
Date: Tue,  7 Aug 2012 21:48:06 +0200
Message-Id: <1344368886-24033-42-git-send-email-jslaby@suse.cz>
In-Reply-To: <1344368886-24033-1-git-send-email-jslaby@suse.cz>
References: <1344368886-24033-1-git-send-email-jslaby@suse.cz>
Cc: jirislaby@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This has two outcomes:
* we give the TTY layer a tty_port
* we do not find the info structure every time open is called on that
  tty

>From now on, we only increase the reference count in ->install (and
decrease in ->cleanup).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvcs.c |   52 ++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 6f5c3be..cab5c7a 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1102,11 +1102,7 @@ static struct hvcs_struct *hvcs_get_by_index(int index)
 	return NULL;
 }
 
-/*
- * This is invoked via the tty_open interface when a user app connects to the
- * /dev node.
- */
-static int hvcs_open(struct tty_struct *tty, struct file *filp)
+static int hvcs_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct hvcs_struct *hvcsd;
 	struct vio_dev *vdev;
@@ -1114,9 +1110,6 @@ static int hvcs_open(struct tty_struct *tty, struct file *filp)
 	unsigned int irq;
 	int retval;
 
-	if (tty->driver_data)
-		goto fast_open;
-
 	/*
 	 * Is there a vty-server that shares the same index?
 	 * This function increments the kref index.
@@ -1139,7 +1132,7 @@ static int hvcs_open(struct tty_struct *tty, struct file *filp)
 		}
 	}
 
-	hvcsd->port.count = 1;
+	hvcsd->port.count = 0;
 	hvcsd->port.tty = tty;
 	tty->driver_data = hvcsd;
 
@@ -1166,28 +1159,42 @@ static int hvcs_open(struct tty_struct *tty, struct file *filp)
 		goto err_put;
 	}
 
-	goto open_success;
+	retval = tty_port_install(&hvcsd->port, driver, tty);
+	if (retval)
+		goto err_irq;
 
-fast_open:
-	hvcsd = tty->driver_data;
+	return 0;
+err_irq:
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	vio_disable_interrupts(hvcsd->vdev);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	free_irq(irq, hvcsd);
+err_put:
+	tty_port_put(&hvcsd->port);
+
+	return retval;
+}
+
+/*
+ * This is invoked via the tty_open interface when a user app connects to the
+ * /dev node.
+ */
+static int hvcs_open(struct tty_struct *tty, struct file *filp)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned long flags;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
-	tty_port_get(&hvcsd->port);
 	hvcsd->port.count++;
 	hvcsd->todo_mask |= HVCS_SCHED_READ;
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 
-open_success:
 	hvcs_kick();
 
 	printk(KERN_INFO "HVCS: vty-server@%X connection opened.\n",
 		hvcsd->vdev->unit_address );
 
 	return 0;
-err_put:
-	tty_port_put(&hvcsd->port);
-
-	return retval;
 }
 
 static void hvcs_close(struct tty_struct *tty, struct file *filp)
@@ -1238,7 +1245,6 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 		tty->driver_data = NULL;
 
 		free_irq(irq, hvcsd);
-		tty_port_put(&hvcsd->port);
 		return;
 	} else if (hvcsd->port.count < 0) {
 		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d"
@@ -1247,6 +1253,12 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 	}
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
+}
+
+static void hvcs_cleanup(struct tty_struct * tty)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+
 	tty_port_put(&hvcsd->port);
 }
 
@@ -1433,8 +1445,10 @@ static int hvcs_chars_in_buffer(struct tty_struct *tty)
 }
 
 static const struct tty_operations hvcs_ops = {
+	.install = hvcs_install,
 	.open = hvcs_open,
 	.close = hvcs_close,
+	.cleanup = hvcs_cleanup,
 	.hangup = hvcs_hangup,
 	.write = hvcs_write,
 	.write_room = hvcs_write_room,
-- 
1.7.10.4
