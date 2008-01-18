Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79D38DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:05:50 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0I05hQ3008420
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:05:44 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-199.am.freescale.net
	[10.214.72.199])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0I05dKD028206
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 18:05:43 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v3 6/8] Cleanup checkpatch.pl problems in
	mpc52xx_uart.c
Date: Thu, 17 Jan 2008 17:05:36 -0700
Message-Id: <1200614738-25654-7-git-send-email-jrigby@freescale.com>
In-Reply-To: <1200614738-25654-6-git-send-email-jrigby@freescale.com>
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
	<1200614738-25654-2-git-send-email-jrigby@freescale.com>
	<1200614738-25654-3-git-send-email-jrigby@freescale.com>
	<1200614738-25654-4-git-send-email-jrigby@freescale.com>
	<1200614738-25654-5-git-send-email-jrigby@freescale.com>
	<1200614738-25654-6-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In preparation of adding MPC5121 support
cleanup some things that checkpatch.pl complains
about also some minor fixes suggested by
Stephen Rothwell.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 drivers/serial/mpc52xx_uart.c |  204 ++++++++++++++++++++++-------------------
 1 files changed, 109 insertions(+), 95 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 25a91c9..9bf4521 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -36,7 +36,7 @@
  * DCD. However, the pin multiplexing aren't changed and should be set either
  * by the bootloader or in the platform init code.
  *
