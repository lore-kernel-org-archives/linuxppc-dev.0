To: "Brown, David (dbrown03)" <DBrown03@harris.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is it normal for serial ports to drop characters at the end?
References: <BE1C564723B3D21191FD0000F840E39801D814F1@rfcmx2.rfc.comm.harris.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 03 May 2000 21:27:56 +0200
In-Reply-To: "Brown, David's message of "Wed, 3 May 2000 11:30:06 -0400"
Message-ID: <veya5rv3gj.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" <DBrown03@harris.com> writes:

> I see characters dropped at the end of a write to a serial port.  Surely
> that isn't normal.
> I'm using the current MontaVista 2.2.13 kernel patched for my custom
> 860-based board.  The serial ports are running at 9600.
>
> When I do this:
> init-2.00# help while >/dev/ttyS1

[snip]

> well.  Could it be that when a serial port is closed, the uart is disabled
> immediately instead of waiting for output to finish?

Right on target.
rs_8xx_wait_until_sent() will wait for the *first* buffer descriptor
to be finished, instead of waiting for the last one as it should.
This patch fixes that problem:

diff -bu uart.orig uart.c
--- uart.c.orig	Wed May  3 20:25:09 2000
+++ uart.c	Fri Apr 28 20:08:15 2000
@@ -1710,6 +1718,13 @@
 	 * be at least two characters waiting to be sent after the buffers
 	 * are empty.
 	 */
+	bdp = info->tx_cur;
+	/* We want to wait for the last buffer, not the first. */
+	if (bdp == info->tx_bd_base) {
+		bdp += (TX_NUM_FIFO-1);
+	} else {
+		bdp--;
+	}
 	do {
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
@@ -1721,7 +1736,6 @@
 			break;
 		if (timeout && ((orig_jiffies + timeout) < jiffies))
 			break;
-		bdp = info->tx_cur;
 	} while (bdp->cbd_sc & BD_SC_READY);
 	current->state = TASK_RUNNING;
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT


There is also a problem with kernel messages being truncated when
an application open the serial console. This patch should fix that:

diff -bu uart.orig uart.c
--- uart.c.orig	Wed May  3 20:25:09 2000
+++ uart.c	Fri Apr 28 20:08:15 2000
@@ -915,8 +909,20 @@
 		info->read_status_mask &= ~BD_SC_EMPTY;
 	save_flags(flags); cli();

+	/* Make sure last buffer has been sent. */
+	{
+		volatile cbd_t	*bdp;
+		bdp = info->tx_cur;
+		if (bdp == info->tx_bd_base) {
+			bdp += (TX_NUM_FIFO-1);
+		} else {
+			bdp--;
+		}
+		while (bdp->cbd_sc & BD_SC_READY);
+	}
+
 	/* Start bit has not been added (so don't, because we would just
 	 * subtract it later), and we need to add one for the number of
 	 * stops bits (there is always at least one).
 	 */
 	bits++;

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.se/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
