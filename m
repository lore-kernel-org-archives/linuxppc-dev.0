Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 7C065DDF68
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 01:17:10 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] ibm_newemac: Fix problem with jumbo frame support and EMAC V4
Date: Thu,  3 Apr 2008 16:16:56 +0200
Message-Id: <1207232216-21053-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the jumbo frame support on EMAC V4 systems. Now the correct
bit is set depending on the EMAC version configured.

Tested on Kilauea (405EX) and Canyonlands (460EX).

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 0789802..486901f 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -524,7 +524,10 @@ static int emac_configure(struct emac_instance *dev)
 		rx_size = dev->rx_fifo_size_gige;
 
 		if (dev->ndev->mtu > ETH_DATA_LEN) {
-			mr1 |= EMAC_MR1_JPSM;
+			if (emac_has_feature(dev, EMAC_FTR_EMAC4))
+				mr1 |= EMAC4_MR1_JPSM;
+			else
+				mr1 |= EMAC_MR1_JPSM;
 			dev->stop_timeout = STOP_TIMEOUT_1000_JUMBO;
 		} else
 			dev->stop_timeout = STOP_TIMEOUT_1000;
-- 
1.5.4.5
