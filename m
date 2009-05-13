Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BA861DE050
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 02:01:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] serial/nwpserial: fix wrong register read address and add
	interrupt acknowledge.
Date: Wed, 13 May 2009 17:56:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905131756.54724.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Krill <ben@codiert.org>

The receive interrupt routine checks the wrong register if the
receive fifo is empty. Further an explicit interrupt acknowledge
write is introduced. In some circumstances another interrupt was
issued.

Signed-off-by: Benjamin Krill <ben@codiert.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/serial/nwpserial.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/nwpserial.c b/drivers/serial/nwpserial.c
index 32f3eaf..9e150b1 100644
--- a/drivers/serial/nwpserial.c
+++ b/drivers/serial/nwpserial.c
@@ -145,11 +145,13 @@ static irqreturn_t nwpserial_interrupt(int irq, void *dev_id)
 		ch = dcr_read(up->dcr_host, UART_RX);
 		if (up->port.ignore_status_mask != NWPSERIAL_STATUS_RXVALID)
 			tty_insert_flip_char(tty, ch, TTY_NORMAL);
-	} while (dcr_read(up->dcr_host, UART_RX) & UART_LSR_DR);
+	} while (dcr_read(up->dcr_host, UART_LSR) & UART_LSR_DR);
 
 	tty_flip_buffer_push(tty);
 	ret = IRQ_HANDLED;
 
+	/* clear interrupt */
+	dcr_write(up->dcr_host, UART_IIR, 1);
 out:
 	spin_unlock(&up->port.lock);
 	return ret;
-- 
1.5.6.3