- * The idx field must be equal to the PSC index ( e.g. 0 for PSC1, 1 for PSC2,
+ * The idx field must be equal to the PSC index (e.g. 0 for PSC1, 1 for PSC2,
  * and so on). So the PSC1 is mapped to /dev/ttyPSC0, PSC2 to /dev/ttyPSC1 and
  * so on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly
  * fpr the console code : without this 1:1 mapping, at early boot time, when we
@@ -68,11 +68,11 @@
 #include <linux/sysrq.h>
 #include <linux/console.h>
 
-#include <asm/delay.h>
-#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 
 #if defined(CONFIG_PPC_MERGE)
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 #else
 #include <linux/platform_device.h>
 #endif
@@ -115,19 +115,20 @@ static void mpc52xx_uart_of_enumerate(void);
 
 
 /* Forward declaration of the interruption handling routine */
-static irqreturn_t mpc52xx_uart_int(int irq,void *dev_id);
+static irqreturn_t mpc52xx_uart_int(int irq, void *dev_id);
 
 
 /* Simple macro to test if a port is console or not. This one is taken
  * for serial_core.c and maybe should be moved to serial_core.h ? */
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
-#define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
+#define uart_console(port) \
+	((port)->cons && (port)->cons->index == (port)->line)
 #else
 #define uart_console(port)	(0)
 #endif
 
 #if defined(CONFIG_PPC_MERGE)
-static struct of_device_id mpc52xx_uart_of_match[] = {
+static const struct of_device_id mpc52xx_uart_of_match[] = {
 	{ .type = "serial", .compatible = "mpc5200-psc-uart", },
 	{},
 };
@@ -163,7 +164,7 @@ mpc52xx_uart_stop_tx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
 	port->read_status_mask &= ~MPC52xx_PSC_IMR_TXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
 
 static void
@@ -171,7 +172,7 @@ mpc52xx_uart_start_tx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
 	port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
 
 static void
@@ -185,7 +186,7 @@ mpc52xx_uart_send_xchar(struct uart_port *port, char ch)
 		/* Make sure tx interrupts are on */
 		/* Truly necessary ??? They should be anyway */
 		port->read_status_mask |= MPC52xx_PSC_IMR_TXRDY;
-		out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
+		out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -196,7 +197,7 @@ mpc52xx_uart_stop_rx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
 	port->read_status_mask &= ~MPC52xx_PSC_IMR_RXRDY;
-	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
+	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
 
 static void
@@ -211,10 +212,10 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	unsigned long flags;
 	spin_lock_irqsave(&port->lock, flags);
 
-	if ( ctl == -1 )
-		out_8(&PSC(port)->command,MPC52xx_PSC_START_BRK);
+	if (ctl == -1)
+		out_8(&PSC(port)->command, MPC52xx_PSC_START_BRK);
 	else
-		out_8(&PSC(port)->command,MPC52xx_PSC_STOP_BRK);
+		out_8(&PSC(port)->command, MPC52xx_PSC_STOP_BRK);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -233,10 +234,10 @@ mpc52xx_uart_startup(struct uart_port *port)
 		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
-	out_8(&psc->command,MPC52xx_PSC_RST_RX);
-	out_8(&psc->command,MPC52xx_PSC_RST_TX);
+	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
-	out_be32(&psc->sicr,0);	/* UART mode DCD ignored */
+	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
 
 	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /16 prescaler on */
 
@@ -246,10 +247,10 @@ mpc52xx_uart_startup(struct uart_port *port)
 	out_be16(&fifo->tfalarm, 0x80);
 
 	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | MPC52xx_PSC_IMR_TXRDY;
-	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
 
-	out_8(&psc->command,MPC52xx_PSC_TX_ENABLE);
-	out_8(&psc->command,MPC52xx_PSC_RX_ENABLE);
+	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
+	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
 
 	return 0;
 }
@@ -260,12 +261,12 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
 	/* Shut down the port.  Leave TX active if on a console port */
-	out_8(&psc->command,MPC52xx_PSC_RST_RX);
+	out_8(&psc->command, MPC52xx_PSC_RST_RX);
 	if (!uart_console(port))
-		out_8(&psc->command,MPC52xx_PSC_RST_TX);
+		out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	port->read_status_mask = 0;
-	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
 
 	/* Release interrupt */
 	free_irq(port->irq, port);
@@ -273,7 +274,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 
 static void
 mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
-                         struct ktermios *old)
+			 struct ktermios *old)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned long flags;
@@ -285,14 +286,14 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	mr1 = 0;
 
 	switch (new->c_cflag & CSIZE) {
-		case CS5:	mr1 |= MPC52xx_PSC_MODE_5_BITS;
-				break;
-		case CS6:	mr1 |= MPC52xx_PSC_MODE_6_BITS;
-				break;
-		case CS7:	mr1 |= MPC52xx_PSC_MODE_7_BITS;
-				break;
-		case CS8:
-		default:	mr1 |= MPC52xx_PSC_MODE_8_BITS;
+	case CS5:	mr1 |= MPC52xx_PSC_MODE_5_BITS;
+		break;
+	case CS6:	mr1 |= MPC52xx_PSC_MODE_6_BITS;
+		break;
+	case CS7:	mr1 |= MPC52xx_PSC_MODE_7_BITS;
+		break;
+	case CS8:
+	default:	mr1 |= MPC52xx_PSC_MODE_8_BITS;
 	}
 
 	if (new->c_cflag & PARENB) {
@@ -334,24 +335,24 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 		udelay(1);
 
 	if (!j)
-		printk(	KERN_ERR "mpc52xx_uart.c: "
+		printk(KERN_ERR "mpc52xx_uart.c: "
 			"Unable to flush RX & TX fifos in-time in set_termios."
-			"Some chars may have been lost.\n" );
+			"Some chars may have been lost.\n");
 
 	/* Reset the TX & RX */
-	out_8(&psc->command,MPC52xx_PSC_RST_RX);
-	out_8(&psc->command,MPC52xx_PSC_RST_TX);
+	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	/* Send new mode settings */
-	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
-	out_8(&psc->mode,mr1);
-	out_8(&psc->mode,mr2);
-	out_8(&psc->ctur,ctr >> 8);
-	out_8(&psc->ctlr,ctr & 0xff);
+	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
+	out_8(&psc->mode, mr1);
+	out_8(&psc->mode, mr2);
+	out_8(&psc->ctur, ctr >> 8);
+	out_8(&psc->ctlr, ctr & 0xff);
 
 	/* Reenable TX & RX */
-	out_8(&psc->command,MPC52xx_PSC_TX_ENABLE);
-	out_8(&psc->command,MPC52xx_PSC_RX_ENABLE);
+	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
+	out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
 
 	/* We're all set, release the lock */
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -366,7 +367,8 @@ mpc52xx_uart_type(struct uart_port *port)
 static void
 mpc52xx_uart_release_port(struct uart_port *port)
 {
-	if (port->flags & UPF_IOREMAP) { /* remapped by us ? */
+	/* remapped by us ? */
+	if (port->flags & UPF_IOREMAP) {
 		iounmap(port->membase);
 		port->membase = NULL;
 	}
@@ -381,7 +383,7 @@ mpc52xx_uart_request_port(struct uart_port *port)
 
 	if (port->flags & UPF_IOREMAP) /* Need to remap ? */
 		port->membase = ioremap(port->mapbase,
-		                        sizeof(struct mpc52xx_psc));
+					sizeof(struct mpc52xx_psc));
 
 	if (!port->membase)
 		return -EINVAL;
@@ -400,22 +402,22 @@ mpc52xx_uart_request_port(struct uart_port *port)
 static void
 mpc52xx_uart_config_port(struct uart_port *port, int flags)
 {
-	if ( (flags & UART_CONFIG_TYPE) &&
-	     (mpc52xx_uart_request_port(port) == 0) )
-	     	port->type = PORT_MPC52xx;
+	if ((flags & UART_CONFIG_TYPE)
+		&& (mpc52xx_uart_request_port(port) == 0))
+		port->type = PORT_MPC52xx;
 }
 
 static int
 mpc52xx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if ( ser->type != PORT_UNKNOWN && ser->type != PORT_MPC52xx )
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_MPC52xx)
 		return -EINVAL;
 
-	if ( (ser->irq != port->irq) ||
-	     (ser->io_type != SERIAL_IO_MEM) ||
-	     (ser->baud_base != port->uartclk)  ||
-	     (ser->iomem_base != (void*)port->mapbase) ||
-	     (ser->hub6 != 0 ) )
+	if ((ser->irq != port->irq) ||
+	    (ser->io_type != SERIAL_IO_MEM) ||
+	    (ser->baud_base != port->uartclk)  ||
+	    (ser->iomem_base != (void *)port->mapbase) ||
+	    (ser->hub6 != 0))
 		return -EINVAL;
 
 	return 0;
@@ -457,8 +459,8 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 	unsigned short status;
 
 	/* While we can read, do so ! */
-	while ( (status = in_be16(&PSC(port)->mpc52xx_psc_status)) &
-	        MPC52xx_PSC_SR_RXRDY) {
+	while ((status = in_be16(&PSC(port)->mpc52xx_psc_status)) &
+		MPC52xx_PSC_SR_RXRDY) {
 
 		/* Get the char */
 		ch = in_8(&PSC(port)->mpc52xx_psc_buffer_8);
@@ -476,9 +478,9 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
-		if ( status & (MPC52xx_PSC_SR_PE |
-		               MPC52xx_PSC_SR_FE |
-		               MPC52xx_PSC_SR_RB) ) {
+		if (status & (MPC52xx_PSC_SR_PE |
+			      MPC52xx_PSC_SR_FE |
+			      MPC52xx_PSC_SR_RB)) {
 
 			if (status & MPC52xx_PSC_SR_RB) {
 				flag = TTY_BREAK;
@@ -489,7 +491,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 				flag = TTY_FRAME;
 
 			/* Clear error condition */
-			out_8(&PSC(port)->command,MPC52xx_PSC_RST_ERR_STAT);
+			out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
 
 		}
 		tty_insert_flip_char(tty, ch, flag);
@@ -570,16 +572,16 @@ mpc52xx_uart_int(int irq, void *dev_id)
 
 		/* Do we need to receive chars ? */
 		/* For this RX interrupts must be on and some chars waiting */
-		if ( status & MPC52xx_PSC_IMR_RXRDY )
+		if (status & MPC52xx_PSC_IMR_RXRDY)
 			keepgoing |= mpc52xx_uart_int_rx_chars(port);
 
 		/* Do we need to send chars ? */
 		/* For this, TX must be ready and TX interrupt enabled */
-		if ( status & MPC52xx_PSC_IMR_TXRDY )
+		if (status & MPC52xx_PSC_IMR_TXRDY)
 			keepgoing |= mpc52xx_uart_int_tx_chars(port);
 
 		/* Limit number of iteration */
-		if ( !(--pass) )
+		if (!(--pass))
 			keepgoing = 0;
 
 	} while (keepgoing);
@@ -598,7 +600,7 @@ mpc52xx_uart_int(int irq, void *dev_id)
 
 static void __init
 mpc52xx_console_get_options(struct uart_port *port,
-                            int *baud, int *parity, int *bits, int *flow)
+			    int *baud, int *parity, int *bits, int *flow)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned char mr1;
@@ -606,7 +608,7 @@ mpc52xx_console_get_options(struct uart_port *port,
 	pr_debug("mpc52xx_console_get_options(port=%p)\n", port);
 
 	/* Read the mode registers */
-	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
+	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);
 
 	/* CT{U,L}R are write-only ! */
@@ -618,11 +620,18 @@ mpc52xx_console_get_options(struct uart_port *port,
 
 	/* Parse them */
 	switch (mr1 & MPC52xx_PSC_MODE_BITS_MASK) {
-		case MPC52xx_PSC_MODE_5_BITS:	*bits = 5; break;
-		case MPC52xx_PSC_MODE_6_BITS:	*bits = 6; break;
-		case MPC52xx_PSC_MODE_7_BITS:	*bits = 7; break;
-		case MPC52xx_PSC_MODE_8_BITS:
-		default:			*bits = 8;
+	case MPC52xx_PSC_MODE_5_BITS:
+		*bits = 5;
+		break;
+	case MPC52xx_PSC_MODE_6_BITS:
+		*bits = 6;
+		break;
+	case MPC52xx_PSC_MODE_7_BITS:
+		*bits = 7;
+		break;
+	case MPC52xx_PSC_MODE_8_BITS:
+	default:
+		*bits = 8;
 	}
 
 	if (mr1 & MPC52xx_PSC_MODE_PARNONE)
@@ -659,7 +668,7 @@ mpc52xx_console_write(struct console *co, const char *s, unsigned int count)
 		/* Wait the TX buffer to be empty */
 		j = 20000;	/* Maximum wait */
 		while (!(in_be16(&psc->mpc52xx_psc_status) &
-		         MPC52xx_PSC_SR_TXEMP) && --j)
+			 MPC52xx_PSC_SR_TXEMP) && --j)
 			udelay(1);
 	}
 
@@ -732,16 +741,18 @@ mpc52xx_console_setup(struct console *co, char *options)
 	}
 
 	pr_debug("Console on ttyPSC%x is %s\n",
-	         co->index, mpc52xx_uart_nodes[co->index]->full_name);
+		 co->index, mpc52xx_uart_nodes[co->index]->full_name);
 
 	/* Fetch register locations */
