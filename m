Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DEBF8B7B8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 21:45:46 +1000 (EST)
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.17.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 126BDDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 21:45:45 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7RBjUba030573
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 11:45:30 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n7RBjUIS2408478
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 13:45:30 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n7RBjTsb014963
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 13:45:30 +0200
Date: Thu, 27 Aug 2009 13:45:39 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] hvc_console: provide (un)locked version for hvc_resize()
Message-ID: <20090827114538.GC5257@cetus.boeblingen.de.ibm.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
	<20090827100809.5f0aa0a7@linux.intel.com>
	<1251365243.20467.47.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1251365243.20467.47.camel@pasglop>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	qemu-devel@nongnu.org, miltonm@bga.com,
	virtualization@lists.linux-foundation.org,
	borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com,
	Amit Shah <amit.shah@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 27, 2009 at 07:27:23PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-08-27 at 10:08 +0100, Alan Cox wrote:
> So at this stage, I think the reasonably thing to do is to stick to the
> spinlock, but we can try to make it a bit smarter, and we can definitely
> attempt to fix the case Amit pointed out where we call resize without a
> lock while it seems to expect it (though we also need to be careful
> about re-entrancy I believe).

I have worked on a patch for providing a locked hvc_resize() function.
Since only two back-ends (virtio_console and hvc_iucv) use the function,
I decided to update my hvc_iucv back-end through renaming the function
call as follows:

Rename the locking free hvc_resize() function to __hvc_resize() and
provide an inline function that locks the hvc_struct and calls
__hvc_resize().

The rationale for this patch is that virtio_console calls the hvc_resize()
function without locking the hvc_struct.
According to naming rules, the unlocked version is renamed and
prefixed with "__".
References to unlocked function calls in hvc back-ends has been updated.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/char/hvc_console.c |    6 +++---
 drivers/char/hvc_console.h |   12 +++++++++++-
 drivers/char/hvc_iucv.c    |    4 +++-
 3 files changed, 17 insertions(+), 5 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -680,7 +680,7 @@ int hvc_poll(struct hvc_struct *hp)
 EXPORT_SYMBOL_GPL(hvc_poll);
 
 /**
- * hvc_resize() - Update terminal window size information.
+ * __hvc_resize() - Update terminal window size information.
  * @hp:		HVC console pointer
  * @ws:		Terminal window size structure
  *
@@ -689,12 +689,12 @@ EXPORT_SYMBOL_GPL(hvc_poll);
  *
  * Locking:	Locking free; the function MUST be called holding hp->lock
  */
-void hvc_resize(struct hvc_struct *hp, struct winsize ws)
+void __hvc_resize(struct hvc_struct *hp, struct winsize ws)
 {
 	hp->ws = ws;
 	schedule_work(&hp->tty_resize);
 }
-EXPORT_SYMBOL_GPL(hvc_resize);
+EXPORT_SYMBOL_GPL(__hvc_resize);
 
 /*
  * This kthread is either polling or interrupt driven.  This is determined by
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -28,6 +28,7 @@
 #define HVC_CONSOLE_H
 #include <linux/kref.h>
 #include <linux/tty.h>
+#include <linux/spinlock.h>
 
 /*
  * This is the max number of console adapters that can/will be found as
@@ -88,7 +89,16 @@ int hvc_poll(struct hvc_struct *hp);
 void hvc_kick(void);
 
 /* Resize hvc tty terminal window */
-extern void hvc_resize(struct hvc_struct *hp, struct winsize ws);
+extern void __hvc_resize(struct hvc_struct *hp, struct winsize ws);
+
+static inline void hvc_resize(struct hvc_struct *hp, struct winsize ws)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hp->lock, flags);
+	__hvc_resize(hp, ws);
+	spin_unlock_irqrestore(&hp->lock, flags);
+}
 
 /* default notifier for irq based notification */
 extern int notifier_add_irq(struct hvc_struct *hp, int data);
--- a/drivers/char/hvc_iucv.c
+++ b/drivers/char/hvc_iucv.c
@@ -273,7 +273,9 @@ static int hvc_iucv_write(struct hvc_iuc
 	case MSG_TYPE_WINSIZE:
 		if (rb->mbuf->datalen != sizeof(struct winsize))
 			break;
-		hvc_resize(priv->hvc, *((struct winsize *) rb->mbuf->data));
+		/* The caller must ensure that the hvc is locked, which
+		 * is the case when called from hvc_iucv_get_chars() */
+		__hvc_resize(priv->hvc, *((struct winsize *) rb->mbuf->data));
 		break;
 
 	case MSG_TYPE_ERROR:	/* ignored ... */
