Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA84F2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 06:02:13 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 39/41] TTY: hvc_console, add tty install
Date: Tue,  7 Aug 2012 21:48:04 +0200
Message-Id: <1344368886-24033-40-git-send-email-jslaby@suse.cz>
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

Since we take a reference to a port in ->install, we need also
->cleanup to drop that reference.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvc_console.c |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 2d691eb..7f80f15 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -299,20 +299,33 @@ static void hvc_unthrottle(struct tty_struct *tty)
 	hvc_kick();
 }
 
+static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct hvc_struct *hp;
+	int rc;
+
+	/* Auto increments kref reference if found. */
+	if (!(hp = hvc_get_by_index(tty->index)))
+		return -ENODEV;
+
+	tty->driver_data = hp;
+
+	rc = tty_port_install(&hp->port, driver, tty);
+	if (rc)
+		tty_port_put(&hp->port);
+	return rc;
+}
+
 /*
  * The TTY interface won't be used until after the vio layer has exposed the vty
  * adapter to the kernel.
  */
 static int hvc_open(struct tty_struct *tty, struct file * filp)
 {
-	struct hvc_struct *hp;
+	struct hvc_struct *hp = tty->driver_data;
 	unsigned long flags;
 	int rc = 0;
 
-	/* Auto increments kref reference if found. */
-	if (!(hp = hvc_get_by_index(tty->index)))
-		return -ENODEV;
-
 	spin_lock_irqsave(&hp->port.lock, flags);
 	/* Check and then increment for fast path open. */
 	if (hp->port.count++ > 0) {
@@ -322,7 +335,6 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 	} /* else count == 0 */
 	spin_unlock_irqrestore(&hp->port.lock, flags);
 
-	tty->driver_data = hp;
 	tty_port_tty_set(&hp->port, tty);
 
 	if (hp->ops->notifier_add)
@@ -389,6 +401,11 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 				hp->vtermno, hp->port.count);
 		spin_unlock_irqrestore(&hp->port.lock, flags);
 	}
+}
+
+static void hvc_cleanup(struct tty_struct *tty)
+{
+	struct hvc_struct *hp = tty->driver_data;
 
 	tty_port_put(&hp->port);
 }
@@ -792,8 +809,10 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
 #endif
 
 static const struct tty_operations hvc_ops = {
+	.install = hvc_install,
 	.open = hvc_open,
 	.close = hvc_close,
+	.cleanup = hvc_cleanup,
 	.write = hvc_write,
 	.hangup = hvc_hangup,
 	.unthrottle = hvc_unthrottle,
-- 
1.7.10.4
