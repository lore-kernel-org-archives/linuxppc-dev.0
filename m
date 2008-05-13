Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C093DDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 10:41:59 +1000 (EST)
Date: Mon, 12 May 2008 17:41:52 -0700 (PDT)
Message-Id: <20080512.174152.123760440.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2]: lmb: Fix inconsistent alignment of size argument.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikpe@it.uu.se, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When allocating, if we will align up the size when making
the reservation, we should also align the size for the
check that the space is actually available.

The simplest thing is to just aling the size up from
the beginning, then we can use plain 'size' throughout.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 83287d3..93445dc 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -286,8 +286,7 @@ static u64 __init lmb_alloc_nid_unreserved(u64 start, u64 end,
 		j = lmb_overlaps_region(&lmb.reserved, base, size);
 		if (j < 0) {
 			/* this area isn't reserved, take it */
-			if (lmb_add_region(&lmb.reserved, base,
-					   lmb_align_up(size, align)) < 0)
+			if (lmb_add_region(&lmb.reserved, base, size) < 0)
 				base = ~(u64)0;
 			return base;
 		}
@@ -333,6 +332,10 @@ u64 __init lmb_alloc_nid(u64 size, u64 align, int nid,
 	struct lmb_region *mem = &lmb.memory;
 	int i;
 
+	BUG_ON(0 == size);
+
+	size = lmb_align_up(size, align);
+
 	for (i = 0; i < mem->cnt; i++) {
 		u64 ret = lmb_alloc_nid_region(&mem->region[i],
 					       nid_range,
@@ -370,6 +373,8 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 
 	BUG_ON(0 == size);
 
+	size = lmb_align_up(size, align);
+
 	/* On some platforms, make sure we allocate lowmem */
 	/* Note that LMB_REAL_LIMIT may be LMB_ALLOC_ANYWHERE */
 	if (max_addr == LMB_ALLOC_ANYWHERE)
@@ -393,8 +398,7 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 			j = lmb_overlaps_region(&lmb.reserved, base, size);
 			if (j < 0) {
 				/* this area isn't reserved, take it */
-				if (lmb_add_region(&lmb.reserved, base,
-						   lmb_align_up(size, align)) < 0)
+				if (lmb_add_region(&lmb.reserved, base, size) < 0)
 					return 0;
 				return base;
 			}
-- 
1.5.5.1.57.g5909c
