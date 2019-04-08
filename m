Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADDC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:24:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDAC2147A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDAC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dB3Z3pcczDqLv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 23:24:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d9y05yFgzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 23:19:52 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x38DIncq174023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 09:19:50 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rr6nr9mbe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 09:19:49 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 8 Apr 2019 14:19:49 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Apr 2019 14:19:45 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x38DJiq324510536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Apr 2019 13:19:44 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AF78112066;
 Mon,  8 Apr 2019 13:19:44 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 479EF112062;
 Mon,  8 Apr 2019 13:19:42 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.54.201])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  8 Apr 2019 13:19:41 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/3] powerpc/mm: Add helpers for accessing hash translation
 related variables
Date: Mon,  8 Apr 2019 18:49:32 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408131934.27959-1-aneesh.kumar@linux.ibm.com>
References: <20190408131934.27959-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040813-0060-0000-0000-00000329FBD3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010889; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186116; UDB=6.00621190; IPR=6.00966873; 
 MB=3.00026343; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 13:19:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040813-0061-0000-0000-000048E04BE5
Message-Id: <20190408131934.27959-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-08_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080111
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

We want to switch to allocating them runtime only when hash translation is
enabled. Add helpers so that both book3s and nohash can be adapted to
upcoming change easily.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      | 63 ++++++++++++++++++-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  | 50 +++++++++++++++
 arch/powerpc/kernel/paca.c                    | 12 ++--
 arch/powerpc/mm/hash_utils_64.c               | 10 +--
 arch/powerpc/mm/slb.c                         |  2 +-
 arch/powerpc/mm/slice.c                       | 49 +++++++--------
 arch/powerpc/mm/subpage-prot.c                |  8 +--
 8 files changed, 154 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index a28a28079edb..eb36fbfe4ef5 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -657,8 +657,8 @@ extern void slb_set_size(u16 size);
 
 /* 4 bits per slice and we have one slice per 1TB */
 #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
