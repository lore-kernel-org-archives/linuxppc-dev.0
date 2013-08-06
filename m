Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 624C12C01B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:44:53 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 02/31] serial: mpc512x: cleanup clock API use
Date: Tue,  6 Aug 2013 22:43:42 +0200
Message-Id: <1375821851-31609-3-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cleanup the clock API use of the UART driver which is shared among the
MPC512x and the MPC5200 platforms
- get, prepare, and enable the MCLK during port allocation; disable,
  unprepare and put the MCLK upon port release; hold a reference to the
  clock over the period of use; check for and propagate enable errors
- fix a buffer overflow for clock names with two digit PSC index numbers
- stick with the PPC_CLOCK 'psc%d_mclk' name for clock lookup, only
  switch to a fixed string later after device tree based clock lookup
  will have become available

to achieve support for MPC512x which is neutral to MPC5200, the
modification was done as follows
- introduce "clock alloc" and "clock release" routines in addition to
  the previous "clock enable/disable" routine in the psc_ops struct
- make the clock allocation a part of the port request (resource
  allocation), and make clock release a part of the port release, such
  that essential resources get allocated early
- just enable/disable the clock from within the .clock() callback
  without any allocation or preparation as the former implementation
  did, since this routine is called from within the startup and shutdown
  callbacks
- all of the above remains a NOP for the MPC5200 platform (no callbacks
  are provided on that platform)
- implementation note: the clock gets enabled upon allocation already
  just in case the clock is not only required for bitrate generation but
  for register access as well

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/tty/serial/mpc52xx_uart.c |   98 ++++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index e1280a2..5be1df3 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -107,6 +107,8 @@ struct psc_ops {
 	unsigned int	(*set_baudrate)(struct uart_port *port,
 					struct ktermios *new,
 					struct ktermios *old);
+	int		(*clock_alloc)(struct uart_port *port);
+	void		(*clock_relse)(struct uart_port *port);
 	int		(*clock)(struct uart_port *port, int enable);
 	int		(*fifoc_init)(void);
 	void		(*fifoc_uninit)(void);
@@ -616,31 +618,73 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 	return IRQ_NONE;
 }
 
-static int mpc512x_psc_clock(struct uart_port *port, int enable)
+static struct clk *psc_mclk_clk[MPC52xx_PSC_MAXNUM];
+
+/* called from within the .request_port() callback (allocation) */
+static int mpc512x_psc_alloc_clock(struct uart_port *port)
 {
-	struct clk *psc_clk;
 	int psc_num;
-	char clk_name[10];
+	char clk_name[16];
+	struct clk *clk;
+	int err;
+
+	psc_num = (port->mapbase & 0xf00) >> 8;
+	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
+	clk = devm_clk_get(port->dev, clk_name);
+	if (IS_ERR(clk)) {
+		dev_err(port->dev, "Failed to get MCLK!\n");
+		return PTR_ERR(clk);
+	}
+	err = clk_prepare_enable(clk);
+	if (err) {
+		dev_err(port->dev, "Failed to enable MCLK!\n");
+		return err;
+	}
+	psc_mclk_clk[psc_num] = clk;
+	return 0;
+}
+
+/* called from within the .release_port() callback (release) */
+static void mpc512x_psc_relse_clock(struct uart_port *port)
+{
+	int psc_num;
+	struct clk *clk;
+
+	psc_num = (port->mapbase & 0xf00) >> 8;
+	clk = psc_mclk_clk[psc_num];
+	if (clk) {
+		clk_disable_unprepare(clk);
+		psc_mclk_clk[psc_num] = NULL;
+	}
+}
+
+/* implementation of the .clock() callback (enable/disable) */
+static int mpc512x_psc_endis_clock(struct uart_port *port, int enable)
+{
+	int psc_num;
+	struct clk *psc_clk;
+	int ret;
 
 	if (uart_console(port))
 		return 0;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	psc_clk = clk_get(port->dev, clk_name);
-	if (IS_ERR(psc_clk)) {
+	psc_clk = psc_mclk_clk[psc_num];
+	if (!psc_clk) {
 		dev_err(port->dev, "Failed to get PSC clock entry!\n");
 		return -ENODEV;
 	}
 
-	dev_dbg(port->dev, "%s %sable\n", clk_name, enable ? "en" : "dis");
-
-	if (enable)
-		clk_enable(psc_clk);
-	else
+	dev_dbg(port->dev, "mclk %sable\n", enable ? "en" : "dis");
+	if (enable) {
+		ret = clk_enable(psc_clk);
+		if (ret)
+			dev_err(port->dev, "Failed to enable MCLK!\n");
+		return ret;
+	} else {
 		clk_disable(psc_clk);
-
-	return 0;
+		return 0;
+	}
 }
 
 static void mpc512x_psc_get_irq(struct uart_port *port, struct device_node *np)
@@ -873,7 +917,9 @@ static struct psc_ops mpc5125_psc_ops = {
 	.cw_disable_ints = mpc5125_psc_cw_disable_ints,
 	.cw_restore_ints = mpc5125_psc_cw_restore_ints,
 	.set_baudrate = mpc5125_psc_set_baudrate,
-	.clock = mpc512x_psc_clock,
+	.clock_alloc = mpc512x_psc_alloc_clock,
+	.clock_relse = mpc512x_psc_relse_clock,
+	.clock = mpc512x_psc_endis_clock,
 	.fifoc_init = mpc512x_psc_fifoc_init,
 	.fifoc_uninit = mpc512x_psc_fifoc_uninit,
 	.get_irq = mpc512x_psc_get_irq,
@@ -906,7 +952,9 @@ static struct psc_ops mpc512x_psc_ops = {
 	.cw_disable_ints = mpc512x_psc_cw_disable_ints,
 	.cw_restore_ints = mpc512x_psc_cw_restore_ints,
 	.set_baudrate = mpc512x_psc_set_baudrate,
-	.clock = mpc512x_psc_clock,
+	.clock_alloc = mpc512x_psc_alloc_clock,
+	.clock_relse = mpc512x_psc_relse_clock,
+	.clock = mpc512x_psc_endis_clock,
 	.fifoc_init = mpc512x_psc_fifoc_init,
 	.fifoc_uninit = mpc512x_psc_fifoc_uninit,
 	.get_irq = mpc512x_psc_get_irq,
@@ -1166,6 +1214,9 @@ mpc52xx_uart_type(struct uart_port *port)
 static void
 mpc52xx_uart_release_port(struct uart_port *port)
 {
+	if (psc_ops->clock_relse)
+		psc_ops->clock_relse(port);
+
 	/* remapped by us ? */
 	if (port->flags & UPF_IOREMAP) {
 		iounmap(port->membase);
@@ -1190,11 +1241,24 @@ mpc52xx_uart_request_port(struct uart_port *port)
 	err = request_mem_region(port->mapbase, sizeof(struct mpc52xx_psc),
 			"mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
 
-	if (err && (port->flags & UPF_IOREMAP)) {
+	if (err)
+		goto out_membase;
+
+	if (psc_ops->clock_alloc) {
+		err = psc_ops->clock_alloc(port);
+		if (err)
+			goto out_mapregion;
+	}
+
+	return 0;
+
+out_mapregion:
+	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
+out_membase:
+	if (port->flags & UPF_IOREMAP) {
 		iounmap(port->membase);
 		port->membase = NULL;
 	}
-
 	return err;
 }
 
-- 
1.7.10.4
