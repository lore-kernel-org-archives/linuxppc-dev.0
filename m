Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id 3E0FA2C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:26:31 +1100 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] serial/mpc52xx_uart: fix psc clock name for mpc512x
Date: Tue, 12 Mar 2013 22:17:17 +0100
Message-Id: <1363123037-4926-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: Matteo Facchinetti <engineering@sirius-es.it>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matteo Facchinetti <engineering@sirius-es.it>

On platform mpc512x, PSC clock name registered by clk_register()
(clock.c:703) has _mclk suffix.
In mpc512x uart device driver, PSC clock name has _clk suffix.

So change PSC clock name in UART device driver using registered clock.

Signed-off-by: Matteo Facchinetti <engineering@sirius-es.it>
---
 drivers/tty/serial/mpc52xx_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index c0e1fad..018bad9 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -550,7 +550,7 @@ static int mpc512x_psc_clock(struct uart_port *port, int enable)
 		return 0;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_clk", psc_num);
+	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
 	psc_clk = clk_get(port->dev, clk_name);
 	if (IS_ERR(psc_clk)) {
 		dev_err(port->dev, "Failed to get PSC clock entry!\n");
-- 
1.7.10.4
