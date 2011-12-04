Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CD28B6F99
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 10:42:33 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: alan@linux.intel.com, gregkh@suse.de, scottwood@freescale.com,
 galak@kernel.crashing.org
Subject: [PATCH 2/6] serial: clean up parameter passing for 8250 Rx IRQ
 handling
Date: Sun,  4 Dec 2011 18:42:19 -0500
Message-Id: <1323042143-25330-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1323042143-25330-1-git-send-email-paul.gortmaker@windriver.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1323042143-25330-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The receive_chars() was taking a pointer to a passed in LSR value
in status and knocking off bits as it processed them.  But since
receive_chars isn't returning a value, we can instead pass in
a normal non-pointer value for LSR, and simply return the
residual (unprocessed) LSR once it is done.

The value in this cleanup, is that it clarifies the API of the
receive_chars prior to exporting it to other 8250-like drivers
for shared usage.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index d97628e..a20d7eb 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1375,11 +1375,16 @@ static void clear_rx_fifo(struct uart_8250_port *up)
 	} while (1);
 }
 
-static void
-receive_chars(struct uart_8250_port *up, unsigned int *status)
+/*
+ * receive_chars: processes according to the passed in LSR
+ * value, and returns the remaining LSR bits not handled
+ * by this Rx routine.
+ */
+static unsigned char
+receive_chars(struct uart_8250_port *up, unsigned char lsr)
 {
 	struct tty_struct *tty = up->port.state->port.tty;
-	unsigned char ch, lsr = *status;
+	unsigned char ch;
 	int max_count = 256;
 	char flag;
 
@@ -1455,7 +1460,7 @@ ignore_char:
 	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(tty);
 	spin_lock(&up->port.lock);
-	*status = lsr;
+	return lsr;
 }
 
 static void transmit_chars(struct uart_8250_port *up)
@@ -1524,7 +1529,7 @@ static unsigned int check_modem_status(struct uart_8250_port *up)
  */
 static void serial8250_handle_port(struct uart_8250_port *up)
 {
-	unsigned int status;
+	unsigned char status;
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -1534,7 +1539,7 @@ static void serial8250_handle_port(struct uart_8250_port *up)
 	DEBUG_INTR("status = %x...", status);
 
 	if (status & (UART_LSR_DR | UART_LSR_BI))
-		receive_chars(up, &status);
+		status = receive_chars(up, status);
 	check_modem_status(up);
 	if (status & UART_LSR_THRE)
 		transmit_chars(up);
-- 
1.7.7
