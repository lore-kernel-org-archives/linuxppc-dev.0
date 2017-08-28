Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xglTt3NwVzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 18:36:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S8YG2L012392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 04:35:59 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmbmxjebn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 04:35:59 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 02:35:57 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v2] powerpc/mm/cxl: Add barrier when setting mm cpumask
Date: Mon, 28 Aug 2017 14:05:44 +0530
Message-Id: <20170828083544.16514-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to add memory barrier so that the page table walk doesn't happen
before the cpumask is set and made visible to the other cpus. We need
to use a sync here instead of lwsync because lwsync is not sufficient for
store/load ordering.

We also need to add an if (mm) check so that we do the right thing when called
with a kernel context. For kernel context, we have mm = NULL. W.r.t kernel
address we can skip setting the mm cpumask.

Fixes: 0f4bc0932e ("powerpc/mm/cxl: Add the fault handling cpu to mm cpumask")
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 drivers/misc/cxl/fault.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index ab507e4ed69b..f17f72ea0545 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -141,9 +141,19 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
 	/*
 	 * Add the fault handling cpu to task mm cpumask so that we
 	 * can do a safe lockless page table walk when inserting the
-	 * hash page table entry.
+	 * hash page table entry. This function get called with a
+	 * valid mm for user space addresses. Hence using the if (mm)
+	 * check is sufficient here.
 	 */
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+	if (mm && !cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
+		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+		/*
+		 * We need to make sure we walk the table only after
+		 * we update the cpumask. The other side of the barrier
+		 * is explained in serialize_against_pte_lookup()
+		 */
+		smp_mb();
+	}
 	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
 		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
 		return result;
-- 
2.13.5