-	if ((ret = of_address_to_resource(np, 0, &res)) != 0) {
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
 		pr_debug("Could not get resources for PSC%x\n", co->index);
 		return ret;
 	}
 
 	/* Search for bus-frequency property in this node or a parent */
-	if ((ipb_freq = mpc52xx_find_ipb_freq(np)) == 0) {
+	ipb_freq = mpc52xx_find_ipb_freq(np);
+	if (ipb_freq == 0) {
 		pr_debug("Could not find IPB bus frequency!\n");
 		return -EINVAL;
 	}
@@ -759,7 +770,8 @@ mpc52xx_console_setup(struct console *co, char *options)
 		return -EINVAL;
 
 	pr_debug("mpc52xx-psc uart at %p, mapped to %p, irq=%x, freq=%i\n",
-	         (void*)port->mapbase, port->membase, port->irq, port->uartclk);
+		 (void *)port->mapbase, port->membase,
+		 port->irq, port->uartclk);
 
 	/* Setup the port parameters accoding to options */
 	if (options)
@@ -768,7 +780,7 @@ mpc52xx_console_setup(struct console *co, char *options)
 		mpc52xx_console_get_options(port, &baud, &parity, &bits, &flow);
 
 	pr_debug("Setting console parameters: %i %i%c1 flow=%c\n",
-	         baud, bits, parity, flow);
+		 baud, bits, parity, flow);
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
@@ -783,7 +795,7 @@ static struct console mpc52xx_console = {
 	.device	= uart_console_device,
 	.setup	= mpc52xx_console_setup,
 	.flags	= CON_PRINTBUFFER,
-	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyPSC0 ) */
+	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyPSC0) */
 	.data	= &mpc52xx_uart_driver,
 };
 
