Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id B1F4A1A010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 19:46:16 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] powerpc/pseries: replace kmalloc + strlcpy
Date: Thu,  1 Oct 2015 12:46:08 +0300
Message-Id: <1443692770-44944-4-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1443692770-44944-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443692770-44944-1-git-send-email-andriy.shevchenko@linux.intel.com>
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
2.5.1
