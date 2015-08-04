Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 270481A1BD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:37:24 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/5] powerpc/pseries: don't call strrchr() twice
Date: Tue,  4 Aug 2015 17:36:47 +0300
Message-Id: <1438699009-112794-3-git-send-email-andriy.shevchenko@linux.intel.com>
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

There is no need to call strrchr() second time. We already know that in that
case parent_path_len either 1 ("/foo") or bigger ("/foo/bar").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 2f363e3..027446a 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -23,7 +23,7 @@ struct device_node *pseries_of_derive_parent(const char *path)
 	if (!strcmp(path, "/"))
 		return ERR_PTR(-EINVAL);
 
-	if (strrchr(path, '/') != path) {
+	if (parent_path_len > 1) {
 		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
 		if (!parent_path)
 			return ERR_PTR(-ENOMEM);
-- 
2.4.6
