Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 5DAC2DDE3C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 19:29:18 +1000 (EST)
Subject: [Fwd: [PATCH] Fix ethernet multicast for ucc_geth.]
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 11:29:07 +0200
Message-Id: <1192699747.7848.51.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No response yet, figured I should try here instead.

 Jocke
-------- Forwarded Message --------
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Reply-To: joakim.tjernlund@transmode.se
To: Netdev <netdev@vger.kernel.org>, Li Yang-r58472
<LeoLi@freescale.com>
Subject: [PATCH] Fix ethernet multicast for ucc_geth.
Date: Wed, 17 Oct 2007 11:05:42 +0200

>From 5761a9e5924b34615c748fba2dcb977ed04c1243 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 17 Oct 2007 11:01:44 +0200
Subject: [PATCH] Fix ethernet multicast for ucc_geth.
 hw_add_addr_in_hash() already swaps byte
 order, don't do it in ucc_geth_set_multi() too.


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 drivers/net/ucc_geth.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 61f5cce..f649b1e 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2214,9 +2214,7 @@ static void ucc_geth_set_multi(struct net_device *dev)
 	struct dev_mc_list *dmi;
 	struct ucc_fast *uf_regs;
 	struct ucc_geth_82xx_address_filtering_pram *p_82xx_addr_filt;
-	u8 tempaddr[6];
-	u8 *mcptr, *tdptr;
-	int i, j;
+	int i;
 
 	ugeth = netdev_priv(dev);
 
@@ -2255,19 +2253,10 @@ static void ucc_geth_set_multi(struct net_device *dev)
 				if (!(dmi->dmi_addr[0] & 1))
 					continue;
 
-				/* The address in dmi_addr is LSB first,
-				 * and taddr is MSB first.  We have to
-				 * copy bytes MSB first from dmi_addr.
-				 */
-				mcptr = (u8 *) dmi->dmi_addr + 5;
-				tdptr = (u8 *) tempaddr;
-				for (j = 0; j < 6; j++)
-					*tdptr++ = *mcptr--;
-
 				/* Ask CPM to run CRC and set bit in
 				 * filter mask.
 				 */
-				hw_add_addr_in_hash(ugeth, tempaddr);
+				hw_add_addr_in_hash(ugeth, dmi->dmi_addr);
 			}
 		}
 	}
