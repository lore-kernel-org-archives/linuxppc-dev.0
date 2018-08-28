Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205ld3Sw6zDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:41 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 3/6] net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
Date: Tue, 28 Aug 2018 13:09:18 +0200
Message-Id: <20180828110921.2542-4-david.gounaris@infinera.com>
In-Reply-To: <20180828110921.2542-1-david.gounaris@infinera.com>
References: <20180828110921.2542-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was done to avoid discarding ethernet
packets when using HDLC_ETH protocol.

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 963b3b5ae15e..54e2b2143e36 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -375,6 +375,10 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 		dev->stats.tx_bytes += skb->len;
 		break;
 
+	case ARPHRD_ETHER:
+		dev->stats.tx_bytes += skb->len;
+		break;
+
 	default:
 		dev->stats.tx_dropped++;
 		dev_kfree_skb(skb);
@@ -512,6 +516,8 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 			break;
 
 		case ARPHRD_PPP:
+		case ARPHRD_ETHER:
+			
 			length -= HDLC_CRC_SIZE;
 
 			skb = dev_alloc_skb(length);
-- 
2.13.6
