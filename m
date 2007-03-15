Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 0D228DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 21:42:00 +1100 (EST)
Date: Thu, 15 Mar 2007 11:41:58 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/5] mpc52xx suspend: FEC (ethernet)
Message-ID: <20070315104158.GC22215@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315103959.GA22215@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Suspend and resume for FEC on MPC52xx.

Note that resume is a bit different for lite5200b low-power mode.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 drivers/net/fec_mpc52xx/fec.c     |   60 ++++++++++++++++++++++++++++++++++++--
 drivers/net/fec_mpc52xx/fec_phy.c |   17 ++++++++++
 drivers/net/fec_mpc52xx/fec_phy.h |    5 +++
 3 files changed, 80 insertions(+), 2 deletions(-)

Index: grant.git/drivers/net/fec_mpc52xx/fec.c
===================================================================
--- grant.git.orig/drivers/net/fec_mpc52xx/fec.c
+++ grant.git/drivers/net/fec_mpc52xx/fec.c
@@ -801,6 +801,62 @@ mpc52xx_fec_remove(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mpc52xx_fec_suspend(struct of_device *op, pm_message_t state)
+{
+	struct net_device *ndev = dev_get_drvdata(&op->dev);
+	struct fec_priv *priv = ndev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	netif_device_detach(ndev);
+
+	/* Disable the rx and tx tasks. */
+	sdma_disable(priv->rx_sdma);
+	sdma_disable(priv->tx_sdma);
+
+	fec_free_rx_buffers(priv->rx_sdma);
+
+	/* Stop FEC */
+	out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) & ~0x2);
+
+	fec_mii_suspend(ndev);
+
+	return 0;
+}
+
+int mpc52xx_fec_resume(struct of_device *op)
+{
+	struct net_device *ndev = dev_get_drvdata(&op->dev);
+	struct fec_priv *priv = ndev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	/* XXX ugly hack */
+	/* not deep-sleep (but low-power), so re-init hw */
+	if (*(unsigned long *)CONFIG_KERNEL_START != 0x60000000) {
+		*(unsigned long *)CONFIG_KERNEL_START = 0x60000000; // restore
+		fec_mii_init(ndev);
+		fec_hw_init(ndev);
+	} else
+		fec_mii_resume(ndev);
+
+	/* Restart the DMA tasks */
+	sdma_fec_rx_init(priv->rx_sdma, priv->rx_fifo, FEC_RX_BUFFER_SIZE);
+	sdma_fec_tx_init(priv->tx_sdma, priv->tx_fifo);
+
+	/* Start FEC */
+	out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) | 0x2);
+
+	netif_device_attach(ndev);
+
+	if (priv->sequence_done) {		 /* redo the fec_open() */
+		fec_free_rx_buffers(priv->rx_sdma);
+		fec_open(ndev);
+	}
+
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_PPC_MERGE)
 static struct of_device_id mpc52xx_fec_of_match[] = {
 	{ .compatible = "mpc5200-ethernet", },
@@ -815,8 +871,8 @@ static struct of_platform_driver mpc52xx
 	.probe = mpc52xx_fec_probe,
 	.remove = mpc52xx_fec_remove,
 #ifdef CONFIG_PM
-/*	.suspend = mpc52xx_fec_suspend, TODO */
-/*	.resume = mpc52xx_fec_resume, TODO */
+	.suspend = mpc52xx_fec_suspend,
+	.resume = mpc52xx_fec_resume,
 #endif
 	.driver = {
 		.name = DRIVER_NAME,
Index: grant.git/drivers/net/fec_mpc52xx/fec_phy.c
===================================================================
--- grant.git.orig/drivers/net/fec_mpc52xx/fec_phy.c
+++ grant.git/drivers/net/fec_mpc52xx/fec_phy.c
@@ -527,6 +527,23 @@ int fec_mii_wait(struct net_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+phy_cmd_t phy_cmd_off[] = { { mk_mii_write(MII_BMCR, BMCR_PDOWN), NULL },
+			{ mk_mii_end, } };
+phy_cmd_t phy_cmd_on[] =  { { mk_mii_write(MII_BMCR, 0), NULL },
+			{ mk_mii_end, } };
+
+void fec_mii_suspend(struct net_device *dev)
+{
+	mii_do_cmd(dev, phy_cmd_off);
+}
+
+void fec_mii_resume(struct net_device *dev)
+{
+	mii_do_cmd(dev, phy_cmd_on);
+}
+#endif
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dale Farnsworth");
 MODULE_DESCRIPTION("PHY driver for Motorola MPC52xx FEC");
Index: grant.git/drivers/net/fec_mpc52xx/fec_phy.h
===================================================================
--- grant.git.orig/drivers/net/fec_mpc52xx/fec_phy.h
+++ grant.git/drivers/net/fec_mpc52xx/fec_phy.h
@@ -71,3 +71,8 @@ extern int fec_mii_wait(struct net_devic
 extern void fec_mii(struct net_device *dev);
 
 extern int fec_ioctl(struct net_device *, struct ifreq *rq, int cmd);
+
+#ifdef CONFIG_PM
+extern void fec_mii_suspend(struct net_device *dev);
+extern void fec_mii_resume(struct net_device *dev);
+#endif
