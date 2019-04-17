Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F0C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:41:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C1C204EC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C1C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kk0c432NzDqNg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:41:20 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kjB454bgzDq6K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:04:28 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCjFA7064126
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:04:26 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx3j8kbc7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:04:25 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 14:04:25 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 14:04:21 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HD4KPI27721892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 13:04:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92499C6066;
 Wed, 17 Apr 2019 13:04:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 600C2C6055;
 Wed, 17 Apr 2019 13:04:18 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 13:04:18 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 6/6] powerc/mm/hash: Reduce hash_mm_context size
Date: Wed, 17 Apr 2019 18:33:51 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
References: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041713-0004-0000-0000-000014FE9B7A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190371; UDB=6.00623771; IPR=6.00971169; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 13:04:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041713-0005-0000-0000-00008B4B1046
Message-Id: <20190417130351.3805-7-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=969 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170089
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

Allocate subpage protect related variables only if we use the feature.
This helps in reducing the hash related mm context struct by around 4K

Before the patch
sizeof(struct hash_mm_context)  = 8288

After the patch
sizeof(struct hash_mm_context) = 4160

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 +--
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +-
 arch/powerpc/mm/hash_utils_64.c               |  3 ++
 arch/powerpc/mm/mmu_context_book3s64.c        | 17 +++++++++--
 arch/powerpc/mm/subpage-prot.c                | 28 ++++++++++++++-----
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 4481bedbb5be..eeb40091b46b 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -687,10 +687,8 @@ struct subpage_prot_table {
 #define SBP_L3_SHIFT		(SBP_L2_SHIFT + SBP_L2_BITS)
 
 extern void subpage_prot_free(struct mm_struct *mm);
-extern void subpage_prot_init_new_context(struct mm_struct *mm);
 #else
 static inline void subpage_prot_free(struct mm_struct *mm) {}
-static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
 
 /*
@@ -720,7 +718,7 @@ struct hash_mm_context {
 #endif
 
 #ifdef CONFIG_PPC_SUBPAGE_PROT
-	struct subpage_prot_table spt;
+	struct subpage_prot_table *spt;
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
 };
 
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 3bc94baf5ed5..62ae73df93d2 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -191,7 +191,7 @@ static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
 {
-	return &ctx->hash_context->spt;
+	return ctx->hash_context->spt;
 }
 #endif
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 04ac7c36d380..33bd4a1b4d75 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1155,6 +1155,9 @@ static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 	u32 spp = 0;
 	u32 **sbpm, *sbpp;
 
+	if (!spt)
+		return 0;
+
 	if (ea >= spt->maxaddr)
 		return 0;
 	if (ea < 0x100000000UL) {
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 6eef5a36b2e9..cb2b08635508 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -63,7 +63,8 @@ static int hash__init_new_context(struct mm_struct *mm)
 	if (index < 0)
 		return index;
 
-	mm->context.hash_context = kmalloc(sizeof(struct hash_mm_context), GFP_KERNEL);
+	mm->context.hash_context = kmalloc(sizeof(struct hash_mm_context),
+					   GFP_KERNEL);
 	if (!mm->context.hash_context) {
 		ida_free(&mmu_context_ida, index);
 		return -ENOMEM;
@@ -89,11 +90,21 @@ static int hash__init_new_context(struct mm_struct *mm)
 	} else {
 		/* This is fork. Copy hash_context details from current->mm */
 		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+		/* inherit subpage prot detalis if we have one. */
+		if (current->mm->context.hash_context->spt) {
+			mm->context.hash_context->spt = kmalloc(sizeof(struct subpage_prot_table),
+								GFP_KERNEL);
+			if (!mm->context.hash_context->spt) {
+				ida_free(&mmu_context_ida, index);
+				kfree(mm->context.hash_context);
+				return -ENOMEM;
+			}
+		}
+#endif
 
 	}
 
-	subpage_prot_init_new_context(mm);
-
 	pkey_mm_init(mm);
 	return index;
 }
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index c72252542210..c9dff4e1f295 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -29,6 +29,9 @@ void subpage_prot_free(struct mm_struct *mm)
 	unsigned long i, j, addr;
 	u32 **p;
 
+	if (!spt)
+		return;
+
 	for (i = 0; i < 4; ++i) {
 		if (spt->low_prot[i]) {
 			free_page((unsigned long)spt->low_prot[i]);
@@ -48,13 +51,7 @@ void subpage_prot_free(struct mm_struct *mm)
 		free_page((unsigned long)p);
 	}
 	spt->maxaddr = 0;
-}
-
-void subpage_prot_init_new_context(struct mm_struct *mm)
-{
-	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
-
-	memset(spt, 0, sizeof(*spt));
+	kfree(spt);
 }
 
 static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
@@ -99,6 +96,9 @@ static void subpage_prot_clear(unsigned long addr, unsigned long len)
 	size_t nw;
 	unsigned long next, limit;
 
+	if (!spt)
+		return ;
+
 	down_write(&mm->mmap_sem);
 	limit = addr + len;
 	if (limit > spt->maxaddr)
@@ -218,6 +218,20 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 		return -EFAULT;
 
 	down_write(&mm->mmap_sem);
+
+	if (!spt) {
+		/*
+		 * Allocate subpage prot table if not already done.
+		 * Do this with mmap_sem held
+		 */
+		spt = kzalloc(sizeof(struct subpage_prot_table), GFP_KERNEL);
+		if (!spt) {
+			err = -ENOMEM;
+			goto out;
+		}
+		mm->context.hash_context->spt = spt;
+	}
+
 	subpage_mark_vma_nohuge(mm, addr, len);
 	for (limit = addr + len; addr < limit; addr = next) {
 		next = pmd_addr_end(addr, limit);
-- 
2.20.1

