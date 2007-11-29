Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5573FDE48A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 13:54:46 +1100 (EST)
Date: Wed, 28 Nov 2007 20:57:56 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [10/12] pasemi_mac: Remove SKB copy/recycle logic
Message-ID: <20071129025756.GK17215@lixom.net>
References: <20071129025410.GA17215@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129025410.GA17215@lixom.net>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pasemi_mac: Remove SKB copy/recycle logic

It doesn't really buy us much, since copying is about as expensive
as the allocation in the first place. Just remove it for now.


Signed-off-by: Olof Johansson <olof@lixom.net>


---
 drivers/net/pasemi_mac.c |   25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

Index: k.org/drivers/net/pasemi_mac.c
===================================================================
--- k.org.orig/drivers/net/pasemi_mac.c
+++ k.org/drivers/net/pasemi_mac.c
@@ -503,13 +503,8 @@ static void pasemi_mac_replenish_rx_ring
 		/* Entry in use? */
 		WARN_ON(*buff);
 
-		/* skb might still be in there for recycle on short receives */
-		if (info->skb)
-			skb = info->skb;
-		else {
-			skb = dev_alloc_skb(BUF_SIZE);
-			skb_reserve(skb, LOCAL_SKB_ALIGN);
-		}
+		skb = dev_alloc_skb(BUF_SIZE);
+		skb_reserve(skb, LOCAL_SKB_ALIGN);
 
 		if (unlikely(!skb))
 			break;
@@ -666,21 +661,7 @@ static int pasemi_mac_clean_rx(struct pa
 			goto next;
 		}
 
-		if (len < 256) {
-			struct sk_buff *new_skb;
-
-			new_skb = netdev_alloc_skb(mac->netdev,
-						   len + LOCAL_SKB_ALIGN);
-			if (new_skb) {
-				skb_reserve(new_skb, LOCAL_SKB_ALIGN);
-				memcpy(new_skb->data, skb->data, len);
-				/* save the skb in buffer_info as good */
-				skb = new_skb;
-			}
-			/* else just continue with the old one */
-		} else
-			info->skb = NULL;
-
+		info->skb = NULL;
 		info->dma = 0;
 
 		if (likely((macrx & XCT_MACRX_HTY_M) == XCT_MACRX_HTY_IPV4_OK)) {
