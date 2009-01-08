Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D8E95DE3D4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:17:00 +1100 (EST)
Subject: [PATCH 1/4] hvc_console: do not set low_latency
From: Milton Miller <miltonm@bga.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Benjiman Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <hvc-console-29-3-1@bga.com>
In-Reply-To: : <hvc-console-29-3@bga.com>
Date: Thu, 08 Jan 2009 06:14:24 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Joe Peterson <joe@skyrush.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hvc_console is setting low_latency unconditionally, but some clients are
interrupt driven and will call hvc_poll from irq context.  This will cause
tty_flip_buffer_push to be called from irq context, and it very clearly
states it must not be called from IRQ when low_latency is specified.

Looking back through history:
v2.6.16-rc1 via 33f0f88f1c51ae5c2d593d26960c760ea154c2e2
    [PATCH] TTY layer buffering revamp

added this new api.

v2.6.16-rc3 via 8977d929e49021d9a6e031310aab01fa72f849c2
    [PATCH] tty buffering stall fix

claims to fix a stall discovered with hvc_console

v2.6.16-rc5 via fb5c594c2acc441f0d2d8f457484a0e0e9285db3
   [PATCH] Fix race condition in hvc console.

said set this flag to avoid a stall problem, and was merged through
the powerpc arch tree.

Without searching for email discussions, it would appear to be an
overlapping "fix", but one that did not consider all users.

---
This version continues to set low_latency if irqs are not flagged to
be in use, as requested by paulus.   Do all hvc drivers identify the
interrupt this way?  (A quick look at hvc_iucv says they lock to bh
and are not irq driven, the rest would have used the irq before that
patch).

Having the flag set for purely polled drivers will save delaying
the work when receiving input for 1 jiffie.


Index: work.git/drivers/char/hvc_console.c
===================================================================
--- work.git.orig/drivers/char/hvc_console.c	2009-01-08 03:01:24.000000000 -0600
+++ work.git/drivers/char/hvc_console.c	2009-01-08 03:01:51.000000000 -0600
@@ -318,7 +318,8 @@ static int hvc_open(struct tty_struct *t
 	} /* else count == 0 */
 
 	tty->driver_data = hp;
-	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
+	if (!hp->irq_requested)
+		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
 
 	hp->tty = tty;
 
