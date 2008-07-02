Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 166B3DDF67
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 18:58:48 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCHv2] cpm_uart: Support uart_wait_until_sent()
Date: Wed, 2 Jul 2008 10:58:45 +0200
References: <200806261355.09334.laurentp@cse-semaphore.com>
	<4768A00D-3C8B-4AF2-A2E1-DE9C9BD055E4@kernel.crashing.org>
In-Reply-To: <4768A00D-3C8B-4AF2-A2E1-DE9C9BD055E4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807021058.45619.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Set port->fifosize to the software FIFO size, and update the port timeout
when the baud rate is modified. SCC ports have an optional 32 byte hardware
FIFO which is currently not taken into account, as there is no documented way
to check when the FIFO becomes empty.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index a19dc7e..151cad2 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -608,6 +608,11 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	}
 
 	/*
+	 * Update the timeout
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
 	 * Set up parity check flag
 	 */
 #define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
@@ -1068,6 +1073,7 @@ int cpm_uart_drv_get_platform_data(struct platform_device *pdev, int is_con)
 	pinfo->port.type = PORT_CPM;
 	pinfo->port.ops = &cpm_uart_pops,
 	pinfo->port.iotype = UPIO_MEM;
+	pinfo->port.fifosize = pinfo->tx_nrfifos * pinfo->tx_fifosize;
 	spin_lock_init(&pinfo->port.lock);
 
 	pinfo->port.irq = of_irq_to_resource(np, 0, NULL);
-- 
1.5.0

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
