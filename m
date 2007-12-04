Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C9770DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 14:30:18 +1100 (EST)
Date: Mon, 3 Dec 2007 21:34:14 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH 2.6.24] pasemi_mac: Fix reuse of free'd skb
Message-ID: <20071204033414.GA13616@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ranger@gentoo.org, netdev@vger.kernel.org, dwmw2@infradead.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Turns out we're freeing the skb when we detect CRC error, but we're
not clearing out info->skb. We could either clear it and have the stack
reallocate it, or just leave it and the rx ring refill code will reuse
the one that was allocated.

Reusing a freed skb obviously caused some nasty crashes of various kind,
as reported by Brent Baude and David Woodhouse.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

Jeff, I'd like to see this in 2.6.24, it's causing some real problems
out there. It's not needed in the 2.6.25 queue since the other changes
there have already covered these cases.

My test network at home is quiet enough to not cause CRC errors, we
mainly get those during interface bringup before speed is configured.

diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index 09b4fde..6617e24 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -586,7 +586,7 @@ static int pasemi_mac_clean_rx(struct pasemi_mac *mac, int limit)
 			/* CRC error flagged */
 			mac->netdev->stats.rx_errors++;
 			mac->netdev->stats.rx_crc_errors++;
-			dev_kfree_skb_irq(skb);
+			/* No need to free skb, it'll be reused */
 			goto next;
 		}
 
