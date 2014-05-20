Return-Path: <f.fainelli@gmail.com>
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com
 [IPv6:2607:f8b0:4002:c07::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D29D01A08FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 10:57:24 +1000 (EST)
Received: by mail-yk0-f180.google.com with SMTP id q9so5149230ykb.39
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 17:57:21 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 6/9] gianfar: use the new fixed PHY helpers
Date: Mon, 19 May 2014 17:56:21 -0700
Message-Id: <1400547384-11363-7-git-send-email-f.fainelli@gmail.com>
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
 drivers/net/ethernet/freescale/gianfar.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index e2d42475b006..282674027c92 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -889,6 +889,17 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	priv->phy_node = of_parse_phandle(np, "phy-handle", 0);
 
+	/* In the case of a fixed PHY, the DT node associated
+	 * to the PHY is the Ethernet MAC DT node.
+	 */
+	if (of_phy_is_fixed_link(np)) {
+		err = of_phy_register_fixed_link(np);
+		if (err)
+			goto err_grp_init;
+
+		priv->phy_node = np;
+	}
+
 	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
 	priv->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
 
@@ -1660,9 +1671,6 @@ static int init_phy(struct net_device *dev)
 
 	priv->phydev = of_phy_connect(dev, priv->phy_node, &adjust_link, 0,
 				      interface);
-	if (!priv->phydev)
-		priv->phydev = of_phy_connect_fixed_link(dev, &adjust_link,
-							 interface);
 	if (!priv->phydev) {
 		dev_err(&dev->dev, "could not attach to PHY\n");
 		return -ENODEV;
-- 
1.9.1
