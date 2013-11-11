Return-Path: <shh.xie@gmail.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92B102C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 23:25:23 +1100 (EST)
From: <shh.xie@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] phylib: Add of_phy_attach
Date: Mon, 11 Nov 2013 19:08:16 +0800
Message-ID: <1384168100-3046-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti@freescale.com, Shaohui Xie <Shaohui.Xie@freescale.com>,
 madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming

10G PHYs don't currently support running the state machine, which
is implicitly setup via of_phy_connect(). Therefore, it is necessary
to implement an OF version of phy_attach(), which does everything
except start the state machine.

Signed-off-by: Andy Fleming
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 drivers/of/of_mdio.c    | 22 ++++++++++++++++++++--
 include/linux/of_mdio.h |  8 ++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index d5a57a9..a748274 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -221,8 +221,7 @@ EXPORT_SYMBOL(of_phy_connect);
  * not call this function from new drivers.
  */
 struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
-					     void (*hndlr)(struct net_device *),
-					     phy_interface_t iface)
+		void (*hndlr)(struct net_device *), phy_interface_t iface)
 {
 	struct device_node *net_np;
 	char bus_id[MII_BUS_ID_SIZE + 3];
@@ -247,3 +246,22 @@ struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
 	return IS_ERR(phy) ? NULL : phy;
 }
 EXPORT_SYMBOL(of_phy_connect_fixed_link);
+
+/**
+ * of_phy_attach - Attach to a PHY without starting the state machine
+ * @dev: pointer to net_device claiming the phy
+ * @phy_np: Node pointer for the PHY
+ * @flags: flags to pass to the PHY
+ * @iface: PHY data interface type
+ */
+struct phy_device *of_phy_attach(struct net_device *dev,
+		struct device_node *phy_np, u32 flags, phy_interface_t iface)
+{
+	struct phy_device *phy = of_phy_find_device(phy_np);
+
+	if (!phy)
+		return NULL;
+
+	return phy_attach_direct(dev, phy, flags, iface) ? NULL : phy;
+}
+EXPORT_SYMBOL(of_phy_attach);
diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
index 8163107..dcda44d 100644
--- a/include/linux/of_mdio.h
+++ b/include/linux/of_mdio.h
@@ -19,6 +19,8 @@ extern struct phy_device *of_phy_connect(struct net_device *dev,
 					 struct device_node *phy_np,
 					 void (*hndlr)(struct net_device *),
 					 u32 flags, phy_interface_t iface);
+extern struct phy_device *of_phy_attach(struct net_device *dev,
+		struct device_node *phy_np, u32 flags, phy_interface_t iface);
 extern struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
 					 void (*hndlr)(struct net_device *),
 					 phy_interface_t iface);
@@ -44,6 +46,12 @@ static inline struct phy_device *of_phy_connect(struct net_device *dev,
 	return NULL;
 }
 
+static inline struct phy_device *of_phy_attach(struct net_device *dev,
+		struct device_node *phy_np, u32 flags, phy_interface_t iface)
+{
+	return NULL;
+}
+
 static inline struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
 							   void (*hndlr)(struct net_device *),
 							   phy_interface_t iface)
-- 
1.8.4.1
