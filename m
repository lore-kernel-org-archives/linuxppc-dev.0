Return-Path: <fabf@skynet.be>
Received: from mailrelay110.isp.belgacom.be (mailrelay110.isp.belgacom.be
 [195.238.20.137])
 by lists.ozlabs.org (Postfix) with ESMTP id 841E21A0DEB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 02:33:29 +1000 (AEST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Fabian Frederick <fabf@skynet.be>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: [PATCH 1/1 linux-next] net: fs_enet: use swap() in fs_enet_rx_napi()
Date: Wed, 10 Jun 2015 18:33:19 +0200
Message-Id: <1433953999-24740-1-git-send-email-fabf@skynet.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use kernel.h macro definition.

Thanks to Julia Lawall for Coccinelle scripting support.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 9b3639e..c5f299d 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -86,7 +86,7 @@ static int fs_enet_rx_napi(struct napi_struct *napi, int budget)
 	struct net_device *dev = fep->ndev;
 	const struct fs_platform_info *fpi = fep->fpi;
 	cbd_t __iomem *bdp;
-	struct sk_buff *skb, *skbn, *skbt;
+	struct sk_buff *skb, *skbn;
 	int received = 0;
 	u16 pkt_len, sc;
 	int curidx;
@@ -161,10 +161,7 @@ static int fs_enet_rx_napi(struct napi_struct *napi, int budget)
 					skb_reserve(skbn, 2);	/* align IP header */
 					skb_copy_from_linear_data(skb,
 						      skbn->data, pkt_len);
-					/* swap */
-					skbt = skb;
-					skb = skbn;
-					skbn = skbt;
+					swap(skb, skbn);
 				}
 			} else {
 				skbn = netdev_alloc_skb(dev, ENET_RX_FRSIZE);
-- 
2.4.2
