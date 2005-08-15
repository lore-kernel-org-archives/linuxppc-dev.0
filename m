Return-Path: <nacc@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D360167EFD
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 05:46:20 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.esmtp.ibm.com [9.14.4.133])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j7FIFFqW012347
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 14:15:16 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7FIF9n7283328
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 14:15:09 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id
	j7FIFB3q134416
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 12:15:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j7FIF9t9002342
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 12:15:09 -0600
Date: Mon, 15 Aug 2005 11:15:08 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: paulus@samba.org
Message-ID: <20050815181508.GO2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: [-mm PATCH 12/32] ppc: fix-up schedule_timeout() usage
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size. Also use
human-time conversion functions instead of hard-coded HZ division to
avoid rounding errors.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 arch/ppc/4xx_io/serial_sicc.c |   17 +++++++----------
 arch/ppc/8260_io/fcc_enet.c   |    3 +--
 2 files changed, 8 insertions(+), 12 deletions(-)

diff -urpN 2.6.13-rc5-mm1/arch/ppc/4xx_io/serial_sicc.c 2.6.13-rc5-mm1-dev/arch/ppc/4xx_io/serial_sicc.c
--- 2.6.13-rc5-mm1/arch/ppc/4xx_io/serial_sicc.c	2005-03-01 23:37:30.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/arch/ppc/4xx_io/serial_sicc.c	2005-08-11 15:55:47.000000000 -0700
@@ -1145,8 +1145,8 @@ static int set_serial_info(struct SICC_i
     info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
                (info->flags & ASYNC_INTERNAL_FLAGS));
     state->custom_divisor = new_serial.custom_divisor;
-    state->close_delay = new_serial.close_delay * HZ / 100;
-    state->closing_wait = new_serial.closing_wait * HZ / 100;
+    state->close_delay = msecs_to_jiffies(10 * new_serial.close_delay);
+    state->closing_wait = msecs_to_jiffies(10 * new_serial.closing_wait);
     info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
     port->fifosize = new_serial.xmit_fifo_size;
 
@@ -1465,10 +1465,8 @@ static void siccuart_close(struct tty_st
     info->event = 0;
     info->tty = NULL;
     if (info->blocked_open) {
-        if (info->state->close_delay) {
-            set_current_state(TASK_INTERRUPTIBLE);
-            schedule_timeout(info->state->close_delay);
-        }
+        if (info->state->close_delay)
+            schedule_timeout_interruptible(info->state->close_delay);
         wake_up_interruptible(&info->open_wait);
     }
     info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
@@ -1496,7 +1494,7 @@ static void siccuart_wait_until_sent(str
      * Note: we have to use pretty tight timings here to satisfy
      * the NIST-PCTS.
      */
-    char_time = (info->timeout - HZ/50) / info->port->fifosize;
+    char_time = (info->timeout - msecs_to_jiffies(20)) / info->port->fifosize;
     char_time = char_time / 5;
     if (char_time == 0)
         char_time = 1;
@@ -1521,8 +1519,7 @@ static void siccuart_wait_until_sent(str
            tty->index, jiffies,
            expire, char_time);
     while ((readb(info->port->uart_base + BL_SICC_LSR) & _LSR_TX_ALL) != _LSR_TX_ALL) {
-        set_current_state(TASK_INTERRUPTIBLE);
-        schedule_timeout(char_time);
+        schedule_timeout_interruptible(char_time);
         if (signal_pending(current))
             break;
         if (timeout && time_after(jiffies, expire))
@@ -1773,7 +1770,7 @@ int __init siccuart_init(void)
     for (i = 0; i < SERIAL_SICC_NR; i++) {
         struct SICC_state *state = sicc_state + i;
         state->line     = i;
-        state->close_delay  = 5 * HZ / 10;
+        state->close_delay  = msecs_to_jiffies(500);
         state->closing_wait = 30 * HZ;
 	spin_lock_init(&state->sicc_lock);
     }
diff -urpN 2.6.13-rc5-mm1/arch/ppc/8260_io/fcc_enet.c 2.6.13-rc5-mm1-dev/arch/ppc/8260_io/fcc_enet.c
--- 2.6.13-rc5-mm1/arch/ppc/8260_io/fcc_enet.c	2005-08-07 09:57:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/arch/ppc/8260_io/fcc_enet.c	2005-08-08 13:54:41.000000000 -0700
@@ -1309,8 +1309,7 @@ static void mii_dm9161_wait(uint mii_reg
 
 	/* Davicom takes a bit to come up after a reset,
 	 * so wait here for a bit */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(timeout);
+	schedule_timeout_uninterruptible(timeout);
 }
 
 static phy_info_t phy_info_dm9161 = {
