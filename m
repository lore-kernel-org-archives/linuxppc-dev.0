Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 517DEDDEED
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 04:35:17 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org,
	Sylvain Munaut <tnt@246tnt.com>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH] Don't shutdown mpc5200 serial port if it is a console
Date: Thu, 19 Apr 2007 12:08:33 -0600
Message-Id: <11770061133776-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the serial port gets shut down, then console output stalls.  9 out
of 10 kernel hackers agree, this is a bad thing.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Bartlomiej Sieka <tur@semihalf.com>
---

This is a simple bug fix, but it's not a critical one.  It would be really
nice to get this merged for 2.6.21
 drivers/serial/mpc52xx_uart.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index f8c1761..35669f8 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -257,14 +257,16 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
-	/* Shut down the port, interrupt and all */
-	out_8(&psc->command,MPC52xx_PSC_RST_RX);
-	out_8(&psc->command,MPC52xx_PSC_RST_TX);
+	/* We don't want to shut down a port that is used as a console */
+	if (!uart_console(port)) {
+		out_8(&psc->command,MPC52xx_PSC_RST_RX);
+		out_8(&psc->command,MPC52xx_PSC_RST_TX);
 
-	port->read_status_mask = 0;
-	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+		port->read_status_mask = 0;
+		out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+	}
 
-	/* Release interrupt */
+	/* Release interrupt (OK for console port b/c console uses polling) */
 	free_irq(port->irq, port);
 }
 
-- 
1.5.1
