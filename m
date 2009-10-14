Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id B0EC7B7B74
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 04:43:47 +1100 (EST)
Received: by pxi7 with SMTP id 7so12342pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 10:43:45 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2] net/fec_mpc52xx: Fix kernel panic on FEC error
To: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, davem@davemloft.net
Date: Wed, 14 Oct 2009 11:43:43 -0600
Message-ID: <20091014174224.29221.18830.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: John Bonesio <bones@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Bonesio <bones@secretlab.ca>

The MDIO bus cannot be accessed at interrupt context, but on an FEC
error, the fec_mpc52xx driver reset function also tries to reset the
PHY.  Since the error is detected at IRQ context, and the PHY functions
try to sleep, the kernel ends up panicking.

Resetting the PHY on an FEC error isn't even necessary.  This patch
solves the problem by removing the PHY reset entirely.

Signed-off-by: John Bonesio <bones@secretlab.ca>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

v2: fixed stupid misspelling of John's email address.  No changes to content.

 drivers/net/fec_mpc52xx.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index c40113f..66dace6 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -759,12 +759,6 @@ static void mpc52xx_fec_reset(struct net_device *dev)
 
 	mpc52xx_fec_hw_init(dev);
 
-	if (priv->phydev) {
-		phy_stop(priv->phydev);
-		phy_write(priv->phydev, MII_BMCR, BMCR_RESET);
-		phy_start(priv->phydev);
-	}
-
 	bcom_fec_rx_reset(priv->rx_dmatsk);
 	bcom_fec_tx_reset(priv->tx_dmatsk);
 
