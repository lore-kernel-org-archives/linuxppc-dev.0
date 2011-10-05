Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E174B6FF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 04:49:06 +1100 (EST)
From: Miche Baker-Harvey <miche@google.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] hvc_console: display printk messages on console.
Date: Wed,  5 Oct 2011 10:48:51 -0700
Message-Id: <1317836931-17534-1-git-send-email-miche@google.com>
Cc: Miche Baker-Harvey <miche@google.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

printk only works for "registered consoles."  Currently, the hvc_console
code calls register_console() from hvc_instantiate(), but that's only
used in the early console case.  In hvc_alloc(), register_console() was
not called.

Add a call to register_console() in hvc_alloc(), set up the index in
the hvc_console, and set up the necessary vtermnos[] and cons_op[]
entries so that printk functions work.

Signed-off-by: Miche Baker-Harvey <miche@google.com>

---

However, I'm not sure how this is supposed to be working, and not at all
sure how this should tie in with command line selection of the console,
or if there are other related issues I may have missed.  I'd really
appreciate your comments.
---
 drivers/tty/hvc/hvc_console.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index e9cba13..6add6cd 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -790,7 +790,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	 * find index to use:
 	 * see if this vterm id matches one registered for console.
 	 */
-	for (i=0; i < MAX_NR_HVC_CONSOLES; i++)
+	for (i = 0; i < MAX_NR_HVC_CONSOLES; i++)
 		if (vtermnos[i] == hp->vtermno &&
 		    cons_ops[i] == hp->ops)
 			break;
@@ -800,9 +800,13 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 		i = ++last_hvc;
 
 	hp->index = i;
+	hvc_console.index = i;
+	vtermnos[i] = vtermno;
+	cons_ops[i] = ops;
 
 	list_add_tail(&(hp->next), &hvc_structs);
 	spin_unlock(&hvc_structs_lock);
+	register_console(&hvc_console);
 
 	return hp;
 }
@@ -813,6 +817,7 @@ int hvc_remove(struct hvc_struct *hp)
 	unsigned long flags;
 	struct tty_struct *tty;
 
+	unregister_console(&hvc_console);
 	spin_lock_irqsave(&hp->lock, flags);
 	tty = tty_kref_get(hp->tty);
 
-- 
1.7.3.1
