Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kxv83f5GzDrWV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:24:04 +1000 (AEST)
From: zhong jiang <zhongjiang@huawei.com>
To: <paulus@samba.org>, <benh@kernel.crashing.org>, <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: Move a dereference below a NULL test
Date: Wed, 26 Sep 2018 19:46:08 +0800
Message-ID: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
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

It is safe to move dereference below a NULL test.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/powerpc/kernel/cacheinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index a8f20e5..7f19714 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -401,14 +401,13 @@ static struct cache *cache_lookup_or_instantiate(struct device_node *node,
 	struct cache *cache;
 
 	cache = cache_lookup_by_node(node);
+	if (!cache)
+		cache = cache_do_one_devnode(node, level);
 
 	WARN_ONCE(cache && cache->level != level,
 		  "cache level mismatch on lookup (got %d, expected %d)\n",
 		  cache->level, level);
 
-	if (!cache)
-		cache = cache_do_one_devnode(node, level);
-
 	return cache;
 }
 
-- 
1.7.12.4
