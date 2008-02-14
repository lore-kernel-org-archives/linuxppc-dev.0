Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C6F52DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:10:04 +1100 (EST)
Date: Wed, 13 Feb 2008 17:10:35 -0800 (PST)
Message-Id: <20080213.171035.249149650.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4]: [LMB]: Fix bug in __lmb_alloc_base().
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


[LMB]: Fix bug in __lmb_alloc_base().

We need to check lmb_add_region() for errors, it can run out
of regions etc.

Also, the size needs to be padded to the given alignment
or else the lmb.reserved regions don't get expanded and
instead we get tons of holes and eventually run out of
regions prematurely.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 98078b4..6390d63 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -245,6 +245,11 @@ static unsigned long lmb_align_down(unsigned long addr, unsigned long size)
 	return addr & ~(size - 1);
 }
 
+static unsigned long lmb_align_up(unsigned long addr, unsigned long size)
+{
+	return (addr + (size - 1)) & ~(size - 1);
+}
+
 unsigned long __init __lmb_alloc_base(unsigned long size, unsigned long align,
 				    unsigned long max_addr)
 {
@@ -281,7 +286,8 @@ unsigned long __init __lmb_alloc_base(unsigned long size, unsigned long align,
 	if (i < 0)
 		return 0;
 
-	lmb_add_region(&lmb.reserved, base, size);
+	if (lmb_add_region(&lmb.reserved, base, lmb_align_up(size, align)) < 0)
+		return 0;
 
 	return base;
 }
-- 
1.5.4.29.gb828fe
