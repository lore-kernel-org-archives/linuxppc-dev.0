Return-Path: <alexander.stein@systec-electronic.com>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61])
 by lists.ozlabs.org (Postfix) with ESMTP id 47BB31A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 18:40:04 +1000 (AEST)
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Timur Tabi <timur@tabi.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/1] serial/uuc_uart: Support higher bitrates than 115200 Bit/s
Date: Thu,  9 Jul 2015 10:34:34 +0200
Message-Id: <1436430874-17385-1-git-send-email-alexander.stein@systec-electronic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The maximum bitrate supported depends on the clock rate used in BRG.
This is stored in port.uartclk during probe. Respecting the 16x
oversampling higher bitrates can be supported.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 7d2532b..73190f5 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -950,7 +950,7 @@ static void qe_uart_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->read_status_mask &= ~BD_SC_EMPTY;
 
-	baud = uart_get_baud_rate(port, termios, old, 0, 115200);
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
 
 	/* Do we really need a spinlock here? */
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.3.6
