Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgkYX6K9szDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 17:54:08 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S7rlbL059854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 03:54:06 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cmb2r1m9q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 03:54:05 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 17:54:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7S7s1U439977104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 17:54:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7S7rqOc025018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 17:53:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] powerpc/mm/cxl: Add barrier when setting mm cpumask
In-Reply-To: <1503902395.4850.0.camel@kernel.crashing.org>
References: <20170828062530.5789-1-aneesh.kumar@linux.vnet.ibm.com>
 <1503902395.4850.0.camel@kernel.crashing.org>
Date: Mon, 28 Aug 2017 13:23:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8ws5dri.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2017-08-28 at 11:55 +0530, Aneesh Kumar K.V wrote:
>> We need to add memory barrier so that the page table walk doesn't happen
>> before the cpumask is set and made visible to the other cpus. We need
>> to use a sync here instead of lwsync because lwsync is not sufficient for
>> store/load ordering.
>> 
>> We also need to add an if (mm) check so that we do the right thing when called
>> with a kernel context. For kernel context, we have mm = NULL. W.r.t kernel
>> address we can skip setting the mm cpumask.
>> 
>> Fixes: 0f4bc0932e ("powerpc/mm/cxl: Add the fault handling cpu to mm cpumask")
>> Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  drivers/misc/cxl/fault.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
>> index ab507e4ed69b..caed2a523bee 100644
>> --- a/drivers/misc/cxl/fault.c
>> +++ b/drivers/misc/cxl/fault.c
>> @@ -141,9 +141,19 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
>>  	/*
>>  	 * Add the fault handling cpu to task mm cpumask so that we
>>  	 * can do a safe lockless page table walk when inserting the
>> -	 * hash page table entry.
>> +	 * hash page table entry. This function get called with a
>> +	 * valid mm for all user space applications. Hence using
>> +	 * if (mm) check is sufficient here.
>>  	 */
>> -	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
>> +	if (mm) {
>> +		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
>
> First test if it's already set as this should be quite common and the
> cost of setting is a full atomic.
>

Something like below ?

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index caed2a523bee..ccf8568262e4 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -146,13 +146,13 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
 	 * if (mm) check is sufficient here.
 	 */
 	if (mm) {
-		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-		/*
-		 * We need to make sure we walk the table only after
-		 * we update the cpumask. The other side of the barrier is
-		 * explained * in serialize_against_pte_lookup()
-		 */
-		smp_mb();
+		if (!cpumask_test_and_set_cpu(smp_processor_id(), mm_cpumask(mm)))
+			/*
+			 * We need to make sure we walk the table only after
+			 * we update the cpumask. The other side of the barrier
+			 * is explained in serialize_against_pte_lookup()
+			 */
+			smp_mb();
 	}
 	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
 		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
