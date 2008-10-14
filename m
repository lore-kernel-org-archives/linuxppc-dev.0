Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DF30DDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:14:25 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id m9E9EEHD005341
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:14:17 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E9EEJh3203180
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:14 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E9EDbZ005224
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:14 +0200
Message-Id: <20081014091413.107040955@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
Date: Tue, 14 Oct 2008 11:12:50 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [RFC PATCH 3/5] hvc_console: Fix loop if put_char() returns 0
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

If put_char() routine of a hvc console backend returns 0, then the
hvc console starts looping in the following scenarios:

1. hvc_console_print()
	If put_char() returns 0 then the while loop may loop forever.
	I have added the missing check for 0 to throw away console messages.

2. khvcd may loop:
	The thread calls hvc_poll() --> hvc_push()... if there are still
	buffered data then the HVC_POLL_WRITE bit is set and causes the
	khvcd thread to loop (if yield() returns immediately).

	However, instead of looping, the khvcd thread could sleep for
	MIN_TIMEOUT (doing the same as for get_chars()).
	The MIN_TIMEOUT is set if hvc_push() was not able to write
	data to the backend. If data has been written, the timeout is
	set to 0 to immediately re-schedule hvc_poll().

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com> (virtio_console)
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -161,7 +161,7 @@ static void hvc_console_print(struct con
 			}
 		} else {
 			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
-			if (r < 0) {
+			if (r <= 0) {
 				/* throw away chars on error */
 				i = 0;
 			} else if (r > 0) {
@@ -431,7 +431,7 @@ static void hvc_hangup(struct tty_struct
  * Push buffered characters whether they were just recently buffered or waiting
  * on a blocked hypervisor.  Call this function with hp->lock held.
  */
-static void hvc_push(struct hvc_struct *hp)
+static int hvc_push(struct hvc_struct *hp)
 {
 	int n;
 
@@ -439,7 +439,7 @@ static void hvc_push(struct hvc_struct *
 	if (n <= 0) {
 		if (n == 0) {
 			hp->do_wakeup = 1;
-			return;
+			return 0;
 		}
 		/* throw away output on error; this happens when
 		   there is no session connected to the vterm. */
@@ -450,6 +450,8 @@ static void hvc_push(struct hvc_struct *
 		memmove(hp->outbuf, hp->outbuf + n, hp->n_outbuf);
 	else
 		hp->do_wakeup = 1;
+
+	return n;
 }
 
 static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -538,16 +540,20 @@ int hvc_poll(struct hvc_struct *hp)
 	char buf[N_INBUF] __ALIGNED__;
 	unsigned long flags;
 	int read_total = 0;
+	int written_total = 0;
 
 	spin_lock_irqsave(&hp->lock, flags);
 
 	/* Push pending writes */
 	if (hp->n_outbuf > 0)
-		hvc_push(hp);
+		written_total = hvc_push(hp);
 
 	/* Reschedule us if still some write pending */
-	if (hp->n_outbuf > 0)
+	if (hp->n_outbuf > 0) {
 		poll_mask |= HVC_POLL_WRITE;
+		/* If hvc_push() was not able to write, sleep a few msecs */
+		timeout = (written_total) ? 0 : MIN_TIMEOUT;
+	}
 
 	/* No tty attached, just skip */
 	tty = hp->tty;
@@ -659,10 +665,6 @@ static int khvcd(void *unused)
 			poll_mask |= HVC_POLL_READ;
 		if (hvc_kicked)
 			continue;
-		if (poll_mask & HVC_POLL_WRITE) {
-			yield();
-			continue;
-		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (!hvc_kicked) {
 			if (poll_mask == 0)

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
