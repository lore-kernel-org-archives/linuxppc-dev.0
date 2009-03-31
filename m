Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id C5D7FDDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 19:27:48 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so2448207rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:27:48 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 12/14] powerpc/82xx: Rework Embedded Planet ep8248e platform
	to use of_mdio
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Tue, 31 Mar 2009 02:27:46 -0600
Message-ID: <20090331082745.1427.91493.stgit@localhost.localdomain>
In-Reply-To: <20090331075537.1427.7819.stgit@localhost.localdomain>
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: olof@lixom.net, afleming@freescale.com,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch modifies the bitbanged MDIO driver in the ep8248e platform
code to use the common of_mdio infrastructure.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/82xx/ep8248e.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 0eb6d7f..51fcae4 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
 #include <linux/mdio-bitbang.h>
+#include <linux/of_mdio.h>
 #include <linux/of_platform.h>
 
 #include <asm/io.h>
@@ -115,7 +116,7 @@ static int __devinit ep8248e_mdio_probe(struct of_device *ofdev,
 	struct mii_bus *bus;
 	struct resource res;
 	struct device_node *node;
-	int ret, i;
+	int ret;
 
 	node = of_get_parent(ofdev->node);
 	of_node_put(node);
@@ -130,17 +131,13 @@ static int __devinit ep8248e_mdio_probe(struct of_device *ofdev,
 	if (!bus)
 		return -ENOMEM;
 
-	bus->phy_mask = 0;
 	bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
 
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		bus->irq[i] = -1;
-
 	bus->name = "ep8248e-mdio-bitbang";
 	bus->parent = &ofdev->dev;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
 
-	return mdiobus_register(bus);
+	return of_mdiobus_register(bus, ofdev->node);
 }
 
 static int ep8248e_mdio_remove(struct of_device *ofdev)
