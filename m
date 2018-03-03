Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztjL05WLQzF1kc
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2018 21:37:44 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w239JtlR111796
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Mar 2018 04:24:12 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gfpwqu53q-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Mar 2018 04:24:12 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Sat, 3 Mar 2018 09:24:11 -0000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Drop the function native_register_proc_table()
Date: Sat,  3 Mar 2018 14:54:02 +0530
Message-Id: <20180303092402.6032-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is left over from the segment table implementation and not getting
called from any where now. Hence just drop it.

Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
RFC: http://patchwork.ozlabs.org/patch/857937/

 arch/powerpc/mm/hash_native_64.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index a0675e91ad7d..993842f1ed60 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -852,18 +852,6 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_restore(flags);
 }
 
-static int native_register_proc_table(unsigned long base, unsigned long page_size,
-				      unsigned long table_size)
-{
-	unsigned long patb1 = base << 25; /* VSID */
-
-	patb1 |= (page_size << 5);  /* sllp */
-	patb1 |= table_size;
-
-	partition_tb->patb1 = cpu_to_be64(patb1);
-	return 0;
-}
-
 void __init hpte_init_native(void)
 {
 	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
@@ -875,7 +863,4 @@ void __init hpte_init_native(void)
 	mmu_hash_ops.hpte_clear_all	= native_hpte_clear;
 	mmu_hash_ops.flush_hash_range = native_flush_hash_range;
 	mmu_hash_ops.hugepage_invalidate   = native_hugepage_invalidate;
-
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		register_process_table = native_register_proc_table;
 }
-- 
2.11.0
