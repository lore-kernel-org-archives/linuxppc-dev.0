Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 85DACB7D98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 23:32:48 +1000 (EST)
Message-ID: <4C1B7312.6080708@ThePTRGroup.com>
Date: Fri, 18 Jun 2010 09:22:26 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
	"Chuck Meade (PTR Group)" <chuck@ThePTRGroup.com>
Subject: [PATCH] serial: Add missing call to init UCC UART port timeout
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chuck Meade <chuck@ThePTRGroup.com>

The UCC UART driver is missing a call to uart_update_timeout().
Without this call, attempting to close the port after outputting large
amounts of data (i.e. using tty and uart buffering) results in long
timeouts before the port will actually be shut down.

For example, cat a large file to a UCC UART port.  With the current
driver, the port will stay open for 30 seconds after the last byte
of data is output.  But with this patch, the port is closed as
expected, just after the data has been output (tx fifos empty).

Signed-off-by: Chuck Meade <chuck@ThePTRGroup.com>
---
 drivers/serial/ucc_uart.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/ucc_uart.c b/drivers/serial/ucc_uart.c
index 907b06f..a136030 100644
--- a/drivers/serial/ucc_uart.c
+++ b/drivers/serial/ucc_uart.c
@@ -961,6 +961,9 @@ static void qe_uart_set_termios(struct uart_port *port,
 	/* Do we really need a spinlock here? */
 	spin_lock_irqsave(&port->lock, flags);

+	/* Update the per-port timeout. */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
 	out_be16(&uccp->upsmr, upsmr);
 	if (soft_uart) {
 		out_be16(&uccup->supsmr, supsmr);
-- 
1.5.6.3
