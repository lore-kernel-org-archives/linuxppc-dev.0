Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DE9CDDF91
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:17:59 +1100 (EST)
Date: Mon, 26 Nov 2007 16:17:52 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 2/3][RESEND] phylib: marvell: add support for TX-only and
	RX-only Internal Delay
Message-Id: <20071126161752.5b4bd09d.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, Internal Delay specification implied the delay be
applied to both TX and RX.  This patch allows for separate TX/RX-only
internal delay specification.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Tested-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Li Yang <leoli@freescale.com>
---
 drivers/net/phy/marvell.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 035fd41..f057407 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -143,21 +143,29 @@ static int m88e1111_config_init(struct phy_device *phydev)
 	int err;
 
 	if ((phydev->interface == PHY_INTERFACE_MODE_RGMII) ||
-	    (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)) {
+	    (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID) ||
+	    (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
+	    (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
 		int temp;
 
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID) {
-			temp = phy_read(phydev, MII_M1111_PHY_EXT_CR);
-			if (temp < 0)
-				return temp;
+		temp = phy_read(phydev, MII_M1111_PHY_EXT_CR);
+		if (temp < 0)
+			return temp;
 
+		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID) {
 			temp |= (MII_M1111_RX_DELAY | MII_M1111_TX_DELAY);
-
-			err = phy_write(phydev, MII_M1111_PHY_EXT_CR, temp);
-			if (err < 0)
-				return err;
+		} else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) {
+			temp &= ~MII_M1111_TX_DELAY;
+			temp |= MII_M1111_RX_DELAY;
+		} else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
+			temp &= ~MII_M1111_RX_DELAY;
+			temp |= MII_M1111_TX_DELAY;
 		}
 
+		err = phy_write(phydev, MII_M1111_PHY_EXT_CR, temp);
+		if (err < 0)
+			return err;
+
 		temp = phy_read(phydev, MII_M1111_PHY_EXT_SR);
 		if (temp < 0)
 			return temp;
-- 
1.5.2.2
