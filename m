Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BDC02C034F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:13 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 10/17] serial: mpc512x: setup the PSC FIFO clock as well
Date: Sat, 30 Nov 2013 23:51:30 +0100
Message-Id: <1385851897-23475-11-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 linux-serial@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 Jiri Slaby <jslaby@suse.cz>
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
disable and unprepare the FIFO clock upon PSC FIFO uninitialization

devm_{get,put}_clk() doesn't apply here, as the SoC provides a
single FIFO component which is shared among several PSC components,
thus the FIFO isn't associated with a device (while the PSCs are)

provide a fallback clock lookup approach in case the OF based clock
lookup for the PSC FIFO fails, this allows for successful operation in
the presence of an outdated device tree which lacks clock specs

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
Greg, the addition since v4 is the clk_get_sys() call for the 'ipg'
clock item (backwards compat for device trees w/o clock specs)

---
 drivers/tty/serial/mpc52xx_uart.c |   50 ++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 6345f377a246..97888f4900ec 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -421,6 +421,7 @@ struct psc_fifoc {
 
 static struct psc_fifoc __iomem *psc_fifoc;
 static unsigned int psc_fifoc_irq;
+static struct clk *psc_fifoc_clk;
 
 static void mpc512x_psc_fifo_init(struct uart_port *port)
 {
@@ -568,36 +569,73 @@ static unsigned int mpc512x_psc_set_baudrate(struct uart_port *port,
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
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		/* backwards compat with device trees that lack clock specs */
+		clk = clk_get_sys(np->name, "ipg");
+	}
+	if (IS_ERR(clk)) {
+		pr_err("%s: Can't lookup FIFO clock\n", __func__);
+		err = PTR_ERR(clk);
+		goto out_ofnode_put;
+	}
+	if (clk_prepare_enable(clk)) {
+		pr_err("%s: Can't enable FIFO clock\n", __func__);
+		clk_put(clk);
+		goto out_ofnode_put;
 	}
+	psc_fifoc_clk = clk;
 
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
