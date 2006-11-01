Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 0B26067EC4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 19:40:37 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Remove unneeded memset from mpc52xx_psc_uart probe
	function
Date: Wed,  1 Nov 2006 01:39:55 -0700
Message-Id: <11623704072881-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11623704073308-git-send-email-grant.likely@secretlab.ca>
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
	<11623704061869-git-send-email-grant.likely@secretlab.ca>
	<11623704063907-git-send-email-grant.likely@secretlab.ca>
	<11623704071131-git-send-email-grant.likely@secretlab.ca>
	<1162370407105-git-send-email-grant.likely@secretlab.ca>
	<11623704073308-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This allows the console to continue to work after initializing the port
for full serial access.  However, this is not a proper fix.  The init
behaviour between console and serial driver access must be reengineered

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/serial/mpc52xx_uart.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 09bf8e0..f194010 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -753,7 +753,6 @@ mpc52xx_uart_probe(struct of_device *op,
 	struct resource res;
 	int ret;
 
-	printk("Got here!\n");
 	dev_dbg(&op->dev, "mpc52xx_uart_probe(op=%p, match=%p)\n", op, match);
 
 	/* Check validity & presence */
@@ -763,8 +762,6 @@ mpc52xx_uart_probe(struct of_device *op,
 	/* Init the port structure */
 	port = &mpc52xx_uart_ports[idx];
 
-	memset(port, 0x00, sizeof(struct uart_port));
-
 	spin_lock_init(&port->lock);
 	port->fifosize	= 512;
 	port->iotype	= UPIO_MEM;
-- 
1.4.3.rc2.g0503
