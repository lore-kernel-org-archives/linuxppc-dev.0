Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E1C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 14:36:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2D220857
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 14:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2D220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YWxS3GWTzDqMW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 01:36:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YWv333LfzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 01:34:38 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x32EXq37107695
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Apr 2019 10:34:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rm9jsg77h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 10:34:36 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 2 Apr 2019 15:34:35 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Apr 2019 15:34:32 +0100
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x32EYVdJ29425892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2019 14:34:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D23F6E050;
 Tue,  2 Apr 2019 14:34:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 104F56E04C;
 Tue,  2 Apr 2019 14:34:27 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.72.143])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  2 Apr 2019 14:34:27 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH] powerpc/mm: Reduce memory usage for mm_context_t for radix
Date: Tue,  2 Apr 2019 20:04:24 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040214-0016-0000-0000-0000099B716E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010860; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183286; UDB=6.00619479; IPR=6.00964034; 
 MB=3.00026260; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 14:34:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040214-0017-0000-0000-000042ABABA9
Message-Id: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-02_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020099
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently, our mm_context_t on book3s64 include all hash specific
context details like slice mask, subpage protection details. We
can skip allocating those on radix. This will help us to save
8K per mm_context with radix translation.

With the patch applied we have

sizeof(mm_context_t)  = 136
sizeof(struct hash_mm_context)  = 8288

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
NOTE:

If we want to do this, I am still trying to figure out how best we can do this
without all the #ifdef and other overhead for 8xx book3e


 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      | 48 +++++++++++--------
 arch/powerpc/include/asm/book3s/64/slice.h    |  6 +--
 arch/powerpc/kernel/paca.c                    |  9 ++--
 arch/powerpc/kernel/setup-common.c            |  7 ++-
 arch/powerpc/mm/hash_utils_64.c               | 10 ++--
 arch/powerpc/mm/mmu_context_book3s64.c        | 16 ++++++-
 arch/powerpc/mm/slb.c                         |  2 +-
 arch/powerpc/mm/slice.c                       | 48 +++++++++----------
 arch/powerpc/mm/subpage-prot.c                |  8 ++--
 10 files changed, 91 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index a28a28079edb..d801be977623 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -657,7 +657,7 @@ extern void slb_set_size(u16 size);
 
 /* 4 bits per slice and we have one slice per 1TB */
 #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
-#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
+#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.hash_context->slb_addr_limit >> 41)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index a809bdd77322..07e76e304a3b 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -114,6 +114,33 @@ struct slice_mask {
 	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
 };
 
