Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 4278167A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Apr 2005 06:02:54 +1000 (EST)
Message-ID: <424DA8E7.3070908@varma-el.com>
Date: Sat, 02 Apr 2005 00:02:47 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
	<4246B8E6.4060401@varma-el.com>
In-Reply-To: <4246B8E6.4060401@varma-el.com>
Content-Type: multipart/mixed; boundary="------------020700080002040609090008"
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/1] Change MPC52xx-fec  platform bus / ppc_sys model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020700080002040609090008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Sylvain

Comments/Commit?

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>


--------------020700080002040609090008
Content-Type: text/plain;
 name="fec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec.diff"

===================================================================


ChangeSet@1.2297, 2005-04-01 23:50:51+04:00, avolkov@varma-el.com
  
  Converted from OCP to Platform usage


 fec.c |  162 +++++++++++++++++++++++++++++++++---------------------------------
 fec.h |    2 
 2 files changed, 84 insertions(+), 80 deletions(-)


diff -Nru a/drivers/net/fec_mpc52xx/fec.c b/drivers/net/fec_mpc52xx/fec.c
--- a/drivers/net/fec_mpc52xx/fec.c	2005-04-01 23:53:43 +04:00
+++ b/drivers/net/fec_mpc52xx/fec.c	2005-04-01 23:53:43 +04:00
@@ -29,7 +29,6 @@
 #include <asm/delay.h>
 #include <asm/ppcboot.h>
 #include <asm/mpc52xx.h>
-#include <asm/ocp.h>
 
 #include <syslib/bestcomm/bestcomm.h>
 #include <syslib/bestcomm/fec.h>
@@ -37,6 +36,8 @@
 #include "fec_phy.h"
 #include "fec.h"
 
+#define DRIVER_NAME "mpc52xx-fec"
+
 static irqreturn_t fec_interrupt(int, void *, struct pt_regs *);
 static irqreturn_t fec_rx_interrupt(int, void *, struct pt_regs *);
 static irqreturn_t fec_tx_interrupt(int, void *, struct pt_regs *);
@@ -109,7 +110,7 @@
 		udelay(1);
 	}
 	if (i == FEC_RESET_DELAY)
-		printk (KERN_ERR "FEC Reset timeout!\n");
+		printk (KERN_ERR DRIVER_NAME ": FEC Reset timeout!\n");
 
 	/* Set station address. */
 	fec_set_paddr(dev, dev->dev_addr);
@@ -488,7 +489,7 @@
 	return 0;
 }
 
