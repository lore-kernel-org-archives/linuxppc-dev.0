Return-Path: <jezz@sysmic.org>
Received: from draco.sysmic.org (sysmic.org [88.191.45.54])
	by ozlabs.org (Postfix) with ESMTP id 80457B7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 19:34:31 +1100 (EST)
From: =?utf-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jezz@sysmic.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Remove nested function
Date: Thu,  8 Oct 2009 10:34:23 +0200
Message-Id: <1254990863-15271-1-git-send-email-jezz@sysmic.org>
In-Reply-To: <fa686aa40910070911x769d7d41u908fbcf6b0980962@mail.gmail.com>
References: <fa686aa40910070911x769d7d41u908fbcf6b0980962@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev <netdev@vger.kernel.org>, linuxppc <linuxppc-dev@lists.ozlabs.org>,
	Andy Fleming <afleming@freescale.com>,
	=?utf-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jezz@sysmic.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some toolchains dislike nested function definition, so we define function match
outside of of_phy_find_device.

Signed-off-by: Jérôme Pouiller <jezz@sysmic.org>
---
 drivers/of/of_mdio.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index bacaa53..4b22ba5 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -97,6 +97,12 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 }
 EXPORT_SYMBOL(of_mdiobus_register);
 
+/* Helper function for of_phy_find_device */
+static int of_phy_match(struct device *dev, void *phy_np)
+{
+	return dev_archdata_get_node(&dev->archdata) == phy_np;
+}
+
 /**
  * of_phy_find_device - Give a PHY node, find the phy_device
  * @phy_np: Pointer to the phy's device tree node
@@ -106,15 +112,10 @@ EXPORT_SYMBOL(of_mdiobus_register);
 struct phy_device *of_phy_find_device(struct device_node *phy_np)
 {
 	struct device *d;
-	int match(struct device *dev, void *phy_np)
-	{
-		return dev_archdata_get_node(&dev->archdata) == phy_np;
-	}
-
 	if (!phy_np)
 		return NULL;
 
-	d = bus_find_device(&mdio_bus_type, NULL, phy_np, match);
+	d = bus_find_device(&mdio_bus_type, NULL, phy_np, of_phy_match);
 	return d ? to_phy_device(d) : NULL;
 }
 EXPORT_SYMBOL(of_phy_find_device);
-- 
1.6.0.4
