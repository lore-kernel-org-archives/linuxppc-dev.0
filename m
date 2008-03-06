Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A2E3DDF9E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 00:47:18 +1100 (EST)
Date: Thu, 6 Mar 2008 16:43:59 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround
Message-ID: <20080306134359.GA31762@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204804237.21545.257.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds ibm_newemac PHY clock workaround for 440EP/440GR EMAC
attached to a PHY which doesn't generate RX clock if there is no link.
The code is based on the previous ibm_emac driver stuff. The 440EP/440GR
allows controlling each EMAC clock separately as opposed to global clock
selection for 440GX.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/net/ibm_newemac/core.c |   34 ++++++++++++++++++++++++++++++++--
 drivers/net/ibm_newemac/core.h |    6 +++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
--- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2008-02-26 16:32:33.000000000 +0300
+++ linux-2.6/drivers/net/ibm_newemac/core.c	2008-02-26 16:37:52.000000000 +0300
@@ -129,10 +129,29 @@ static struct device_node *emac_boot_lis
 static inline void emac_report_timeout_error(struct emac_instance *dev,
 					     const char *error)
 {
-	if (net_ratelimit())
+	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX |
+				  EMAC_FTR_440EP_PHY_CLK_FIX))
+		DBG(dev, "%s" NL, error);
+	else if (net_ratelimit())
 		printk(KERN_ERR "%s: %s\n", dev->ndev->name, error);
 }
 
+/* EMAC PHY clock workaround:
+ * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX,
+ * which allows controlling each EMAC clock
+ */
+static inline void emac_rx_clk_tx(struct emac_instance *dev)
+{
+	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX))
+		dcri_clrset(SDR0, SDR0_MFR, 0, SDR0_MFR_ECS >> dev->cell_index);
+}
+
+static inline void emac_rx_clk_default(struct emac_instance *dev)
+{
+	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX))
+		dcri_clrset(SDR0, SDR0_MFR, SDR0_MFR_ECS >> dev->cell_index, 0);
+}
+
 /* PHY polling intervals */
 #define PHY_POLL_LINK_ON	HZ
 #define PHY_POLL_LINK_OFF	(HZ / 5)
@@ -1089,9 +1112,11 @@ static int emac_open(struct net_device *
 		int link_poll_interval;
 		if (dev->phy.def->ops->poll_link(&dev->phy)) {
 			dev->phy.def->ops->read_link(&dev->phy);
+			emac_rx_clk_default(dev);
 			netif_carrier_on(dev->ndev);
 			link_poll_interval = PHY_POLL_LINK_ON;
 		} else {
+			emac_rx_clk_tx(dev);
 			netif_carrier_off(dev->ndev);
 			link_poll_interval = PHY_POLL_LINK_OFF;
 		}
@@ -1169,6 +1194,7 @@ static void emac_link_timer(struct work_
 
 	if (dev->phy.def->ops->poll_link(&dev->phy)) {
 		if (!netif_carrier_ok(dev->ndev)) {
+			emac_rx_clk_default(dev);
 			/* Get new link parameters */
 			dev->phy.def->ops->read_link(&dev->phy);
 
@@ -1181,6 +1207,7 @@ static void emac_link_timer(struct work_
 		link_poll_interval = PHY_POLL_LINK_ON;
 	} else {
 		if (netif_carrier_ok(dev->ndev)) {
+			emac_rx_clk_tx(dev);
 			netif_carrier_off(dev->ndev);
 			netif_tx_disable(dev->ndev);
 			emac_reinitialize(dev);
@@ -2325,9 +2352,12 @@ static int __devinit emac_init_phy(struc
 	dev->phy.mdio_read = emac_mdio_read;
 	dev->phy.mdio_write = emac_mdio_write;
 
-	/* Enable internal clock source */
+	/* EMAC PHY clock workaround */
 	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
+		/* Enable internal clock source */
 		dcri_clrset(SDR0, SDR0_MFR, 0, SDR0_MFR_ECS);
+	else
+		emac_rx_clk_tx(dev);
 
 	/* Configure EMAC with defaults so we can at least use MDIO
 	 * This is needed mostly for 440GX
@@ -2495,6 +2525,10 @@ static int __devinit emac_init_config(st
 		dev->features |= EMAC_FTR_EMAC4;
 		if (of_device_is_compatible(np, "ibm,emac-440gx"))
 			dev->features |= EMAC_FTR_440GX_PHY_CLK_FIX;
+	} else {
+		if (of_device_is_compatible(np, "ibm,emac-440ep") ||
+		    of_device_is_compatible(np, "ibm,emac-440gr"))
+			dev->features |= EMAC_FTR_440EP_PHY_CLK_FIX;
 	}
 
 	/* Fixup some feature bits based on the device tree */
diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/core.h linux-2.6/drivers/net/ibm_newemac/core.h
--- linux-2.6.orig/drivers/net/ibm_newemac/core.h	2008-02-26 16:32:33.000000000 +0300
+++ linux-2.6/drivers/net/ibm_newemac/core.h	2008-02-26 16:37:52.000000000 +0300
@@ -305,6 +305,10 @@ struct emac_instance {
  * Set if we need phy clock workaround for 440gx
  */
 #define EMAC_FTR_440GX_PHY_CLK_FIX	0x00000080
+/*
+ * Set if we need phy clock workaround for 440ep or 440gr
+ */
+#define EMAC_FTR_440EP_PHY_CLK_FIX	0x00000100
 
 
 /* Right now, we don't quite handle the always/possible masks on the
@@ -328,7 +332,7 @@ enum {
 #ifdef CONFIG_IBM_NEW_EMAC_RGMII
 	    EMAC_FTR_HAS_RGMII	|
 #endif
-	    0,
+	EMAC_FTR_440EP_PHY_CLK_FIX,
 };
 
 static inline int emac_has_feature(struct emac_instance *dev,
