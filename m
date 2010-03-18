Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id D2DE1B87B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 02:22:47 +1100 (EST)
Received: by mail-pw0-f51.google.com with SMTP id 7so1544340pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 08:22:47 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [V2 PATCH 07/10] of: eliminate calls to dev_archdata_set_node()
To: davem@davemloft.net, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	michal.simek@petalogix.com, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au
Date: Thu, 18 Mar 2010 09:22:44 -0600
Message-ID: <20100318152244.21082.81121.stgit@angua>
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
References: <20100318144836.21082.93040.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At this point, there are no more users of the archdata node pointer,
so the calls to set it can be dropped.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/of_i2c.c  |    1 -
 drivers/of/of_mdio.c |    1 -
 drivers/of/of_spi.c  |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 604ba96..ab6522c 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -42,7 +42,6 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = be32_to_cpup(addr);
 
-		dev_archdata_set_node(&dev_ad, node);
 		info.of_node = node;
 		info.archdata = &dev_ad;
 
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 01d794a..794fbc2 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -79,7 +79,6 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		/* Associate the OF node with the device structure so it
 		 * can be looked up later */
 		of_node_get(child);
-		dev_archdata_set_node(&phy->dev.archdata, child);
 		phy->dev.of_node = child;
 
 		/* All data is now stored in the phy struct; register it */
diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index f3119a0..5fed7e3 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -80,7 +80,6 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
 		/* Store a pointer to the node in the device structure */
 		of_node_get(nc);
 		spi->dev.of_node = nc;
-		spi->dev.archdata.of_node = nc;
 
 		/* Register the new device */
 		request_module(spi->modalias);
