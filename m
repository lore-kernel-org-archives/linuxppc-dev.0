Return-Path: <f.fainelli@gmail.com>
Received: from mail-yh0-x229.google.com (mail-yh0-x229.google.com
 [IPv6:2607:f8b0:4002:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF541A0870
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 10:57:30 +1000 (EST)
Received: by mail-yh0-f41.google.com with SMTP id f73so7648093yha.28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 17:57:27 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 8/9] of: mdio: remove of_phy_connect_fixed_link
Date: Mon, 19 May 2014 17:56:23 -0700
Message-Id: <1400547384-11363-9-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400547384-11363-1-git-send-email-f.fainelli@gmail.com>
References: <1400547384-11363-1-git-send-email-f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Grant Likely <grant.likely@linaro.org>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>,
 davem@davemlof.net, Vitaly Bordug <vbordug@ru.mvista.com>,
 Kumar Gala <galak@codeaurora.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All in-tree drivers have been converted to use the new pair of
functions: of_is_fixed_phy_link() plus of_phy_register_fixed_link(), we
can now safely remove of_phy_connect_fixed_link.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/of_mdio.c    | 38 --------------------------------------
 include/linux/of_mdio.h | 10 ----------
 2 files changed, 48 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 1def0bb5cb37..4c1e01ed16dc 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -246,44 +246,6 @@ struct phy_device *of_phy_connect(struct net_device *dev,
 EXPORT_SYMBOL(of_phy_connect);
 
 /**
- * of_phy_connect_fixed_link - Parse fixed-link property and return a dummy phy
- * @dev: pointer to net_device claiming the phy
- * @hndlr: Link state callback for the network device
- * @iface: PHY data interface type
- *
- * This function is a temporary stop-gap and will be removed soon.  It is
- * only to support the fs_enet, ucc_geth and gianfar Ethernet drivers.  Do
- * not call this function from new drivers.
- */
-struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
-					     void (*hndlr)(struct net_device *),
-					     phy_interface_t iface)
-{
-	struct device_node *net_np;
-	char bus_id[MII_BUS_ID_SIZE + 3];
-	struct phy_device *phy;
-	const __be32 *phy_id;
-	int sz;
-
-	if (!dev->dev.parent)
-		return NULL;
-
-	net_np = dev->dev.parent->of_node;
-	if (!net_np)
-		return NULL;
-
-	phy_id = of_get_property(net_np, "fixed-link", &sz);
-	if (!phy_id || sz < sizeof(*phy_id))
-		return NULL;
-
-	sprintf(bus_id, PHY_ID_FMT, "fixed-0", be32_to_cpu(phy_id[0]));
-
-	phy = phy_connect(dev, bus_id, hndlr, iface);
-	return IS_ERR(phy) ? NULL : phy;
-}
-EXPORT_SYMBOL(of_phy_connect_fixed_link);
-
-/**
  * of_phy_attach - Attach to a PHY without starting the state machine
  * @dev: pointer to net_device claiming the phy
  * @phy_np: Node pointer for the PHY
diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
index 0aa367e316cb..d449018d0726 100644
--- a/include/linux/of_mdio.h
+++ b/include/linux/of_mdio.h
@@ -22,9 +22,6 @@ extern struct phy_device *of_phy_connect(struct net_device *dev,
 struct phy_device *of_phy_attach(struct net_device *dev,
 				 struct device_node *phy_np, u32 flags,
 				 phy_interface_t iface);
-extern struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
-					 void (*hndlr)(struct net_device *),
-					 phy_interface_t iface);
 
 extern struct mii_bus *of_mdio_find_bus(struct device_node *mdio_np);
 
@@ -59,13 +56,6 @@ static inline struct phy_device *of_phy_attach(struct net_device *dev,
 	return NULL;
 }
 
-static inline struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
-							   void (*hndlr)(struct net_device *),
-							   phy_interface_t iface)
-{
-	return NULL;
-}
-
 static inline struct mii_bus *of_mdio_find_bus(struct device_node *mdio_np)
 {
 	return NULL;
-- 
1.9.1
