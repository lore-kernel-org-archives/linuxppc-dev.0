Return-Path: <f.fainelli@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD8521A0873
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:39:18 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rp16so1803074pbb.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:16 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH RESEND net-next 7/9] ucc_geth: use the new fixed PHY helpers
Date: Wed, 21 May 2014 14:38:49 -0700
Message-Id: <1400708331-18088-8-git-send-email-f.fainelli@gmail.com>
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
 drivers/net/ethernet/freescale/ucc_geth.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index c8299c31b21f..fab39e295441 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1728,9 +1728,6 @@ static int init_phy(struct net_device *dev)
 
 	phydev = of_phy_connect(dev, ug_info->phy_node, &adjust_link, 0,
 				priv->phy_interface);
-	if (!phydev)
-		phydev = of_phy_connect_fixed_link(dev, &adjust_link,
-						   priv->phy_interface);
 	if (!phydev) {
 		dev_err(&dev->dev, "Could not attach to PHY\n");
 		return -ENODEV;
@@ -3790,6 +3787,17 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
 
 	ug_info->phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (!ug_info->phy_node) {
+		/* In the case of a fixed PHY, the DT node associated
+		 * to the PHY is the Ethernet MAC DT node.
+		 */
+		if (of_phy_is_fixed_link(np)) {
+			err = of_phy_register_fixed_link(np);
+			if (err)
+				return err;
+		}
+		ug_info->phy_node = np;
+	}
 
 	/* Find the TBI PHY node.  If it's not there, we don't support SGMII */
 	ug_info->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
-- 
1.9.1
