Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 35615DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:25:47 +1000 (EST)
Date: Thu, 10 May 2007 02:25:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] early_pfn_to_nid needs to be __meminit
Message-Id: <20070510022552.4bb1a407.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

since it is referenced by memmap_init_zone (which is __meminit) via the
early_pfn_in_nid macro when CONFIG_NODES_SPAN_OTHER_NODES is set (which
basically means PowerPC 64).

This removes a section mismatch warning in those circumstances.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/page_alloc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6fd0b74..3297fa9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2298,7 +2298,7 @@ static int __meminit next_active_region_index_in_nid(int index, int nid)
  * was used and there are no special requirements, this is a convenient
  * alternative
  */
-int __init early_pfn_to_nid(unsigned long pfn)
+int __meminit early_pfn_to_nid(unsigned long pfn)
 {
 	int i;
 
-- 
1.5.1.3
