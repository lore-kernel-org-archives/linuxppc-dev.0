Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E0C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 09:46:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26BF21841
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26BF21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JtSq6qbZzDqQC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:46:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JtN055HMzDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 20:42:08 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBI9egQk097621
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 04:42:06 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pex0f1edx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 04:42:05 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 18 Dec 2018 09:42:04 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 18 Dec 2018 09:42:02 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBI9g10h29491212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Dec 2018 09:42:01 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 075586E052;
 Tue, 18 Dec 2018 09:42:01 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8559C6E04C;
 Tue, 18 Dec 2018 09:41:57 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.88.39])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 18 Dec 2018 09:41:57 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, akpm@linux-foundation.org, x86@kernel.org
Subject: [PATCH V4 1/5] mm: Update ptep_modify_prot_start/commit to take
 vm_area_struct as arg
Date: Tue, 18 Dec 2018 15:11:33 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218094137.13732-1-aneesh.kumar@linux.ibm.com>
References: <20181218094137.13732-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121809-0016-0000-0000-00000965F79F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010242; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133443; UDB=6.00589233; IPR=6.00913618; 
 MB=3.00024731; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-18 09:42:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121809-0017-0000-0000-000041730BCA
Message-Id: <20181218094137.13732-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-18_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180086
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some architecture may want to call flush_tlb_range from these helpers.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h       |  4 ++--
 arch/s390/mm/pgtable.c                |  6 ++++--
 arch/x86/include/asm/paravirt.h       | 11 ++++++-----
 arch/x86/include/asm/paravirt_types.h |  5 +++--
 arch/x86/xen/mmu.h                    |  4 ++--
 arch/x86/xen/mmu_pv.c                 |  8 ++++----
 fs/proc/task_mmu.c                    |  4 ++--
 include/asm-generic/pgtable.h         | 16 ++++++++--------
 mm/memory.c                           |  4 ++--
 mm/mprotect.c                         |  4 ++--
 10 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 063732414dfb..5d730199e37b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1069,8 +1069,8 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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
index 4bf42f9e4eea..a1d0ee5c5c51 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -417,25 +417,26 @@ static inline pgdval_t pgd_val(pgd_t pgd)
 }
 
 #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
+static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
 					   pte_t *ptep)
 {
 	pteval_t ret;
 
-	ret = PVOP_CALL3(pteval_t, mmu.ptep_modify_prot_start, mm, addr, ptep);
+	ret = PVOP_CALL3(pteval_t, mmu.ptep_modify_prot_start, vma, addr, ptep);
 
 	return (pte_t) { .pte = ret };
 }
 
-static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
+static inline void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 					   pte_t *ptep, pte_t pte)
 {
+
 	if (sizeof(pteval_t) > sizeof(long))
 		/* 5 arg words */
-		pv_ops.mmu.ptep_modify_prot_commit(mm, addr, ptep, pte);
+		pv_ops.mmu.ptep_modify_prot_commit(vma, addr, ptep, pte);
 	else
 		PVOP_VCALL4(mmu.ptep_modify_prot_commit,
-			    mm, addr, ptep, pte.pte);
+			    vma, addr, ptep, pte.pte);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 26942ad63830..609a728ec809 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -55,6 +55,7 @@ struct task_struct;
 struct cpumask;
 struct flush_tlb_info;
 struct mmu_gather;
+struct vm_area_struct;
 
 /*
  * Wrapper type for pointers to code which uses the non-standard
@@ -254,9 +255,9 @@ struct pv_mmu_ops {
 			   pte_t *ptep, pte_t pteval);
 	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
 
-	pte_t (*ptep_modify_prot_start)(struct mm_struct *mm, unsigned long addr,
+	pte_t (*ptep_modify_prot_start)(struct vm_area_struct *vma, unsigned long addr,
 					pte_t *ptep);
-	void (*ptep_modify_prot_commit)(struct mm_struct *mm, unsigned long addr,
+	void (*ptep_modify_prot_commit)(struct vm_area_struct *vma, unsigned long addr,
 					pte_t *ptep, pte_t pte);
 
 	struct paravirt_callee_save pte_val;
diff --git a/arch/x86/xen/mmu.h b/arch/x86/xen/mmu.h
index a7e47cf7ec6c..6e4c6bd62203 100644
--- a/arch/x86/xen/mmu.h
+++ b/arch/x86/xen/mmu.h
@@ -17,8 +17,8 @@ bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn);
 
 void set_pte_mfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
-pte_t xen_ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-void  xen_ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
+pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
+void  xen_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 				  pte_t *ptep, pte_t pte);
 
 unsigned long xen_read_cr2_direct(void);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a5d7ed125337..b7c89619cfc9 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -306,20 +306,20 @@ static void xen_set_pte_at(struct mm_struct *mm, unsigned long addr,
 	__xen_set_pte(ptep, pteval);
 }
 
-pte_t xen_ptep_modify_prot_start(struct mm_struct *mm,
+pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma,
 				 unsigned long addr, pte_t *ptep)
 {
 	/* Just return the pte as-is.  We preserve the bits on commit */
-	trace_xen_mmu_ptep_modify_prot_start(mm, addr, ptep, *ptep);
+	trace_xen_mmu_ptep_modify_prot_start(vma->vm_mm, addr, ptep, *ptep);
 	return *ptep;
 }
 
-void xen_ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
+void xen_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 				 pte_t *ptep, pte_t pte)
 {
 	struct mmu_update u;
 
-	trace_xen_mmu_ptep_modify_prot_commit(mm, addr, ptep, pte);
+	trace_xen_mmu_ptep_modify_prot_commit(vma->vm_mm, addr, ptep, pte);
 	xen_mc_batch();
 
 	u.ptr = virt_to_machine(ptep).maddr | MMU_PT_UPDATE_PRESERVE_AD;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 47c3764c469b..9952d7185170 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -940,10 +940,10 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
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
index 359fb935ded6..d28683ada357 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -568,7 +568,7 @@ static inline int pmd_none_or_clear_bad(pmd_t *pmd)
 	return 0;
 }
 
-static inline pte_t __ptep_modify_prot_start(struct mm_struct *mm,
+static inline pte_t __ptep_modify_prot_start(struct vm_area_struct *vma,
 					     unsigned long addr,
 					     pte_t *ptep)
 {
@@ -577,10 +577,10 @@ static inline pte_t __ptep_modify_prot_start(struct mm_struct *mm,
 	 * non-present, preventing the hardware from asynchronously
 	 * updating it.
 	 */
-	return ptep_get_and_clear(mm, addr, ptep);
+	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
 }
 
-static inline void __ptep_modify_prot_commit(struct mm_struct *mm,
+static inline void __ptep_modify_prot_commit(struct vm_area_struct *vma,
 					     unsigned long addr,
 					     pte_t *ptep, pte_t pte)
 {
@@ -588,7 +588,7 @@ static inline void __ptep_modify_prot_commit(struct mm_struct *mm,
 	 * The pte is non-present, so there's no hardware state to
 	 * preserve.
 	 */
-	set_pte_at(mm, addr, ptep, pte);
+	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
 
 #ifndef __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
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
+	return __ptep_modify_prot_start(vma, addr, ptep);
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
+	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
diff --git a/mm/memory.c b/mm/memory.c
index 4ad2d293ddc2..d36b0eaa7862 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3588,12 +3588,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
2.19.2

