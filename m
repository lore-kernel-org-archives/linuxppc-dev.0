Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13163DDF4B
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:14:26 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9E9EE4D313164
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:14:14 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E9EEfQ3846164
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:14 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E9EDka025108
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:14 +0200
Message-Id: <20081014091413.306993844@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
Date: Tue, 14 Oct 2008 11:12:51 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [RFC PATCH 4/5] hvc_console: Add tty window resizing
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

The patch provides the hvc_resize() function to update the terminal
window dimensions (struct winsize) for a specified hvc console.
The function stores the new window size and schedules a function
that finally updates the tty winsize and signals the change to
user space (SIGWINCH).
Because the winsize update must acquire a mutex and might sleep,
the function is scheduled instead of being called from hvc_poll()
or khvcd.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |   61 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/hvc_console.h |    6 ++++
 2 files changed, 67 insertions(+)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -494,6 +494,48 @@ static int hvc_write(struct tty_struct *
 	return written;
 }
 
+/**
+ * hvc_set_winsz() - Resize the hvc tty terminal window.
+ * @work:	work structure.
+ *
+ * The routine shall not be called within an atomic context because it
+ * acquires the tty termios mutex and might sleep.
+ *
+ * Locking:	hp->lock, tty->termios_mutex and tty->ctrl_lock
+ */
+static void hvc_set_winsz(struct work_struct *work)
+{
+	struct hvc_struct *hp;
+	struct pid *pgrp;
+	unsigned long hvc_flags;
+	unsigned long ctrl_flags;
+
+	hp = container_of(work, struct hvc_struct, tty_resize);
+	if (!hp || !hp->tty)
+		return;
+
+	mutex_lock(&hp->tty->termios_mutex);
+	spin_lock_irqsave(&hp->lock, hvc_flags);
+
+	if ((hp->ws.ws_row == hp->tty->winsize.ws_row) &&
+	    (hp->ws.ws_col == hp->tty->winsize.ws_col))
+		goto out_mutex_unlock;
+
+	spin_lock_irqsave(&hp->tty->ctrl_lock, ctrl_flags);
+	pgrp = get_pid(hp->tty->pgrp);
+	spin_unlock_irqrestore(&hp->tty->ctrl_lock, ctrl_flags);
+
+	if (pgrp)
+		kill_pgrp(pgrp, SIGWINCH, 1);
+	put_pid(pgrp);
+
+	hp->tty->winsize = hp->ws;
+
+out_mutex_unlock:
+	spin_unlock_irqrestore(&hp->lock, hvc_flags);
+	mutex_unlock(&hp->tty->termios_mutex);
+}
+
 /*
  * This is actually a contract between the driver and the tty layer outlining
  * how much write room the driver can guarantee will be sent OR BUFFERED.  This
@@ -638,6 +680,24 @@ int hvc_poll(struct hvc_struct *hp)
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
@@ -720,6 +780,7 @@ struct hvc_struct __devinit *hvc_alloc(u
 
 	kref_init(&hp->kref);
 
+	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
 	spin_lock_init(&hp->lock);
 	spin_lock(&hvc_structs_lock);
 
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
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
