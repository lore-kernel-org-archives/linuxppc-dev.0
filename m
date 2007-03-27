Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 744BCDDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 07:33:22 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] POWERPC CPM_UART: got rid of extra status checks during RX
Date: Wed, 28 Mar 2007 01:33:17 +0400
Message-ID: <20070327213317.22598.18315.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Status were verified in the cycle while exact variable is not updated in
it. All "possibly bad" bits in status are relevant to the last received
byte from buffer only. Also, more robust handling of overrun case.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_core.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 7a3b97f..bbb0b22 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -299,8 +299,8 @@ static void cpm_uart_int_rx(struct uart_port *port)
 			port->icount.rx++;
 			flg = TTY_NORMAL;
 
-			if (status &
-			    (BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV))
+			if (!i && status &
+				  (BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV))
 				goto handle_error;
 			if (uart_handle_sysrq_char(port, ch))
 				continue;
@@ -354,14 +354,8 @@ static void cpm_uart_int_rx(struct uart_port *port)
 		flg = TTY_FRAME;
 
 	/* overrun does not affect the current character ! */
-	if (status & BD_SC_OV) {
-		ch = 0;
-		flg = TTY_OVERRUN;
-		/* We skip this buffer */
-		/* CHECK: Is really nothing senseful there */
-		/* ASSUMPTION: it contains nothing valid */
-		i = 0;
-	}
+	if (status & BD_SC_OV)
+		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
 #ifdef SUPPORT_SYSRQ
 	port->sysrq = 0;
 #endif
