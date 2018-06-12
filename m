Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414h5g0ksVzF4Lb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 17:16:54 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y5-v6so10706427pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 00:16:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
 Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with precise
 TLB ranges in mmu_gather
Date: Tue, 12 Jun 2018 17:16:21 +1000
Message-Id: <20180612071621.26775-4-npiggin@gmail.com>
In-Reply-To: <20180612071621.26775-1-npiggin@gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the page_start and page_end fields of mmu_gather to implement more
precise TLB flushing. (start, end) covers the entire TLB and page
table range that has been invalidated, for architectures that do not
have explicit page walk cache management. page_start and page_end are
just for ranges that may have TLB entries.

A tlb_flush may have no pages in this range, but still requires PWC
to be flushed. That is handled properly.

This brings the number of tlbiel instructions required by a kernel
compile from 33M to 25M, most avoided from exec->shift_arg_pages.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..06452ad701cf 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -853,8 +853,11 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 		else
 			radix__flush_all_mm(mm);
 	} else {
-		unsigned long start = tlb->start;
-		unsigned long end = tlb->end;
+		unsigned long start = tlb->page_start;
+		unsigned long end = tlb->page_end;
+
+		if (end < start)
+			end = start;
 
 		if (!tlb->need_flush_all)
 			radix__flush_tlb_range_psize(mm, start, end, psize);
-- 
2.17.0
