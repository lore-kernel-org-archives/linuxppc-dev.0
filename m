Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8BC58DDF9D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:40:19 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 773B28810
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:40:27 +0400 (SAMT)
Date: Thu, 24 Jan 2008 18:40:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] [POWERPC][SPI] use brg-frequency for SPI in QE
Message-ID: <20080124154003.GC23246@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080124151850.GA15190@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In case of QE we can use brg-frequency (which is qeclk/2).
Thus no need to divide sysclk in the spi_mpc83xx.

This patch also adds code to use get_brgfreq() on QE chips.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/powerpc/sysdev/fsl_soc.c |   44 ++++++++++++++++++++++++++++------------
 drivers/spi/spi_mpc83xx.c     |    6 +----
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 26f7d83..f4473ad 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -75,7 +75,7 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
-#if defined(CONFIG_CPM2) || defined(CONFIG_8xx)
+#if defined(CONFIG_CPM2) || defined(CONFIG_QUICC_ENGINE) || defined(CONFIG_8xx)
 
 static u32 brgfreq = -1;
 
@@ -100,11 +100,21 @@ u32 get_brgfreq(void)
 
 	/* Legacy device binding -- will go away when no users are left. */
 	node = of_find_node_by_type(NULL, "cpm");
+	if (!node)
+		node = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!node)
+		node = of_find_node_by_type(NULL, "qe");
+
 	if (node) {
 		prop = of_get_property(node, "brg-frequency", &size);
 		if (prop && size == 4)
 			brgfreq = *prop;
 
+		if (brgfreq == -1 || brgfreq == 0) {
+			prop = of_get_property(node, "bus-frequency", &size);
+			if (prop && size == 4)
+				brgfreq = *prop / 2;
+		}
 		of_node_put(node);
 	}
 
@@ -1273,22 +1283,30 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 {
 	struct device_node *np;
 	unsigned int i;
-	const u32 *sysclk;
+	u32 sysclk;
 
 	/* SPI controller is either clocked from QE or SoC clock */
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np)
-		np = of_find_node_by_type(NULL, "qe");
+	sysclk = get_brgfreq();
+	if (sysclk == -1) {
+		const u32 *freq;
+		int size;
 
-	if (!np)
 		np = of_find_node_by_type(NULL, "soc");
+		if (!np)
+			return -ENODEV;
+
+		freq = of_get_property(np, "clock-frequency", &size);
+		if (!freq || size != sizeof(*freq) || *freq == 0) {
+			freq = of_get_property(np, "bus-frequency", &size);
+			if (!freq || size != sizeof(*freq) || *freq == 0) {
+				of_node_put(np);
+				return -ENODEV;
+			}
+		}
 
-	if (!np)
-		return -ENODEV;
-
-	sysclk = of_get_property(np, "bus-frequency", NULL);
-	if (!sysclk)
-		return -ENODEV;
+		sysclk = *freq;
+		of_node_put(np);
+	}
 
 	for (np = NULL, i = 1;
 	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
@@ -1305,7 +1323,7 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 
 		memset(res, 0, sizeof(res));
 
-		pdata.sysclk = *sysclk;
+		pdata.sysclk = sysclk;
 
 		prop = of_get_property(np, "reg", NULL);
 		if (!prop)
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 4580b9c..04f7cd9 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -436,11 +436,7 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 	mpc83xx_spi->qe_mode = pdata->qe_mode;
 	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
 	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
-
-	if (mpc83xx_spi->qe_mode)
-		mpc83xx_spi->spibrg = pdata->sysclk / 2;
-	else
-		mpc83xx_spi->spibrg = pdata->sysclk;
+	mpc83xx_spi->spibrg = pdata->sysclk;
 
 	mpc83xx_spi->rx_shift = 0;
 	mpc83xx_spi->tx_shift = 0;
-- 
1.5.2.2
