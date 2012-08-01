Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD1F72C0302
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 02:14:16 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 1 Aug 2012 21:44:13 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q71GE8vS17694764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 21:44:08 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q71GE788000404
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2012 02:14:08 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V6 08/12] arch/powerpc: Make some of the PGTABLE_RANGE
 dependency explicit
Date: Wed,  1 Aug 2012 21:43:39 +0530
Message-Id: <1343837623-9046-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1343837623-9046-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1343837623-9046-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h    |   13 ++++++++-----
 arch/powerpc/include/asm/page_64.h       |   16 ++++++++++++----
 arch/powerpc/include/asm/pgtable-ppc64.h |    8 ++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 8f05eec..8c5c5a4 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -420,6 +420,13 @@ extern void slb_set_size(u16 size);
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
 
@@ -464,11 +471,7 @@ typedef struct {
 
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
index 6c9bef4..b55beb4 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -78,14 +78,22 @@ extern u64 ppc64_pft_size;
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+/* 1 bit per slice and we have one slice per 1TB */
+#if 0 /* We can't directly include pgtable.h hence this hack */
+#define SLICE_MASK_SIZE (PGTABLE_RANGE >> 43)
+#else
+/*
+ * Right now we support only 64TB.
+ * IF we change this we will have to change the type
+ * of high_slices
+ */
+#define SLICE_MASK_SIZE 8
+#endif
+
 #ifndef __ASSEMBLY__
 
 struct slice_mask {
 	u16 low_slices;
-	/*
-	 * This should be derived out of PGTABLE_RANGE. For the current
-	 * max 64TB, u64 should be ok.
-	 */
 	u64 high_slices;
 };
 
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
-- 
1.7.10
