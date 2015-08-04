Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 751A81A1BD9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:37:12 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/5] powerpc/pseries: replace kmalloc + strlcpy
Date: Tue,  4 Aug 2015 17:36:48 +0300
Message-Id: <1438699009-112794-4-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The helper kstrndup() will do the same in one line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 027446a..afa5555 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -24,10 +24,9 @@ struct device_node *pseries_of_derive_parent(const char *path)
 		return ERR_PTR(-EINVAL);
 
 	if (parent_path_len > 1) {
-		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
+		parent_path = kstrndup(path, parent_path_len, GFP_KERNEL);
 		if (!parent_path)
 			return ERR_PTR(-ENOMEM);
-		strlcpy(parent_path, path, parent_path_len);
 	}
 	parent = of_find_node_by_path(parent_path);
 	if (strcmp(parent_path, "/"))
-- 
2.4.6
