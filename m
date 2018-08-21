Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vs746S7JzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 23:32:48 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7LDNjHE087705
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 09:32:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m0gp88ghf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 09:32:46 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 21 Aug 2018 07:32:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 2/2] powerpc/mm: Increase the max addressable memory to 2PB
Date: Tue, 21 Aug 2018 19:02:26 +0530
In-Reply-To: <20180821133226.15908-1-aneesh.kumar@linux.ibm.com>
References: <20180821133226.15908-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180821133226.15908-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we limit the max addressable memory to 128TB. This patch increase the
limit to 2PB. We can have devices like nvdimm which adds memory above 512TB
limit.

We still don't support regular system ram above 512TB. One of the challenge with
that is the percpu allocator, that allocates per node memory and use the max
distance between them as the percpu offsets. This means with large gap in
address space ( system ram above 1PB) we will run out of vmalloc space to map
the percpu allocation.

In order to support addressable memory above 512TB, kernel should be able to
linear map this range. To do that with hash translation we now add 4 context
to kernel linear map region. Our per context addressable range is 512TB. We
still keep VMALLOC and VMEMMAP region to old size. SLB miss handlers is updated
to validate these limit.

We also limit this update to SPARSEMEM_VMEMMAP and SPARSEMEM_EXTREME

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---

Changes dependent on http://patchwork.ozlabs.org/patch/960211/
"powerpc/64s/hash: convert SLB miss handlers to C"


 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 49 ++++++++++++++++---
 arch/powerpc/include/asm/mmu.h                | 15 ++++++
 arch/powerpc/include/asm/sparsemem.h          | 11 -----
 arch/powerpc/mm/slb.c                         | 20 ++++++--
 4 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b3520b549cba..a184b71cead8 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -558,6 +558,26 @@ extern void slb_set_size(u16 size);
 #define ESID_BITS_MASK		((1 << ESID_BITS) - 1)
 #define ESID_BITS_1T_MASK	((1 << ESID_BITS_1T) - 1)
 
+/*
+ * Now certain config support MAX_PHYSMEM more than 512TB. Hence we will need
+ * to use more than one context for linear mapping the kernel.
+ * For vmalloc and memmap, we use just one context with 512TB. With 64 byte
+ * struct page size, we need ony 32 TB in memmap for 2PB (51 bits (MAX_PHYSMEM_BITS)).
+ */
+#if (MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
+#define MAX_KERNEL_CTX_CNT	(1UL << (MAX_PHYSMEM_BITS - MAX_EA_BITS_PER_CONTEXT))
+#else
+#define MAX_KERNEL_CTX_CNT	1
+#endif
+
+#define MAX_VMALLOC_CTX_CNT	1
+#define MAX_MEMMAP_CTX_CNT	1
+
+/*
+ * Would be nice to use KERNEL_REGION_ID here
+ */
+#define KERNEL_REGION_CONTEXT_OFFSET	(0xc - 1)
+
 /*
  * 256MB segment
  * The proto-VSID space has 2^(CONTEX_BITS + ESID_BITS) - 1 segments
@@ -568,12 +588,13 @@ extern void slb_set_size(u16 size);
  * We also need to avoid the last segment of the last context, because that
  * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
  * because of the modulo operation in vsid scramble.
+ *
+ * We add one extra context to MIN_USER_CONTEXT so that we can map kernel
+ * context easily. The +1 is to map the unused 0xe region mapping.
  */
 #define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 2)
-#define MIN_USER_CONTEXT	(5)
-
-/* Would be nice to use KERNEL_REGION_ID here */
-#define KERNEL_REGION_CONTEXT_OFFSET	(0xc - 1)
+#define MIN_USER_CONTEXT	(MAX_KERNEL_CTX_CNT + MAX_VMALLOC_CTX_CNT + \
+				 MAX_MEMMAP_CTX_CNT + 2)
 
 /*
  * For platforms that support on 65bit VA we limit the context bits
@@ -733,6 +754,23 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 	return vsid_scramble(protovsid, VSID_MULTIPLIER_1T, vsid_bits);
 }
 
+static inline unsigned long get_kernel_context(unsigned long ea)
+{
+	unsigned long region_id = REGION_ID(ea);
+	unsigned long ctx = region_id - KERNEL_REGION_CONTEXT_OFFSET;
+	/*
+	 * For linear mapping we do support multiple context
+	 */
+	if (region_id == KERNEL_REGION_ID) {
+		/*
+		 * We already verified ea to be not beyond the addr limit.
+		 */
+		ctx +=  ((ea & ~REGION_MASK) >> MAX_EA_BITS_PER_CONTEXT);
+	}
+
+	return ctx;
+}
+
 /*
  * This is only valid for addresses >= PAGE_OFFSET
  */
@@ -755,8 +793,7 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 	 * So we can compute the context from the region (top nibble) by
 	 * subtracting 11, or 0xc - 1.
 	 */
-	context = (ea >> 60) - KERNEL_REGION_CONTEXT_OFFSET;
-
+	context = get_kernel_context(ea);
 	return get_vsid(context, ea, ssize);
 }
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 13ea441ac531..eb20eb3b8fb0 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -309,6 +309,21 @@ static inline u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
  */
 #define MMU_PAGE_COUNT	16
 
+/*
+ * If we store section details in page->flags we can't increase the MAX_PHYSMEM_BITS
+ * if we increase SECTIONS_WIDTH we will not store node details in page->flags and
+ * page_to_nid does a page->section->node lookup
+ * Hence only increase for VMEMMAP. Further depending on SPARSEMEM_EXTREME reduce
+ * memory requirements with large number of sections.
+ * 51 bits is the max physical real address on POWER9
+ */
+#if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME) &&	\
+	defined (CONFIG_PPC_64K_PAGES)
+#define MAX_PHYSMEM_BITS        51
+#else
+#define MAX_PHYSMEM_BITS        46
+#endif
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/mmu.h>
 #else /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 28f5dae25db6..68da49320592 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -9,17 +9,6 @@
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
 #define SECTION_SIZE_BITS       24
-/*
- * If we store section details in page->flags we can't increase the MAX_PHYSMEM_BITS
- * if we increase SECTIONS_WIDTH we will not store node details in page->flags and
- * page_to_nid does a page->section->node lookup
- * Hence only increase for VMEMMAP.
- */
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-#define MAX_PHYSMEM_BITS        47
-#else
-#define MAX_PHYSMEM_BITS        46
-#endif
 
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index f63a608922ca..afad18763be3 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -423,16 +423,27 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 	unsigned long flags;
 	int ssize;
 
-	if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
-		return -EFAULT;
-
 	if (id == KERNEL_REGION_ID) {
+
+		/* We only support upto MAX_PHYSMEM_BITS */
+		if ((ea & ~REGION_MASK) > (1UL << MAX_PHYSMEM_BITS))
+			return -EFAULT;
+
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	} else if (id == VMEMMAP_REGION_ID) {
+
+		if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+			return -EFAULT;
+
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmemmap_psize].sllp;
 #endif
 	} else if (id == VMALLOC_REGION_ID) {
+
+		if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+			return -EFAULT;
+
 		if (ea < H_VMALLOC_END)
 			flags = get_paca()->vmalloc_sllp;
 		else
@@ -445,8 +456,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 	if (!mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		ssize = MMU_SEGSIZE_256M;
 
-	context = id - KERNEL_REGION_CONTEXT_OFFSET;
-
+	context = get_kernel_context(ea);
 	return slb_insert_entry(ea, context, flags, ssize, true);
 }
 
-- 
2.17.1
