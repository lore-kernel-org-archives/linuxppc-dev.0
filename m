Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id ECDB9DDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:55:48 +1100 (EST)
Date: Thu, 1 Mar 2007 08:55:42 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/7] mpc52xx suspend: FEC (ethernet)
Message-ID: <20070301075542.GC17184@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
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

It just turns off (and on) leds, and even this in a hackish way.
The right way is probably to figure out how BMCR_PDOWN works.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Index: grant.git/drivers/net/fec_mpc52xx/fec.c
===================================================================
--- grant.git.orig/drivers/net/fec_mpc52xx/fec.c
+++ grant.git/drivers/net/fec_mpc52xx/fec.c
@@ -801,6 +801,58 @@ mpc52xx_fec_remove(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+int mpc52xx_fec_suspend(struct of_device *op, pm_message_t state)
+{
+	struct net_device *ndev = dev_get_drvdata(&op->dev);
+	struct fec_priv *priv = ndev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	netif_stop_queue(ndev);
+	out_be32(&fec->imask, 0x0);
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
+	//fec_mii_resume(ndev);
+
+	fec_mii_init(ndev);
+
+	fec_hw_init(ndev);
+
+	/* restore leds. ugly hack, but fec_mii_resume doesn't work for me */
+	out_be32(&fec->mii_data, 0x50020000 | (0x14 << 18) | 0x0422);
+
+	/* Restart the DMA tasks */
+	sdma_fec_rx_init(priv->rx_sdma, priv->rx_fifo, FEC_RX_BUFFER_SIZE);
+	sdma_fec_tx_init(priv->tx_sdma, priv->tx_fifo);
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
@@ -815,8 +867,8 @@ static struct of_platform_driver mpc52xx
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
@@ -77,6 +77,7 @@ static int mii_queue(struct net_device *
 #define MII_REG_ANER	 6	/* A-N Expansion Register */
 #define MII_REG_ANNPTR	 7	/* A-N Next Page Transmit Register */
 #define MII_REG_ANLPRNPR 8	/* A-N Link Partner Received Next Page Reg. */
+#define MII_REG_LED	20	/* LED Configuration Register */
 
 /* values for phy_status */
 
@@ -527,6 +528,23 @@ int fec_mii_wait(struct net_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+phy_cmd_t phy_cmd_leds_off[] ={ { mk_mii_write(MII_REG_LED, 0x9992), NULL },
+				{ mk_mii_end, } };
+phy_cmd_t phy_cmd_leds_on[] = {	{ mk_mii_write(MII_REG_LED, 0x0422), NULL },
+				{ mk_mii_end, } };
+
+void fec_mii_suspend(struct net_device *dev)
+{
+	mii_do_cmd(dev, phy_cmd_leds_off);
+}
+
+void fec_mii_resume(struct net_device *dev)
+{
+	mii_do_cmd(dev, phy_cmd_leds_on);
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
