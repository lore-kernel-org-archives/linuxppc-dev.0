Message-ID: <3D89E18B.8020708@tiscali.cz>
Date: Thu, 19 Sep 2002 16:39:07 +0200
From: Pavel Bartusek <pavel.bartusek@tiscali.cz>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, damm@opensource.se
Subject: Re: PCMCIA cards for MPC8xx?
Content-Type: multipart/mixed;
 boundary="------------000401060204090003070004"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000401060204090003070004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There is a patch, which allows concurent use of arch/ppc/8xx_io/uart.c
and drivers/char/serial.c

--------------000401060204090003070004
Content-Type: text/plain;
 name="fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixup.patch"

diff -Nurb linux__/arch/ppc/8xx_io/uart.c /opt/elinos/linux-2.4.18/arch/ppc/8xx_io/uart.c
--- linux__/arch/ppc/8xx_io/uart.c	Thu Jan 24 05:23:57 2002
+++ /opt/elinos/linux-2.4.18/arch/ppc/8xx_io/uart.c	Mon Jul  1 13:16:40 2002
@@ -357,8 +357,14 @@
 				  int event)
 {
 	info->event |= 1 << event;
+#ifdef CONFIG_SERIAL
+	/* if the serial driver is also selected, we have to use another tq */
+	queue_task(&info->tqueue, &tq_immediate);
+	mark_bh(IMMEDIATE_BH);
+#else
 	queue_task(&info->tqueue, &tq_serial);
 	mark_bh(SERIAL_BH);
+#endif
 }

 static _INLINE_ void receive_chars(ser_info_t *info, struct pt_regs *regs)
@@ -2566,7 +2572,10 @@
 	volatile	scc_uart_t	*sup;
 	volatile	immap_t		*immap;

+#ifndef CONFIG_SERIAL
+	/* if the serial driver is also selected, SERIAL_BH can't be used */
 	init_bh(SERIAL_BH, do_serial_bh);
+#endif

 	show_serial_version();


--------------000401060204090003070004--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
