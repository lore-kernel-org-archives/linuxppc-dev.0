Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 389C5B7B80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 13:01:07 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e846103b117cc36798b1f352ed526d600fd88e16.1250132460.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Add kmemleak annotations to lmb.c
Date: Thu, 13 Aug 2009 13:01:07 +1000 (EST)
Cc: catalin.marinas@arm.com, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't actually want kmemleak to track the lmb allocations, so we
pass min_count as 0. However telling kmemleak about lmb allocations
allows it to scan that memory for pointers to other memory that is
tracked by kmemleak, ie. slab allocations etc.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 lib/lmb.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e4a6482..b82779a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/lmb.h>
+#include <linux/kmemleak.h>
 
 #define LMB_ALLOC_ANYWHERE	0
 
@@ -352,8 +353,10 @@ u64 __init lmb_alloc_nid(u64 size, u64 align, int nid,
 		u64 ret = lmb_alloc_nid_region(&mem->region[i],
 					       nid_range,
 					       size, align, nid);
-		if (ret != ~(u64)0)
+		if (ret != ~(u64)0) {
+			kmemleak_alloc(__va(ret), size, 0, 0);
 			return ret;
+		}
 	}
 
 	return lmb_alloc(size, align);
@@ -412,6 +415,8 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 				/* this area isn't reserved, take it */
 				if (lmb_add_region(&lmb.reserved, base, size) < 0)
 					return 0;
+
+				kmemleak_alloc(__va(base), size, 0, 0);
 				return base;
 			}
 			res_base = lmb.reserved.region[j].base;
-- 
1.6.2.1