@@ -811,7 +823,6 @@ console_initcall(mpc52xx_console_init);
 /* ======================================================================== */
 
 static struct uart_driver mpc52xx_uart_driver = {
-	.owner		= THIS_MODULE,
 	.driver_name	= "mpc52xx_psc_uart",
 	.dev_name	= "ttyPSC",
 	.major		= SERIAL_PSC_MAJOR,
@@ -839,7 +850,7 @@ mpc52xx_uart_probe(struct platform_device *dev)
 	if (idx < 0 || idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
 
-	if (!mpc52xx_match_psc_function(idx,"uart"))
+	if (!mpc52xx_match_psc_function(idx, "uart"))
 		return -ENODEV;
 
 	/* Init the port structure */
@@ -850,13 +861,13 @@ mpc52xx_uart_probe(struct platform_device *dev)
 	port->fifosize	= 512;
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF |
-			  ( uart_console(port) ? 0 : UPF_IOREMAP );
+			  (uart_console(port) ? 0 : UPF_IOREMAP);
 	port->line	= idx;
 	port->ops	= &mpc52xx_uart_ops;
 	port->dev	= &dev->dev;
 
 	/* Search for IRQ and mapbase */
-	for (i=0 ; i<dev->num_resources ; i++, res++) {
+	for (i = 0 ; i < dev->num_resources ; i++, res++) {
 		if (res->flags & IORESOURCE_MEM)
 			port->mapbase = res->start;
 		else if (res->flags & IORESOURCE_IRQ)
@@ -868,7 +879,7 @@ mpc52xx_uart_probe(struct platform_device *dev)
 	/* Add the port to the uart sub-system */
 	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
 	if (!ret)
-		platform_set_drvdata(dev, (void*)port);
+		platform_set_drvdata(dev, (void *)port);
 
 	return ret;
 }
@@ -919,6 +930,7 @@ static struct platform_driver mpc52xx_uart_platform_driver = {
 	.resume		= mpc52xx_uart_resume,
 #endif
 	.driver		= {
+		.owner	= THIS_MODULE,
 		.name	= "mpc52xx-psc",
 	},
 };
@@ -948,10 +960,11 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
 	pr_debug("Found %s assigned to ttyPSC%x\n",
-	         mpc52xx_uart_nodes[idx]->full_name, idx);
+		 mpc52xx_uart_nodes[idx]->full_name, idx);
 
 	/* Search for bus-frequency property in this node or a parent */
-	if ((ipb_freq = mpc52xx_find_ipb_freq(op->node)) == 0) {
+	ipb_freq = mpc52xx_find_ipb_freq(op->node);
+	if (ipb_freq == 0) {
 		dev_dbg(&op->dev, "Could not find IPB bus frequency!\n");
 		return -EINVAL;
 	}
@@ -964,22 +977,23 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	port->fifosize	= 512;
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF |
-			  ( uart_console(port) ? 0 : UPF_IOREMAP );
+			  (uart_console(port) ? 0 : UPF_IOREMAP);
 	port->line	= idx;
 	port->ops	= &mpc52xx_uart_ops;
 	port->dev	= &op->dev;
 
 	/* Search for IRQ and mapbase */
-	if ((ret = of_address_to_resource(op->node, 0, &res)) != 0)
+	ret = of_address_to_resource(op->node, 0, &res);
+	if (ret)
 		return ret;
 
 	port->mapbase = res.start;
 	port->irq = irq_of_parse_and_map(op->node, 0);
 
 	dev_dbg(&op->dev, "mpc52xx-psc uart at %p, irq=%x, freq=%i\n",
-	        (void*)port->mapbase, port->irq, port->uartclk);
+		(void *)port->mapbase, port->irq, port->uartclk);
 
-	if ((port->irq==NO_IRQ) || !port->mapbase) {
+	if ((port->irq == NO_IRQ) || !port->mapbase) {
 		printk(KERN_ERR "Could not allocate resources for PSC\n");
 		return -EINVAL;
 	}
@@ -987,7 +1001,7 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	/* Add the port to the uart sub-system */
 	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
 	if (!ret)
-		dev_set_drvdata(&op->dev, (void*)port);
+		dev_set_drvdata(&op->dev, (void *)port);
 
 	return ret;
 }
@@ -1050,6 +1064,7 @@ mpc52xx_uart_of_assign(struct device_node *np, int idx)
 	if (idx < 0)
 		return; /* No free slot; abort */
 
+	of_node_get(np);
 	/* If the slot is already occupied, then swap slots */
 	if (mpc52xx_uart_nodes[idx] && (free_idx != -1))
 		mpc52xx_uart_nodes[free_idx] = mpc52xx_uart_nodes[idx];
@@ -1059,7 +1074,7 @@ mpc52xx_uart_of_assign(struct device_node *np, int idx)
 static void
 mpc52xx_uart_of_enumerate(void)
 {
-	static int enum_done = 0;
+	static int enum_done;
 	struct device_node *np;
 	const unsigned int *devno;
 	int i;
@@ -1073,7 +1088,7 @@ mpc52xx_uart_of_enumerate(void)
 
 		/* Is a particular device number requested? */
 		devno = of_get_property(np, "port-number", NULL);
-		mpc52xx_uart_of_assign(of_node_get(np), devno ? *devno : -1);
+		mpc52xx_uart_of_assign(np, devno ? *devno : -1);
 	}
 
 	enum_done = 1;
@@ -1081,15 +1096,13 @@ mpc52xx_uart_of_enumerate(void)
 	for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
 		if (mpc52xx_uart_nodes[i])
 			pr_debug("%s assigned to ttyPSC%x\n",
-			         mpc52xx_uart_nodes[i]->full_name, i);
+				 mpc52xx_uart_nodes[i]->full_name, i);
 	}
 }
 
 MODULE_DEVICE_TABLE(of, mpc52xx_uart_of_match);
 
 static struct of_platform_driver mpc52xx_uart_of_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "mpc52xx-psc-uart",
 	.match_table	= mpc52xx_uart_of_match,
 	.probe		= mpc52xx_uart_of_probe,
 	.remove		= mpc52xx_uart_of_remove,
@@ -1115,7 +1128,8 @@ mpc52xx_uart_init(void)
 
 	printk(KERN_INFO "Serial: MPC52xx PSC UART driver\n");
 
-	if ((ret = uart_register_driver(&mpc52xx_uart_driver)) != 0) {
+	ret = uart_register_driver(&mpc52xx_uart_driver);
+	if (ret) {
 		printk(KERN_ERR "%s: uart_register_driver failed (%i)\n",
 		       __FILE__, ret);
 		return ret;
-- 
1.5.3.5.726.g41a7a
