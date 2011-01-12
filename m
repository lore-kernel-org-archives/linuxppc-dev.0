Return-Path: <tklauser@distanz.ch>
Received: from mx1.zhaw.ch (mx1.zhaw.ch [160.85.104.50])
	by ozlabs.org (Postfix) with ESMTP id E6006B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Jan 2011 20:38:44 +1100 (EST)
From: Tobias Klauser <tklauser@distanz.ch>
To: Li Yang <leoli@freescale.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next-2.6] netdev: ucc_geth: Use is_multicast_ether_addr
	helper
Date: Wed, 12 Jan 2011 10:31:01 +0100
Message-Id: <1294824661-10564-1-git-send-email-tklauser@distanz.ch>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/net/ucc_geth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 73a3e0d..715e7b4 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2032,7 +2032,7 @@ static void ucc_geth_set_multi(struct net_device *dev)
 			netdev_for_each_mc_addr(ha, dev) {
 				/* Only support group multicast for now.
 				 */
-				if (!(ha->addr[0] & 1))
+				if (!is_multicast_ether_addr(ha->addr))
 					continue;
 
 				/* Ask CPM to run CRC and set bit in
-- 
1.7.0.4
