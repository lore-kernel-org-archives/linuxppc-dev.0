Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 834271A076F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:36:56 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/5] powerpc/pseries: fix a potential memory leak
Date: Tue,  4 Aug 2015 17:36:46 +0300
Message-Id: <1438699009-112794-2-git-send-email-andriy.shevchenko@linux.intel.com>
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

In case we have a full node name like /foo/bar and /foo is not found the
parent_path left unfreed. So, free a memory before return to a caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 1cbd896..2f363e3 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -15,7 +15,7 @@
  */
 struct device_node *pseries_of_derive_parent(const char *path)
 {
-	struct device_node *parent = NULL;
+	struct device_node *parent;
 	char *parent_path = "/";
 	size_t parent_path_len = strrchr(path, '/') - path + 1;
 
@@ -30,9 +30,7 @@ struct device_node *pseries_of_derive_parent(const char *path)
 		strlcpy(parent_path, path, parent_path_len);
 	}
 	parent = of_find_node_by_path(parent_path);
-	if (!parent)
-		return ERR_PTR(-EINVAL);
 	if (strcmp(parent_path, "/"))
 		kfree(parent_path);
-	return parent;
+	return parent ? parent : ERR_PTR(-EINVAL);
 }
-- 
2.4.6
