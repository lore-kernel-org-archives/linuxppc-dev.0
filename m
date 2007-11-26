Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A78EDE058
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:18:07 +1100 (EST)
Date: Mon, 26 Nov 2007 16:17:58 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 3/3][RESEND] ucc_geth: handle passing of RX-only and TX-only
	internal delay PHY connection type parameters
Message-Id: <20071126161758.38056096.kim.phillips@freescale.com>
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

Extend the RGMII-Internal Delay specification case to include
TX-only and RX-only variants.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Tested-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Li Yang <leoli@freescale.com>
---
 drivers/net/ucc_geth.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index a3ff270..7f68990 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1460,6 +1460,8 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 	if ((ugeth->phy_interface == PHY_INTERFACE_MODE_RMII) ||
 	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII) ||
 	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_ID) ||
+	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
+	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) ||
 	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RTBI)) {
 		upsmr |= UPSMR_RPM;
 		switch (ugeth->max_speed) {
@@ -1557,6 +1559,8 @@ static void adjust_link(struct net_device *dev)
 				if ((ugeth->phy_interface == PHY_INTERFACE_MODE_RMII) ||
 				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII) ||
 				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_ID) ||
+				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
+				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) ||
 				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RTBI)) {
 					if (phydev->speed == SPEED_10)
 						upsmr |= UPSMR_R10M;
@@ -3795,6 +3799,10 @@ static phy_interface_t to_phy_interface(const char *phy_connection_type)
 		return PHY_INTERFACE_MODE_RGMII;
 	if (strcasecmp(phy_connection_type, "rgmii-id") == 0)
 		return PHY_INTERFACE_MODE_RGMII_ID;
+	if (strcasecmp(phy_connection_type, "rgmii-txid") == 0)
+		return PHY_INTERFACE_MODE_RGMII_TXID;
+	if (strcasecmp(phy_connection_type, "rgmii-rxid") == 0)
+		return PHY_INTERFACE_MODE_RGMII_RXID;
 	if (strcasecmp(phy_connection_type, "rtbi") == 0)
 		return PHY_INTERFACE_MODE_RTBI;
 
@@ -3889,6 +3897,8 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 		case PHY_INTERFACE_MODE_GMII:
 		case PHY_INTERFACE_MODE_RGMII:
 		case PHY_INTERFACE_MODE_RGMII_ID:
+		case PHY_INTERFACE_MODE_RGMII_RXID:
+		case PHY_INTERFACE_MODE_RGMII_TXID:
 		case PHY_INTERFACE_MODE_TBI:
 		case PHY_INTERFACE_MODE_RTBI:
 			max_speed = SPEED_1000;
-- 
1.5.2.2
