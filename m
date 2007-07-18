Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A97F0DF231
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:23 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1aIwG019261
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:18 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1aHY0001617
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:17 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BaFc008007
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:36 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 81BF5AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:16 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1aGjJ015490
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:16 -0500
Date: Tue, 17 Jul 2007 20:36:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 57/61] fs_enet: Whitespace cleanup.
Message-ID: <20070718013616.GC15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/net/fs_enet/fs_enet-main.c |   85 ++++++++++++++++-------------------
 drivers/net/fs_enet/mac-fcc.c      |    1 -
 drivers/net/fs_enet/mii-fec.c      |    1 -
 3 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index a4a2a0e..f261b90 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -353,7 +353,6 @@ static void fs_enet_tx(struct net_device *dev)
 
 	do_wake = do_restart = 0;
 	while (((sc = CBDR_SC(bdp)) & BD_ENET_TX_READY) == 0) {
-
 		dirtyidx = bdp - fep->tx_bd_base;
 
 		if (fep->tx_free == fep->tx_ring)
@@ -454,7 +453,6 @@ fs_enet_interrupt(int irq, void *dev_id)
 
 	nr = 0;
 	while ((int_events = (*fep->ops->get_int_events)(dev)) != 0) {
-
 		nr++;
 
 		int_clr_events = int_events;
@@ -710,45 +708,43 @@ static void fs_timeout(struct net_device *dev)
  *-----------------------------------------------------------------------------*/
 static void generic_adjust_link(struct  net_device *dev)
 {
-       struct fs_enet_private *fep = netdev_priv(dev);
-       struct phy_device *phydev = fep->phydev;
-       int new_state = 0;
-
-       if (phydev->link) {
-
-               /* adjust to duplex mode */
-               if (phydev->duplex != fep->oldduplex){
-                       new_state = 1;
-                       fep->oldduplex = phydev->duplex;
-               }
-
-               if (phydev->speed != fep->oldspeed) {
-                       new_state = 1;
-                       fep->oldspeed = phydev->speed;
-               }
-
-               if (!fep->oldlink) {
-                       new_state = 1;
-                       fep->oldlink = 1;
-                       netif_schedule(dev);
-                       netif_carrier_on(dev);
-                       netif_start_queue(dev);
-               }
-
-               if (new_state)
-                       fep->ops->restart(dev);
-
-       } else if (fep->oldlink) {
-               new_state = 1;
-               fep->oldlink = 0;
-               fep->oldspeed = 0;
-               fep->oldduplex = -1;
-               netif_carrier_off(dev);
-               netif_stop_queue(dev);
-       }
-
-       if (new_state && netif_msg_link(fep))
-               phy_print_status(phydev);
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct phy_device *phydev = fep->phydev;
+	int new_state = 0;
+
+	if (phydev->link) {
+		/* adjust to duplex mode */
+		if (phydev->duplex != fep->oldduplex) {
+			new_state = 1;
+			fep->oldduplex = phydev->duplex;
+		}
+
+		if (phydev->speed != fep->oldspeed) {
+			new_state = 1;
+			fep->oldspeed = phydev->speed;
+		}
+
+		if (!fep->oldlink) {
+			new_state = 1;
+			fep->oldlink = 1;
+			netif_schedule(dev);
+			netif_carrier_on(dev);
+			netif_start_queue(dev);
+		}
+
+		if (new_state)
+			fep->ops->restart(dev);
+	} else if (fep->oldlink) {
+		new_state = 1;
+		fep->oldlink = 0;
+		fep->oldspeed = 0;
+		fep->oldduplex = -1;
+		netif_carrier_off(dev);
+		netif_stop_queue(dev);
+	}
+
+	if (new_state && netif_msg_link(fep))
+		phy_print_status(phydev);
 }
 
 
@@ -792,7 +788,6 @@ static int fs_init_phy(struct net_device *dev)
 	return 0;
 }
 
-
 static int fs_enet_open(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
@@ -978,7 +973,7 @@ static struct net_device *fs_init_instance(struct device *dev,
 #endif
 
 #ifdef CONFIG_FS_ENET_HAS_SCC
-	if (fs_get_scc_index(fpi->fs_no) >=0 )
+	if (fs_get_scc_index(fpi->fs_no) >=0)
 		fep->ops = &fs_scc_ops;
 #endif
 
@@ -1069,9 +1064,8 @@ static struct net_device *fs_init_instance(struct device *dev,
 
 	return ndev;
 
-      err:
+err:
 	if (ndev != NULL) {
-
 		if (registered)
 			unregister_netdev(ndev);
 
@@ -1262,7 +1256,6 @@ static int __init fs_init(void)
 err:
 	cleanup_immap();
 	return r;
-	
 }
 
 static void __exit fs_cleanup(void)
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index 5603121..ad3c5fa 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -86,7 +86,6 @@
 static inline int fcc_cr_cmd(struct fs_enet_private *fep, u32 mcn, u32 op)
 {
 	const struct fs_platform_info *fpi = fep->fpi;
-
 	cpm2_map_t *immap = fs_enet_immap;
 	cpm_cpm2_t *cpmp = &immap->im_cpm;
 	u32 v;
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index 0a563a8..53db696 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -113,7 +113,6 @@ static int fs_enet_fec_mii_read(struct mii_bus *bus , int phy_id, int location)
 	}
 
 	return ret;
-
 }
 
 static int fs_enet_fec_mii_write(struct mii_bus *bus, int phy_id, int location, u16 val)
-- 
1.5.0.3
