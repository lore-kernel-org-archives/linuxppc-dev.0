Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id ABE3DDDFE4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 02:01:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/cell: make ptcal more reliable
Date: Wed, 13 May 2009 17:50:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <0ML21M-1M4Gtp1PZb-0001oc@mrelayeu.kundenserver.de>
Cc: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Gerhard Stenzel <stenzel@de.ibm.com>

There have been a series of checkstops on QS21 related to
ptcal being set up incorrectly. On systems that only
have memory on a single node, ptcal fails when it gets
a pointer to memory on the remote node.

Moreover, agressive prefetching in memcpy and other
functions may accidentally touch the first cache line
of the page that we reserve for ptcal, which causes
an ECC checkstop.

We now allocate pages only from the specified node, moves the
ptcal area into the middle of the allocated page to avoid
potential prefetch problems and prints the address of the
ptcal area to facilitate diagnostics.

Signed-off-by: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/ras.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 5f961c4..296b526 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -122,12 +122,23 @@ static int __init cbe_ptcal_enable_on_node(int nid, int order)
 
 	area->nid = nid;
 	area->order = order;
-	area->pages = alloc_pages_node(area->nid, GFP_KERNEL, area->order);
+	area->pages = alloc_pages_node(area->nid, GFP_KERNEL | GFP_THISNODE,
+					area->order);
 
-	if (!area->pages)
+	if (!area->pages) {
+		printk(KERN_WARNING "%s: no page on node %d\n",
+			__func__, area->nid);
 		goto out_free_area;
+	}
 
-	addr = __pa(page_address(area->pages));
+	/*
+	 * We move the ptcal area to the middle of the allocated
+	 * page, in order to avoid prefetches in memcpy and similar
+	 * functions stepping on it.
+	 */
+	addr = __pa(page_address(area->pages)) + (PAGE_SIZE >> 1);
+	printk(KERN_DEBUG "%s: enabling PTCAL on node %d address=0x%016lx\n",
+			__func__, area->nid, addr);
 
 	ret = -EIO;
 	if (rtas_call(ptcal_start_tok, 3, 1, NULL, area->nid,
-- 
1.5.6.3
