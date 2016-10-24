Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2M4T31clzDvXh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 14:20:57 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9O3IiYP056848
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 23:20:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2694e02frm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 23:20:55 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 23 Oct 2016 21:20:54 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Use tlbiel only if we ever ran on the current cpu
Date: Mon, 24 Oct 2016 08:50:43 +0530
Message-Id: <20161024032043.22455-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before this patch, we used tlbiel, if we ever ran only on this core.
That was mostly derived from the nohash usage of the same. But the
ISA 3.0 clarifies tlbiel such that

"All TLB entries that have all of the following properties are made
invalid on the thread executing the tlbiel instruction"

Hence use tlbiel, if we only ever ran on just the current cpu.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

NOTE: May be the nohash usage also need to switch to mm_is_thread_local ?
I didn't check the spec, hence I left it unchanged.

I am also not adding a Fixes: line because there is no one commit. But
this is needed for radix enabled kernel. So a backport to 4.8 is needed.


 arch/powerpc/include/asm/tlb.h | 12 ++++++++++++
 arch/powerpc/mm/tlb-radix.c    |  8 ++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index f6f68f73e858..99e1397b71da 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -52,11 +52,23 @@ static inline int mm_is_core_local(struct mm_struct *mm)
 	return cpumask_subset(mm_cpumask(mm),
 			      topology_sibling_cpumask(smp_processor_id()));
 }
+
+static inline int mm_is_thread_local(struct mm_struct *mm)
+{
+	return cpumask_equal(mm_cpumask(mm),
+			      cpumask_of(smp_processor_id()));
+}
+
 #else
 static inline int mm_is_core_local(struct mm_struct *mm)
 {
 	return 1;
 }
+
+static inline int mm_is_thread_local(struct mm_struct *mm)
+{
+	return 1;
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 0e49ec541ab5..bda8c43be78a 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -175,7 +175,7 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-	if (!mm_is_core_local(mm)) {
+	if (!mm_is_thread_local(mm)) {
 		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
@@ -201,7 +201,7 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-	if (!mm_is_core_local(mm)) {
+	if (!mm_is_thread_local(mm)) {
 		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
@@ -226,7 +226,7 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
-	if (!mm_is_core_local(mm)) {
+	if (!mm_is_thread_local(mm)) {
 		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
@@ -321,7 +321,7 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long pid;
 	unsigned long addr;
-	int local = mm_is_core_local(mm);
+	int local = mm_is_thread_local(mm);
 	unsigned long ap = mmu_get_ap(psize);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
-- 
2.10.1
