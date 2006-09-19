Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3393C67B63
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 14:56:50 +1000 (EST)
Received: from localhost (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 068743684CF
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 14:56:49 +1000 (EST)
Date: Tue, 19 Sep 2006 14:54:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Fw: [PATCH] Remove powerpc specific parts of 3c509 driver
Message-Id: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch has been sent to netdev and is needed to build 3c509 after my following patch (that removes some io accessor functions).

Begin forwarded message:

Date: Tue, 19 Sep 2006 11:54:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: netdev@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH] Remove powerpc specific parts of 3c509 driver


On powerpc and ppc, insl_ns and insl are identical as are outsl_ns and
outsl, so remove the conditional use of insl_ns and outsl_ns.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/3c509.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

This is in anticipation of removing the insl_ns and outsl_ns definitions
which are powerpc sepcific patches.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
index cbdae54..add6381 100644
--- a/drivers/net/3c509.c
+++ b/drivers/net/3c509.c
@@ -879,11 +879,7 @@ #endif
 	outw(skb->len, ioaddr + TX_FIFO);
 	outw(0x00, ioaddr + TX_FIFO);
 	/* ... and the packet rounded to a doubleword. */
-#ifdef  __powerpc__
-	outsl_ns(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
-#else
 	outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
-#endif
 
 	dev->trans_start = jiffies;
 	if (inw(ioaddr + TX_FREE) > 1536)
@@ -1103,13 +1099,8 @@ el3_rx(struct net_device *dev)
 				skb_reserve(skb, 2);     /* Align IP on 16 byte */
 
 				/* 'skb->data' points to the start of sk_buff data area. */
-#ifdef  __powerpc__
-				insl_ns(ioaddr+RX_FIFO, skb_put(skb,pkt_len),
-							   (pkt_len + 3) >> 2);
-#else
 				insl(ioaddr + RX_FIFO, skb_put(skb,pkt_len),
 					 (pkt_len + 3) >> 2);
-#endif
 
 				outw(RxDiscard, ioaddr + EL3_CMD); /* Pop top Rx packet. */
 				skb->protocol = eth_type_trans(skb,dev);
-- 
1.4.2.1
