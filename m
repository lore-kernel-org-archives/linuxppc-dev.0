Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69040DE004
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 02:02:25 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m9EF2BS2180334
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 15:02:11 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9EF2B9J3522572
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 16:02:11 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9EF2As2019201
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 16:02:11 +0100
Date: Tue, 14 Oct 2008 17:02:09 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 4/5] hvc_console: Add tty window resizing
Message-ID: <20081014150209.GB5318@cetus.boeblingen.de.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.306993844@linux.vnet.ibm.com>
	<20081014104428.698b750b@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081014104428.698b750b@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 10:44:28AM +0100, Alan Cox wrote:
> > +	hp = container_of(work, struct hvc_struct, tty_resize);
> > +	if (!hp || !hp->tty)
> > +		return;
> What locks hp->tty here, it can go NULL after the test on a hangup it
> seems ?
You are right. Thanks.

> See tty_do_resize() for all of this stuff in the latest git. If you can't
> use tty_do_resize from your work queue then please let me know why as I'd
> like everyone to be using one abstraction.
I have looked at it  and I have corrected my patch to use tty_do_resize().
Since tty_do_resize() cannot be called holding the hp spinlock; the code uses
now tty_kref_get/put to keep track of the tty object. I am not sure if the
use of the kref's is correct here, so please let me know if there is a better
solution.

Thanks.

Regards,
Hendrik

[RFC PATCH 4/5 v2] hvc_console: Add tty window resizing using tty_do_resize()

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

The patch provides the hvc_resize() function to update the terminal
window dimensions (struct winsize) for a specified hvc console.
The function stores the new window size and schedules a function
that finally updates the tty winsize and signals the change to
user space (SIGWINCH).
Because the winsize update must acquire a mutex and might sleep,
the function is scheduled instead of being called from hvc_poll()
or khvcd.

This patch uses the tty_do_resize() routine from the tty layer.
A pending resize work is canceled in hvc_close() and hvc_hangup().

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |   58 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/hvc_console.h |    6 ++++
 2 files changed, 64 insertions(+)

--- a/drivers/char/hvc_console.c	2008-10-14 16:13:12.000000000 +0200
+++ b/drivers/char/hvc_console.c	2008-10-14 16:43:03.000000000 +0200
@@ -374,6 +374,9 @@ static void hvc_close(struct tty_struct 
 		hp->tty = NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		/* cancel pending tty resize work */
+		cancel_work_sync(&hp->tty_resize);
+
 		/*
 		 * Chain calls chars_in_buffer() and returns immediately if
 		 * there is no buffered data otherwise sleeps on a wait queue
@@ -399,6 +402,9 @@ static void hvc_hangup(struct tty_struct
 	if (!hp)
 		return;
 
+	/* cancel pending tty resize work */
+	cancel_work_sync(&hp->tty_resize);
+
 	spin_lock_irqsave(&hp->lock, flags);
 
 	/*
@@ -494,6 +500,39 @@ static int hvc_write(struct tty_struct *
 	return written;
 }
 
+/**
+ * hvc_set_winsz() - Resize the hvc tty terminal window.
+ * @work:	work structure.
+ *
+ * The routine shall not be called within an atomic context because it
+ * might sleep.
+ *
+ * Locking:	hp->lock
+ */
+static void hvc_set_winsz(struct work_struct *work)
+{
+	struct hvc_struct *hp;
+	unsigned long hvc_flags;
+	struct tty_struct *tty;
+	struct winsize ws;
+
+	hp = container_of(work, struct hvc_struct, tty_resize);
+	if (!hp)
+		return;
+
+	spin_lock_irqsave(&hp->lock, hvc_flags);
+	if (!hp->tty) {
+		spin_unlock_irqrestore(&hp->lock, hvc_flags);
+		return;
+	}
+	ws  = hp->ws;
+	tty = tty_kref_get(hp->tty);
+	spin_unlock_irqrestore(&hp->lock, hvc_flags);
+
+	tty_do_resize(tty, tty, &ws);
+	tty_kref_put(tty);
+}
+
 /*
  * This is actually a contract between the driver and the tty layer outlining
  * how much write room the driver can guarantee will be sent OR BUFFERED.  This
@@ -638,6 +677,24 @@ int hvc_poll(struct hvc_struct *hp)
 }
 EXPORT_SYMBOL_GPL(hvc_poll);
 
+/**
+ * hvc_resize() - Update terminal window size information.
+ * @hp:		HVC console pointer
+ * @ws:		Terminal window size structure
+ *
+ * Stores the specified window size information in the hvc structure of @hp.
+ * The function schedule the tty resize update.
+ *
+ * Locking:	Locking free; the function MUST be called holding hp->lock
+ */
+void hvc_resize(struct hvc_struct *hp, struct winsize ws)
+{
+	if ((hp->ws.ws_row != ws.ws_row) || (hp->ws.ws_col != ws.ws_col)) {
+		hp->ws = ws;
+		schedule_work(&hp->tty_resize);
+	}
+}
+
 /*
  * This kthread is either polling or interrupt driven.  This is determined by
  * calling hvc_poll() who determines whether a console adapter support
@@ -720,6 +777,7 @@ struct hvc_struct __devinit *hvc_alloc(u
 
 	kref_init(&hp->kref);
 
+	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
 	spin_lock_init(&hp->lock);
 	spin_lock(&hvc_structs_lock);
 
--- a/drivers/char/hvc_console.h	2008-10-14 16:13:11.000000000 +0200
+++ b/drivers/char/hvc_console.h	2008-10-14 16:13:13.000000000 +0200
@@ -27,6 +27,7 @@
 #ifndef HVC_CONSOLE_H
 #define HVC_CONSOLE_H
 #include <linux/kref.h>
+#include <linux/tty.h>
 
 /*
  * This is the max number of console adapters that can/will be found as
@@ -56,6 +57,8 @@ struct hvc_struct {
 	struct hv_ops *ops;
 	int irq_requested;
 	int data;
+	struct winsize ws;
+	struct work_struct tty_resize;
 	struct list_head next;
 	struct kref kref; /* ref count & hvc_struct lifetime */
 };
@@ -84,6 +87,9 @@ extern int __devexit hvc_remove(struct h
 int hvc_poll(struct hvc_struct *hp);
 void hvc_kick(void);
 
+/* Resize hvc tty terminal window */
+extern void hvc_resize(struct hvc_struct *hp, struct winsize ws);
+
 /* default notifier for irq based notification */
 extern int notifier_add_irq(struct hvc_struct *hp, int data);
 extern void notifier_del_irq(struct hvc_struct *hp, int data);
-- 
Hendrik Brueckner
D/3303 Linux on System z Development
Tel: +49 7031 16-1073
Fax: +49 7031 16-3456
eMail: brueckner@linux.vnet.ibm.com
IBM Deutschland Research & Development GmbH, Schoenaicher Str. 220, 71032 Boeblingen

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
