Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB3C32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2152085B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2152085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vxyg6S5vzF36K
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 14:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vxrz1nsszF1QG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 14:53:23 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9B3mpcD011523
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 23:53:20 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n1xxmg3uv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 23:53:20 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 10 Oct 2018 21:53:19 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 21:53:16 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9B3rFVS38404226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 20:53:15 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D35B7805E;
 Wed, 10 Oct 2018 21:53:15 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15A317805C;
 Wed, 10 Oct 2018 21:53:13 -0600 (MDT)
Received: from skywalker.ibmuc.com (unknown [9.85.73.187])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 10 Oct 2018 21:53:12 -0600 (MDT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 1/5] mm: Update ptep_modify_prot_start/commit to take
 vm_area_struct as arg
Date: Thu, 11 Oct 2018 09:22:43 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011035247.30687-1-aneesh.kumar@linux.ibm.com>
References: <20181011035247.30687-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101103-0016-0000-0000-0000093F5F93
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009857; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100919; UDB=6.00569641; IPR=6.00880964; 
 MB=3.00023702; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-11 03:53:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101103-0017-0000-0000-000040A93298
Message-Id: <20181011035247.30687-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-11_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=824 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110036
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some architecture may want to call flush_tlb_range from these helpers.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 arch/s390/mm/pgtable.c          | 6 ++++--
 arch/x86/include/asm/paravirt.h | 7 +++++--
 fs/proc/task_mmu.c              | 4 ++--
 include/asm-generic/pgtable.h   | 8 ++++----
 mm/memory.c                     | 4 ++--
 mm/mprotect.c                   | 4 ++--
 7 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0e7cb0dc9c33..8e7f26dfedc6 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1035,8 +1035,8 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-pte_t ptep_modify_prot_start(struct mm_struct *, unsigned long, pte_t *);
-void ptep_modify_prot_commit(struct mm_struct *, unsigned long, pte_t *, pte_t);
+pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte_t *);
+void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long, pte_t *, pte_t);
 
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index f2cc7da473e4..29c0a21cd34a 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -301,12 +301,13 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(ptep_xchg_lazy);
 
-pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
+pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t *ptep)
 {
 	pgste_t pgste;
 	pte_t old;
 	int nodat;
+	struct mm_struct *mm = vma->vm_mm;
 
 	preempt_disable();
 	pgste = ptep_xchg_start(mm, addr, ptep);
@@ -320,10 +321,11 @@ pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(ptep_modify_prot_start);
 
-void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
+void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t *ptep, pte_t pte)
 {
 	pgste_t pgste;
+	struct mm_struct *mm = vma->vm_mm;
 
 	if (!MACHINE_HAS_NX)
 		pte_val(pte) &= ~_PAGE_NOEXEC;
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e375d4266b53..c5d203a51e50 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -421,10 +421,11 @@ static inline pgdval_t pgd_val(pgd_t pgd)
 }
 
 #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
+static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
 					   pte_t *ptep)
 {
 	pteval_t ret;
+	struct mm_struct *mm = vma->vm_mm;
 
 	ret = PVOP_CALL3(pteval_t, pv_mmu_ops.ptep_modify_prot_start,
 			 mm, addr, ptep);
@@ -432,9 +433,11 @@ static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long a
 	return (pte_t) { .pte = ret };
 }
 
-static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
+static inline void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 					   pte_t *ptep, pte_t pte)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	if (sizeof(pteval_t) > sizeof(long))
 		/* 5 arg words */
 		pv_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5ea1d64cb0b4..229df16e7ad0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -938,10 +938,10 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	pte_t ptent = *pte;
 
 	if (pte_present(ptent)) {
-		ptent = ptep_modify_prot_start(vma->vm_mm, addr, pte);
+		ptent = ptep_modify_prot_start(vma, addr, pte);
 		ptent = pte_wrprotect(ptent);
 		ptent = pte_clear_soft_dirty(ptent);
-		ptep_modify_prot_commit(vma->vm_mm, addr, pte, ptent);
+		ptep_modify_prot_commit(vma, addr, pte, ptent);
 	} else if (is_swap_pte(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 88ebc6102c7c..021b94cd3260 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -606,22 +606,22 @@ static inline void __ptep_modify_prot_commit(struct mm_struct *mm,
  * queue the update to be done at some later time.  The update must be
  * actually committed before the pte lock is released, however.
  */
-static inline pte_t ptep_modify_prot_start(struct mm_struct *mm,
+static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   pte_t *ptep)
 {
-	return __ptep_modify_prot_start(mm, addr, ptep);
+	return __ptep_modify_prot_start(vma->vm_mm, addr, ptep);
 }
 
 /*
  * Commit an update to a pte, leaving any hardware-controlled bits in
  * the PTE unmodified.
  */
-static inline void ptep_modify_prot_commit(struct mm_struct *mm,
+static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   pte_t *ptep, pte_t pte)
 {
-	__ptep_modify_prot_commit(mm, addr, ptep, pte);
+	__ptep_modify_prot_commit(vma->vm_mm, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
diff --git a/mm/memory.c b/mm/memory.c
index c467102a5cbc..261d30f51499 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3806,12 +3806,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Make it present again, Depending on how arch implementes non
 	 * accessible ptes, some can allow access by kernel mode.
 	 */
-	pte = ptep_modify_prot_start(vma->vm_mm, vmf->address, vmf->pte);
+	pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
 	pte = pte_modify(pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
 		pte = pte_mkwrite(pte);
-	ptep_modify_prot_commit(vma->vm_mm, vmf->address, vmf->pte, pte);
+	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 
 	page = vm_normal_page(vma, vmf->address, pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6d331620b9e5..a301d4c83d3c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -110,7 +110,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					continue;
 			}
 
-			ptent = ptep_modify_prot_start(mm, addr, pte);
+			ptent = ptep_modify_prot_start(vma, addr, pte);
 			ptent = pte_modify(ptent, newprot);
 			if (preserve_write)
 				ptent = pte_mk_savedwrite(ptent);
@@ -121,7 +121,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					 !(vma->vm_flags & VM_SOFTDIRTY))) {
 				ptent = pte_mkwrite(ptent);
 			}
-			ptep_modify_prot_commit(mm, addr, pte, ptent);
+			ptep_modify_prot_commit(vma, addr, pte, ptent);
 			pages++;
 		} else if (IS_ENABLED(CONFIG_MIGRATION)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
-- 
2.17.1

