Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 375DEB7CC2
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 05:23:07 +1100 (EST)
Date: Wed, 03 Mar 2010 19:23:03 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [Patch v.2] mpc5200b/uart: improve baud rate calculation (reach
	high baud rates, better accuracy)
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, "Likely, Grant"
	<grant.likely@secretlab.ca>
Message-Id: <1267640583.4760.0@antares>
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
the getuartclk method has been dropped, and all calculations are done with =
a
"virtual" /4 prescaler for all chips for maximum accuracy.  A new set_divis=
or
method scales down the divisor values found by the generic serial code
appropriately.

Note: only "fsl,mpc5200b-psc-uart" compatible devices benefit from these
improvements.

Tested on a custom 5200B based board, with up to 3 MBaud, and with both
"fsl,mpc5200b-psc-uart" and "fsl,mpc5200-psc-uart" devices.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

Changes vs. v.1: include improvements suggested by Wolfram and Grant (thank=
s a
lot for your helpful input!!): drop getuartclk method and use the highest
possible frequency for calculation, use new psc_ops for the 5200b, let the
set_divisor method do all the dirty work, emit warnings if bad divisor valu=
es
have been selected.
=20

--- linux-2.6.33-orig/drivers/serial/mpc52xx_uart.c	2010-02-24 19:52:17.000=
000000 +0100
+++ linux-2.6.33/drivers/serial/mpc52xx_uart.c	2010-03-03 10:52:04.00000000=
0 +0100
@@ -144,7 +144,8 @@ struct psc_ops {
 	unsigned char	(*read_char)(struct uart_port *port);
 	void		(*cw_disable_ints)(struct uart_port *port);
 	void		(*cw_restore_ints)(struct uart_port *port);
-	unsigned long	(*getuartclk)(void *p);
+	void		(*set_divisor)(struct uart_port *port,
+				       unsigned int divisor);
 };
=20
 #ifdef CONFIG_PPC_MPC52xx
