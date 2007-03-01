Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id CC7F5DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:55:07 +1100 (EST)
Date: Thu, 1 Mar 2007 08:55:04 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/7] mpc52xx suspend: UART
Message-ID: <20070301075504.GB17184@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

MPC52xx uart power management.
Not sure how exactly this should be written, but this seems
to work, and works around a few seconds delay in resume.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Index: grant.git/drivers/serial/mpc52xx_uart.c
===================================================================
--- grant.git.orig/drivers/serial/mpc52xx_uart.c
+++ grant.git/drivers/serial/mpc52xx_uart.c
@@ -418,6 +418,22 @@ mpc52xx_uart_verify_port(struct uart_por
 	return 0;
 }
 
+/* just Reenable TX and RX */
+static void mpc52xx_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate)
+{
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+	unsigned long flags;
+
+	/* Get the lock */
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Reenable TX & RX */
+	out_8(&psc->command,MPC52xx_PSC_TX_ENABLE);
+	out_8(&psc->command,MPC52xx_PSC_RX_ENABLE);
+
+	/* We're all set, release the lock */
+	spin_unlock_irqrestore(&port->lock, flags);
+}
 
 static struct uart_ops mpc52xx_uart_ops = {
 	.tx_empty	= mpc52xx_uart_tx_empty,
@@ -432,8 +448,10 @@ static struct uart_ops mpc52xx_uart_ops 
 	.startup	= mpc52xx_uart_startup,
 	.shutdown	= mpc52xx_uart_shutdown,
 	.set_termios	= mpc52xx_uart_set_termios,
-/*	.pm		= mpc52xx_uart_pm,		Not supported yet */
-/*	.set_wake	= mpc52xx_uart_set_wake,	Not supported yet */
+
+	.pm		= mpc52xx_uart_pm,
+/*	.set_wake	= mpc52xx_uart_set_wake,*/
+
 	.type		= mpc52xx_uart_type,
 	.release_port	= mpc52xx_uart_release_port,
 	.request_port	= mpc52xx_uart_request_port,
