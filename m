To: dan@netx4.com
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] Re: UART driver problem
References: <s88831d7.021@mail.frequentis.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Jan 2000 14:27:52 +0100
In-Reply-To: "Ralf HECKHAUSEN"'s message of "Fri, 21 Jan 2000 10:15:21 +0100"
Message-ID: <kfyzotumgbr.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Ralf HECKHAUSEN" <RHeckhau@frequentis.com> writes:

> I have a strange problem with the uart driver. The 8xx_write in uart.c
> always fails because copy_from_user returns 0 instead of the requested
> number of bytes. When I ignore the comparison with the requested
> number of bytes everything works ok, the correct bytes are transmitted
> and 8xx_write returns something >0.

I noted that as well the other day, together with another problem,
when starting to use sysvinit instead of a simple bash script.

The above problem is solved by this patch:

diff -u -u -r1.4 -r1.5
--- uart.c      2000/01/17 17:20:57     1.4
+++ uart.c      2000/01/24 18:02:19     1.5
@@ -976,8 +976,7 @@
                }

                if (from_user) {
-                       if (c !=
-                           copy_from_user(__va(bdp->cbd_bufaddr), buf, c)) {
+                       if (copy_from_user(__va(bdp->cbd_bufaddr), buf, c)) {
                                if (!ret)
                                        ret = -EFAULT;
                                break;

Strangely enough drivers/char/serial.c is broken as well in standard
kernels. The only difference is that there the copy_from_user() will
appear to always succeed instead of always failing...

The other problem got triggered by init doing open(); write(); close();
cycles on the serial console. Without this patch the write() output
gets aborted before finishing:

diff -u -u -r1.4 -r1.5
--- uart.c      2000/01/17 17:20:57     1.4
+++ uart.c      2000/01/24 18:02:19     1.5
@@ -1692,6 +1691,13 @@
         * be at least two characters waiting to be sent after the buffers
         * are empty.
         */
+       bdp = info->tx_cur;
+       /* We want to wait for the last buffer, not the first. */
+       if (bdp == info->tx_bd_base) {
+               bdp += (TX_NUM_FIFO-1);
+       } else {
+               bdp--;
+       }
        do {
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
                printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
@@ -1703,7 +1709,6 @@
                        break;
                if (timeout && ((orig_jiffies + timeout) < jiffies))
                        break;
-               bdp = info->tx_cur;
        } while (bdp->cbd_sc & BD_SC_READY);
        current->state = TASK_RUNNING;
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT


//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