+struct hash_mm_context {
+
+	u16 user_psize; /* page size index */
+
+#ifdef CONFIG_PPC_MM_SLICES
+	/* SLB page size encodings*/
+	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
+	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
+	unsigned long slb_addr_limit;
+#ifdef CONFIG_PPC_64K_PAGES
+	struct slice_mask mask_64k;
+#endif
+	struct slice_mask mask_4k;
+#ifdef CONFIG_HUGETLB_PAGE
+	struct slice_mask mask_16m;
+	struct slice_mask mask_16g;
+#endif
+#else
+	u16 sllp; /* SLB page size encoding */
+#endif
+
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+	struct subpage_prot_table spt;
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
+
+};
+
 typedef struct {
 	union {
 		/*
@@ -127,7 +154,6 @@ typedef struct {
 		mm_context_id_t id;
 		mm_context_id_t extended_id[TASK_SIZE_USER64/TASK_CONTEXT_SIZE];
 	};
-	u16 user_psize;		/* page size index */
 
 	/* Number of bits in the mm_cpumask */
 	atomic_t active_cpus;
@@ -137,27 +163,9 @@ typedef struct {
 
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
+	struct hash_mm_context *hash_context;
 
-#ifdef CONFIG_PPC_MM_SLICES
-	 /* SLB page size encodings*/
-	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
-	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
-	unsigned long slb_addr_limit;
-# ifdef CONFIG_PPC_64K_PAGES
-	struct slice_mask mask_64k;
-# endif
-	struct slice_mask mask_4k;
-# ifdef CONFIG_HUGETLB_PAGE
-	struct slice_mask mask_16m;
-	struct slice_mask mask_16g;
-# endif
-#else
-	u16 sllp;		/* SLB page size encoding */
-#endif
 	unsigned long vdso_base;
-#ifdef CONFIG_PPC_SUBPAGE_PROT
-	struct subpage_prot_table spt;
-#endif /* CONFIG_PPC_SUBPAGE_PROT */
 	/*
 	 * pagetable fragment support
 	 */
diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index db0dedab65ee..3ca1bebe258e 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -15,11 +15,11 @@
 
 #else /* CONFIG_PPC_MM_SLICES */
 
-#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
+#define get_slice_psize(mm, addr)	((mm)->context.hash_context->user_psize)
 #define slice_set_user_psize(mm, psize)		\
 do {						\
-	(mm)->context.user_psize = (psize);	\
-	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
+	(mm)->context.hash_context->user_psize = (psize);	\
+	(mm)->context.hash_context->sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
 } while (0)
 
 #endif /* CONFIG_PPC_MM_SLICES */
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index e7382abee868..9f1e5d08fa74 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -267,12 +267,13 @@ void copy_mm_to_paca(struct mm_struct *mm)
 
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
-	VM_BUG_ON(!mm->context.slb_addr_limit);
-	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
+	VM_BUG_ON(!mm->context.hash_context->slb_addr_limit);
+	get_paca()->mm_ctx_slb_addr_limit = mm->context.hash_context->slb_addr_limit;
 	memcpy(&get_paca()->mm_ctx_low_slices_psize,
-	       &context->low_slices_psize, sizeof(context->low_slices_psize));
+	       &context->hash_context->low_slices_psize,
+	       sizeof(context->hash_context->low_slices_psize));
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
+	       &context->hash_context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
 #else /* CONFIG_PPC_MM_SLICES */
 	get_paca()->mm_ctx_user_psize = context->user_psize;
 	get_paca()->mm_ctx_sllp = context->sllp;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2e5dfb6e0823..40290d3d95b0 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -862,6 +862,7 @@ static void smp_setup_pacas(void)
 }
 #endif
 
+struct hash_mm_context init_hash_mm_context;
 /*
  * Called into from start_kernel this initializes memblock, which is used
  * to manage page allocation until mem_init is called.
@@ -949,8 +950,10 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #ifdef CONFIG_PPC64
-	if (!radix_enabled())
-		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	if (!radix_enabled()) {
+		init_mm.context.hash_context = &init_hash_mm_context;
+		init_mm.context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	}
 #elif defined(CONFIG_PPC_8xx)
 	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
 #else
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0a4f939a8161..df035c3ebb4b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1147,7 +1147,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  */
 static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
 	u32 spp = 0;
 	u32 **sbpm, *sbpp;
 
@@ -1470,7 +1470,7 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 	int psize = get_slice_psize(mm, ea);
 
 	/* We only prefault standard pages for now */
-	if (unlikely(psize != mm->context.user_psize))
+	if (unlikely(psize != mm->context.hash_context->user_psize))
 		return false;
 
 	/*
@@ -1549,7 +1549,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 	/* Hash it in */
 #ifdef CONFIG_PPC_64K_PAGES
-	if (mm->context.user_psize == MMU_PAGE_64K)
+	if (mm->context.hash_context->user_psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
 				     update_flags, ssize);
 	else
@@ -1562,8 +1562,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 */
 	if (rc == -1)
 		hash_failure_debug(ea, access, vsid, trap, ssize,
-				   mm->context.user_psize,
-				   mm->context.user_psize,
+				   mm->context.hash_context->user_psize,
+				   mm->context.hash_context->user_psize,
 				   pte_val(*ptep));
 out_exit:
 	local_irq_restore(flags);
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index f720c5cc0b5e..6eef5a36b2e9 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -63,6 +63,12 @@ static int hash__init_new_context(struct mm_struct *mm)
 	if (index < 0)
 		return index;
 
+	mm->context.hash_context = kmalloc(sizeof(struct hash_mm_context), GFP_KERNEL);
+	if (!mm->context.hash_context) {
+		ida_free(&mmu_context_ida, index);
+		return -ENOMEM;
+	}
+
 	/*
 	 * The old code would re-promote on fork, we don't do that when using
 	 * slices as it could cause problem promoting slices that have been
@@ -77,8 +83,14 @@ static int hash__init_new_context(struct mm_struct *mm)
 	 * We should not be calling init_new_context() on init_mm. Hence a
 	 * check against 0 is OK.
 	 */
-	if (mm->context.id == 0)
+	if (mm->context.id == 0) {
+		memset(mm->context.hash_context, 0, sizeof(struct hash_mm_context));
 		slice_init_new_context_exec(mm);
+	} else {
+		/* This is fork. Copy hash_context details from current->mm */
+		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
+
+	}
 
 	subpage_prot_init_new_context(mm);
 
@@ -118,6 +130,7 @@ static int radix__init_new_context(struct mm_struct *mm)
 	asm volatile("ptesync;isync" : : : "memory");
 
 	mm->context.npu_context = NULL;
+	mm->context.hash_context = NULL;
 
 	return index;
 }
