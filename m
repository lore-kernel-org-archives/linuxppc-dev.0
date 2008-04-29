Return-Path: <Shengping.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 00105DE079
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 03:35:10 +1000 (EST)
Message-ID: <4816CFF9.5030505@windriver.com>
Date: Tue, 29 Apr 2008 16:36:25 +0900
From: Andrew Liu <shengping.liu@windriver.com>
MIME-Version: 1.0
To: grant.likely@secretlab.ca, tnt@246tnt.com
Subject: [PATCH]  Fix a potential issue in mpc52xx uart driver 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc52xx_uart_int and __uart_put_char both try to acquire the
port->lock. Therefore the function sequence of:

mpc52xx_uart_int--> ...-->flush_to_ldisc-->...-->__uart_put_char

can potentially trigger a deadlock. To avoid this deadlock a fix
similar to that found in the 8250.c serial driver is applied. The
deadlock is avoided by releasing the lock before pushing a buffer
and reacquiring it when completed.

Signed-off-by: Andrew Liu <shengping.liu@windriver.com>

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index d93b357..5f95e53 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -783,7 +783,9 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
                 }
         }

+       spin_unlock(&port->lock);
         tty_flip_buffer_push(tty);
+       spin_lock(&port->lock);

         return psc_ops->raw_rx_rdy(port);
  }
