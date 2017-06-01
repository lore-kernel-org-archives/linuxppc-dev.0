Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdqbf5FvqzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 00:34:06 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51ETr2C068938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 10:34:02 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2atjys6c85-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 10:34:02 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 08:34:01 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc/mm/cxl: Add the fault handling cpu to mm
 cpumask
Date: Thu,  1 Jun 2017 20:03:35 +0530
In-Reply-To: <1496327615-7754-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1496327615-7754-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1496327615-7754-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 10 +---------
 drivers/misc/cxl/fault.c           |  6 ++++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 2679f57b90e2..6a50ab23f722 100644
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
index 5344448f514e..02efaaa7cbd1 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -140,6 +140,12 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 	unsigned long access, flags, inv_flags = 0;
 
 	trace_cxl_pte_miss(ctx, dsisr, dar);
+	/*
+	 * Add the fault handling cpu to task mm cpumask so that we
+	 * can do a safe lockless page table walk when inserting the
+	 * hash page table entry.
+	 */
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
 
 	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
 		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
-- 
2.7.4
