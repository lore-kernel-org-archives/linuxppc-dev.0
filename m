Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 423qWK4wxgzF37K
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 22:47:54 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 joakim.tjernlund@infinera.com
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v3 3/6] net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
Date: Mon,  3 Sep 2018 14:47:27 +0200
Message-Id: <20180903124730.1551-4-david.gounaris@infinera.com>
In-Reply-To: <20180903124730.1551-1-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180903124730.1551-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to avoid discarding ethernet
packets when using HDLC_ETH protocol.

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 5619e2c2e02d..2aaa5e1959a9 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -376,6 +376,10 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 		dev->stats.tx_bytes += skb->len;
 		break;
 
+	case ARPHRD_ETHER:
+		dev->stats.tx_bytes += skb->len;
+		break;
+
 	default:
 		dev->stats.tx_dropped++;
 		dev_kfree_skb(skb);
@@ -513,6 +517,7 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 			break;
 
 		case ARPHRD_PPP:
+		case ARPHRD_ETHER:
 			length -= HDLC_CRC_SIZE;
 
 			skb = dev_alloc_skb(length);
-- 
2.13.6
