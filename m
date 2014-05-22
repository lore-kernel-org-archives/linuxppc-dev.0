Return-Path: <f.fainelli@gmail.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFD9B1A05DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 02:48:25 +1000 (EST)
Received: by mail-ig0-f179.google.com with SMTP id hn18so3776989igb.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 09:48:23 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 5/9] fs_enet: use the new fixed PHY helpers
Date: Thu, 22 May 2014 09:47:47 -0700
Message-Id: <1400777271-32199-6-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
References: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_phy_connect_fixed_link() is becoming obsolete, and also required
platform code to register the fixed PHYs at the specified addresses for
those to be usable. Get rid of it and use the new of_phy_is_fixed_link()
plus of_phy_register_fixed_link() helpers to transition over the new
scheme.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
- merge if conditions on the same line as suggested by Sergei
- add comment explaining the device_node pointer assignment

 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index dc80db41d6b3..cfaf17b70f3f 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -792,10 +792,6 @@ static int fs_init_phy(struct net_device *dev)
 	phydev = of_phy_connect(dev, fep->fpi->phy_node, &fs_adjust_link, 0,
 				iface);
 	if (!phydev) {
-		phydev = of_phy_connect_fixed_link(dev, &fs_adjust_link,
-						   iface);
-	}
-	if (!phydev) {
 		dev_err(&dev->dev, "Could not attach to PHY\n");
 		return -ENODEV;
 	}
@@ -1029,9 +1025,16 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	fpi->use_napi = 1;
 	fpi->napi_weight = 17;
 	fpi->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
-	if ((!fpi->phy_node) && (!of_get_property(ofdev->dev.of_node, "fixed-link",
-						  NULL)))
-		goto out_free_fpi;
+	if (!fpi->phy_node && of_phy_is_fixed_link(ofdev->dev.of_node)) {
+		err = of_phy_register_fixed_link(ofdev->dev.of_node);
+		if (err)
+			goto out_free_fpi;
+
+		/* In the case of a fixed PHY, the DT node associated
+		 * to the PHY is the Ethernet MAC DT node.
+		 */
+		fpi->phy_node = ofdev->dev.of_node;
+	}
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec")) {
 		phy_connection_type = of_get_property(ofdev->dev.of_node,
-- 
1.9.1
