Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38D7FDDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:14:21 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9E9ED4K612912
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:14:13 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E9EDe92326618
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:13 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E9ECcb021571
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:13 +0200
Message-Id: <20081014091412.847833204@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
Date: Tue, 14 Oct 2008 11:12:48 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [RFC PATCH 1/5] hvc_console: Adding hangup notifier
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

I have added a hangup notifier that can be used by hvc console
backends to handle a tty hangup. The default irq hangup notifier
calls the notifier_del_irq() for compatibility.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c    |    4 ++--
 drivers/char/hvc_console.h    |    4 +++-
 drivers/char/hvc_irq.c        |    5 +++++
 drivers/char/hvc_iseries.c    |    1 +
 drivers/char/hvc_vio.c        |    1 +
 drivers/char/hvc_xen.c        |    1 +
 drivers/char/virtio_console.c |    1 +
 7 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/char/hvc_console.c	2008-10-08 16:08:40.000000000 +0200
+++ b/drivers/char/hvc_console.c	2008-10-09 10:30:13.000000000 +0200
@@ -416,8 +416,8 @@ static void hvc_hangup(struct tty_struct
 	hp->n_outbuf = 0;
 	hp->tty = NULL;
 
-	if (hp->ops->notifier_del)
-			hp->ops->notifier_del(hp, hp->data);
+	if (hp->ops->notifier_hangup)
+			hp->ops->notifier_hangup(hp, hp->data);
 
 	spin_unlock_irqrestore(&hp->lock, flags);
 
--- a/drivers/char/hvc_console.h	2008-10-08 16:08:40.000000000 +0200
+++ b/drivers/char/hvc_console.h	2008-10-09 10:30:13.000000000 +0200
@@ -65,9 +65,10 @@ struct hv_ops {
 	int (*get_chars)(uint32_t vtermno, char *buf, int count);
 	int (*put_chars)(uint32_t vtermno, const char *buf, int count);
 
-	/* Callbacks for notification. Called in open and close */
+	/* Callbacks for notification. Called in open, close and hangup */
 	int (*notifier_add)(struct hvc_struct *hp, int irq);
 	void (*notifier_del)(struct hvc_struct *hp, int irq);
+	void (*notifier_hangup)(struct hvc_struct *hp, int irq);
 };
 
 /* Register a vterm and a slot index for use as a console (console_init) */
@@ -86,6 +87,7 @@ void hvc_kick(void);
 /* default notifier for irq based notification */
 extern int notifier_add_irq(struct hvc_struct *hp, int data);
 extern void notifier_del_irq(struct hvc_struct *hp, int data);
+extern void notifier_hangup_irq(struct hvc_struct *hp, int data);
 
 
 #if defined(CONFIG_XMON) && defined(CONFIG_SMP)
--- a/drivers/char/hvc_irq.c	2008-10-08 16:08:40.000000000 +0200
+++ b/drivers/char/hvc_irq.c	2008-10-09 10:30:13.000000000 +0200
@@ -42,3 +42,8 @@ void notifier_del_irq(struct hvc_struct 
 	free_irq(irq, hp);
 	hp->irq_requested = 0;
 }
+
+void notifier_hangup_irq(struct hvc_struct *hp, int irq)
+{
+	notifier_del_irq(hp, irq);
+}
--- a/drivers/char/hvc_iseries.c	2008-10-08 16:08:40.000000000 +0200
+++ b/drivers/char/hvc_iseries.c	2008-10-09 10:30:13.000000000 +0200
@@ -202,6 +202,7 @@ static struct hv_ops hvc_get_put_ops = {
 	.put_chars = put_chars,
 	.notifier_add = notifier_add_irq,
 	.notifier_del = notifier_del_irq,
+	.notifier_hangup = notifier_hangup_irq,
 };
 
 static int __devinit hvc_vio_probe(struct vio_dev *vdev,
--- a/drivers/char/hvc_xen.c	2008-10-08 16:08:40.000000000 +0200
+++ b/drivers/char/hvc_xen.c	2008-10-09 10:30:13.000000000 +0200
@@ -102,6 +102,7 @@ static struct hv_ops hvc_ops = {
 	.put_chars = write_console,
 	.notifier_add = notifier_add_irq,
 	.notifier_del = notifier_del_irq,
+	.notifier_hangup = notifier_hangup_irq,
 };
 
 static int __init xen_init(void)
--- a/drivers/char/hvc_vio.c	2008-10-08 16:08:40.000000000 +0200
+++ b/drivers/char/hvc_vio.c	2008-10-09 10:30:13.000000000 +0200
@@ -82,6 +82,7 @@ static struct hv_ops hvc_get_put_ops = {
 	.put_chars = hvc_put_chars,
 	.notifier_add = notifier_add_irq,
 	.notifier_del = notifier_del_irq,
+	.notifier_hangup = notifier_hangup_irq,
 };
 
 static int __devinit hvc_vio_probe(struct vio_dev *vdev,
--- a/drivers/char/virtio_console.c	2008-10-09 10:29:41.000000000 +0200
+++ b/drivers/char/virtio_console.c	2008-10-09 10:30:23.000000000 +0200
@@ -198,6 +198,7 @@ static int __devinit virtcons_probe(stru
 	virtio_cons.put_chars = put_chars;
 	virtio_cons.notifier_add = notifier_add_vio;
 	virtio_cons.notifier_del = notifier_del_vio;
+	virtio_cons.notifier_hangup = notifier_del_vio;
 
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the parameter for the

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
