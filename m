Return-Path: <dingtianhong@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BBC292C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 16:16:40 +1100 (EST)
Message-ID: <52B7C598.9010904@huawei.com>
Date: Mon, 23 Dec 2013 13:09:44 +0800
From: Ding Tianhong <dingtianhong@huawei.com>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>, Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 02/21] net: freescale: slight optimization of addr compare
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the recently added and possibly more efficient
ether_addr_equal_unaligned to instead of memcmp.

Cc: Li Yang <leoli@freescale.com>
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 5548b6d..88a1525 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -437,7 +437,7 @@ static void hw_add_addr_in_hash(struct ucc_geth_private *ugeth,
 
 static inline int compare_addr(u8 **addr1, u8 **addr2)
 {
-	return memcmp(addr1, addr2, ETH_ALEN);
+	return !ether_addr_equal_unaligned(addr1, addr2);
 }
 
 #ifdef DEBUG
-- 
1.8.0
