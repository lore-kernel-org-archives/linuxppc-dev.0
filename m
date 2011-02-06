Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by ozlabs.org (Postfix) with ESMTP id 7F889B70E3
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2011 10:45:31 +1100 (EST)
Message-Id: <20110206232253.421321729@pcw.home.local>
Date: Mon, 07 Feb 2011 00:23:13 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org, stable@kernel.org, stable-review@kernel.org
Subject: [PATCH 21/23] hvc_console: Fix race between hvc_close and hvc_remove
In-Reply-To: <4beed4da27f06efb2c13d6ed48850634@local>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
	linuxppc-dev@ozlabs.org, Amit Shah <amit.shah@redhat.com>,
	Willy Tarreau <w@1wt.eu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2.6.27.58-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Amit Shah <amit.shah@redhat.com>

commit e74d098c66543d0731de62eb747ccd5b636a6f4c upstream.

Alan pointed out a race in the code where hvc_remove is invoked. The
recent virtio_console work is the first user of hvc_remove().

Alan describes it thus:

The hvc_console assumes that a close and remove call can't occur at the
same time.

In addition tty_hangup(tty) is problematic as tty_hangup is asynchronous
itself....

So this can happen

        hvc_close                               hvc_remove
        hung up ? - no
                                                lock
                                                tty = hp->tty
                                                unlock
        lock
        hp->tty = NULL
        unlock
        notify del
        kref_put the hvc struct
        close completes
        tty is destroyed
                                                tty_hangup dead tty
                                                tty->ops will be NULL
                                                NULL->...

This patch adds some tty krefs and also converts to using tty_vhangup().

Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linuxppc-dev@ozlabs.org
CC: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
 drivers/char/hvc_console.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

Index: longterm-2.6.27/drivers/char/hvc_console.c
===================================================================
--- longterm-2.6.27.orig/drivers/char/hvc_console.c	2011-01-23 10:52:15.000000000 +0100
+++ longterm-2.6.27/drivers/char/hvc_console.c	2011-01-29 15:33:05.169065818 +0100
@@ -312,6 +312,7 @@
 	spin_lock_irqsave(&hp->lock, flags);
 	/* Check and then increment for fast path open. */
 	if (hp->count++ > 0) {
+		tty_kref_get(tty);
 		spin_unlock_irqrestore(&hp->lock, flags);
 		hvc_kick();
 		return 0;
@@ -320,7 +321,7 @@
 	tty->driver_data = hp;
 	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
 
-	hp->tty = tty;
+	hp->tty = tty_kref_get(tty);
 
 	spin_unlock_irqrestore(&hp->lock, flags);
 
@@ -337,6 +338,7 @@
 		spin_lock_irqsave(&hp->lock, flags);
 		hp->tty = NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
+		tty_kref_put(tty);
 		tty->driver_data = NULL;
 		kref_put(&hp->kref, destroy_hvc_struct);
 		printk(KERN_ERR "hvc_open: request_irq failed with rc %d.\n", rc);
@@ -364,13 +366,18 @@
 		return;
 
 	hp = tty->driver_data;
+
 	spin_lock_irqsave(&hp->lock, flags);
+	tty_kref_get(tty);
 
 	if (--hp->count == 0) {
 		/* We are done with the tty pointer now. */
 		hp->tty = NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		/* Put the ref obtained in hvc_open() */
+		tty_kref_put(tty);
+
 		if (hp->ops->notifier_del)
 			hp->ops->notifier_del(hp, hp->data);
 
@@ -387,6 +394,7 @@
 		spin_unlock_irqrestore(&hp->lock, flags);
 	}
 
+	tty_kref_put(tty);
 	kref_put(&hp->kref, destroy_hvc_struct);
 }
 
@@ -423,6 +431,7 @@
 
 	while(temp_open_count) {
 		--temp_open_count;
+		tty_kref_put(tty);
 		kref_put(&hp->kref, destroy_hvc_struct);
 	}
 }
@@ -550,7 +559,7 @@
 		poll_mask |= HVC_POLL_WRITE;
 
 	/* No tty attached, just skip */
-	tty = hp->tty;
+	tty = tty_kref_get(hp->tty);
 	if (tty == NULL)
 		goto bail;
 
@@ -627,6 +636,8 @@
 
 		tty_flip_buffer_push(tty);
 	}
+	if (tty)
+		tty_kref_put(tty);
 
 	return poll_mask;
 }
@@ -749,7 +760,7 @@
 	struct tty_struct *tty;
 
 	spin_lock_irqsave(&hp->lock, flags);
-	tty = hp->tty;
+	tty = tty_kref_get(hp->tty);
 
 	if (hp->index < MAX_NR_HVC_CONSOLES)
 		vtermnos[hp->index] = -1;
@@ -761,18 +772,18 @@
 	/*
 	 * We 'put' the instance that was grabbed when the kref instance
 	 * was initialized using kref_init().  Let the last holder of this
-	 * kref cause it to be removed, which will probably be the tty_hangup
+	 * kref cause it to be removed, which will probably be the tty_vhangup
 	 * below.
 	 */
 	kref_put(&hp->kref, destroy_hvc_struct);
 
 	/*
-	 * This function call will auto chain call hvc_hangup.  The tty should
-	 * always be valid at this time unless a simultaneous tty close already
-	 * cleaned up the hvc_struct.
+	 * This function call will auto chain call hvc_hangup.
 	 */
-	if (tty)
-		tty_hangup(tty);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
 	return 0;
 }
 
