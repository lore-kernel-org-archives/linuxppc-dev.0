Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.5.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8B8667DB0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 02:56:58 +1100 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kADFulFP008420
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Nov 2006 16:56:47 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade.biz (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])       by outmx001.isp.belgacom.be
	(8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kADFuivp008374
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Nov 2006 16:56:44 +0100     
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: CPM_UART: tcdrain() is broken
Date: Mon, 13 Nov 2006 16:56:23 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="Boundary-00=_nWJWFSo36S9WOnX"
Message-Id: <200611131656.23580.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_nWJWFSo36S9WOnX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody,

while working with a CPM UART port (SMC2), I noticed that tcdrain() doesn't 
actually wait until all the characters hit the wire. After some 
investigation, I found out that uart_wait_until_sent() (in 
drivers/serial/serial_core.c) returns immediately because port->fifosize is 
equal to 0.

The following patch improves the situation by setting fifosize and calling 
uart_update_timeout() when the baud rate is modified. It didn't break might 
system, but further testing is probably needed.

There is, however, a problem left. The SCC controllers have a 32-byte FIFO 
between the buffer descriptors and the wires. cpm_uart_tx_empty() checks if 
all buffer descriptors have been processed, but doesn't check if the transmit 
FIFO is actually empty. I can't figure out how to do so from the datasheet. 
Does anyone have an idea ?

Best regards,

Laurent Pinchart

--Boundary-00=_nWJWFSo36S9WOnX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpm-tcdrain.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm-tcdrain.diff"

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 38719aa..8bb7f2b 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -555,6 +555,11 @@ static void cpm_uart_set_termios(struct 
 	}
 
 	/*
+	 * Update the timeout
+	 */
+        uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
 	 * Setup hardware (RTS/CTS) flow control
 	 */
 	if (old == NULL ||
@@ -960,6 +965,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.ops		= &cpm_uart_pops,
 			.iotype		= UPIO_MEM,
 			.lock		= SPIN_LOCK_UNLOCKED,
+			.fifosize	= TX_BUF_SIZE * TX_NUM_FIFO,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -974,6 +980,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.ops		= &cpm_uart_pops,
 			.iotype		= UPIO_MEM,
 			.lock		= SPIN_LOCK_UNLOCKED,
+			.fifosize	= TX_BUF_SIZE * TX_NUM_FIFO,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -991,6 +998,7 @@ #endif
 			.ops		= &cpm_uart_pops,
 			.iotype		= UPIO_MEM,
 			.lock		= SPIN_LOCK_UNLOCKED,
+			.fifosize	= TX_BUF_SIZE * TX_NUM_FIFO,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -1005,6 +1013,7 @@ #endif
 			.ops		= &cpm_uart_pops,
 			.iotype		= UPIO_MEM,
 			.lock		= SPIN_LOCK_UNLOCKED,
+			.fifosize	= TX_BUF_SIZE * TX_NUM_FIFO,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -1019,6 +1028,7 @@ #endif
 			.ops		= &cpm_uart_pops,
 			.iotype		= UPIO_MEM,
 			.lock		= SPIN_LOCK_UNLOCKED,
+			.fifosize	= TX_BUF_SIZE * TX_NUM_FIFO,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -1033,6 +1043,7 @@ #endif
 			.ops		= &cpm_uart_pops,
 			.iotype		= UPIO_MEM,
 			.lock		= SPIN_LOCK_UNLOCKED,
+			.fifosize	= TX_BUF_SIZE * TX_NUM_FIFO,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,

--Boundary-00=_nWJWFSo36S9WOnX--
