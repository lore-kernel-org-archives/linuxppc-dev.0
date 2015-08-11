Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id CA4CE1A1C07
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:23:44 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] powerpc/pseries: replace kmalloc + strlcpy
Date: Tue, 11 Aug 2015 14:23:07 +0300
Message-Id: <1439292189-78925-3-git-send-email-andriy.shevchenko@linux.intel.com>
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

The helper kstrndup() will do the same in one line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 2f363e3..8c6b05a 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -24,10 +24,9 @@ struct device_node *pseries_of_derive_parent(const char *path)
 		return ERR_PTR(-EINVAL);
 
 	if (strrchr(path, '/') != path) {
-		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
+		parent_path = kstrndup(path, parent_path_len, GFP_KERNEL);
 		if (!parent_path)
 			return ERR_PTR(-ENOMEM);
-		strlcpy(parent_path, path, parent_path_len);
 	}
 	parent = of_find_node_by_path(parent_path);
 	if (strcmp(parent_path, "/"))
-- 
2.5.0
