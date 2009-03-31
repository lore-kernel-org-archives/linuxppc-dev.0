Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D95ADDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 05:33:53 +1100 (EST)
Date: Tue, 31 Mar 2009 22:33:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] fsl_pq_mdio: Revive UCC MDIO support
Message-ID: <20090331183352.GA4474@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 1577ecef766650a57fceb171acee2b13cbfaf1d3 ("netdev: Merge UCC
and gianfar MDIO bus drivers") introduced a regression so that UCC
MDIO buses no longer work.

This is because fsl_pq_mdio driver wrongly masks all non-TBI PHYs
for !fsl,gianfar-mdio buses, while it should do that only for
fsl,gianfar-tbi buses.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/fsl_pq_mdio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index b3079a5..d9e1ecf 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -387,7 +387,7 @@ static int fsl_pq_mdio_probe(struct of_device *ofdev,
 	 * The TBIPHY-only buses will find PHYs at every address,
 	 * so we mask them all but the TBI
 	 */
-	if (!of_device_is_compatible(np, "fsl,gianfar-mdio"))
+	if (of_device_is_compatible(np, "fsl,gianfar-tbi"))
 		new_bus->phy_mask = ~(1 << tbiaddr);
 
 	err = mdiobus_register(new_bus);
-- 
1.5.6.5
