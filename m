Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jRLk0XxTzF3GF
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 00:36:44 +1000 (AEST)
From: zhong jiang <zhongjiang@huawei.com>
To: <benh@kernel.crashing.org>
CC: <paulus@samba.org>, <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] powpc:feature: of_node_put is not needed after iterator.
Date: Sat, 4 Aug 2018 22:25:00 +0800
Message-ID: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

for_each_node_by_name iterators only  exit normally when the loop
cursor is NULL, So there is no point to call of_node_put.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/powerpc/platforms/powermac/feature.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 3f82cb2..4eb8cb3 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2889,10 +2889,8 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 	/* On all machines, switch modem & serial ports off */
 	for_each_node_by_name(np, "ch-a")
 		initial_serial_shutdown(np);
-	of_node_put(np);
 	for_each_node_by_name(np, "ch-b")
 		initial_serial_shutdown(np);
-	of_node_put(np);
 }
 
 void __init
-- 
1.7.12.4
