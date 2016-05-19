Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkF1JMJzDqfK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:01 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:28:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AD7B0E005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:32:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wtYd7864696
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wraR006592
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:55 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/7] powerpc/mm: Drop multiple definition of mm_is_core_local
Date: Thu, 19 May 2016 13:28:45 +0530
Message-Id: <1463644730-10946-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/tlb.h | 13 +++++++++++++
 arch/powerpc/mm/tlb-radix.c    |  6 ------
 arch/powerpc/mm/tlb_nohash.c   |  6 ------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 20733fa518ae..f6f68f73e858 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -46,5 +46,18 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 #endif
 }
 
+#ifdef CONFIG_SMP
+static inline int mm_is_core_local(struct mm_struct *mm)
+{
+	return cpumask_subset(mm_cpumask(mm),
+			      topology_sibling_cpumask(smp_processor_id()));
+}
+#else
+static inline int mm_is_core_local(struct mm_struct *mm)
+{
+	return 1;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_TLB_H */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 0fdaf93a3e09..5807f5d72e1b 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -152,12 +152,6 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
 #ifdef CONFIG_SMP
-static int mm_is_core_local(struct mm_struct *mm)
-{
-	return cpumask_subset(mm_cpumask(mm),
-			      topology_sibling_cpumask(smp_processor_id()));
-}
-
 void radix__flush_tlb_mm(struct mm_struct *mm)
 {
 	unsigned int pid;
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index f4668488512c..050badc0ebd3 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -215,12 +215,6 @@ EXPORT_SYMBOL(local_flush_tlb_page);
 
 static DEFINE_RAW_SPINLOCK(tlbivax_lock);
 
-static int mm_is_core_local(struct mm_struct *mm)
-{
-	return cpumask_subset(mm_cpumask(mm),
-			      topology_sibling_cpumask(smp_processor_id()));
-}
-
 struct tlb_flush_param {
 	unsigned long addr;
 	unsigned int pid;
-- 
2.7.4
