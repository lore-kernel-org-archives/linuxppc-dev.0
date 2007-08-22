Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D12E7DDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 01:08:05 +1000 (EST)
Date: Wed, 22 Aug 2007 09:12:55 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [04/10] pasemi_mac: Fix memcpy amount for short receives
Message-ID: <20070822141255.GE16830@lixom.net>
References: <20070817205413.548020000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix up memcpy for short receives.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: mainline/drivers/net/pasemi_mac.c
===================================================================
--- mainline.orig/drivers/net/pasemi_mac.c
+++ mainline/drivers/net/pasemi_mac.c
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
