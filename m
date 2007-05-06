Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E02E8DDE42
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:12 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd8tV027624
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:08 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/8] serial/powerpc: Don't shutdown TX on mpc5200 serial port
	if it is a console
Date: Sun,  6 May 2007 17:38:51 +0200
Message-Id: <11784659381238-git-send-email-tnt@246tNt.com>
In-Reply-To: <11784659372712-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
	<1178465935138-git-send-email-tnt@246tNt.com>
	<11784659368-git-send-email-tnt@246tNt.com>
	<1178465936695-git-send-email-tnt@246tNt.com>
	<11784659371139-git-send-email-tnt@246tNt.com>
	<11784659372712-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

If the serial port gets shut down, then console output stalls.  9 out
of 10 kernel hackers agree, this is a bad thing.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
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
1.5.1.2
