Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C9637DE0E4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:15:04 +1100 (EST)
Subject: [PATCH 4/4] hvc_console: comment mb and make it an smp_ one
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Benjiman Herrenschmidt <benh@kernel.crashing.org>
From: Milton Miller <miltonm@bga.com>
Message-Id: <hvc-console-29-3-4@bga.com>
In-Reply-To: : <hvc-console-29-3@bga.com>
Date: Thu, 08 Jan 2009 06:14:18 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I remember some history on this barrier.  There was a race between
open via /dev/console and the tty being fully setup.  Its also why
there is a temporary variable and the global is assigned at the end
of the function.

Signed-off-by: Milton Miller <miltonm@bga.com>


Index: work.git/drivers/char/hvc_console.c
===================================================================
--- work.git.orig/drivers/char/hvc_console.c	2009-01-08 04:33:39.000000000 -0600
+++ work.git/drivers/char/hvc_console.c	2009-01-08 04:35:09.000000000 -0600
@@ -875,8 +875,11 @@ static int hvc_init(void)
 		goto stop_thread;
 	}
 
-	/* FIXME: This mb() seems completely random.  Remove it. */
-	mb();
+	/*
+	 * Make sure tty is fully registered before allowing it to be
+	 * found by hvc_console_device.
+	 */
+	smp_mb();
 	hvc_driver = drv;
 	return 0;
 
