Return-Path: <f.fainelli@gmail.com>
Received: from mail-yh0-x22f.google.com (mail-yh0-x22f.google.com
 [IPv6:2607:f8b0:4002:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0E111A087D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 10:57:21 +1000 (EST)
Received: by mail-yh0-f47.google.com with SMTP id z6so7503813yhz.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 17:57:18 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 5/9] fs_enet: use the new fixed PHY helpers
Date: Mon, 19 May 2014 17:56:20 -0700
Message-Id: <1400547384-11363-6-git-send-email-f.fainelli@gmail.com>
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
