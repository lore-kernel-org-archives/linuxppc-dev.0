Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 0BEDBDDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 23:41:51 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so703857eyi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 04:41:49 -0800 (PST)
Message-ID: <4931387C.4000001@gmail.com>
Date: Sat, 29 Nov 2008 07:41:32 -0500
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: hvc_close() unsigned hp->count cannot be negative
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

unsigned hp->count cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Similar to the previous patch but with lock. For hvc_struct, see
vi drivers/char/hvc_console.h +47

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 5b819b1..337f6c6 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -366,7 +366,8 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 	hp = tty->driver_data;
 	spin_lock_irqsave(&hp->lock, flags);
 
-	if (--hp->count == 0) {
+	if (hp->count == 1) {
+		hp->count--;
 		/* We are done with the tty pointer now. */
 		hp->tty = NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
@@ -384,7 +385,9 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		 */
 		tty_wait_until_sent(tty, HVC_CLOSE_WAIT);
 	} else {
-		if (hp->count < 0)
+		if (hp->count > 1)
+			hp->count--;
+		else
 			printk(KERN_ERR "hvc_close %X: oops, count is %d\n",
 				hp->vtermno, hp->count);
 		spin_unlock_irqrestore(&hp->lock, flags);
