Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A7526DDF24
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:48 +1000 (EST)
Message-Id: <20070705170235.873955000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:42 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 09/35] pasemi_mac: Simplify memcpy for short receives
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No need to copy over the skipped align bytes (besides, NET_IP_ALIGN is
0 on ppc64).

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: netdev-2.6/drivers/net/pasemi_mac.c
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.c
+++ netdev-2.6/drivers/net/pasemi_mac.c
@@ -516,9 +516,7 @@ static int pasemi_mac_clean_rx(struct pa
 			    netdev_alloc_skb(mac->netdev, len + NET_IP_ALIGN);
 			if (new_skb) {
 				skb_reserve(new_skb, NET_IP_ALIGN);
-				memcpy(new_skb->data - NET_IP_ALIGN,
-					skb->data - NET_IP_ALIGN,
-					len + NET_IP_ALIGN);
+				memcpy(new_skb->data, skb->data, len);
 				/* save the skb in buffer_info as good */
 				skb = new_skb;
 			}

--
