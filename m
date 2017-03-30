Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3Fx6qLJzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 05/19] powerpc/mm/slice: Move slice_mask struct definition
 to slice.c
Date: Thu, 30 Mar 2017 23:03:53 +1100
Message-Id: <1490875447-4016-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This structure definition need not be in a header since this is used only by
slice.c file. So move it to slice.c. This also allow us to use SLICE_NUM_HIGH
instead of 64.

I also switch the low_slices type to u64 from u16. This doesn't have an impact
on size of struct due to padding added with u16 type. This helps in using
bitmap printing function for printing slice mask.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/page_64.h | 11 -----------
 arch/powerpc/mm/slice.c            | 10 +++++++++-
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index bd55ff751938..c4d9654bd637 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -99,17 +99,6 @@ extern u64 ppc64_pft_size;
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
 #ifndef __ASSEMBLY__
-/*
- * One bit per slice. We have lower slices which cover 256MB segments
- * upto 4G range. That gets us 16 low slices. For the rest we track slices
- * in 1TB size.
- * 64 below is actually SLICE_NUM_HIGH to fixup complie errros
- */
-struct slice_mask {
-	u16 low_slices;
-	DECLARE_BITMAP(high_slices, 64);
-};
-
 struct mm_struct;
 
 extern unsigned long slice_get_unmapped_area(unsigned long addr,
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 175e0dbce89b..7599c2703520 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -37,7 +37,15 @@
 #include <asm/hugetlb.h>
 
 static DEFINE_SPINLOCK(slice_convert_lock);
-
+/*
+ * One bit per slice. We have lower slices which cover 256MB segments
+ * upto 4G range. That gets us 16 low slices. For the rest we track slices
+ * in 1TB size.
+ */
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
+};
 
 #ifdef DEBUG
 int _slice_debug = 1;
-- 
2.7.4
