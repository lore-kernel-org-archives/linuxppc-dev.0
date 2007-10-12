Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A59FCDDE1B
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 09:34:08 +1000 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: akpm@linux-foundation.org, jgarzik@pobox.com, leoli@Freescale.com,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] ucc_geth: Fix build break introduced by commit
	09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
Date: Fri, 12 Oct 2007 18:26:28 -0500
Message-Id: <1192231588-17516-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  CC      drivers/net/ucc_geth.o
drivers/net/ucc_geth.c: In function 'ucc_geth_startup':
drivers/net/ucc_geth.c:2614: warning: assignment makes integer from pointer without a cast
drivers/net/ucc_geth.c:2651: warning: assignment makes integer from pointer without a cast
drivers/net/ucc_geth.c: In function 'ucc_geth_rx':
drivers/net/ucc_geth.c:3483: error: 'dev' undeclared (first use in this function)
drivers/net/ucc_geth.c:3483: error: (Each undeclared identifier is reported only once
drivers/net/ucc_geth.c:3483: error: for each function it appears in.)
make[2]: *** [drivers/net/ucc_geth.o] Error 1

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

Here is a convenient link for the culprit patch: http://git.kernel.org/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commit;h=09f75cd7bf13720738e6a196cc0107ce9a5bd5a0

netdev-2.6> scripts/checkpatch.pl 0001-POWERPC-ucc_geth-Fix-build-break-introduced-by-co.patch 
Your patch has no obvious style problems and is ready for submission.

 drivers/net/ucc_geth.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index d00e7d4..c43d4d1 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -63,7 +63,7 @@
 #define UGETH_MSG_DEFAULT	(NETIF_MSG_IFUP << 1 ) - 1
 
 void uec_set_ethtool_ops(struct net_device *netdev);
-	
+
 static DEFINE_SPINLOCK(ugeth_lock);
 
 static struct {
@@ -3480,9 +3480,9 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 				dev_kfree_skb_any(skb);
 
 			ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]] = NULL;
-			dev->stats.rx_dropped++;
+			ugeth->dev->stats.rx_dropped++;
 		} else {
-			dev->stats.rx_packets++;
+			ugeth->dev->stats.rx_packets++;
 			howmany++;
 
 			/* Prep the skb for the packet */
@@ -3491,7 +3491,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 			/* Tell the skb what kind of packet this is */
 			skb->protocol = eth_type_trans(skb, ugeth->dev);
 
-			dev->stats.rx_bytes += length;
+			ugeth->dev->stats.rx_bytes += length;
 			/* Send the packet up the stack */
 #ifdef CONFIG_UGETH_NAPI
 			netif_receive_skb(skb);
@@ -3506,7 +3506,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 		if (!skb) {
 			if (netif_msg_rx_err(ugeth))
 				ugeth_warn("%s: No Rx Data Buffer", __FUNCTION__);
-			dev->stats.rx_dropped++;
+			ugeth->dev->stats.rx_dropped++;
 			break;
 		}
 
-- 
1.5.3.GIT
