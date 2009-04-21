Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7B0D2DDFD2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 19:45:05 +1000 (EST)
Message-ID: <49ED859B.30904@denx.de>
Date: Tue, 21 Apr 2009 10:36:43 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: [PATCH] [net, 83xx] ucc_geth.c: Fix upsmr setting in RMII mode
Content-Type: text/plain; charset=ISO-8859-15
Cc: Shlomi Gridish <gridish@freescale.com>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If using the UCC on a MPC8360 in RMII mode, don;t set
UCC_GETH_UPSMR_RPM bit in the upsmr register.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/ucc_geth.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index d3f39e8..44f8392 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1394,7 +1394,8 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
 	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) ||
 	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RTBI)) {
-		upsmr |= UCC_GETH_UPSMR_RPM;
+		if (ugeth->phy_interface != PHY_INTERFACE_MODE_RMII)
+			upsmr |= UCC_GETH_UPSMR_RPM;
 		switch (ugeth->max_speed) {
 		case SPEED_10:
 			upsmr |= UCC_GETH_UPSMR_R10M;
-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
