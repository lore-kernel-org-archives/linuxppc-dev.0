Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hYTb2f7mzF2Br
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:09:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: rashmica.g@gmail.com,
	anton@samba.org
Subject: [PATCH] powerpc/powernv: Fix memtrace build when NUMA=n
Date: Thu, 10 May 2018 23:09:13 +1000
Message-Id: <20180510130913.23931-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently memtrace doesn't build if NUMA=n:

  In function ‘memtrace_alloc_node’:
  arch/powerpc/platforms/powernv/memtrace.c:134:6:
  error: the address of ‘contig_page_data’ will always evaluate as ‘true’
    if (!NODE_DATA(nid) || !node_spanned_pages(nid))
        ^

This is because for NUMA=n NODE_DATA(nid) points to an always
allocated structure, contig_page_data.

But even in the NUMA=y case memtrace_alloc_node() is only called for
online nodes, and we should always have a NODE_DATA() allocated for an
online node. So remove the (hopefully) overly paranoid check, which
also means we can build when NUMA=n.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/memtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index fc222a0c2ac4..b99283df8584 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -131,7 +131,7 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 	u64 start_pfn, end_pfn, nr_pages;
 	u64 base_pfn;
 
-	if (!NODE_DATA(nid) || !node_spanned_pages(nid))
+	if (!node_spanned_pages(nid))
 		return 0;
 
 	start_pfn = node_start_pfn(nid);
-- 
2.14.1
