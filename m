Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id A83A01A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:23:15 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] powerpc/pseries: re-use code from of_helpers module
Date: Tue, 11 Aug 2015 14:23:09 +0300
Message-Id: <1439292189-78925-5-git-send-email-andriy.shevchenko@linux.intel.com>
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

The derive_parent() has similar semantics to what we have in newly introduced
of_helpers module. The replacement reduces code base and propagates the actual
error code to the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 47d9cebe..b7f243c 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -18,6 +18,8 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+
+#include "of_helpers.h"
 #include "offline_states.h"
 #include "pseries.h"
 
@@ -244,36 +246,13 @@ cc_error:
 	return first_dn;
 }
 
-static struct device_node *derive_parent(const char *path)
-{
-	struct device_node *parent;
-	char *last_slash;
-
-	last_slash = strrchr(path, '/');
-	if (last_slash == path) {
-		parent = of_find_node_by_path("/");
-	} else {
-		char *parent_path;
-		int parent_path_len = last_slash - path + 1;
-		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
-		if (!parent_path)
-			return NULL;
-
-		strlcpy(parent_path, path, parent_path_len);
-		parent = of_find_node_by_path(parent_path);
-		kfree(parent_path);
-	}
-
-	return parent;
-}
-
 int dlpar_attach_node(struct device_node *dn)
 {
 	int rc;
 
-	dn->parent = derive_parent(dn->full_name);
-	if (!dn->parent)
-		return -ENOMEM;
+	dn->parent = pseries_of_derive_parent(dn->full_name);
+	if (IS_ERR(dn->parent))
+		return PTR_ERR(dn_parent);
 
 	rc = of_attach_node(dn);
 	if (rc) {
-- 
2.5.0
