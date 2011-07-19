Return-Path: <sr@denx.de>
Received: from mo-p05-ob6.rzone.de (mo-p05-ob6.rzone.de
	[IPv6:2a01:238:20a:202:53f5::1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B9EDB6F75
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2011 20:50:24 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: ibm_newemac: Don't start autonegotiation when disabled
	in BMCR (genmii)
Date: Tue, 19 Jul 2011 12:50:04 +0200
Message-Id: <1311072604-24840-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As noticed on a custom 440GX board using the Micrel KSZ8041 PHY in
fiber mode, a strapped fixed PHY configuration will currently restart
the autonegotiation. This patch checks the BMCR_ANENABLE bit and
skips this autonegotiation if its disabled.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/net/ibm_newemac/phy.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/phy.c b/drivers/net/ibm_newemac/phy.c
index ac9d964..90afc58 100644
--- a/drivers/net/ibm_newemac/phy.c
+++ b/drivers/net/ibm_newemac/phy.c
@@ -116,6 +116,11 @@ static int genmii_setup_aneg(struct mii_phy *phy, u32 advertise)
 	ctl = phy_read(phy, MII_BMCR);
 	if (ctl < 0)
 		return ctl;
+
+	/* Don't start auto negotiation when its disabled in BMCR */
+	if (!(ctl & BMCR_ANENABLE))
+		return 0;
+
 	ctl &= ~(BMCR_FULLDPLX | BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_ANENABLE);
 
 	/* First clear the PHY */
-- 
1.7.6
