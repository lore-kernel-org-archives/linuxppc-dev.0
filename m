Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v1 20/24] fs_enet: OF clock lookup (non-fatal),
 prepare and enable
Date: Tue, 16 Jul 2013 08:05:55 +0200
Message-Id: <1373954759-23947-1-git-send-email-gsi@denx.de>
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
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

device tree based clock lookup, must prepare clocks before enabling
them, unprepare after disable, error check in the clock setup, remove
the pre-enable workaround in the MPC512x platform's clock driver

this change implements non-fatal clock lookup since not all platforms
provide device tree specs for clocks, but failure to enable a specified
clock is considered fatal

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c      |    1 -
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |   27 +++++++++++++++++++-
 include/linux/fs_enet_pd.h                         |    3 +++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 29c51a5..31d0cf3 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -692,7 +692,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_prepare_enable(clks[MPC512x_CLK_LPC]);	/* boot media */
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
-	clk_prepare_enable(clks[MPC512x_CLK_FEC]);	/* network, NFS */
 	/*
 	 * some have their individual clock subtree with separate clock
 	 * items and their individual enable counters, yet share a
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 8de53a1..df92e12 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1020,6 +1020,21 @@ static int fs_enet_probe(struct platform_device *ofdev)
 		fpi->cp_command = *data;
 	}
 
+	/* make clock lookup non-fatal (the driver is shared among platforms),
+	 * but require enable to succeed when a clock was specified/found
+	 */
+	fpi->clk_per = clk_get(&ofdev->dev, "per");
+	if (IS_ERR(fpi->clk_per))
+		fpi->clk_per = NULL;
+	if (fpi->clk_per) {
+		int err;
+		err = clk_prepare_enable(fpi->clk_per);
+		if (err) {
+			ret = err;
+			goto out_clk_put;
+		}
+	}
+
 	fpi->rx_ring = 32;
 	fpi->tx_ring = 32;
 	fpi->rx_copybreak = 240;
@@ -1028,7 +1043,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	fpi->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
 	if ((!fpi->phy_node) && (!of_get_property(ofdev->dev.of_node, "fixed-link",
 						  NULL)))
-		goto out_free_fpi;
+		goto out_clk_dis;
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec")) {
 		phy_connection_type = of_get_property(ofdev->dev.of_node,
@@ -1108,6 +1123,12 @@ out_free_dev:
 	free_netdev(ndev);
 out_put:
 	of_node_put(fpi->phy_node);
+out_clk_dis:
+	if (fpi->clk_per)
+		clk_disable_unprepare(fpi->clk_per);
+out_clk_put:
+	if (fpi->clk_per)
+		clk_put(fpi->clk_per);
 out_free_fpi:
 	kfree(fpi);
 	return ret;
@@ -1124,6 +1145,10 @@ static int fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
 	of_node_put(fep->fpi->phy_node);
+	if (fep->fpi->clk_per) {
+		clk_disable_unprepare(fep->fpi->clk_per);
+		clk_put(fep->fpi->clk_per);
+	}
 	free_netdev(ndev);
 	return 0;
 }
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 51b7934..a978d0d 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -16,6 +16,7 @@
 #ifndef FS_ENET_PD_H
 #define FS_ENET_PD_H
 
+#include <linux/clk.h>
 #include <linux/string.h>
 #include <linux/of_mdio.h>
 #include <asm/types.h>
@@ -142,6 +143,8 @@ struct fs_platform_info {
 
 	int use_rmii;		/* use RMII mode 	       */
 	int has_phy;            /* if the network is phy container as well...*/
+
+	struct clk *clk_per;	/* 'per' clock for register access */
 };
 struct fs_mii_fec_platform_info {
 	u32 irq[32];
-- 
1.7.10.4
