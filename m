Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5E1C67B55
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 09:22:54 +1000 (EST)
Message-ID: <42A0E647.80604@am.sony.com>
Date: Fri, 03 Jun 2005 16:22:47 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [2/2] PM support for emac driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a first attempt to add PM support to the PPC 440 emac 
driver.  Still needed are code to take care of the PHY chip, 
and to support wake-on-lan.  Any comments on how to do 
those would be most welcome.

The 'PM support for Ebony' patch I posted can be used to test 
on that platform.

-Geoff

* emac-pm.patch

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--

Index: linux-2.6.12-bhpm/drivers/net/ibm_emac/ibm_emac_core.c
===================================================================
--- linux-2.6.12-bhpm.orig/drivers/net/ibm_emac/ibm_emac_core.c	2005-06-02 15:09:23.000000000 -0700
+++ linux-2.6.12-bhpm/drivers/net/ibm_emac/ibm_emac_core.c	2005-06-02 17:11:02.000000000 -0700
@@ -1306,7 +1306,7 @@
 	ep->ack_slot = 0;
 }
 
-static void emac_reset_configure(struct ocp_enet_private *fep)
+static void emac_reset(struct ocp_enet_private *fep)
 {
 	emac_t *emacp = fep->emacp;
 	int i;
@@ -1338,6 +1338,14 @@
 
 	/* Switch IRQs off for now */
 	out_be32(&emacp->em0iser, 0);
+}
+
+static void emac_reset_configure(struct ocp_enet_private *fep)
+{
+	emac_t *emacp = fep->emacp;
+
+	/* Reset EMAC */
+	emac_reset(fep);
 
 	/* Configure MAL rx channel */
 	mal_set_rcbs(fep->mal, fep->mal_rx_chan, DESC_BUF_SIZE_REG);
@@ -1615,20 +1623,10 @@
 	}
 }
 
-static int emac_open(struct net_device *dev)
+static int emac_up(struct net_device *dev)
 {
-	struct ocp_enet_private *fep = dev->priv;
 	int rc;
-
-	spin_lock_irq(&fep->lock);
-
-	fep->opened = 1;
-	netif_carrier_off(dev);
-
-	/* Reset & configure the chip */
-	emac_reset_configure(fep);
-
-	spin_unlock_irq(&fep->lock);
+	struct ocp_enet_private *fep = dev->priv;
 
 	/* Request our interrupt lines */
 	rc = request_irq(dev->irq, emac_mac_irq, 0, "IBM EMAC MAC", dev);
@@ -1646,6 +1644,24 @@
 	return rc;
 }
 
+static int emac_open(struct net_device *dev)
+{
+	struct ocp_enet_private *fep = dev->priv;
+
+	spin_lock_irq(&fep->lock);
+
+	fep->opened = 1;
+	netif_carrier_off(dev);
+
+	/* Reset & configure the chip */
+	emac_reset_configure(fep);
+
+	spin_unlock_irq(&fep->lock);
+
+	return emac_up(dev);
+
+}
+
 static int emac_close(struct net_device *dev)
 {
 	struct ocp_enet_private *fep = dev->priv;
@@ -1975,6 +1991,71 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int emac_suspend(struct ocp_device *pdev, u32 state)
+{
+	struct net_device *netdev = ocp_get_drvdata(pdev);
+	struct ocp_enet_private *fep = netdev->priv;
+
+	pr_debug("PM:emac_suspend:%d\n", state);
+
+	if(netif_running(netdev))
+		emac_close(netdev);
+
+	/* Stop timer and Reset the chip */
+	spin_lock_irq(&fep->lock);
+	del_timer(&fep->link_timer);
+	fep->opened = 0;
+	emac_reset(fep);
+	spin_unlock_irq(&fep->lock);
+
+	/* detach */
+	netif_device_detach(netdev);
+
+	/* 
+	 * Save current states then turn off EMAC and PHY
+	 * according to specified state.  
+	 * make WOL(WakeupOnLan) enable, if needed
+	 */
+	// XXX:TBD
+	pdev->current_state = state;
+
+	return 0;
+}
+
+static int emac_resume(struct ocp_device *pdev)
+{
+	struct net_device *netdev = ocp_get_drvdata(pdev);
+	struct ocp_enet_private *fep = netdev->priv;
+
+	pr_debug("emac_resume:\n");
+
+	/* Turn on EMAC and PHY and restore state */
+	// XXX:TBD
+	pdev->current_state = 0;
+
+	/* Reset & configure the chip then Restart Timer */
+	spin_lock_irq(&fep->lock);
+
+	fep->opened = 1;
+	netif_carrier_off(netdev);
+	emac_reset_configure(fep);
+
+	(fep->link_timer).expires = jiffies+1;
+	add_timer(&fep->link_timer);
+
+	spin_unlock_irq(&fep->lock);
+
+	/* attach */
+	netif_device_attach(netdev);
+
+	if(netif_running(netdev))
+		emac_up(netdev);
+
+	return 0;
+}
+#endif
+
 /* Structure for a device driver */
 static struct ocp_device_id emac_ids[] = {
 	{.vendor = OCP_ANY_ID,.function = OCP_FUNC_EMAC},
@@ -1987,6 +2068,10 @@
 
 	.probe = emac_probe,
 	.remove = emac_remove,
+#ifdef CONFIG_PM
+	.suspend = emac_suspend,
+	.resume = emac_resume,
+#endif
 };
 
 static int __init emac_init(void)

-EOF
