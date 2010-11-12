Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B46B3B7123
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Nov 2010 06:04:14 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-serial@vger.kernel.org
Subject: [PATCH] serial: mpc52xx: make printout for type more generic
Date: Fri, 12 Nov 2010 19:47:47 +0100
Message-Id: <1289587667-7341-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The printout for the type should be just "5xxx", so 512x users won't
wonder why they have a mpc52xx-type UART.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---

At least I got confused and thought the wrong type was detected.

 drivers/serial/mpc52xx_uart.c |    6 +++++-
 include/linux/serial_core.h   |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index c4399e2..126ec7f 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -838,7 +838,11 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 static const char *
 mpc52xx_uart_type(struct uart_port *port)
 {
-	return port->type == PORT_MPC52xx ? "MPC52xx PSC" : NULL;
+	/*
+	 * We keep using PORT_MPC52xx for historic reasons although it applies
+	 * for MPC512x, too, but print "MPC5xxx" to not irritate users
+	 */
+	return port->type == PORT_MPC52xx ? "MPC5xxx PSC" : NULL;
 }
 
 static void
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 212eb4c..3b354bf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -95,7 +95,7 @@
 /* PPC CPM type number */
 #define PORT_CPM        58
 
-/* MPC52xx type numbers */
+/* MPC52xx (and MPC512x) type numbers */
 #define PORT_MPC52xx	59
 
 /* IBM icom */
-- 
1.7.2.3
