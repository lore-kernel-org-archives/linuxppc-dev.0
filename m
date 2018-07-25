Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bH941sTMzDrTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 00:07:04 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id m16-v6so3344619pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 07:07:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/4] mm: allow arch to have tlb_flush caled on an empty
 TLB range
Date: Thu, 26 Jul 2018 00:06:40 +1000
Message-Id: <20180725140641.30372-4-npiggin@gmail.com>
In-Reply-To: <20180725140641.30372-1-npiggin@gmail.com>
References: <20180725140641.30372-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc wants to de-couple page table caching structure flushes
from TLB flushes, which will make it possible to have mmu_gather
with freed page table pages but no TLB range. These must be sent
to tlb_flush, so allow the arch to specify when mmu_gather with
empty ranges should have tlb_flush called.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/tlb.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b3353e21f3b3..b320c0cc8996 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -139,14 +139,27 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	}
 }
 
+/*
+ * arch_tlb_mustflush specifies if tlb_flush is to be called even if the
+ * TLB range is empty (this can be the case for freeing page table pages
+ * if the arch does not adjust TLB range to cover them).
+ */
+#ifndef arch_tlb_mustflush
+#define arch_tlb_mustflush(tlb) false
+#endif
+
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
-	if (!tlb->end)
+	unsigned long start = tlb->start;
+	unsigned long end = tlb->end;
+
+	if (!(end || arch_tlb_mustflush(tlb)))
 		return;
 
 	tlb_flush(tlb);
-	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
 	__tlb_reset_range(tlb);
+	if (end)
+		mmu_notifier_invalidate_range(tlb->mm, start, end);
 }
 
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
-- 
2.17.0
