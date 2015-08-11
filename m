Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 891291A1C07
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:23:45 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/5] powerpc/pseries: handle nodes without '/'
Date: Tue, 11 Aug 2015 14:23:08 +0300
Message-Id: <1439292189-78925-4-git-send-email-andriy.shevchenko@linux.intel.com>
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

In case we have node without '/' strrchr() returns NULL which might lead to
crash. Replace strrchr() by kbasename() and modify condition to avoid such
behaviour.

Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 8c6b05a..4417afe 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -17,14 +17,14 @@ struct device_node *pseries_of_derive_parent(const char *path)
 {
 	struct device_node *parent;
 	char *parent_path = "/";
-	size_t parent_path_len = strrchr(path, '/') - path + 1;
+	const char *tail = kbasename(path);
 
 	/* reject if path is "/" */
 	if (!strcmp(path, "/"))
 		return ERR_PTR(-EINVAL);
 
-	if (strrchr(path, '/') != path) {
-		parent_path = kstrndup(path, parent_path_len, GFP_KERNEL);
+	if (tail > path + 1) {
+		parent_path = kstrndup(path, tail - path, GFP_KERNEL);
 		if (!parent_path)
 			return ERR_PTR(-ENOMEM);
 	}
-- 
2.5.0
