Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D6C714008B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 20:54:12 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>, <trini@ti.com>
Subject: [PATCH] net/phy:  tune get_phy_c45_ids to support more c45 phy
Date: Wed, 23 Apr 2014 17:55:51 +0800
Message-ID: <1398246951-27303-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As some C45 10G PHYs(e.g. Cortina CS4315/CS4340 PHY) have
zero Devices In package, current driver can't get correct
devices_in_package value by non-zero Devices In package.
so let's probe more with zero Devices In package to support
more C45 PHYs which have zero Devices In package.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
Tested with CS4315 on T2080RDB, this patch have no impact on previous XAUI phy with verification. 

 drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index cfb5110..8fd777e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -244,12 +244,29 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			return -EIO;
 		c45_ids->devices_in_package |= (phy_reg & 0xffff);
 
-		/* If mostly Fs, there is no device there,
-		 * let's get out of here.
+		/* If mostly Fs, let's continue to probe more
+		 * as some 10G PHYs have zero Devices In package
+		 * e.g. Cortina CS4315/CS4340 PHY.
 		 */
 		if ((c45_ids->devices_in_package & 0x1fffffff) == 0x1fffffff) {
-			*phy_id = 0xffffffff;
-			return 0;
+			reg_addr = MII_ADDR_C45 | 0 << 16 | 6;
+			phy_reg = mdiobus_read(bus, addr, reg_addr);
+			if (phy_reg < 0)
+				return -EIO;
+			c45_ids->devices_in_package = (phy_reg & 0xffff) << 16;
+			reg_addr = MII_ADDR_C45 | 0 << 16 | 5;
+			phy_reg = mdiobus_read(bus, addr, reg_addr);
+			if (phy_reg < 0)
+				return -EIO;
+			c45_ids->devices_in_package |= (phy_reg & 0xffff);
+			/* If mostly Fs, there is no device there,
+			 * let's get out of here.
+			 */
+			if ((c45_ids->devices_in_package & 0x1fffffff) ==
+							0x1fffffff) {
+				*phy_id = 0xffffffff;
+				return 0;
+			}
 		}
 	}
 
-- 
1.8.0
