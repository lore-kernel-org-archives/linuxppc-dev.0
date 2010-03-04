Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id DB032B7CC1
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 06:00:17 +1100 (EST)
Date: Thu, 04 Mar 2010 20:00:14 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [Patch v.3] mpc5200b/uart: improve baud rate calculation (reach
	high baud rates, better accuracy)
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, "Likely, Grant"
	<grant.likely@secretlab.ca>
Message-Id: <1267729214.5965.0@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the MPC5200B, make very high baud rates (e.g. 3 MBaud) accessible and
achieve a higher precision for high baud rates in general.  This is done by
selecting the appropriate prescaler (/4 or /32).  As to keep the code clean=
,
the getuartclk method has been dropped, and all calculations are done in a
new set_baudrate method.

Notes: only "fsl,mpc5200b-psc-uart" compatible devices benefit from these
improvements.
The 512x may or may not work; the patch keeps the current implementation
(using a /16 prescaler), but according to the data sheet, this is plain
wrong.  See the comment in mpc512x_psc_set_baudrate().  Any insight and
testing of the code would be appreciated.

Tested on a custom 5200B based board, from 110 baud up to 3 MBaud, and with
both "fsl,mpc5200b-psc-uart" and "fsl,mpc5200-psc-uart" devices.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

Changes vs. v.2: Pick up Grant's comments by shifting the calculations to t=
he
new set_baudrate method.


--- linux-2.6.33-orig/drivers/serial/mpc52xx_uart.c	2010-02-24 19:52:17.000=
000000 +0100
+++ linux-2.6.33/drivers/serial/mpc52xx_uart.c	2010-03-04 17:13:47.00000000=
0 +0100
@@ -144,9 +144,21 @@ struct psc_ops {
 	unsigned char	(*read_char)(struct uart_port *port);
 	void		(*cw_disable_ints)(struct uart_port *port);
 	void		(*cw_restore_ints)(struct uart_port *port);
-	unsigned long	(*getuartclk)(void *p);
+	unsigned int	(*set_baudrate)(struct uart_port *port,
+					struct ktermios *new,
+					struct ktermios *old);
 };
=20
+/* setting the prescaler and divisor reg is common for all chips */
+static inline void mpc52xx_set_divisor(struct mpc52xx_psc __iomem *psc,
+				       u16 prescaler, unsigned int divisor)
+{
+	/* select prescaler */
+	out_be16(&psc->mpc52xx_psc_clock_select, prescaler);
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
+}
+
 #ifdef CONFIG_PPC_MPC52xx
 #define FIFO_52xx(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 static void mpc52xx_psc_fifo_init(struct uart_port *port)