@@ -162,6 +175,7 @@ static void destroy_contexts(mm_context_t *ctx)
 		if (context_id)
 			ida_free(&mmu_context_ida, context_id);
 	}
+	kfree(ctx->hash_context);
 }
 
 static void pmd_frag_destroy(void *pmd_frag)
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5986df48359b..2b128939e2e7 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -739,7 +739,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 	 * consider this as bad access if we take a SLB miss
 	 * on an address above addr limit.
 	 */
-	if (ea >= mm->context.slb_addr_limit)
+	if (ea >= mm->context.hash_context->slb_addr_limit)
 		return -EFAULT;
 
 	context = get_user_context(&mm->context, ea);
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index aec91dbcdc0b..84b200429464 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -101,7 +101,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
 {
 	struct vm_area_struct *vma;
 
-	if ((mm->context.slb_addr_limit - len) < addr)
+	if ((mm->context.hash_context->slb_addr_limit - len) < addr)
 		return 0;
 	vma = find_vma(mm, addr);
 	return (!vma || (addr + len) <= vm_start_gap(vma));
@@ -155,15 +155,15 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
 {
 #ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
-		return &mm->context.mask_64k;
+		return &mm->context.hash_context->mask_64k;
 #endif
 	if (psize == MMU_PAGE_4K)
-		return &mm->context.mask_4k;
+		return &mm->context.hash_context->mask_4k;
 #ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_16M)
-		return &mm->context.mask_16m;
+		return &mm->context.hash_context->mask_16m;
 	if (psize == MMU_PAGE_16G)
-		return &mm->context.mask_16g;
+		return &mm->context.hash_context->mask_16g;
 #endif
 	BUG();
 }
@@ -253,7 +253,7 @@ static void slice_convert(struct mm_struct *mm,
 	 */
 	spin_lock_irqsave(&slice_convert_lock, flags);
 
-	lpsizes = mm->context.low_slices_psize;
+	lpsizes = mm->context.hash_context->low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++) {
 		if (!(mask->low_slices & (1u << i)))
 			continue;
@@ -272,8 +272,8 @@ static void slice_convert(struct mm_struct *mm,
 				(((unsigned long)psize) << (mask_index * 4));
 	}
 
-	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
+	hpsizes = mm->context.hash_context->high_slices_psize;
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.hash_context->slb_addr_limit); i++) {
 		if (!test_bit(i, mask->high_slices))
 			continue;
 
@@ -292,8 +292,8 @@ static void slice_convert(struct mm_struct *mm,
 	}
 
 	slice_dbg(" lsps=%lx, hsps=%lx\n",
-		  (unsigned long)mm->context.low_slices_psize,
-		  (unsigned long)mm->context.high_slices_psize);
+		  (unsigned long)mm->context.hash_context->low_slices_psize,
+		  (unsigned long)mm->context.hash_context->high_slices_psize);
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
@@ -393,7 +393,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	 * DEFAULT_MAP_WINDOW we should apply this.
 	 */
 	if (high_limit > DEFAULT_MAP_WINDOW)
