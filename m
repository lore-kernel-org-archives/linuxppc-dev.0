Return-Path: <shailendras@nvidia.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDJSJ4vC1zDq5Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 09:57:52 +1100 (AEDT)
From: Shailendra Singh <shailendras@nvidia.com>
To: <linuxppc-dev@lists.ozlabs.org>, <jk@ozlabs.org>,
 <shailendras@nvidia.com>, <apopple@au1.ibm.com>, <balbirs@au1.ibm.com>,
 <aritger@nvidia.com>, <jhubbard@nvidia.com>, <scheung@nvidia.com>,
 <amanjunatha@nvidia.com>, <jmckenna@nvidia.com>
Subject: [PATCH] powerpc: Fix inconsistent of_node_to_nid EXPORT_SYMBOL
 handling
Date: Wed, 1 Feb 2017 14:52:42 -0800
Message-ID: <1485989562-16741-1-git-send-email-shailendras@nvidia.com>
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

The generic implementation of of_node_to_nid is EXPORT_SYMBOL.

The powerpc implementation added by following commit is EXPORT_SYMBOL_GPL.
commit 953039c8df7b ("[PATCH] powerpc: Allow devices to register with numa
topology")

This creates an inconsistency for of_node_to_nid callers across
architectures.

Update the powerpc implementation to be exported consistently with the
generic implementation.

Signed-off-by: Shailendra Singh <shailendras@nvidia.com>

Reviewed-by: Andy Ritger <aritger@nvidia.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b1099cb2f393..8aa4ca3c84c9 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -290,7 +290,7 @@ int of_node_to_nid(struct device_node *device)
 
 	return nid;
 }
-EXPORT_SYMBOL_GPL(of_node_to_nid);
+EXPORT_SYMBOL(of_node_to_nid);
 
 static int __init find_min_common_depth(void)
 {
-- 
2.4.11
