Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmP2dZpzDwsF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:05 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58EddZ4134469
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:02 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m42wau-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:02 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 08/16] powerpc/mm: Drop multiple definition of
 mm_is_core_local
Date: Wed,  8 Jun 2016 20:13:15 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 03e719ee6747..74b0c90045ab 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -163,12 +163,6 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
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
 	unsigned long pid;
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