-		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
+		addr += mm->context.hash_context->slb_addr_limit - DEFAULT_MAP_WINDOW;
 
 	while (addr > min_addr) {
 		info.high_limit = addr;
@@ -505,20 +505,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			return -ENOMEM;
 	}
 
-	if (high_limit > mm->context.slb_addr_limit) {
+	if (high_limit > mm->context.hash_context->slb_addr_limit) {
 		/*
 		 * Increasing the slb_addr_limit does not require
 		 * slice mask cache to be recalculated because it should
 		 * be already initialised beyond the old address limit.
 		 */
-		mm->context.slb_addr_limit = high_limit;
+		mm->context.hash_context->slb_addr_limit = high_limit;
 
 		on_each_cpu(slice_flush_segments, mm, 1);
 	}
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
-	BUG_ON(mm->context.slb_addr_limit == 0);
+	BUG_ON(mm->context.hash_context->slb_addr_limit == 0);
 	VM_BUG_ON(radix_enabled());
 
 	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
@@ -696,7 +696,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long flags)
 {
 	return slice_get_unmapped_area(addr, len, flags,
-				       current->mm->context.user_psize, 0);
+				       current->mm->context.hash_context->user_psize, 0);
 }
 
 unsigned long arch_get_unmapped_area_topdown(struct file *filp,
@@ -706,7 +706,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long flags)
 {
 	return slice_get_unmapped_area(addr0, len, flags,
-				       current->mm->context.user_psize, 1);
+				       current->mm->context.hash_context->user_psize, 1);
 }
 
 unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
@@ -717,10 +717,10 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 	VM_BUG_ON(radix_enabled());
 
 	if (slice_addr_is_low(addr)) {
-		psizes = mm->context.low_slices_psize;
+		psizes = mm->context.hash_context->low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {
-		psizes = mm->context.high_slices_psize;
+		psizes = mm->context.hash_context->high_slices_psize;
 		index = GET_HIGH_SLICE_INDEX(addr);
 	}
 	mask_index = index & 0x1;
@@ -742,20 +742,20 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	 * duplicated.
 	 */
 #ifdef CONFIG_PPC64
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	mm->context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
 #else
 	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
 #endif
 
-	mm->context.user_psize = psize;
+	mm->context.hash_context->user_psize = psize;
 
 	/*
 	 * Set all slice psizes to the default.
 	 */
-	lpsizes = mm->context.low_slices_psize;
+	lpsizes = mm->context.hash_context->low_slices_psize;
 	memset(lpsizes, (psize << 4) | psize, SLICE_NUM_LOW >> 1);
 
-	hpsizes = mm->context.high_slices_psize;
+	hpsizes = mm->context.hash_context->high_slices_psize;
 	memset(hpsizes, (psize << 4) | psize, SLICE_NUM_HIGH >> 1);
 
 	/*
@@ -777,7 +777,7 @@ void slice_setup_new_exec(void)
 	if (!is_32bit_task())
 		return;
 
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
+	mm->context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW;
 }
 #endif
 
@@ -816,7 +816,7 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len)
 {
 	const struct slice_mask *maskp;
-	unsigned int psize = mm->context.user_psize;
+	unsigned int psize = mm->context.hash_context->user_psize;
 
 	VM_BUG_ON(radix_enabled());
 
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 5e4178790dee..3a13cbcb6f97 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -25,7 +25,7 @@
  */
 void subpage_prot_free(struct mm_struct *mm)
 {
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
 	unsigned long i, j, addr;
 	u32 **p;
 
@@ -52,7 +52,7 @@ void subpage_prot_free(struct mm_struct *mm)
 
 void subpage_prot_init_new_context(struct mm_struct *mm)
 {
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
 
 	memset(spt, 0, sizeof(*spt));
 }
@@ -93,7 +93,7 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 static void subpage_prot_clear(unsigned long addr, unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
 	u32 **spm, *spp;
 	unsigned long i;
 	size_t nw;
@@ -189,7 +189,7 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 		unsigned long, len, u32 __user *, map)
 {
 	struct mm_struct *mm = current->mm;
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
 	u32 **spm, *spp;
 	unsigned long i;
 	size_t nw;
-- 
2.20.1