-__setup("mpc52xx_mac=", mpc52xx_fec_mac_setup);
+__setup("mpc52xx-mac=", mpc52xx_fec_mac_setup);
 
 static void fec_hw_init(struct net_device *dev)
 {
@@ -547,52 +548,62 @@
 
 
 /* ======================================================================== */
-/* OCP Driver                                                               */
+/* Platform Driver                                                               */
 /* ======================================================================== */
 
 static int __devinit
-mpc52xx_fec_probe(struct ocp_device *ocp)
+mpc52xx_fec_probe(struct device *dev)
 {
 	int ret;
-	struct net_device *dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *ndev;
 	struct fec_priv *priv = NULL;
+	struct resource *mem;
 
 	/* Reserve FEC control zone */
-	if (!request_mem_region(ocp->def->paddr, sizeof(struct mpc52xx_fec),
-	                        "mpc52xx_fec"))
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if ((mem->end - mem->start + 1) != sizeof(struct mpc52xx_fec)) {
+		printk(KERN_ERR DRIVER_NAME 
+			   " - invalid resource size (%lx != %x), check mpc52xx_devices.c\n",
+									mem->end - mem->start + 1, sizeof(struct mpc52xx_fec));
+		return -EINVAL;
+	}
+	
+	if (!request_mem_region(mem->start, sizeof(struct mpc52xx_fec),
+	                        DRIVER_NAME))
 		return -EBUSY;
 
-	/* Get the ether dev & it's private zone */
-	dev = alloc_etherdev(sizeof(struct fec_priv));
-	if (!dev) {
+	/* Get the ether ndev & it's private zone */
+	ndev = alloc_etherdev(sizeof(struct fec_priv));
+	if (!ndev) {
 		ret = -ENOMEM;
 		goto probe_error;
 	}
 	
-	priv = (struct fec_priv *)dev->priv;
+	priv = (struct fec_priv *)ndev->priv;
 	
-	/* Init ether dev with what we have */
-	dev->open		= fec_open;
-	dev->stop		= fec_close;
-	dev->hard_start_xmit	= fec_hard_start_xmit;
-	dev->do_ioctl		= fec_ioctl;
-	dev->get_stats		= fec_get_stats;
-	dev->set_mac_address	= fec_set_mac_address;
-	dev->set_multicast_list = fec_set_multicast_list;
-	dev->tx_timeout		= fec_tx_timeout;
-	dev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
-	dev->flags &= ~IFF_RUNNING;
-	dev->base_addr		= ocp->def->paddr;
-
-	priv->rx_fifo = dev->base_addr + FIELD_OFFSET(mpc52xx_fec,rfifo_data);
-	priv->tx_fifo = dev->base_addr + FIELD_OFFSET(mpc52xx_fec,tfifo_data);
-	priv->t_irq = priv->r_irq = dev->irq = -1; /* IRQ are free for now */
+	/* Init ether ndev with what we have */
+	ndev->open		= fec_open;
+	ndev->stop		= fec_close;
+	ndev->hard_start_xmit	= fec_hard_start_xmit;
+	ndev->do_ioctl		= fec_ioctl;
+	ndev->get_stats		= fec_get_stats;
+	ndev->set_mac_address	= fec_set_mac_address;
+	ndev->set_multicast_list = fec_set_multicast_list;
+	ndev->tx_timeout		= fec_tx_timeout;
+	ndev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
+	ndev->flags &= ~IFF_RUNNING;
+	ndev->base_addr		= mem->start;
+
+	priv->rx_fifo = ndev->base_addr + FIELD_OFFSET(mpc52xx_fec,rfifo_data);
+	priv->tx_fifo = ndev->base_addr + FIELD_OFFSET(mpc52xx_fec,tfifo_data);
+	priv->t_irq = priv->r_irq = ndev->irq = -1; /* IRQ are free for now */
 	
 	spin_lock_init(&priv->lock);
 
 	/* ioremap the zones */
 	priv->fec = (struct mpc52xx_fec *)
-		ioremap(ocp->def->paddr, sizeof(struct mpc52xx_fec));
+		ioremap(mem->start, sizeof(struct mpc52xx_fec));
 	
 	if (!priv->fec) {
 		ret = -ENOMEM;
@@ -618,20 +629,20 @@
 
 	/* Get the IRQ we need one by one */
 		/* Control */
-	dev->irq = ocp->def->irq;
-	if (request_irq(dev->irq, &fec_interrupt, SA_INTERRUPT,
-	                "mpc52xx_fec_ctrl", dev)) {
-		printk(KERN_ERR "mpc52xx_fec: ctrl interrupt request failed\n");
+	ndev->irq = platform_get_irq(pdev, 0);
+	if (request_irq(ndev->irq, &fec_interrupt, SA_INTERRUPT,
+	                DRIVER_NAME "_ctrl", ndev)) {
+		printk(KERN_ERR DRIVER_NAME ": ctrl interrupt request failed\n");
 		ret = -EBUSY;
-		dev->irq = -1;	/* Don't try to free it */
+		ndev->irq = -1;	/* Don't try to free it */
 		goto probe_error;
 	}
 
 		/* RX */
 	priv->r_irq = sdma_irq(priv->rx_sdma);
 	if (request_irq(priv->r_irq, &fec_rx_interrupt, SA_INTERRUPT,
-	                "mpc52xx_fec_rx", dev)) {
-		printk(KERN_ERR "mpc52xx_fec: rx interrupt request failed\n");
+	                DRIVER_NAME "_rx", ndev)) {
+		printk(KERN_ERR DRIVER_NAME ": rx interrupt request failed\n");
 		ret = -EBUSY;
 		priv->r_irq = -1;	/* Don't try to free it */
 		goto probe_error;
@@ -640,8 +651,8 @@
 		/* TX */
 	priv->t_irq = sdma_irq(priv->tx_sdma);
 	if (request_irq(priv->t_irq, &fec_tx_interrupt, SA_INTERRUPT,
-	                "mpc52xx_fec_tx", dev)) {
-		printk(KERN_ERR "mpc52xx_fec: tx interrupt request failed\n");
+	                DRIVER_NAME "_tx", ndev)) {
+		printk(KERN_ERR DRIVER_NAME ": tx interrupt request failed\n");
 		ret = -EBUSY;
 		priv->t_irq = -1;	/* Don't try to free it */
 		goto probe_error;
@@ -649,23 +660,23 @@
 
 	/* MAC address init */
 	if (memcmp(mpc52xx_fec_mac_addr, null_mac, 6) != 0)
-		memcpy(dev->dev_addr, mpc52xx_fec_mac_addr, 6);
+		memcpy(ndev->dev_addr, mpc52xx_fec_mac_addr, 6);
 	else
-		fec_get_paddr(dev, dev->dev_addr);
+		fec_get_paddr(ndev, ndev->dev_addr);
 
 	/* Hardware init */
-	fec_hw_init(dev);
+	fec_hw_init(ndev);
 
 	/* Register the new network device */
-	ret = register_netdev(dev);
+	ret = register_netdev(ndev);
 	if(ret < 0)
 		goto probe_error;
 
 	/* MII init : After register ???? */
-	fec_mii_init(dev);
+	fec_mii_init(ndev);
 	
 	/* We're done ! */
-	ocp_set_drvdata(ocp, dev);
+	dev_set_drvdata(dev, ndev);
 
 	return 0;
 
@@ -673,60 +684,54 @@
 	/* Error handling - free everything that might be allocated */
 probe_error:
 
-	if (dev) {
+	if (ndev) {
 		if (priv->rx_sdma)	sdma_free(priv->rx_sdma);
 		if (priv->tx_sdma)	sdma_free(priv->tx_sdma);
 		
-		if (dev->irq >= 0)	free_irq(dev->irq, dev);
-		if (priv->r_irq >= 0)	free_irq(priv->r_irq, dev);
-		if (priv->t_irq >= 0)	free_irq(priv->t_irq, dev);
+		if (ndev->irq >= 0)	free_irq(ndev->irq, ndev);
+		if (priv->r_irq >= 0)	free_irq(priv->r_irq, ndev);
+		if (priv->t_irq >= 0)	free_irq(priv->t_irq, ndev);
 
 		if (priv->fec)		iounmap(priv->fec);
 	
-		free_netdev(dev);
+		free_netdev(ndev);
 	}
 	
-	release_mem_region(ocp->def->paddr, sizeof(struct mpc52xx_fec));
+	release_mem_region(mem->start, sizeof(struct mpc52xx_fec));
 
 	return ret;
 }
 
-static void
-mpc52xx_fec_remove(struct ocp_device *ocp)
+static int
+mpc52xx_fec_remove(struct device *dev)
 {
-	struct net_device *dev;
+	struct net_device *ndev;
 	struct fec_priv *priv;
 	
-	dev = (struct net_device *) ocp_get_drvdata(ocp);
-	if (!dev)
-		return;
-	priv = (struct fec_priv *) dev->priv;
-
-	unregister_netdev(dev);
-	
-	free_irq(dev->irq, dev);
-	free_irq(priv->r_irq, dev);
-	free_irq(priv->t_irq, dev);
+	ndev = (struct net_device *) dev_get_drvdata(dev);
+	if (!ndev)
+		return 0;
+	priv = (struct fec_priv *) ndev->priv;
+
+	unregister_netdev(ndev);
+	
+	free_irq(ndev->irq, ndev);
+	free_irq(priv->r_irq, ndev);
+	free_irq(priv->t_irq, ndev);
 
 	iounmap(priv->fec);
 	
-	release_mem_region(dev->base_addr, sizeof(struct mpc52xx_fec));
+	release_mem_region(ndev->base_addr, sizeof(struct mpc52xx_fec));
 
-	free_netdev(dev);
+	free_netdev(ndev);
 	
-	ocp_set_drvdata(ocp, NULL);
+	dev_set_drvdata(dev, NULL);
+	return 0;
 }
 
-static struct ocp_device_id mpc52xx_fec_ids[] __devinitdata = {
-	{ .vendor = OCP_VENDOR_FREESCALE, .function = OCP_FUNC_FEC_MPC52xx },
-	{ .vendor = OCP_VENDOR_INVALID /* Terminating entry */ }
-};
-
-MODULE_DEVICE_TABLE(ocp, mpc52xx_fec_ids);
-
-static struct ocp_driver mpc52xx_fec_ocp_driver = {
-	.name		= "mpc52xx_fec",
-	.id_table	= mpc52xx_fec_ids,
+static struct device_driver mpc52xx_fec_driver = {
+	.name	  = DRIVER_NAME,
+	.bus		= &platform_bus_type,
 	.probe		= mpc52xx_fec_probe,
 	.remove		= mpc52xx_fec_remove,
 #ifdef CONFIG_PM
@@ -735,7 +740,6 @@
 #endif
 };
 
-
 /* ======================================================================== */
 /* Module                                                                   */
 /* ======================================================================== */
@@ -743,13 +747,13 @@
 static int __init
 mpc52xx_fec_init(void)
 {
-	return ocp_register_driver(&mpc52xx_fec_ocp_driver);
+	return driver_register(&mpc52xx_fec_driver);
 }
 
 static void __exit
 mpc52xx_fec_exit(void)
 {
-	ocp_unregister_driver(&mpc52xx_fec_ocp_driver);
+	driver_unregister(&mpc52xx_fec_driver);
 }
 
 
diff -Nru a/drivers/net/fec_mpc52xx/fec.h b/drivers/net/fec_mpc52xx/fec.h
--- a/drivers/net/fec_mpc52xx/fec.h	2005-04-01 23:53:43 +04:00
+++ b/drivers/net/fec_mpc52xx/fec.h	2005-04-01 23:53:43 +04:00
@@ -229,7 +229,7 @@
 	u32 r_fdxfc;			/* FEC + 0x2DC */
 	u32 ieee_r_octets_ok;		/* FEC + 0x2E0 */
 
-	u32 reserved10[6];		/* FEC + 0x2E4-2FC */
+	u32 reserved10[7];		/* FEC + 0x2E4-2FC */
 
 	u32 reserved11[64];		/* FEC + 0x300-3FF */
 };


--------------020700080002040609090008--
