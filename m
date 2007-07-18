Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 43ABADF2AF
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1aMdC027810
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:23 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1aMV9001629
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:22 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BfMf008016
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:41 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 3745BAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:21 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1aLS9015502
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:21 -0500
Date: Tue, 17 Jul 2007 20:36:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 60/61] fs_enet: Align receive buffers.
Message-ID: <20070718013621.GF15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At least some hardware driven by this driver needs receive buffers
to be aligned on a 16-byte boundary.  This usually happens by chance,
but it breaks if slab debugging is enabled.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/net/fs_enet/fs_enet-main.c |   21 +++++++++++++++++++--
 drivers/net/fs_enet/fs_enet.h      |    3 ++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index da79a45..a4b76cd 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -69,6 +69,14 @@ static void fs_set_multicast_list(struct net_device *dev)
 	(*fep->ops->set_multicast_list)(dev);
 }
 
+static void skb_align(struct sk_buff *skb, int align)
+{
+	int off = ((unsigned long)skb->data) & (align - 1);
+
+	if (off)
+		skb_reserve(skb, align - off);
+}
+
 /* NAPI receive function */
 static int fs_enet_rx_napi(struct net_device *dev, int *budget)
 {
@@ -166,9 +174,13 @@ static int fs_enet_rx_napi(struct net_device *dev, int *budget)
 					skb = skbn;
 					skbn = skbt;
 				}
-			} else
+			} else {
 				skbn = dev_alloc_skb(ENET_RX_FRSIZE);
 
+				if (skbn)
+					skb_align(skbn, ENET_RX_ALIGN);
+			}
+
 			if (skbn != NULL) {
 				skb_put(skb, pkt_len);	/* Make room */
 				skb->protocol = eth_type_trans(skb, dev);
@@ -300,9 +312,13 @@ static int fs_enet_rx_non_napi(struct net_device *dev)
 					skb = skbn;
 					skbn = skbt;
 				}
-			} else
+			} else {
 				skbn = dev_alloc_skb(ENET_RX_FRSIZE);
 
+				if (skbn)
+					skb_align(skbn, ENET_RX_ALIGN);
+			}
+
 			if (skbn != NULL) {
 				skb_put(skb, pkt_len);	/* Make room */
 				skb->protocol = eth_type_trans(skb, dev);
@@ -512,6 +528,7 @@ void fs_init_bds(struct net_device *dev)
 			       dev->name);
 			break;
 		}
+		skb_align(skb, ENET_RX_ALIGN);
 		fep->rx_skbuff[i] = skb;
 		CBDW_BUFADDR(bdp,
 			dma_map_single(fep->dev, skb->data,
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
index 569be22..6875dd8 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -82,7 +82,8 @@ struct phy_info {
 /* Must be a multiple of 32 (to cover both FEC & FCC) */
 #define PKT_MAXBLR_SIZE		((PKT_MAXBUF_SIZE + 31) & ~31)
 /* This is needed so that invalidate_xxx wont invalidate too much */
-#define ENET_RX_FRSIZE		L1_CACHE_ALIGN(PKT_MAXBUF_SIZE)
+#define ENET_RX_ALIGN  16
+#define ENET_RX_FRSIZE L1_CACHE_ALIGN(PKT_MAXBUF_SIZE + ENET_RX_ALIGN - 1)
 
 struct fs_enet_mii_bus {
 	struct list_head list;
-- 
1.5.0.3
