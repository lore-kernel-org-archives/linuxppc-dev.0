Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 5125DDDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 05:28:57 +1000 (EST)
Received: from [127.0.0.1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id 1898965C292
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 21:10:57 +0200 (CEST)
Subject: [PATCH] mpx5200_uart: drop port lock across tty_flip_buffer() call
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 25 Jul 2007 21:10:56 +0200
Message-Id: <1185390656.3227.12.camel@chaos>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The port lock needs to be dropped across the tty_flip_buffer call, as it
would lead to a deadlock with the spin_lock(&port->lock) in uart_start()

Uncovered by lockdep / preempt-rt

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Index: linux-2.6.22/drivers/serial/mpc52xx_uart.c
===================================================================
--- linux-2.6.22.orig/drivers/serial/mpc52xx_uart.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/drivers/serial/mpc52xx_uart.c	2007-07-25 21:06:11.000000000 +0200
@@ -501,7 +501,9 @@ mpc52xx_uart_int_rx_chars(struct uart_po
 		}
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tty);
+	spin_lock(&port->lock);
 
 	return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
 }
