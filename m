Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQprj5hKqzDrH3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 00:22:58 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm/nohash: do not flush the entire mm when range is a
 single page
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180123132250.4A2BD6EF69@localhost.localdomain>
Date: Tue, 23 Jan 2018 14:22:50 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most of the time, flush_tlb_range() is called on single pages.
At the time being, flush_tlb_range() inconditionnaly calls
flush_tlb_mm() which flushes at least the entire PID pages and on
older CPUs like 4xx or 8xx it flushes the entire TLB table.

This patch calls flush_tlb_page() instead of flush_tlb_mm() when
the range is a single page.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/tlb_nohash.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index bfc4a0869609..15fe5f0c8665 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -388,7 +388,10 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 
 {
-	flush_tlb_mm(vma->vm_mm);
+	if (end - start == PAGE_SIZE && !(start & ~PAGE_MASK))
+		flush_tlb_page(vma, start);
+	else
+		flush_tlb_mm(vma->vm_mm);
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
-- 
2.13.3
