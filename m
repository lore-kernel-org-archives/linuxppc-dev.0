Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CFBFB67A79
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 16:15:49 +1100 (EST)
Date: Fri, 4 Mar 2005 23:15:07 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0503042313040.23572@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] initialize a spin lock in CPM2 uart driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Static initialization of spin locks that are otherwise accessed prior to 
initialization.

Signed-off-by: Jaka Mocnik <jaka@activetools.si>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
   
---

diff -Nru a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-04 23:03:27 -06:00
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-04 23:03:27 -06:00
@@ -864,6 +864,7 @@
 			.irq		= SMC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -877,6 +878,7 @@
 			.irq		= SMC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -893,6 +895,7 @@
 			.irq		= SCC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -905,6 +908,7 @@
 			.irq		= SCC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -917,6 +921,7 @@
 			.irq		= SCC3_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -929,6 +934,7 @@
 			.irq		= SCC4_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
