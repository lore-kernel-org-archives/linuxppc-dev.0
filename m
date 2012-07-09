Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66EE82C05D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:14:46 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 13:05:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q69DEAVY44892314
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:14:11 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q69DEARx030208
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:14:10 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 08/11] arch/powerpc: Make some of the PGTABLE_RANGE
 dependency explicit
Date: Mon,  9 Jul 2012 18:43:38 +0530
Message-Id: <1341839621-28332-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

slice array size and slice mask size depend on PGTABLE_RANGE. We
can't directly include pgtable.h in these header because there is
a circular dependency. So add compile time check for these values.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h    |   13 ++++++++-----
 arch/powerpc/include/asm/page_64.h       |   17 ++++++++++++++---
 arch/powerpc/include/asm/pgtable-ppc64.h |    8 ++++++++
 arch/powerpc/mm/slice.c                  |   12 ++++++------
 4 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 35b74e8..aa0d560 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -419,6 +419,13 @@ extern void slb_set_size(u16 size);
 	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
 	add	rt,rt,rx
 
+/* 4 bits per slice and we have one slice per 1TB */
+#if 0 /* We can't directly include pgtable.h hence this hack */
+#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
+#else
+/* Right now we only support 64TB */
+#define SLICE_ARRAY_SIZE  32
+#endif
 
 #ifndef __ASSEMBLY__
 
@@ -463,11 +470,7 @@ typedef struct {
 
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
-	/*
-	 * Right now we support 64TB and 4 bits for each
-	 * 1TB slice we need 32 bytes for 64TB.
-	 */
-	unsigned char high_slices_psize[32];  /* 4 bits per slice for now */
+	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 6c9bef4..141853e 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -78,15 +78,26 @@ extern u64 ppc64_pft_size;
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+/* 1 bit per slice and we have one slice per 1TB */
+#if 0 /* We can't directly include pgtable.h hence this hack */
+#define SLICE_MASK_SIZE (PGTABLE_RANG >> 43)
+#else
+/* Right now we support only 64TB */
+#define SLICE_MASK_SIZE 8
+#endif
+
 #ifndef __ASSEMBLY__
 
 struct slice_mask {
 	u16 low_slices;
 	/*
-	 * This should be derived out of PGTABLE_RANGE. For the current
-	 * max 64TB, u64 should be ok.
+	 * We do this as a union so that we can verify
+	 * SLICE_MASK_SIZE against PGTABLE_RANGE
 	 */
-	u64 high_slices;
+	union {
+		u64 high_slices;
+		unsigned char not_used[SLICE_MASK_SIZE];
+	};
 };
 
 struct mm_struct;
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 8af1cf2..dea953f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -32,6 +32,14 @@
 #endif
 #endif
 
+#if (PGTABLE_RANGE >> 41) > SLICE_ARRAY_SIZE
+#error PGTABLE_RANGE exceeds SLICE_ARRAY_SIZE
+#endif
+
+#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
+#error PGTABLE_RANGE exceeds slice_mask high_slices size
+#endif
+
 /*
  * Define the address range of the kernel non-linear virtual area
  */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 302a481..0aa1b2d 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -73,7 +73,7 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
 					     unsigned long len)
 {
 	unsigned long end = start + len - 1;
-	struct slice_mask ret = { 0, 0 };
+	struct slice_mask ret = { 0, {0} };
 
 	if (start < SLICE_LOW_TOP) {
 		unsigned long mend = min(end, SLICE_LOW_TOP);
@@ -123,7 +123,7 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 
 static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
 {
-	struct slice_mask ret = { 0, 0 };
+	struct slice_mask ret = { 0, {0} };
 	unsigned long i;
 
 	for (i = 0; i < SLICE_NUM_LOW; i++)
@@ -144,7 +144,7 @@ static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
 {
 	unsigned char *hpsizes;
 	int index, mask_index;
-	struct slice_mask ret = { 0, 0 };
+	struct slice_mask ret = { 0, {0} };
 	unsigned long i;
 	u64 lpsizes;
 
@@ -412,10 +412,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 				      unsigned long flags, unsigned int psize,
 				      int topdown, int use_cache)
 {
-	struct slice_mask mask = {0, 0};
+	struct slice_mask mask = {0, {0} };
 	struct slice_mask good_mask;
-	struct slice_mask potential_mask = {0,0} /* silence stupid warning */;
-	struct slice_mask compat_mask = {0, 0};
+	struct slice_mask potential_mask = {0, {0} } /* silence stupid warning */;
+	struct slice_mask compat_mask = {0, {0} };
 	int fixed = (flags & MAP_FIXED);
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	struct mm_struct *mm = current->mm;
-- 
1.7.10
