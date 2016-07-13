Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDHG1pspzDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:36:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YFjA140227
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:23 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243ent3g8f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:23 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:22 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 09/12] powerpc/mm/radix: Update machine call back to
 support new HCALL.
Date: Wed, 13 Jul 2016 15:05:28 +0530
In-Reply-To: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402531-4914-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This update the machine dep callback such that we can use the same
callback to register process table. The interface is updated such that
we can easily call H_REGISTER_PROC_TBL hcall. The HCALL itself is
introduced in a later patch.

No functionality change introduced by this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h |  3 ++-
 arch/powerpc/mm/hash_native_64.c   | 10 ++++++++--
 arch/powerpc/mm/pgtable-radix.c    |  9 ++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 6bdcd0da9e21..4c8260855748 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -256,7 +256,8 @@ struct machdep_calls {
 #ifdef CONFIG_ARCH_RANDOM
 	int (*get_random_seed)(unsigned long *v);
 #endif
-	int (*update_partition_table)(u64);
+	int (*register_process_table)(unsigned long base, unsigned long page_size,
+				      unsigned long tbl_size);
 };
 
 extern void e500_idle(void);
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 70521ef171fc..cb3b4c98b637 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -725,8 +725,14 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_restore(flags);
 }
 
-static int native_update_partition_table(u64 patb1)
+static int native_register_proc_table(unsigned long base, unsigned long page_size,
+				      unsigned long table_size)
 {
+	unsigned long patb1 = base << 25; /* VSID */
+
+	patb1 |= (page_size << 5);  /* sllp */
+	patb1 |= table_size;
+
 	partition_tb->patb1 = cpu_to_be64(patb1);
 	return 0;
 }
@@ -743,5 +749,5 @@ void __init hpte_init_native(void)
 	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		ppc_md.update_partition_table = native_update_partition_table;
+		ppc_md.register_process_table = native_register_proc_table;
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 366d1ea24465..ce21a0f2c2a1 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -21,8 +21,11 @@
 
 #include <trace/events/thp.h>
 
-static int native_update_partition_table(u64 patb1)
+static int native_register_process_table(unsigned long base, unsigned long pg_sz,
+					 unsigned long table_size)
 {
+	unsigned long patb1 = base | table_size | PATB_GR;
+
 	partition_tb->patb1 = cpu_to_be64(patb1);
 	return 0;
 }
@@ -168,7 +171,7 @@ redo:
 	 * of process table here. But our linear mapping also enable us to use
 	 * physical address here.
 	 */
-	ppc_md.update_partition_table(__pa(process_tb) | (PRTB_SIZE_SHIFT - 12) | PATB_GR);
+	ppc_md.register_process_table(__pa(process_tb), 0, PRTB_SIZE_SHIFT - 12);
 	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
 }
 
@@ -195,7 +198,7 @@ static void __init radix_init_partition_table(void)
 
 void __init radix_init_native(void)
 {
-	ppc_md.update_partition_table = native_update_partition_table;
+	ppc_md.register_process_table = native_register_process_table;
 }
 
 static int __init get_idx_from_shift(unsigned int shift)
-- 
2.7.4
