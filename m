Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id E9FCFDDEEF
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 09:29:10 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1929047wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 15:29:10 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 10/13] powerpc/82xx: Rework Embedded Planet ep8248e
	platform to use of_mdio
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, olof@lixom.net
Date: Sat, 21 Mar 2009 16:29:07 -0600
Message-ID: <20090321222906.20493.32061.stgit@localhost.localdomain>
In-Reply-To: <20090321222047.20493.87335.stgit@localhost.localdomain>
References: <20090321222047.20493.87335.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: afleming@freescale.com, davem@davemloft.net
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

 arch/powerpc/platforms/82xx/ep8248e.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 0eb6d7f..bd323b5 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
 #include <linux/mdio-bitbang.h>
+#include <linux/of_mdio.h>
 #include <linux/of_platform.h>
 
 #include <asm/io.h>
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
