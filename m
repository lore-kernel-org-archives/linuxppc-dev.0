Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 22EFF67B75
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 06:19:10 +1000 (EST)
Date: Thu, 7 Sep 2006 15:18:08 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Quiet hvc_console console output on failed opens
Message-ID: <20060907151808.2295ad9a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Please consider for the 2.6.19 queue:



No other tty driver will print on the console when the open of it fails.

On systems that happen to be configured for both ttyS0 and hvc0 console,
this will keep flooding the console output.  This is most likely to
happen with systems booted between with and without hypervisor from the
same filesystem.

Let's just remove it. When it's really needed (i.e. when the open fails
and someone is trying to debug it), noone will see the output anyway. And
init will report the opens failing in due time through the syslog.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/drivers/char/hvc_console.c
===================================================================
--- merge.orig/drivers/char/hvc_console.c
+++ merge/drivers/char/hvc_console.c
@@ -320,10 +320,8 @@ static int hvc_open(struct tty_struct *t
 	struct kobject *kobjp;
 
 	/* Auto increments kobject reference if found. */
-	if (!(hp = hvc_get_by_index(tty->index))) {
-		printk(KERN_WARNING "hvc_console: tty open failed, no vty associated with tty.\n");
+	if (!(hp = hvc_get_by_index(tty->index)))
 		return -ENODEV;
-	}
 
 	spin_lock_irqsave(&hp->lock, flags);
 	/* Check and then increment for fast path open. */
