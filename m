Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B18C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:32:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0F521473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0F521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dBDY597LzDqDc
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 23:32:29 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d9yB12RZzDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 23:20:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x38DHf7G134845
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 09:19:59 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rr6sf93u7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 09:19:58 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 8 Apr 2019 14:19:57 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Apr 2019 14:19:53 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x38DJpX612124194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Apr 2019 13:19:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7773112067;
 Mon,  8 Apr 2019 13:19:51 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE58D112065;
 Mon,  8 Apr 2019 13:19:49 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.54.201])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  8 Apr 2019 13:19:49 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/3] powerpc/mm: Reduce memory usage for mm_context_t for
 radix
Date: Mon,  8 Apr 2019 18:49:34 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408131934.27959-1-aneesh.kumar@linux.ibm.com>
References: <20190408131934.27959-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040813-0060-0000-0000-00000329FBD4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010889; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186116; UDB=6.00621190; IPR=6.00966873; 
 MB=3.00026343; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 13:19:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040813-0061-0000-0000-000048E04BF9
Message-Id: <20190408131934.27959-4-aneesh.kumar@linux.ibm.com>
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

Currently, our mm_context_t on book3s64 include all hash specific
context details like slice mask and subpage protection details. We
can skip allocating these with radix translation. This will help us to save
8K per mm_context with radix translation.

With the patch applied we have

sizeof(mm_context_t)  = 136
sizeof(struct hash_mm_context)  = 8288

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 33 ++++++++++++-
 arch/powerpc/include/asm/book3s/64/mmu.h      | 49 +++++--------------
 arch/powerpc/kernel/setup-common.c            |  6 +++
 arch/powerpc/mm/hash_utils_64.c               |  4 +-
 arch/powerpc/mm/mmu_context_book3s64.c        | 16 +++++-
 5 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index eb36fbfe4ef5..4481bedbb5be 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -658,7 +658,7 @@ extern void slb_set_size(u16 size);
 /* 4 bits per slice and we have one slice per 1TB */
 #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
 #define LOW_SLICE_ARRAY_SZ	(BITS_PER_LONG / BITS_PER_BYTE)
-#define TASK_SLICE_ARRAY_SZ(x)	((x)->slb_addr_limit >> 41)
+#define TASK_SLICE_ARRAY_SZ(x)	((x)->hash_context->slb_addr_limit >> 41)
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_PPC_SUBPAGE_PROT
@@ -693,6 +693,37 @@ static inline void subpage_prot_free(struct mm_struct *mm) {}
 static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
 
+/*
+ * One bit per slice. We have lower slices which cover 256MB segments
+ * upto 4G range. That gets us 16 low slices. For the rest we track slices
+ * in 1TB size.
+ */
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
+};
+
+struct hash_mm_context {
+	u16 user_psize; /* page size index */
+
+	/* SLB page size encodings*/
+	unsigned char low_slices_psize[LOW_SLICE_ARRAY_SZ];
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
+
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+	struct subpage_prot_table spt;
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
+};
+
 #if 0
 /*
  * The code below is equivalent to this function for arguments
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index c9f317090620..e510e46b07ce 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -104,16 +104,6 @@ struct spinlock;
 /* Maximum possible number of NPUs in a system. */
 #define NV_MAX_NPUS 8
 
-/*
- * One bit per slice. We have lower slices which cover 256MB segments
- * upto 4G range. That gets us 16 low slices. For the rest we track slices
- * in 1TB size.
- */
-struct slice_mask {
-	u64 low_slices;
-	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
-};
-
 typedef struct {
 	union {
 		/*
@@ -127,7 +117,6 @@ typedef struct {
 		mm_context_id_t id;
 		mm_context_id_t extended_id[TASK_SIZE_USER64/TASK_CONTEXT_SIZE];
 	};
-	u16 user_psize;		/* page size index */
 
 	/* Number of bits in the mm_cpumask */
 	atomic_t active_cpus;
@@ -137,23 +126,9 @@ typedef struct {
 
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
+	struct hash_mm_context *hash_context;
 
-	 /* SLB page size encodings*/
-	unsigned char low_slices_psize[LOW_SLICE_ARRAY_SZ];
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
 	unsigned long vdso_base;
-#ifdef CONFIG_PPC_SUBPAGE_PROT
-	struct subpage_prot_table spt;
-#endif /* CONFIG_PPC_SUBPAGE_PROT */
 	/*
 	 * pagetable fragment support
 	 */
@@ -176,62 +151,62 @@ typedef struct {
 
 static inline u16 mm_ctx_user_psize(mm_context_t *ctx)
 {
-	return ctx->user_psize;
+	return ctx->hash_context->user_psize;
 }
 
 static inline void mm_ctx_set_user_psize(mm_context_t *ctx, u16 user_psize)
 {
-	ctx->user_psize = user_psize;
+	ctx->hash_context->user_psize = user_psize;
 }
 
 static inline unsigned char *mm_ctx_low_slices(mm_context_t *ctx)
 {
-	return ctx->low_slices_psize;
+	return ctx->hash_context->low_slices_psize;
 }
 
 static inline unsigned char *mm_ctx_high_slices(mm_context_t *ctx)
 {
-	return ctx->high_slices_psize;
+	return ctx->hash_context->high_slices_psize;
 }
 
 static inline unsigned long mm_ctx_slb_addr_limit(mm_context_t *ctx)
 {
-	return ctx->slb_addr_limit;
+	return ctx->hash_context->slb_addr_limit;
 }
 
 static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long limit)
 {
-	ctx->slb_addr_limit = limit;
+	ctx->hash_context->slb_addr_limit = limit;
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
 static inline struct slice_mask *mm_ctx_slice_mask_64k(mm_context_t *ctx)
 {
-	return &ctx->mask_64k;
+	return &ctx->hash_context->mask_64k;
 }
 #endif
 
 static inline struct slice_mask *mm_ctx_slice_mask_4k(mm_context_t *ctx)
 {
-	return &ctx->mask_4k;
+	return &ctx->hash_context->mask_4k;
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
 static inline struct slice_mask *mm_ctx_slice_mask_16m(mm_context_t *ctx)
 {
-	return &ctx->mask_16m;
+	return &ctx->hash_context->mask_16m;
 }
 
 static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
 {
-	return &ctx->mask_16g;
+	return &ctx->hash_context->mask_16g;
 }
 #endif
 
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
 {
-	return &ctx->spt;
+	return &ctx->hash_context->spt;
 }
 #endif
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index a07de8608484..21b1ce200b22 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -947,6 +947,12 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
 
+#ifdef CONFIG_PPC_MM_SLICES
+#if defined(CONFIG_PPC_8xx)
+	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
+#endif
+#endif
+
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(&init_mm);
 #endif
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2cb3a456f5b5..04ac7c36d380 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -968,6 +968,7 @@ void __init hash__early_init_devtree(void)
 	htab_scan_page_sizes();
 }
 
+struct hash_mm_context init_hash_mm_context;
 void __init hash__early_init_mmu(void)
 {
 #ifndef CONFIG_PPC_64K_PAGES
@@ -1041,7 +1042,8 @@ void __init hash__early_init_mmu(void)
 	 */
 	htab_initialize();
 
-	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	init_mm.context.hash_context = &init_hash_mm_context;
+	init_mm.context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
 
 	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
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
-- 
2.20.1

