Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7CC02DDFE1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 00:03:46 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: davem@davemloft.net, galak@kernel.crashing.org
Subject: [PATCH 1/4] net/phy/marvell: update m88e1111 support for SGMII mode
Date: Tue,  2 Jun 2009 10:04:13 -0400
Message-Id: <1243951456-4685-1-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disable fiber/copper auto selection for Marvell m88e1111 SGMII support.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/net/phy/marvell.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 7a3ec9d..dd6f54d 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -243,6 +243,7 @@ static int m88e1111_config_init(struct phy_device *phydev)
 
 		temp &= ~(MII_M1111_HWCFG_MODE_MASK);
 		temp |= MII_M1111_HWCFG_MODE_SGMII_NO_CLK;
+		temp |= MII_M1111_HWCFG_FIBER_COPPER_AUTO;
 
 		err = phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);
 		if (err < 0)
-- 
1.6.0.2