-#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
-
+#define LOW_SLICE_ARRAY_SZ	(BITS_PER_LONG / BITS_PER_BYTE)
+#define TASK_SLICE_ARRAY_SZ(x)	((x)->slb_addr_limit >> 41)
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_PPC_SUBPAGE_PROT
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index afe10dd11c68..c9f317090620 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -139,7 +139,7 @@ typedef struct {
 	struct npu_context *npu_context;
 
 	 /* SLB page size encodings*/
-	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
+	unsigned char low_slices_psize[LOW_SLICE_ARRAY_SZ];
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned long slb_addr_limit;
 # ifdef CONFIG_PPC_64K_PAGES
@@ -174,6 +174,67 @@ typedef struct {
 #endif
 } mm_context_t;
 
+static inline u16 mm_ctx_user_psize(mm_context_t *ctx)
+{
+	return ctx->user_psize;
+}
+
+static inline void mm_ctx_set_user_psize(mm_context_t *ctx, u16 user_psize)
+{
+	ctx->user_psize = user_psize;
+}
+
+static inline unsigned char *mm_ctx_low_slices(mm_context_t *ctx)
+{
+	return ctx->low_slices_psize;
+}
+
+static inline unsigned char *mm_ctx_high_slices(mm_context_t *ctx)
+{
+	return ctx->high_slices_psize;
+}
+
+static inline unsigned long mm_ctx_slb_addr_limit(mm_context_t *ctx)
+{
+	return ctx->slb_addr_limit;
+}
+
+static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long limit)
+{
+	ctx->slb_addr_limit = limit;
+}
+
+#ifdef CONFIG_PPC_64K_PAGES
+static inline struct slice_mask *mm_ctx_slice_mask_64k(mm_context_t *ctx)
+{
+	return &ctx->mask_64k;
+}
+#endif
+
+static inline struct slice_mask *mm_ctx_slice_mask_4k(mm_context_t *ctx)
+{
+	return &ctx->mask_4k;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static inline struct slice_mask *mm_ctx_slice_mask_16m(mm_context_t *ctx)
+{
+	return &ctx->mask_16m;
+}
+
+static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
+{
+	return &ctx->mask_16g;
+}
+#endif
+
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
+{
+	return &ctx->spt;
+}
+#endif
+
 /*
  * The current system page and segment sizes
  */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 0a1a3fc54e54..0f4b0b50e5ad 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -167,6 +167,7 @@
 #ifdef CONFIG_PPC_MM_SLICES
 #include <asm/nohash/32/slice.h>
 #define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
+#define LOW_SLICE_ARRAY_SZ	SLICE_ARRAY_SIZE
 #endif
 
 #ifndef __ASSEMBLY__
@@ -193,6 +194,55 @@ typedef struct {
 	void *pte_frag;
 } mm_context_t;
 
+#ifdef CONFIG_PPC_MM_SLICES
+static inline u16 mm_ctx_user_psize(mm_context_t *ctx)
+{
+	return ctx->user_psize;
+}
+
+static inline void mm_ctx_set_user_psize(mm_context_t *ctx, u16 user_psize)
+{
+	ctx->user_psize = user_psize;
+}
+
+static inline unsigned char *mm_ctx_low_slices(mm_context_t *ctx)
+{
+	return ctx->low_slices_psize;
+}
+
+static inline unsigned char *mm_ctx_high_slices(mm_context_t *ctx)
+{
+	return ctx->high_slices_psize;
+}
+
+static inline unsigned long mm_ctx_slb_addr_limit(mm_context_t *ctx)
+{
+	return ctx->slb_addr_limit;
+}
+
+static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long limit)
+{
+	ctx->slb_addr_limit = limit;
+}
+
+static inline struct slice_mask *mm_ctx_slice_mask_base(mm_context_t *ctx)
+{
+	return &ctx->mask_base_psize;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static inline struct slice_mask *mm_ctx_slice_mask_512k(mm_context_t *ctx)
+{
+	return &ctx->mask_512k;
+}
+
+static inline struct slice_mask *mm_ctx_slice_mask_8m(mm_context_t *ctx)
+{
+	return &ctx->mask_8m;
+}
+#endif
+#endif /* CONFIG_PPC_MM_SLICE */
+
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
 #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
 
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index e7382abee868..9cc91d03ab62 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -267,12 +267,12 @@ void copy_mm_to_paca(struct mm_struct *mm)
 
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
-	VM_BUG_ON(!mm->context.slb_addr_limit);
-	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
-	memcpy(&get_paca()->mm_ctx_low_slices_psize,
-	       &context->low_slices_psize, sizeof(context->low_slices_psize));
-	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
+	VM_BUG_ON(!mm_ctx_slb_addr_limit(context));
+	get_paca()->mm_ctx_slb_addr_limit = mm_ctx_slb_addr_limit(context);
+	memcpy(&get_paca()->mm_ctx_low_slices_psize, mm_ctx_low_slices(context),
+	       LOW_SLICE_ARRAY_SZ);
+	memcpy(&get_paca()->mm_ctx_high_slices_psize, mm_ctx_high_slices(context),
+	       TASK_SLICE_ARRAY_SZ(context));
 #else /* CONFIG_PPC_MM_SLICES */
 	get_paca()->mm_ctx_user_psize = context->user_psize;
 	get_paca()->mm_ctx_sllp = context->sllp;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0a4f939a8161..5a2bd132f92e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1147,7 +1147,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  */
 static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
 	u32 spp = 0;
 	u32 **sbpm, *sbpp;
 
@@ -1470,7 +1470,7 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 	int psize = get_slice_psize(mm, ea);
 
 	/* We only prefault standard pages for now */
-	if (unlikely(psize != mm->context.user_psize))
+	if (unlikely(psize != mm_ctx_user_psize(&mm->context)))
 		return false;
 
 	/*
@@ -1549,7 +1549,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 	/* Hash it in */
 #ifdef CONFIG_PPC_64K_PAGES
-	if (mm->context.user_psize == MMU_PAGE_64K)
+	if (mm_ctx_user_psize(&mm->context) == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
 				     update_flags, ssize);
 	else
@@ -1562,8 +1562,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 */
 	if (rc == -1)
 		hash_failure_debug(ea, access, vsid, trap, ssize,
-				   mm->context.user_psize,
-				   mm->context.user_psize,
+				   mm_ctx_user_psize(&mm->context),
+				   mm_ctx_user_psize(&mm->context),
 				   pte_val(*ptep));
 out_exit:
 	local_irq_restore(flags);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5986df48359b..78c0c0a0e355 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -739,7 +739,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 	 * consider this as bad access if we take a SLB miss
 	 * on an address above addr limit.
 	 */
-	if (ea >= mm->context.slb_addr_limit)
+	if (ea >= mm_ctx_slb_addr_limit(&mm->context))
 		return -EFAULT;
 
 	context = get_user_context(&mm->context, ea);
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index aec91dbcdc0b..35b278082391 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -101,7 +101,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
 {
 	struct vm_area_struct *vma;
 
-	if ((mm->context.slb_addr_limit - len) < addr)
+	if ((mm_ctx_slb_addr_limit(&mm->context) - len) < addr)
 		return 0;
 	vma = find_vma(mm, addr);
 	return (!vma || (addr + len) <= vm_start_gap(vma));
@@ -155,15 +155,15 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
 {
 #ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
-		return &mm->context.mask_64k;
+		return mm_ctx_slice_mask_64k(&mm->context);
 #endif
 	if (psize == MMU_PAGE_4K)
-		return &mm->context.mask_4k;
+		return mm_ctx_slice_mask_4k(&mm->context);
 #ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_16M)
-		return &mm->context.mask_16m;
+		return mm_ctx_slice_mask_16m(&mm->context);
 	if (psize == MMU_PAGE_16G)
-		return &mm->context.mask_16g;
+		return mm_ctx_slice_mask_16g(&mm->context);
 #endif
 	BUG();
 }
@@ -253,7 +253,7 @@ static void slice_convert(struct mm_struct *mm,
 	 */
 	spin_lock_irqsave(&slice_convert_lock, flags);
 
-	lpsizes = mm->context.low_slices_psize;
+	lpsizes = mm_ctx_low_slices(&mm->context);
 	for (i = 0; i < SLICE_NUM_LOW; i++) {
 		if (!(mask->low_slices & (1u << i)))
 			continue;
@@ -272,8 +272,8 @@ static void slice_convert(struct mm_struct *mm,
 				(((unsigned long)psize) << (mask_index * 4));
 	}
 
-	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
+	hpsizes = mm_ctx_high_slices(&mm->context);
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm_ctx_slb_addr_limit(&mm->context)); i++) {
 		if (!test_bit(i, mask->high_slices))
 			continue;
 
@@ -292,8 +292,8 @@ static void slice_convert(struct mm_struct *mm,
 	}
 
 	slice_dbg(" lsps=%lx, hsps=%lx\n",
-		  (unsigned long)mm->context.low_slices_psize,
-		  (unsigned long)mm->context.high_slices_psize);
+		  (unsigned long)mm_ctx_low_slices(&mm->context),
+		  (unsigned long)mm_ctx_high_slices(&mm->context));
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
@@ -393,7 +393,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	 * DEFAULT_MAP_WINDOW we should apply this.
 	 */
 	if (high_limit > DEFAULT_MAP_WINDOW)
-		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
+		addr += mm_ctx_slb_addr_limit(&mm->context) - DEFAULT_MAP_WINDOW;
 
 	while (addr > min_addr) {
 		info.high_limit = addr;
@@ -505,20 +505,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			return -ENOMEM;
 	}
 
-	if (high_limit > mm->context.slb_addr_limit) {
+	if (high_limit > mm_ctx_slb_addr_limit(&mm->context)) {
 		/*
 		 * Increasing the slb_addr_limit does not require
 		 * slice mask cache to be recalculated because it should
 		 * be already initialised beyond the old address limit.
 		 */
-		mm->context.slb_addr_limit = high_limit;
+		mm_ctx_set_slb_addr_limit(&mm->context, high_limit);
 
 		on_each_cpu(slice_flush_segments, mm, 1);
 	}
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
-	BUG_ON(mm->context.slb_addr_limit == 0);
+	BUG_ON(mm_ctx_slb_addr_limit(&mm->context) == 0);
 	VM_BUG_ON(radix_enabled());
 
 	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
@@ -696,7 +696,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long flags)
 {
 	return slice_get_unmapped_area(addr, len, flags,
-				       current->mm->context.user_psize, 0);
+				       mm_ctx_user_psize(&current->mm->context), 0);
 }
 
 unsigned long arch_get_unmapped_area_topdown(struct file *filp,
@@ -706,7 +706,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long flags)
 {
 	return slice_get_unmapped_area(addr0, len, flags,
-				       current->mm->context.user_psize, 1);
+				       mm_ctx_user_psize(&current->mm->context), 1);
 }
 
 unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
