Return-Path: <weo@reccoware.de>
Subject: [PATCH] PPC4xx compatible ioctl for PHY control
From: Wolfgang Ocker <weo@reccoware.de>
To: benh@kernel.crashing.org
Content-Type: text/plain
Date: Tue, 26 Aug 2008 20:22:58 +0200
Message-Id: <1219774978.3294.61.camel@galileo.recco.de>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Ocker <weo@reccoware.de>

Made PHY access in ioctl() for newemac driver compatible to other devices.

- Allow specification of PHY address in mii_ioctl_data->phy_id
- Use mii_ioctl_data structure

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

--- linux-2.6.26.3/drivers/net/ibm_newemac/core.c.mdio	2008-08-20 20:11:37.000000000 +0200
+++ linux-2.6.26.3/drivers/net/ibm_newemac/core.c	2008-08-24 18:25:49.000000000 +0200
@@ -2172,28 +2172,31 @@
 static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
-	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
+	struct mii_ioctl_data *data = if_mii(rq);
+	int r;
 
 	DBG(dev, "ioctl %08x" NL, cmd);
 
-	if (dev->phy.address < 0)
+	if (data->phy_id & ~0x1f)
 		return -EOPNOTSUPP;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:
 	case SIOCDEVPRIVATE:
-		data[0] = dev->phy.address;
+		data->phy_id = dev->phy.address;
 		/* Fall through */
 	case SIOCGMIIREG:
 	case SIOCDEVPRIVATE + 1:
-		data[3] = emac_mdio_read(ndev, dev->phy.address, data[1]);
+		r = emac_mdio_read(ndev, data->phy_id, data->reg_num);
+		if (r < 0)
+			r = 0xffff;
+		data->val_out = r;
 		return 0;
-
 	case SIOCSMIIREG:
 	case SIOCDEVPRIVATE + 2:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		emac_mdio_write(ndev, dev->phy.address, data[1], data[2]);
+		emac_mdio_write(ndev, data->phy_id, data->reg_num, data->val_in);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
