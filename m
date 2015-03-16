Return-Path: <fabf@skynet.be>
Received: from mailrelay118.isp.belgacom.be (mailrelay118.isp.belgacom.be
 [195.238.20.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 7EF9C1A0A09
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 06:18:42 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/35 linux-next] tty: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:11 +0100
Message-Id: <1426533469-25458-6-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Barry Song <baohua@kernel.org>,
 kernel@stlinux.com, Stephen Warren <swarren@wwwdotorg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Patrice Chotard <patrice.chotard@st.com>, Timur Tabi <timur@tabi.org>,
 Fabian Frederick <fabf@skynet.be>, Thierry Reding <thierry.reding@gmail.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 linux-tegra@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
 Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 Maxime Coquelin <maxime.coquelin@st.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/tty/serial/apbuart.c                | 2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 +-
 drivers/tty/serial/fsl_lpuart.c             | 2 +-
 drivers/tty/serial/mpc52xx_uart.c           | 2 +-
 drivers/tty/serial/mxs-auart.c              | 2 +-
 drivers/tty/serial/of_serial.c              | 4 ++--
 drivers/tty/serial/pmac_zilog.c             | 2 +-
 drivers/tty/serial/pxa.c                    | 2 +-
 drivers/tty/serial/serial-tegra.c           | 2 +-
 drivers/tty/serial/sirfsoc_uart.c           | 2 +-
 drivers/tty/serial/st-asc.c                 | 2 +-
 drivers/tty/serial/uartlite.c               | 2 +-
 drivers/tty/serial/ucc_uart.c               | 2 +-
 drivers/tty/serial/xilinx_uartps.c          | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 4f0f95e..f3af317 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -572,7 +572,7 @@ static int apbuart_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id apbuart_match[] = {
+static const struct of_device_id apbuart_match[] = {
 	{
 	 .name = "GAISLER_APBUART",
 	 },
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index fddb1fd..08431ad 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1435,7 +1435,7 @@ static int cpm_uart_remove(struct platform_device *ofdev)
 	return uart_remove_one_port(&cpm_reg, &pinfo->port);
 }
 
-static struct of_device_id cpm_uart_match[] = {
+static const struct of_device_id cpm_uart_match[] = {
 	{
 		.compatible = "fsl,cpm1-smc-uart",
 	},
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b1893f3..946273a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -257,7 +257,7 @@ struct lpuart_port {
 	struct timer_list	lpuart_timer;
 };
 
-static struct of_device_id lpuart_dt_ids[] = {
+static const struct of_device_id lpuart_dt_ids[] = {
 	{
 		.compatible = "fsl,vf610-lpuart",
 	},
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3308ef2..1589f17 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1717,7 +1717,7 @@ static struct uart_driver mpc52xx_uart_driver = {
 /* OF Platform Driver                                                       */
 /* ======================================================================== */
 
-static struct of_device_id mpc52xx_uart_of_match[] = {
+static const struct of_device_id mpc52xx_uart_of_match[] = {
 #ifdef CONFIG_PPC_MPC52xx
 	{ .compatible = "fsl,mpc5200b-psc-uart", .data = &mpc5200b_psc_ops, },
 	{ .compatible = "fsl,mpc5200-psc-uart", .data = &mpc52xx_psc_ops, },
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 20a863b..f7e5825 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -176,7 +176,7 @@ static struct platform_device_id mxs_auart_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
 
-static struct of_device_id mxs_auart_dt_ids[] = {
+static const struct of_device_id mxs_auart_dt_ids[] = {
 	{
 		.compatible = "fsl,imx28-auart",
 		.data = &mxs_auart_devtype[IMX28_AUART]
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 33fb94f..d8c4eea 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -155,7 +155,7 @@ out:
 /*
  * Try to register a serial port
  */
-static struct of_device_id of_platform_serial_table[];
+static const struct of_device_id of_platform_serial_table[];
 static int of_platform_serial_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
@@ -320,7 +320,7 @@ static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
 /*
  * A few common types, add more as needed.
  */
-static struct of_device_id of_platform_serial_table[] = {
+static const struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "ns8250",   .data = (void *)PORT_8250, },
 	{ .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .compatible = "ns16550a", .data = (void *)PORT_16550A, },
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 8f51579..e156e39 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1846,7 +1846,7 @@ static int __init pmz_register(void)
 
 #ifdef CONFIG_PPC_PMAC
 
-static struct of_device_id pmz_match[] = 
+static const struct of_device_id pmz_match[] =
 {
 	{
 	.name		= "ch-a",
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index d5d0626..9becba6 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -824,7 +824,7 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 };
 #endif
 
-static struct of_device_id serial_pxa_dt_ids[] = {
+static const struct of_device_id serial_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-uart", },
 	{ .compatible = "mrvl,mmp-uart", },
 	{}
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 48e6e41..1d5ea39 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1251,7 +1251,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.support_clk_src_div		= true,
 };
 
-static struct of_device_id tegra_uart_of_match[] = {
+static const struct of_device_id tegra_uart_of_match[] = {
 	{
 		.compatible	= "nvidia,tegra30-hsuart",
 		.data		= &tegra30_uart_chip_data,
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 27ed0e9..9de3eab 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1269,7 +1269,7 @@ static struct uart_driver sirfsoc_uart_drv = {
 #endif
 };
 
-static struct of_device_id sirfsoc_uart_ids[] = {
+static const struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,prima2-uart", .data = &sirfsoc_uart,},
 	{ .compatible = "sirf,atlas7-uart", .data = &sirfsoc_uart},
 	{ .compatible = "sirf,prima2-usp-uart", .data = &sirfsoc_usp},
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 712b03a..d625664 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -720,7 +720,7 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id asc_match[] = {
+static const struct of_device_id asc_match[] = {
 	{ .compatible = "st,asc", },
 	{},
 };
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 189f52e..708eead 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -622,7 +622,7 @@ static int ulite_release(struct device *dev)
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
-static struct of_device_id ulite_of_match[] = {
+static const struct of_device_id ulite_of_match[] = {
 	{ .compatible = "xlnx,opb-uartlite-1.00.b", },
 	{ .compatible = "xlnx,xps-uartlite-1.00.a", },
 	{}
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 14d10fc..7d2532b 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1473,7 +1473,7 @@ static int ucc_uart_remove(struct platform_device *ofdev)
 	return 0;
 }
 
-static struct of_device_id ucc_uart_match[] = {
+static const struct of_device_id ucc_uart_match[] = {
 	{
 		.type = "serial",
 		.compatible = "ucc_uart",
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8f9c543..09258de 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1459,7 +1459,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id cdns_uart_of_match[] = {
+static const struct of_device_id cdns_uart_of_match[] = {
 	{ .compatible = "xlnx,xuartps", },
 	{ .compatible = "cdns,uart-r1p8", },
 	{}
-- 
2.1.0
