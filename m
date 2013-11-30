Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9F5842C033F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:11 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 09/17] serial: mpc512x: adjust for OF based clock lookup
Date: Sat, 30 Nov 2013 23:51:29 +0100
Message-Id: <1385851897-23475-10-git-send-email-gsi@denx.de>
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

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the PSC index,
remove the "psc%d_mclk" template and unconditionally use 'mclk'

acquire and release the "ipg" clock item for register access as well

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
Greg, the difference since v4 of this patch is that v4 took the 'mclk'
and 'ipg' clock items in reverse order, and thus potentially obfuscated
the adjusted name for 'mclk' -- the updated version of the patch is
identical in content but cleaner diff-wise

---
 drivers/tty/serial/mpc52xx_uart.c |   40 ++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index ec06505e3ae6..6345f377a246 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -619,29 +619,55 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 }
 
 static struct clk *psc_mclk_clk[MPC52xx_PSC_MAXNUM];
+static struct clk *psc_ipg_clk[MPC52xx_PSC_MAXNUM];
 
 /* called from within the .request_port() callback (allocation) */
 static int mpc512x_psc_alloc_clock(struct uart_port *port)
 {
 	int psc_num;
-	char clk_name[16];
 	struct clk *clk;
 	int err;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	clk = devm_clk_get(port->dev, clk_name);
+
+	clk = devm_clk_get(port->dev, "mclk");
 	if (IS_ERR(clk)) {
 		dev_err(port->dev, "Failed to get MCLK!\n");
-		return PTR_ERR(clk);
+		err = PTR_ERR(clk);
+		goto out_err;
 	}
 	err = clk_prepare_enable(clk);
 	if (err) {
 		dev_err(port->dev, "Failed to enable MCLK!\n");
-		return err;
+		goto out_err;
 	}
 	psc_mclk_clk[psc_num] = clk;
+
+	clk = devm_clk_get(port->dev, "ipg");
+	if (IS_ERR(clk)) {
+		dev_err(port->dev, "Failed to get IPG clock!\n");
+		err = PTR_ERR(clk);
+		goto out_err;
+	}
+	err = clk_prepare_enable(clk);
+	if (err) {
+		dev_err(port->dev, "Failed to enable IPG clock!\n");
+		goto out_err;
+	}
+	psc_ipg_clk[psc_num] = clk;
+
 	return 0;
+
+out_err:
+	if (psc_mclk_clk[psc_num]) {
+		clk_disable_unprepare(psc_mclk_clk[psc_num]);
+		psc_mclk_clk[psc_num] = NULL;
+	}
+	if (psc_ipg_clk[psc_num]) {
+		clk_disable_unprepare(psc_ipg_clk[psc_num]);
+		psc_ipg_clk[psc_num] = NULL;
+	}
+	return err;
 }
 
 /* called from within the .release_port() callback (release) */
@@ -656,6 +682,10 @@ static void mpc512x_psc_relse_clock(struct uart_port *port)
 		clk_disable_unprepare(clk);
 		psc_mclk_clk[psc_num] = NULL;
 	}
+	if (psc_ipg_clk[psc_num]) {
+		clk_disable_unprepare(psc_ipg_clk[psc_num]);
+		psc_ipg_clk[psc_num] = NULL;
+	}
 }
 
 /* implementation of the .clock() callback (enable/disable) */
-- 
1.7.10.4
