Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ25n3VdgzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 16:25:17 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6R6O2Bc022562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:25:15 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2by8xdmnt4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:25:15 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 02:25:14 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 3/3] powerpc/mm/cxl: Add the fault handling cpu to mm
 cpumask
Date: Thu, 27 Jul 2017 11:54:55 +0530
In-Reply-To: <20170727062455.15404-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170727062455.15404-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170727062455.15404-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use mm cpumask for serializing against lockless page table walk. Anybody
who is doing a lockless page table walk is expected to disable irq and only
cpus in mm cpumask is expected do the lockless walk. This ensure that
a THP split can send IPI to only cpus in the mm cpumask, to make sure there
are no parallel lockless page table walk.

Add the CAPI fault handling cpu to the mm cpumask so that we can do the lockless
page table walk while inserting hash page table entries.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 10 +---------
 drivers/misc/cxl/fault.c           |  6 ++++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 57b947cde2bf..3b65917785a5 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -83,15 +83,7 @@ static void do_nothing(void *unused)
 void serialize_against_pte_lookup(struct mm_struct *mm)
 {
 	smp_mb();
-	/*
-	 * Cxl fault handling requires us to do a lockless page table
-	 * walk while inserting hash page table entry with mm tracked
-	 * in cxl context. Hence we need to do a global flush.
-	 */
-	if (cxl_ctx_in_use())
-		smp_call_function(do_nothing, NULL, 1);
-	else
-		smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
+	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
 }
 
 /*
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 6eed7d03e2b5..ab507e4ed69b 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -138,6 +138,12 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
 	int result;
 	unsigned long access, flags, inv_flags = 0;
 
+	/*
+	 * Add the fault handling cpu to task mm cpumask so that we
+	 * can do a safe lockless page table walk when inserting the
+	 * hash page table entry.
+	 */
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
 	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
 		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
 		return result;
-- 
2.13.3
