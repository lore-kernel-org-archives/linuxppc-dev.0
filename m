Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 033A8DDF55
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 12:35:21 +1000 (EST)
Received: from [192.168.0.123] (unknown [123.118.16.158])
	by mx.linux.net.cn (Postfix) with ESMTP id 1E9D23EC27
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 10:20:45 +0800 (CST)
Message-ID: <48757086.2080704@linux.net.cn>
Date: Thu, 10 Jul 2008 10:14:30 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] Fix copper/fiber auto-selection for 88e1111
Content-Type: text/plain; charset=GB2312
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 27.15 bit (MII_M1111_HWCFG_FIBER_COPPER_AUTO) is disable bit. When
set to 1, copper/fiber auto selection is disabled. The current code
to enable but actually disable auto selection.

Signed-off-by: Wang Jian <lark@linux.net.cn>
---
 drivers/net/phy/marvell.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 32a8503..737512c 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -162,7 +162,7 @@ static int m88e1111_config_init(struct phy_device
*phydev)

 	/* Enable Fiber/Copper auto selection */
 	temp = phy_read(phydev, MII_M1111_PHY_EXT_SR);
-	temp |= MII_M1111_HWCFG_FIBER_COPPER_AUTO;
+	temp &= ~MII_M1111_HWCFG_FIBER_COPPER_AUTO;
 	phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);

 	temp = phy_read(phydev, MII_BMCR);
-- 
1.5.5.4