@@ -154,9 +155,6 @@ static void mpc52xx_psc_fifo_init(struct
 	struct mpc52xx_psc __iomem *psc =3D PSC(port);
 	struct mpc52xx_psc_fifo __iomem *fifo =3D FIFO_52xx(port);
=20
-	/* /32 prescaler */
-	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
-
 	out_8(&fifo->rfcntl, 0x00);
 	out_be16(&fifo->rfalarm, 0x1ff);
 	out_8(&fifo->tfcntl, 0x07);
@@ -245,15 +243,55 @@ static void mpc52xx_psc_cw_restore_ints(
 	out_be16(&PSC(port)->mpc52xx_psc_imr, port->read_status_mask);
 }
=20
-/* Search for bus-frequency property in this node or a parent */
-static unsigned long mpc52xx_getuartclk(void *p)
+static void mpc52xx_psc_set_divisor(struct uart_port *port,
+				    unsigned int divisor)
 {
-	/*
-	 * 5200 UARTs have a / 32 prescaler
-	 * but the generic serial code assumes 16
-	 * so return ipb freq / 2
-	 */
-	return mpc5xxx_get_bus_frequency(p) / 2;
+	struct mpc52xx_psc __iomem *psc =3D PSC(port);
+
+	/* adjust divisor for a /32 prescaler; see note in
+	 * mpc52xx_uart_of_probe() */
+	divisor =3D (divisor + 4) / 8;
+	if (divisor > 0xffff) {
+		pr_warning("%s: divisor overflow (%x), use 0xffff\n", __func__,
+			   divisor);
+		divisor =3D 0xffff;
+	} else if (divisor =3D=3D 0) {
+		pr_warning("%s: divisor 0, use 1\n", __func__);
+		divisor =3D 1;
+	}
+
+	/* prescaler */
+	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /32 */
+
+	/* ctr */
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
+}
+
+static void mpc5200b_psc_set_divisor(struct uart_port *port,
+				     unsigned int divisor)
+{
+	struct mpc52xx_psc __iomem *psc =3D PSC(port);
+
+	/* set prescaler; see note in mpc52xx_uart_of_probe() */
+	if (divisor > 0xffff) {
+		divisor =3D (divisor + 4) / 8;
+		out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /32 */
+	} else
+		out_be16(&psc->mpc52xx_psc_clock_select, 0xff00); /* /4 */
+
+	if (divisor > 0xffff) {
+		pr_warning("%s: divisor overflow (%x), use 0xffff\n", __func__,
+			   divisor);
+		divisor =3D 0xffff;
+	} else if (divisor =3D=3D 0) {
+		pr_warning("%s: divisor 0, use 1\n", __func__);
+		divisor =3D 1;
+	}
+
+	/* ctr */
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
 }
=20
 static struct psc_ops mpc52xx_psc_ops =3D {
@@ -272,7 +310,26 @@ static struct psc_ops mpc52xx_psc_ops =3D=20
 	.read_char =3D mpc52xx_psc_read_char,
 	.cw_disable_ints =3D mpc52xx_psc_cw_disable_ints,
 	.cw_restore_ints =3D mpc52xx_psc_cw_restore_ints,
-	.getuartclk =3D mpc52xx_getuartclk,
+	.set_divisor =3D mpc52xx_psc_set_divisor,
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
+	.set_divisor =3D mpc5200b_psc_set_divisor,
 };
=20
 #endif /* CONFIG_MPC52xx */
@@ -388,9 +445,25 @@ static void mpc512x_psc_cw_restore_ints(
 	out_be32(&FIFO_512x(port)->rximr, port->read_status_mask & 0x7f);
 }
=20
-static unsigned long mpc512x_getuartclk(void *p)
+static void mpc512x_psc_set_divisor(struct uart_port *port,
+				    unsigned int divisor)
 {
-	return mpc5xxx_get_bus_frequency(p);
+	struct mpc52xx_psc __iomem *psc =3D PSC(port);
+
+	/* adjust divisor for a /16 prescaler; see note in
+	 * mpc52xx_uart_of_probe() */
+	divisor =3D (divisor + 2) / 4;
+	if (divisor > 0xffff) {
+		pr_warning("%s: divisor overflow (%x), use 0xffff\n", __func__,
+			   divisor);
+		divisor =3D 0xffff;
+	} else if (divisor =3D=3D 0) {
+		pr_warning("%s: divisor 0, use 1\n", __func__);
+		divisor =3D 1;
+	}
+
+	out_8(&psc->ctur, divisor >> 8);
+	out_8(&psc->ctlr, divisor & 0xff);
 }
=20
 static struct psc_ops mpc512x_psc_ops =3D {
@@ -409,7 +482,7 @@ static struct psc_ops mpc512x_psc_ops =3D=20
 	.read_char =3D mpc512x_psc_read_char,
 	.cw_disable_ints =3D mpc512x_psc_cw_disable_ints,
 	.cw_restore_ints =3D mpc512x_psc_cw_restore_ints,
-	.getuartclk =3D mpc512x_getuartclk,
+	.set_divisor =3D mpc512x_psc_set_divisor,
 };
 #endif
=20
@@ -564,7 +637,6 @@ mpc52xx_uart_set_termios(struct uart_por
 	struct mpc52xx_psc __iomem *psc =3D PSC(port);
 	unsigned long flags;
 	unsigned char mr1, mr2;
-	unsigned short ctr;
 	unsigned int j, baud, quot;
=20
 	/* Prepare what we're gonna write */
@@ -604,7 +676,6 @@ mpc52xx_uart_set_termios(struct uart_por
=20
 	baud =3D uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
 	quot =3D uart_get_divisor(port, baud);
-	ctr =3D quot & 0xffff;
=20
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
@@ -635,8 +706,7 @@ mpc52xx_uart_set_termios(struct uart_por
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);
 	out_8(&psc->mode, mr2);
-	out_8(&psc->ctur, ctr >> 8);
-	out_8(&psc->ctlr, ctr & 0xff);
+	psc_ops->set_divisor(port, quot);
=20
 	if (UART_ENABLE_MS(port, new->c_cflag))
 		mpc52xx_uart_enable_ms(port);
@@ -1007,7 +1077,8 @@ mpc52xx_console_setup(struct console *co
 		return ret;
 	}
=20
-	uartclk =3D psc_ops->getuartclk(np);
+	/* see remarks about the uart clock in mpc52xx_uart_of_probe() */
+	uartclk =3D mpc5xxx_get_bus_frequency(np) * 4;
 	if (uartclk =3D=3D 0) {
 		pr_debug("Could not find uart clock frequency!\n");
 		return -EINVAL;
@@ -1090,6 +1161,7 @@ static struct uart_driver mpc52xx_uart_d
=20
 static struct of_device_id mpc52xx_uart_of_match[] =3D {
 #ifdef CONFIG_PPC_MPC52xx
+	{ .compatible =3D "fsl,mpc5200b-psc-uart", .data =3D &mpc5200b_psc_ops, }=
,
 	{ .compatible =3D "fsl,mpc5200-psc-uart", .data =3D &mpc52xx_psc_ops, },
 	/* binding used by old lite5200 device trees: */
 	{ .compatible =3D "mpc5200-psc-uart", .data =3D &mpc52xx_psc_ops, },
@@ -1122,7 +1194,24 @@ mpc52xx_uart_of_probe(struct of_device *
 	pr_debug("Found %s assigned to ttyPSC%x\n",
 		 mpc52xx_uart_nodes[idx]->full_name, idx);
=20
-	uartclk =3D psc_ops->getuartclk(op->node);
+	/*
+	 * Note about the uart clock:
+	 * This series of processors use the ipb clock frequency for the clock
+	 * generation scaled down by prescalers and a 16-bit counter register:
+	 * - the 5200 has a /32 prescaler
+	 * - the 5200B has selectable /4 or /32 prescalers (i.e. the counter
+	 *   reg can be viewed as a 19-bit value, of which we can use either
+	 *   the upper or the lower 16 bits - in the latter case the three
+	 *   MSB's must of course be 0)
+	 * - the 512x has a /16 prescaler
+	 * The generic serial code assumes a prescaler of /16.  As we want to
+	 * achieve the maximum accuracy possible, we let the generic serial
+	 * code perform all calculations with the /4 prescaler, i.e. we have
+	 * to set the uart clock to ipb freq * 4 here.  The set_divisor methods
+	 * for the different chips are responsible for scaling down the divisor
+	 * value appropriately.
+	 */
+	uartclk =3D mpc5xxx_get_bus_frequency(op->node) * 4;
 	if (uartclk =3D=3D 0) {
 		dev_dbg(&op->dev, "Could not find uart clock frequency!\n");
 		return -EINVAL;
