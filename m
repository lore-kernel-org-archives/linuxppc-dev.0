Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h4Y61rkSzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 19:26:02 +1000 (AEST)
Message-Id: <47f1cc02529bafe8ad258081784e44da188eed49.1533201696.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/mm: fix always true/false warning in slice.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 malat@debian.org, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  2 Aug 2018 09:25:55 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the following warnings (obtained with make W=1).

arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (start < SLICE_LOW_TOP) {
            ^
arch/powerpc/mm/slice.c:81:20: error: comparison is always false due to limited range of data type [-Werror=type-limits]
  if ((start + len) > SLICE_LOW_TOP) {
                    ^
arch/powerpc/mm/slice.c: In function 'slice_mask_for_free':
arch/powerpc/mm/slice.c:136:17: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (high_limit <= SLICE_LOW_TOP)
                 ^
arch/powerpc/mm/slice.c: In function 'slice_check_range_fits':
arch/powerpc/mm/slice.c:185:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (start < SLICE_LOW_TOP) {
            ^
arch/powerpc/mm/slice.c:195:39: error: comparison is always false due to limited range of data type [-Werror=type-limits]
  if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
                                       ^
arch/powerpc/mm/slice.c: In function 'slice_scan_available':
arch/powerpc/mm/slice.c:306:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (addr < SLICE_LOW_TOP) {
           ^
arch/powerpc/mm/slice.c: In function 'get_slice_psize':
arch/powerpc/mm/slice.c:709:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (addr < SLICE_LOW_TOP) {
           ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: fixed issue reported by Michael

 arch/powerpc/mm/slice.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 9530c6db406a..c774d43e038c 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -62,6 +62,13 @@ static void slice_print_mask(const char *label, const struct slice_mask *mask) {
 
 #endif
 
+static inline bool slice_addr_is_low(unsigned long addr)
+{
+	u64 tmp = (u64)addr;
+
+	return tmp < SLICE_LOW_TOP;
+}
+
 static void slice_range_to_mask(unsigned long start, unsigned long len,
 				struct slice_mask *ret)
 {
@@ -71,7 +78,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 	if (SLICE_NUM_HIGH)
 		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
-	if (start < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(start)) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
 
@@ -79,7 +86,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
-	if ((start + len) > SLICE_LOW_TOP) {
+	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
@@ -134,7 +141,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (slice_addr_is_low(high_limit - 1))
 		return;
 
 	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
@@ -183,7 +190,7 @@ static bool slice_check_range_fits(struct mm_struct *mm,
 	unsigned long end = start + len - 1;
 	u64 low_slices = 0;
 
-	if (start < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(start)) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
 
@@ -193,7 +200,7 @@ static bool slice_check_range_fits(struct mm_struct *mm,
 	if ((low_slices & available->low_slices) != low_slices)
 		return false;
 
-	if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
+	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
@@ -304,7 +311,7 @@ static bool slice_scan_available(unsigned long addr,
 				 int end, unsigned long *boundary_addr)
 {
 	unsigned long slice;
-	if (addr < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(addr)) {
 		slice = GET_LOW_SLICE_INDEX(addr);
 		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
 		return !!(available->low_slices & (1u << slice));
@@ -707,7 +714,7 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 
 	VM_BUG_ON(radix_enabled());
 
-	if (addr < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(addr)) {
 		psizes = mm->context.low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {
-- 
2.13.3
