Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 73D2AB7080
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 22:47:53 +1100 (EST)
From: Amit Shah <amit.shah@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hvc_console: Fix a race between hvc_close and hvc_remove
Date: Fri, 26 Feb 2010 17:16:26 +0530
Message-Id: <1267184786-4377-1-git-send-email-amit.shah@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org,
	Rusty Russell <rusty@rustcorp.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

This patch adds some tty krefs and also converts to using tty_vhangup()
before putting the tty kref.

Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linuxppc-dev@ozlabs.org
CC: Rusty Russell <rusty@rustcorp.com.au>
---

I can't be sure if this is all that's needed. tty people, please take
a look!

 drivers/char/hvc_console.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index d8dac58..3983e32 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -106,6 +106,7 @@ static struct hvc_struct *hvc_get_by_index(int index)
 		spin_lock_irqsave(&hp->lock, flags);
 		if (hp->index == index) {
 			kref_get(&hp->kref);
+			tty_kref_get(hp->tty);
 			spin_unlock_irqrestore(&hp->lock, flags);
 			spin_unlock(&hvc_structs_lock);
 			return hp;
@@ -390,6 +391,7 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 	}
 
 	kref_put(&hp->kref, destroy_hvc_struct);
+	tty_kref_put(tty);
 }
 
 static void hvc_hangup(struct tty_struct *tty)
@@ -806,6 +808,7 @@ int hvc_remove(struct hvc_struct *hp)
 	unsigned long flags;
 	struct tty_struct *tty;
 
+	tty_kref_get(hp->tty);
 	spin_lock_irqsave(&hp->lock, flags);
 	tty = hp->tty;
 
@@ -830,7 +833,9 @@ int hvc_remove(struct hvc_struct *hp)
 	 * cleaned up the hvc_struct.
 	 */
 	if (tty)
-		tty_hangup(tty);
+		tty_vhangup(tty);
+
+	tty_kref_put(hp->tty);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hvc_remove);
-- 
1.6.2.5
