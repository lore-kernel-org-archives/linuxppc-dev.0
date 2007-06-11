Return-Path: <rzhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id ADFF9DDE16
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 21:55:46 +1000 (EST)
Subject: [PATCH] MII bitbang driver should generate MII bus phy_mask
	dynamically
From: Mark Zhan <rongkai.zhan@windriver.com>
To: netdev@vger.kernel.org
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:53:37 +0800
Message-Id: <1181548417.5217.13.camel@mark>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current MII bitbang bus driver hard-codes the phy mask of mii_bus to
~0x09, which is actually specific to the FSL boards. This patch will
make the bitbang driver to generate MII bus phy_mask dynamically, by the
PHY irq info provided by the platform.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
 b/drivers/net/fs_enet/mii-bitbang.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fs_enet/mii-bitbang.c
b/drivers/net/fs_enet/mii-bitbang.c
index d384010..3732d69 100644
--- a/drivers/net/fs_enet/mii-bitbang.c
+++ b/drivers/net/fs_enet/mii-bitbang.c
@@ -315,7 +315,7 @@ static int __devinit fs_enet_mdio_probe(
 	struct fs_mii_bb_platform_info *pdata;
 	struct mii_bus *new_bus;
 	struct bb_info *bitbang;
-	int err = 0;
+	int i, err = 0;
 
 	if (NULL == dev)
 		return -EINVAL;
@@ -336,14 +336,17 @@ static int __devinit fs_enet_mdio_probe(
 	new_bus->reset = &fs_enet_mii_bb_reset,
 	new_bus->id = pdev->id;
 
-	new_bus->phy_mask = ~0x9;
 	pdata = (struct fs_mii_bb_platform_info *)pdev->dev.platform_data;
-
 	if (NULL == pdata) {
 		printk(KERN_ERR "gfar mdio %d: Missing platform data!\n", pdev->id);
 		return -ENODEV;
 	}
 
+	new_bus->phy_mask = 0xFFFFFFFF;
+	for (i = 0; i < PHY_MAX_ADDR; i++)
+		if (pdata->irq[i] != -1)
+			new_bus->phy_mask &= ~(1 << i);
+
 	/*set up workspace*/
 	fs_mii_bitbang_init(bitbang, pdata);
 
