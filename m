Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM1pN2x0YzF0Wk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:22:52 +1100 (AEDT)
Message-Id: <5b2e7ea5b11e11034817467a142a9bd01dc22725.1516179904.git.christophe.leroy@c-s.fr>
In-Reply-To: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 5/5] powerpc/mm: Remove intermediate bitmap copy in 'slices'
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Jan 2018 10:22:48 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

bitmap_or() and bitmap_andnot() can work properly with dst identical
to src1 or src2. There is no need of an intermediate result bitmap
that is copied back to dst in a second step.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: New in v2

 arch/powerpc/mm/slice.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index fa6f7f63223c..9d88b1c03caa 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -72,8 +72,6 @@ static void slice_print_mask(const char *label, struct slice_mask mask) {}
 	do { if (nbits) bitmap_zero(dst, nbits); } while (0)
 #define slice_bitmap_set(dst, pos, nbits) \
 	do { if (nbits) bitmap_set(dst, pos, nbits); } while (0)
-#define slice_bitmap_copy(dst, src, nbits) \
-	do { if (nbits) bitmap_copy(dst, src, nbits); } while (0)
 #define slice_bitmap_and(dst, src1, src2, nbits) \
 	({ (nbits) ? bitmap_and(dst, src1, src2, nbits) : 0; })
 #define slice_bitmap_or(dst, src1, src2, nbits) \
@@ -416,25 +414,18 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 
 static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
 	slice_bitmap_or(dst->low_slices, dst->low_slices, src->low_slices,
 			SLICE_NUM_LOW);
-	slice_bitmap_or(result, dst->high_slices, src->high_slices,
+	slice_bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
 			SLICE_NUM_HIGH);
-	slice_bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
 }
 
 static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
 	slice_bitmap_andnot(dst->low_slices, dst->low_slices, src->low_slices,
 			    SLICE_NUM_LOW);
-
-	slice_bitmap_andnot(result, dst->high_slices, src->high_slices,
-			    SLICE_NUM_HIGH);
-	slice_bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+	slice_bitmap_andnot(dst->high_slices, dst->high_slices,
+			    src->high_slices, SLICE_NUM_HIGH);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
-- 
2.13.3
