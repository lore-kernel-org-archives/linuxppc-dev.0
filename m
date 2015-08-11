Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id CC13A1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 20:11:06 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] net: fs_enet: explicitly remove I flag on TX partial frames
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Message-Id: <20150811101101.116E41A2414@localhost.localdomain>
Date: Tue, 11 Aug 2015 12:11:00 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are not interested in interrupts for partially transmitted frames,
we have to clear BD_ENET_TX_INTR explicitly otherwise it may remain
from a previously used descriptor.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index b9ad34e..84c18ee 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -585,7 +585,8 @@ static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	frag = skb_shinfo(skb)->frags;
 	while (nr_frags) {
 		CBDC_SC(bdp,
-			BD_ENET_TX_STATS | BD_ENET_TX_LAST | BD_ENET_TX_TC);
+			BD_ENET_TX_STATS | BD_ENET_TX_INTR | BD_ENET_TX_LAST |
+			BD_ENET_TX_TC);
 		CBDS_SC(bdp, BD_ENET_TX_READY);
 
 		if ((CBDR_SC(bdp) & BD_ENET_TX_WRAP) == 0)
-- 
2.1.0
