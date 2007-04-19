Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id ADE03DDE3D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 05:43:12 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org,
	Sylvain Munaut <tnt@246tnt.com>, Wolfgang Denk <wd@denx.de>,
	Bartlomiej Sieka <tur@semihalf.com>
Subject: [PATCH] Don't shutdown TX on mpc5200 serial port if it is a console
Date: Thu, 19 Apr 2007 13:42:54 -0600
Message-Id: <11770117743675-git-send-email-grant.likely@secretlab.ca>
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
---

Wolfgang, please verify this new patch.  Sylvain rightly pointed out that
RX and interrupts should be turned off regardless.  If it works for you,
please reply with a Signed-of-by line.

Thanks,
g.

 drivers/serial/mpc52xx_uart.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index f8c1761..35f8b86 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -257,9 +257,10 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
-	/* Shut down the port, interrupt and all */
+	/* Shut down the port.  Leave TX active if on a console port */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
-	out_8(&psc->command,MPC52xx_PSC_RST_TX);
+	if (!uart_console(port))
+		out_8(&psc->command,MPC52xx_PSC_RST_TX);
 
 	port->read_status_mask = 0;
 	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
-- 
1.5.1
