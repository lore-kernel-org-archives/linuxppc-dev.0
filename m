Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id F26B61A1D25
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:23:43 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] powerpc/pseries: fix a potential memory leak
Date: Tue, 11 Aug 2015 14:23:06 +0300
Message-Id: <1439292189-78925-2-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1439292189-78925-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1439292189-78925-1-git-send-email-andriy.shevchenko@linux.intel.com>
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
2.5.0
