Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9AF032C04C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:47:19 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 23/31] serial: mpc512x: setup the PSC FIFO clock as well
Date: Tue,  6 Aug 2013 22:44:03 +0200
Message-Id: <1375821851-31609-24-git-send-email-gsi@denx.de>
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

prepare and enable the FIFO clock upon PSC FIFO initialization,
check for and propagage errors when enabling the PSC FIFO clock,
disable and unprepare the FIFO clock upon PSC FIFO uninitialization,
remove the pre-enable workaround from the platform's clock driver

devm_{get,put}_clk() doesn't apply here, as the SoC provides a
single FIFO component which is shared among several PSC components,
thus the FIFO isn't associated with a device (while the PSCs are)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    2 --
 drivers/tty/serial/mpc52xx_uart.c             |   46 +++++++++++++++++++++----
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index bd704b3..803f3be 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -670,8 +670,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_prepare_enable(clks[MPC512x_CLK_MEM]);	/* SRAM */
 	clk_prepare_enable(clks[MPC512x_CLK_IPS]);	/* SoC periph */
 	clk_prepare_enable(clks[MPC512x_CLK_LPC]);	/* boot media */
-	/* some are required yet no dependencies were declared */
-	clk_prepare_enable(clks[MPC512x_CLK_PSC_FIFO]);
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
 	clk_prepare_enable(clks[MPC512x_CLK_DIU]);	/* display */
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index f4d2b70..d16ed6c 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -421,6 +421,7 @@ struct psc_fifoc {
 
 static struct psc_fifoc __iomem *psc_fifoc;
 static unsigned int psc_fifoc_irq;
+static struct clk *psc_fifoc_clk;
 
 static void mpc512x_psc_fifo_init(struct uart_port *port)
 {
@@ -568,36 +569,69 @@ static unsigned int mpc512x_psc_set_baudrate(struct uart_port *port,
 /* Init PSC FIFO Controller */
 static int __init mpc512x_psc_fifoc_init(void)
 {
+	int err;
 	struct device_node *np;
+	struct clk *clk;
+
+	/* default error code, potentially overwritten by clock calls */
+	err = -ENODEV;
 
 	np = of_find_compatible_node(NULL, NULL,
 				     "fsl,mpc5121-psc-fifo");
 	if (!np) {
 		pr_err("%s: Can't find FIFOC node\n", __func__);
-		return -ENODEV;
+		goto out_err;
 	}
 
+	clk = of_clk_get_by_name(np, "per");
+	if (IS_ERR(clk)) {
+		pr_err("%s: Can't lookup FIFO clock\n", __func__);
+		err = PTR_ERR(clk);
+		goto out_ofnode_put;
+	}
+	if (clk_prepare_enable(clk)) {
+		pr_err("%s: Can't enable FIFO clock\n", __func__);
+		clk_put(clk);
+		goto out_ofnode_put;
+	}
+	psc_fifoc_clk = clk;
+
 	psc_fifoc = of_iomap(np, 0);
 	if (!psc_fifoc) {
 		pr_err("%s: Can't map FIFOC\n", __func__);
-		of_node_put(np);
-		return -ENODEV;
+		goto out_clk_disable;
 	}
 
 	psc_fifoc_irq = irq_of_parse_and_map(np, 0);
-	of_node_put(np);
 	if (psc_fifoc_irq == 0) {
 		pr_err("%s: Can't get FIFOC irq\n", __func__);
-		iounmap(psc_fifoc);
-		return -ENODEV;
+		goto out_unmap;
 	}
 
+	of_node_put(np);
 	return 0;
+
+out_unmap:
+	iounmap(psc_fifoc);
+out_clk_disable:
+	clk_disable_unprepare(psc_fifoc_clk);
+	clk_put(psc_fifoc_clk);
+out_ofnode_put:
+	of_node_put(np);
+out_err:
+	return err;
 }
 
 static void __exit mpc512x_psc_fifoc_uninit(void)
 {
 	iounmap(psc_fifoc);
+
+	/* disable the clock, errors are not fatal */
+	if (psc_fifoc_clk) {
+		clk_disable_unprepare(psc_fifoc_clk);
+		clk_put(psc_fifoc_clk);
+		psc_fifoc_clk = NULL;
+	}
 }
 
 /* 512x specific interrupt handler. The caller holds the port lock */
-- 
1.7.10.4
