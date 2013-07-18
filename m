Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v2 14/24] serial: mpc512x: setup the PSC FIFO clock as well
Date: Thu, 18 Jul 2013 19:00:45 +0200
Message-Id: <1374166855-7280-15-git-send-email-gsi@denx.de>
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
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
disable and unprepare the FIFO clock upon PSC FIFO uninitialization,
remove the pre-enable workaround from the platform's clock driver

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    2 --
 drivers/tty/serial/mpc52xx_uart.c             |   39 +++++++++++++++++++++----
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b822469..99d197d 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -689,8 +689,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_prepare_enable(clks[MPC512x_CLK_MEM]);	/* SRAM */
 	clk_prepare_enable(clks[MPC512x_CLK_IPS]);	/* SoC periph */
 	clk_prepare_enable(clks[MPC512x_CLK_LPC]);	/* boot media */
-	/* some are required yet no dependencies were declared */
-	clk_prepare_enable(clks[MPC512x_CLK_PSC_FIFO]);
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
 	clk_prepare_enable(clks[MPC512x_CLK_FEC]);	/* network, NFS */
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 8643dcf..3fdadf9 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -421,6 +421,7 @@ struct psc_fifoc {
 
 static struct psc_fifoc __iomem *psc_fifoc;
 static unsigned int psc_fifoc_irq;
+static struct clk *psc_fifoc_clk;
 
 static void mpc512x_psc_fifo_init(struct uart_port *port)
 {
@@ -574,30 +575,56 @@ static int __init mpc512x_psc_fifoc_init(void)
 				     "fsl,mpc5121-psc-fifo");
 	if (!np) {
 		pr_err("%s: Can't find FIFOC node\n", __func__);
-		return -ENODEV;
+		goto out_err;
+	}
+
+	psc_fifoc_clk = of_clk_get_by_name(np, "per");
+	if (IS_ERR(psc_fifoc_clk)) {
+		pr_err("%s: Can't lookup FIFO clock\n", __func__);
+		goto out_ofnode_put;
+	}
+	if (clk_prepare_enable(psc_fifoc_clk)) {
+		pr_err("%s: Can't enable FIFO clock\n", __func__);
+		goto out_clk_put;
 	}
 
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
+out_clk_put:
+	clk_put(psc_fifoc_clk);
+out_ofnode_put:
+	of_node_put(np);
+out_err:
+	return -ENODEV;
 }
 
 static void __exit mpc512x_psc_fifoc_uninit(void)
 {
 	iounmap(psc_fifoc);
+
+	/* disable the clock, errors are not fatal */
+	if (psc_fifoc_clk && !IS_ERR(psc_fifoc_clk)) {
+		clk_disable_unprepare(psc_fifoc_clk);
+		clk_put(psc_fifoc_clk);
+		psc_fifoc_clk = NULL;
+	}
 }
 
 /* 512x specific interrupt handler. The caller holds the port lock */
-- 
1.7.10.4
