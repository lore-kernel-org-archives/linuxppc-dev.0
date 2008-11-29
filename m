Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 23F71DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 21:57:40 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so693521eyi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 02:57:37 -0800 (PST)
Message-ID: <4931201D.7060701@gmail.com>
Date: Sat, 29 Nov 2008 05:57:33 -0500
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: powerpc: hv{cs,
	si}_close() both unsigned hp->count and hvcsd->open_count
	cannot be negative
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

unsigned hp->count and hvcsd->open_count cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Both members of respectively struct hvcs_struct, see
vi drivers/char/hvcs.c +262

and struct hvcs_struct, see
vi drivers/char/hvsi.c +70

diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
index 473d9b1..b228b84 100644
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -1222,7 +1222,8 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 	hvcsd = tty->driver_data;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
-	if (--hvcsd->open_count == 0) {
+	if (hvcsd->open_count == 1) {
+		hvcsd->open_count--;
 
 		vio_disable_interrupts(hvcsd->vdev);
 
@@ -1248,7 +1249,9 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 		free_irq(irq, hvcsd);
 		kref_put(&hvcsd->kref, destroy_hvcs_struct);
 		return;
-	} else if (hvcsd->open_count < 0) {
+	} else if (hvcsd->open_count > 1) {
+		hvcsd->open_count--;
+	} else {
 		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d"
 				" is missmanaged.\n",
 		hvcsd->vdev->unit_address, hvcsd->open_count);
diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
index 59c6f9a..d46bccd 100644
--- a/drivers/char/hvsi.c
+++ b/drivers/char/hvsi.c
@@ -875,7 +875,8 @@ static void hvsi_close(struct tty_struct *tty, struct file *filp)
 
 	spin_lock_irqsave(&hp->lock, flags);
 
-	if (--hp->count == 0) {
+	if (hp->count == 1) {
+		hp->count--;
 		hp->tty = NULL;
 		hp->inbuf_end = hp->inbuf; /* discard remaining partial packets */
 
@@ -908,7 +909,9 @@ static void hvsi_close(struct tty_struct *tty, struct file *filp)
 
 			spin_lock_irqsave(&hp->lock, flags);
 		}
-	} else if (hp->count < 0)
+	} else if (hp->count > 1)
+		hp->count--;
+	else
 		printk(KERN_ERR "hvsi_close %lu: oops, count is %d\n",
 		       hp - hvsi_ports, hp->count);
 
