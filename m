Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7B82B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 12:01:33 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6F763DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 12:01:33 +1000 (EST)
Date: Thu, 10 Sep 2009 06:01:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 1/3] phy/marvell: Make non-aneg speed/duplex forcing work
	for 88E1111 PHYs
Message-ID: <20090910020130.GA31083@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to specs, when auto-negotiation is disabled, Marvell PHYs need
a software reset after changing speed/duplex forcing bits. Otherwise,
the modified bits have no effect.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/phy/marvell.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index dd6f54d..6f69b9b 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -155,8 +155,27 @@ static int marvell_config_aneg(struct phy_device *phydev)
 		return err;
 
 	err = genphy_config_aneg(phydev);
+	if (err < 0)
+		return err;
 
-	return err;
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		int bmcr;
+
+		/*
+		 * A write to speed/duplex bits (that is performed by
+		 * genphy_config_aneg() call above) must be followed by
+		 * a software reset. Otherwise, the write has no effect.
+		 */
+		bmcr = phy_read(phydev, MII_BMCR);
+		if (bmcr < 0)
+			return bmcr;
+
+		err = phy_write(phydev, MII_BMCR, bmcr | BMCR_RESET);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
 }
 
 static int m88e1121_config_aneg(struct phy_device *phydev)
-- 
1.6.3.3
