Return-Path: <f.fainelli@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA0EA1A082E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:39:15 +1000 (EST)
Received: by mail-pd0-f173.google.com with SMTP id v10so1766676pde.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:13 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH RESEND net-next 5/9] fs_enet: use the new fixed PHY helpers
Date: Wed, 21 May 2014 14:38:47 -0700
Message-Id: <1400708331-18088-6-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
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
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index dc80db41d6b3..d602711e00e9 100644
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
@@ -1029,9 +1025,15 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	fpi->use_napi = 1;
 	fpi->napi_weight = 17;
 	fpi->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
-	if ((!fpi->phy_node) && (!of_get_property(ofdev->dev.of_node, "fixed-link",
-						  NULL)))
-		goto out_free_fpi;
+	if (!fpi->phy_node) {
+		if (of_phy_is_fixed_link(ofdev->dev.of_node)) {
+			err = of_phy_register_fixed_link(ofdev->dev.of_node);
+			if (err)
+				goto out_free_fpi;
+
+			fpi->phy_node = ofdev->dev.of_node;
+		}
+	}
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec")) {
 		phy_connection_type = of_get_property(ofdev->dev.of_node,
-- 
1.9.1
