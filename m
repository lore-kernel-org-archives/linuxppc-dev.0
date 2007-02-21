Return-Path: <akpm@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD121DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 10:21:00 +1100 (EST)
Date: Wed, 21 Feb 2007 15:20:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/4 (final?)] ps3fb: thread updates
Message-Id: <20070221152047.0d3da74c.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.62.0702201141000.20432@pademelon.sonytel.be>
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
	<Pine.LNX.4.62.0702201141000.20432@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 20 Feb 2007 11:42:04 +0100 (CET)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> ps3fb: Replace the kernel_thread and the semaphore by a proper kthread, which is
> simply woken up when the screen must be updated

<goes off and generates the incremental diff again so we can see what changed>


diff -puN drivers/video/ps3fb.c~ps3fb-thread-updates-2 drivers/video/ps3fb.c
--- a/drivers/video/ps3fb.c~ps3fb-thread-updates-2
+++ a/drivers/video/ps3fb.c
@@ -32,7 +32,6 @@
 #include <linux/ioctl.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
-#include <linux/freezer.h>
 #include <linux/kthread.h>
 
 #include <asm/uaccess.h>
@@ -808,16 +807,13 @@ static int ps3fb_ioctl(struct fb_info *i
 
 static int ps3fbd(void *arg)
 {
-	DEFINE_WAIT(wait);
-	DECLARE_WAIT_QUEUE_HEAD(wq);
-
 	while (!kthread_should_stop()) {
-		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
-		if (!ps3fb.is_kicked)
-			schedule();
-		finish_wait(&wq, &wait);
-		ps3fb.is_kicked = 0;
-		ps3fb_sync(0);	/* single buffer */
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (ps3fb.is_kicked) {
+			ps3fb.is_kicked = 0;
+			ps3fb_sync(0);	/* single buffer */
+		}
+		schedule();
 	}
 	return 0;
 }
_

There's still no try_to_freeze() in there.  Shouldn't we have one?