@@ -717,10 +717,10 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 	VM_BUG_ON(radix_enabled());
 
 	if (slice_addr_is_low(addr)) {
-		psizes = mm->context.low_slices_psize;
+		psizes = mm_ctx_low_slices(&mm->context);
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {
-		psizes = mm->context.high_slices_psize;
+		psizes = mm_ctx_high_slices(&mm->context);
 		index = GET_HIGH_SLICE_INDEX(addr);
 	}
 	mask_index = index & 0x1;
@@ -742,20 +742,19 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	 * duplicated.
 	 */
 #ifdef CONFIG_PPC64
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	mm_ctx_set_slb_addr_limit(&mm->context, DEFAULT_MAP_WINDOW_USER64);
 #else
 	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
 #endif
-
-	mm->context.user_psize = psize;
+	mm_ctx_set_user_psize(&mm->context, psize);
 
 	/*
 	 * Set all slice psizes to the default.
 	 */
-	lpsizes = mm->context.low_slices_psize;
+	lpsizes = mm_ctx_low_slices(&mm->context);
 	memset(lpsizes, (psize << 4) | psize, SLICE_NUM_LOW >> 1);
 
-	hpsizes = mm->context.high_slices_psize;
+	hpsizes = mm_ctx_high_slices(&mm->context);
 	memset(hpsizes, (psize << 4) | psize, SLICE_NUM_HIGH >> 1);
 
 	/*
@@ -777,7 +776,7 @@ void slice_setup_new_exec(void)
 	if (!is_32bit_task())
 		return;
 
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
+	mm_ctx_set_slb_addr_limit(&mm->context, DEFAULT_MAP_WINDOW);
 }
 #endif
 
@@ -816,7 +815,7 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len)
 {
 	const struct slice_mask *maskp;
-	unsigned int psize = mm->context.user_psize;
+	unsigned int psize = mm_ctx_user_psize(&mm->context);
 
 	VM_BUG_ON(radix_enabled());
 
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 5e4178790dee..c72252542210 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -25,7 +25,7 @@
  */
 void subpage_prot_free(struct mm_struct *mm)
 {
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
 	unsigned long i, j, addr;
 	u32 **p;
 
@@ -52,7 +52,7 @@ void subpage_prot_free(struct mm_struct *mm)
 
 void subpage_prot_init_new_context(struct mm_struct *mm)
 {
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
 
 	memset(spt, 0, sizeof(*spt));
 }
@@ -93,7 +93,7 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 static void subpage_prot_clear(unsigned long addr, unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
 	u32 **spm, *spp;
 	unsigned long i;
 	size_t nw;
@@ -189,7 +189,7 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 		unsigned long, len, u32 __user *, map)
 {
 	struct mm_struct *mm = current->mm;
-	struct subpage_prot_table *spt = &mm->context.spt;
+	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
 	u32 **spm, *spp;
 	unsigned long i;
 	size_t nw;
-- 
2.20.1

