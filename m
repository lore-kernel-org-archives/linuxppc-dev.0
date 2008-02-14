Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C053EDE36F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:10:19 +1100 (EST)
Date: Wed, 13 Feb 2008 17:10:50 -0800 (PST)
Message-Id: <20080213.171050.183740061.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4]: [LMB]: Fix initial lmb add region with a non-zero base
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[LMB]: Fix initial lmb add region with a non-zero base

If we add to an empty lmb region with a non-zero base we will not
coalesce the number of regions down to one.  This causes problems on
ppc32 for the memory region as its assumed to only have one region.

We can fix this be easily specially casing the initial add to just
replace the dummy region.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 6390d63..e34a9e5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -134,6 +134,12 @@ static long __init lmb_add_region(struct lmb_region *rgn, unsigned long base,
 	unsigned long coalesced = 0;
 	long adjacent, i;
 
+	if ((rgn->cnt == 1) && (rgn->region[0].size == 0)) {
+		rgn->region[0].base = base;
+		rgn->region[0].size = size;
+		return 0;
+	}
+
 	/* First try and coalesce this LMB with another. */
 	for (i=0; i < rgn->cnt; i++) {
 		unsigned long rgnbase = rgn->region[i].base;
-- 
1.5.4.29.gb828fe
