Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21323B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 08:29:48 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3A8B4DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 08:29:47 +1000 (EST)
Date: Sat, 27 Jun 2009 02:29:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 1/4] of/mdio: Add fixed link support
Message-ID: <20090626222945.GA32487@oksana.dev.rtsoft.ru>
References: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the fixed link support is broken for all OF ethernet drivers,
an "OF MDIO rework" removed most of the support. Instead of re-adding
fixed-link stuff to the drivers, add the support to a framework, so we
won't duplicate any code.

With this patch, if a node pointer is NULL, then of_phy_connect() will
try to find ethernet device's node, then will look for fixed-link
property, and if specified, it connects PHY as usual, via bus_id (fixed
link PHYs do not have any device tree nodes associated with them).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/of_mdio.c |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index aee967d..cfd876a 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -9,6 +9,10 @@
  * out of the OpenFirmware device tree and using it to populate an mii_bus.
  */
 
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/err.h>
 #include <linux/phy.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
@@ -129,11 +133,44 @@ struct phy_device *of_phy_connect(struct net_device *dev,
 				  void (*hndlr)(struct net_device *), u32 flags,
 				  phy_interface_t iface)
 {
-	struct phy_device *phy = of_phy_find_device(phy_np);
+	struct phy_device *phy = NULL;
+
+	if (phy_np) {
+		int ret;
+
+		phy = of_phy_find_device(phy_np);
+		if (!phy)
+			return NULL;
+
+		ret = phy_connect_direct(dev, phy, hndlr, flags, iface);
+		if (ret)
+			return NULL;
+	} else if (dev->dev.parent) {
+		struct device_node *net_np;
+		const u32 *phy_id;
+		char *bus_id;
+		int sz;
+
+		net_np = dev_archdata_get_node(&dev->dev.parent->archdata);
+		if (!net_np)
+			return NULL;
+
+		phy_id = of_get_property(net_np, "fixed-link", &sz);
+		if (!phy_id || sz < sizeof(*phy_id))
+			return NULL;
+
+		bus_id = kasprintf(GFP_KERNEL, PHY_ID_FMT, "0", phy_id[0]);
+		if (!bus_id) {
+			dev_err(&dev->dev, "could not allocate memory\n");
+			return NULL;
+		}
 
-	if (!phy)
-		return NULL;
+		phy = phy_connect(dev, bus_id, hndlr, 0, iface);
+		kfree(bus_id);
+		if (IS_ERR(phy))
+			return NULL;
+	}
 
-	return phy_connect_direct(dev, phy, hndlr, flags, iface) ? NULL : phy;
+	return phy;
 }
 EXPORT_SYMBOL(of_phy_connect);
-- 
1.6.3.1
