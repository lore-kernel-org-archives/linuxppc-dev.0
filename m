Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 802032C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 03:34:03 +1100 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
 by gw1.transmode.se (Postfix) with ESMTP id 9015425801C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 17:33:56 +0100 (CET)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: RFC [PATCH] ucc_geth: impl. support for IFF_UNICAST_FLT
Date: Fri, 22 Mar 2013 17:33:48 +0100
Message-Id: <1363970028-29869-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---

I took a stab at impl. IFF_UNICAST_FLT as an exercise but I
didn't get around to test it. So I figured perhaps someone else
wants/need it so here is a start. With any luck it will work
as is. This is on 3.0 so it might not apply without tweaks.

 drivers/net/ethernet/freescale/ucc_geth.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 3d92823..c6eac9b 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2039,12 +2039,13 @@ static void ucc_geth_memclean(struct ucc_geth_private *ugeth)
 	skb_queue_purge(&ugeth->rx_recycle);
 }
 
-static void ucc_geth_set_multi(struct net_device *dev)
+static void ucc_geth_set_rx_mode(struct net_device *dev)
 {
 	struct ucc_geth_private *ugeth;
 	struct netdev_hw_addr *ha;
 	struct ucc_fast __iomem *uf_regs;
 	struct ucc_geth_82xx_address_filtering_pram __iomem *p_82xx_addr_filt;
+	int i;
 
 	ugeth = netdev_priv(dev);
 
@@ -2059,6 +2060,22 @@ static void ucc_geth_set_multi(struct net_device *dev)
 		    (struct ucc_geth_82xx_address_filtering_pram __iomem *) ugeth->
 		    p_rx_glbl_pram->addressfiltering;
 
+		/* Clear filter and add the addresses in the list.
+		 */
+		out_be32(&p_82xx_addr_filt->iaddr_h, 0x0);
+		out_be32(&p_82xx_addr_filt->iaddr_l, 0x0);
+		i = 0;
+		netdev_for_each_uc_addr(ha, dev) {
+			if ( i < NUM_OF_PADDRS )
+				set_mac_addr(&p_82xx_addr_filt->paddr[i].h, ha->addr);
+			else
+				hw_add_addr_in_hash(ugeth, ha->addr);
+			i++;
+		}
+		/* Pad remaining entries with station address */
+		for(; i < NUM_OF_PADDRS; i++)
+			set_mac_addr(&p_82xx_addr_filt->paddr[i].h, dev->dev_addr);
+
 		if (dev->flags & IFF_ALLMULTI) {
 			/* Catch all multicast addresses, so set the
 			 * filter to all 1's.
@@ -3807,7 +3824,7 @@ static const struct net_device_ops ucc_geth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= ucc_geth_set_mac_addr,
 	.ndo_change_mtu		= eth_change_mtu,
-	.ndo_set_rx_mode	= ucc_geth_set_multi,
+	.ndo_set_rx_mode	= ucc_geth_set_rx_mode,
 	.ndo_tx_timeout		= ucc_geth_timeout,
 	.ndo_do_ioctl		= ucc_geth_ioctl,
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -4017,6 +4034,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	ugeth->msg_enable = netif_msg_init(debug.msg_enable, UGETH_MSG_DEFAULT);
 	ugeth->phy_interface = phy_interface;
 	ugeth->max_speed = max_speed;
+	dev->priv_flags |= IFF_UNICAST_FLT;
 
 	err = register_netdev(dev);
 	if (err) {
-- 
1.8.1.5