@@ -154,9 +166,6 @@ static void mpc52xx_psc_fifo_init(struct
 	struct mpc52xx_psc __iomem *psc =3D PSC(port);
 	struct mpc52xx_psc_fifo __iomem *fifo =3D FIFO_52xx(port);
=20
-	/* /32 prescaler */
-	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
-
 	out_8(&fifo->rfcntl, 0x00);
 	out_be16(&fifo->rfalarm, 0x1ff);
 	out_8(&fifo->tfcntl, 0x07);
@@ -245,15 +254,47 @@ static void mpc52xx_psc_cw_restore_ints(
 	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
=20
-/* Search for bus-frequency property in this node or a parent */
-static unsigned long mpc52xx_getuartclk(void *p)
-{
-	/*
-	 * 5200 UARTs have a / 32 prescaler
-	 * but the generic serial code assumes 16
-	 * so return ipb freq / 2
-	 */
-	return mpc5xxx_get_bus_frequency(p) / 2;
+static unsigned int mpc5200_psc_set_baudrate(struct uart_port *port,
+					     struct ktermios *new,
+					     struct ktermios *old)
+{
+	unsigned int baud;
+	unsigned int divisor;
+
+	/* The 5200 has a fixed /32 prescaler, uartclk contains the ipb freq */
+	baud =3D uart_get_baud_rate(port, new, old,
+				  port->uartclk / (32 * 0xffff) + 1,
+				  port->uartclk / 32);
+	divisor =3D (port->uartclk + 16 * baud) / (32 * baud);
+
+	/* enable the /32 prescaler and set the divisor */
+	mpc52xx_set_divisor(PSC(port), 0xdd00, divisor);
+	return baud;
+}
+
+static unsigned int mpc5200b_psc_set_baudrate(struct uart_port *port,
+					      struct ktermios *new,
+					      struct ktermios *old)
+{
+	unsigned int baud;
+	unsigned int divisor;
+	u16 prescaler;
+
+	/* The 5200B has a selectable /4 or /32 prescaler, uartclk contains the
+	 * ipb freq */
+	baud =3D uart_get_baud_rate(port, new, old,
+				  port->uartclk / (32 * 0xffff) + 1,
+				  port->uartclk / 4);
+	divisor =3D (port->uartclk + 2 * baud) / (4 * baud);
+
+	/* select the proper prescaler and set the divisor */
+	if (divisor > 0xffff) {
+		divisor =3D (divisor + 4) / 8;
+		prescaler =3D 0xdd00; /* /32 */
+	} else
+		prescaler =3D 0xff00; /* /4 */
+	mpc52xx_set_divisor(PSC(port), prescaler, divisor);
+	return baud;
 }
=20
 static struct psc_ops mpc52xx_psc_ops =3D {
@@ -272,7 +313,26 @@ static struct psc_ops mpc52xx_psc_ops =3D=20
 	.read_char =3D mpc52xx_psc_read_char,
 	.cw_disable_ints =3D mpc52xx_psc_cw_disable_ints,
 	.cw_restore_ints =3D mpc52xx_psc_cw_restore_ints,
-	.getuartclk =3D mpc52xx_getuartclk,
+	.set_baudrate =3D mpc5200_psc_set_baudrate,
+};
+
+static struct psc_ops mpc5200b_psc_ops =3D {
+	.fifo_init =3D mpc52xx_psc_fifo_init,
+	.raw_rx_rdy =3D mpc52xx_psc_raw_rx_rdy,
+	.raw_tx_rdy =3D mpc52xx_psc_raw_tx_rdy,
+	.rx_rdy =3D mpc52xx_psc_rx_rdy,
+	.tx_rdy =3D mpc52xx_psc_tx_rdy,
+	.tx_empty =3D mpc52xx_psc_tx_empty,
+	.stop_rx =3D mpc52xx_psc_stop_rx,
+	.start_tx =3D mpc52xx_psc_start_tx,
+	.stop_tx =3D mpc52xx_psc_stop_tx,
+	.rx_clr_irq =3D mpc52xx_psc_rx_clr_irq,
+	.tx_clr_irq =3D mpc52xx_psc_tx_clr_irq,
+	.write_char =3D mpc52xx_psc_write_char,
+	.read_char =3D mpc52xx_psc_read_char,
+	.cw_disable_ints =3D mpc52xx_psc_cw_disable_ints,
+	.cw_restore_ints =3D mpc52xx_psc_cw_restore_ints,
+	.set_baudrate =3D mpc5200b_psc_set_baudrate,
 };
=20
 #endif /* CONFIG_MPC52xx */
@@ -388,9 +448,44 @@ static void mpc512x_psc_cw_restore_ints(
 	out_be32(&FIFO_512x(port)->rximr, port->read_status_mask & 0x7f);
 }
=20
-static unsigned long mpc512x_getuartclk(void *p)
+static unsigned int mpc512x_psc_set_baudrate(struct uart_port *port,
+					     struct ktermios *new,
+					     struct ktermios *old)
 {
-	return mpc5xxx_get_bus_frequency(p);
+	unsigned int baud;
+	unsigned int divisor;
+
+	/*
+	 * FIXME -
+	 *          since ages, the code calculates with a /16 prescaler, but
+	 * never configures it explicitly.  The "MPC5121e Microcontroller
+	 * Reference Manual, Rev. 3" says on pg. 30-10 that the chip supports a
+	 * /32 and a /10 prescaler.  Furthermore, it states that "After reset,
+	 * the prescaler by 10 for the UART mode is selected", but the reset
+	 * register value is 0x0000 which means a /32 prescaler...
+	 *
+	 * Thus, using /16 for the calculation might actually be wrong.
+	 *
+	 * However, U-Boot (in the file cpu/mpc512x/serial.c) also uses a /16
+	 * prescaler, activated by 0xdd00 in the csr.
+	 *
+	 *                        **Confusion Alert**
+	 *
+	 * Unfortunately, I don't have a 512x system, so I cannot say what
+	 * happens in reality...
+	 *
+	 * Albrecht Dre=DF <albrecht.dress@arcor.de>, 2010-MAR-04
+	 */
+
+	/* uartclk contains the ips freq */
+	baud =3D uart_get_baud_rate(port, new, old,
+				  port->uartclk / (16 * 0xffff) + 1,
+				  port->uartclk / 16);
+	divisor =3D (port->uartclk + 8 * baud) / (16 * baud);
+
+	/* FIXME - see above, shamelessly stolen from U-Boot */
+	mpc52xx_set_divisor(PSC(port), 0xdd00, divisor);
+	return baud;
 }
=20
 static struct psc_ops mpc512x_psc_ops =3D {
@@ -409,7 +504,7 @@ static struct psc_ops mpc512x_psc_ops =3D=20
 	.read_char =3D mpc512x_psc_read_char,
 	.cw_disable_ints =3D mpc512x_psc_cw_disable_ints,
 	.cw_restore_ints =3D mpc512x_psc_cw_restore_ints,
-	.getuartclk =3D mpc512x_getuartclk,
+	.set_baudrate =3D mpc512x_psc_set_baudrate,
 };
 #endif
=20
@@ -564,8 +659,8 @@ mpc52xx_uart_set_termios(struct uart_por
 	struct mpc52xx_psc __iomem *psc =3D PSC(port);
 	unsigned long flags;
 	unsigned char mr1, mr2;
-	unsigned short ctr;
-	unsigned int j, baud, quot;
+	unsigned int j;
+	unsigned int baud;
=20
 	/* Prepare what we're gonna write */
 	mr1 =3D 0;
@@ -602,16 +697,9 @@ mpc52xx_uart_set_termios(struct uart_por
 		mr2 |=3D MPC52xx_PSC_MODE_TXCTS;
 	}
=20
-	baud =3D uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
-	quot =3D uart_get_divisor(port, baud);
-	ctr =3D quot & 0xffff;
-
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
=20
-	/* Update the per-port timeout */
-	uart_update_timeout(port, new->c_cflag, baud);
-
 	/* Do our best to flush TX & RX, so we don't lose anything */
 	/* But we don't wait indefinitely ! */
 	j =3D 5000000;	/* Maximum wait */
@@ -635,8 +723,10 @@ mpc52xx_uart_set_termios(struct uart_por
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);
 	out_8(&psc->mode, mr2);
-	out_8(&psc->ctur, ctr >> 8);
-	out_8(&psc->ctlr, ctr & 0xff);
+	baud =3D psc_ops->set_baudrate(port, new, old);
+
+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
=20
 	if (UART_ENABLE_MS(port, new->c_cflag))
 		mpc52xx_uart_enable_ms(port);
@@ -1007,7 +1097,7 @@ mpc52xx_console_setup(struct console *co
 		return ret;
 	}
=20
-	uartclk =3D psc_ops->getuartclk(np);
+	uartclk =3D mpc5xxx_get_bus_frequency(np);
 	if (uartclk =3D=3D 0) {
 		pr_debug("Could not find uart clock frequency!\n");
 		return -EINVAL;
@@ -1090,6 +1180,7 @@ static struct uart_driver mpc52xx_uart_d
=20
 static struct of_device_id mpc52xx_uart_of_match[] =3D {
 #ifdef CONFIG_PPC_MPC52xx
+	{ .compatible =3D "fsl,mpc5200b-psc-uart", .data =3D &mpc5200b_psc_ops, }=
,
 	{ .compatible =3D "fsl,mpc5200-psc-uart", .data =3D &mpc52xx_psc_ops, },
 	/* binding used by old lite5200 device trees: */
 	{ .compatible =3D "mpc5200-psc-uart", .data =3D &mpc52xx_psc_ops, },
@@ -1122,7 +1213,10 @@ mpc52xx_uart_of_probe(struct of_device *
 	pr_debug("Found %s assigned to ttyPSC%x\n",
 		 mpc52xx_uart_nodes[idx]->full_name, idx);
=20
-	uartclk =3D psc_ops->getuartclk(op->node);
+	/* set the uart clock to the input clock of the psc, the different
+	 * prescalers are taken into account in the set_baudrate() methods
+	 * of the respective chip */
+	uartclk =3D mpc5xxx_get_bus_frequency(op->node);
 	if (uartclk =3D=3D 0) {
 		dev_dbg(&op->dev, "Could not find uart clock frequency!\n");
 		return -EINVAL;
