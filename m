Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgmj01wtyzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 19:30:43 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S9Soff091307
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 05:30:41 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cmcctb5md-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 05:30:40 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 28 Aug 2017 19:30:37 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7S9UYwJ40960082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 19:30:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7S9UYZo023757
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 19:30:35 +1000
Subject: Re: [PATCH v2] powerpc/mm/cxl: Add barrier when setting mm cpumask
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170828083544.16514-1-aneesh.kumar@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 28 Aug 2017 19:30:33 +1000
MIME-Version: 1.0
In-Reply-To: <20170828083544.16514-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6c8d7102-60c4-6e79-87f7-10a2a6760e40@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/08/17 18:35, Aneesh Kumar K.V wrote:
> We need to add memory barrier so that the page table walk doesn't happen
> before the cpumask is set and made visible to the other cpus. We need
> to use a sync here instead of lwsync because lwsync is not sufficient for
> store/load ordering.
> 
> We also need to add an if (mm) check so that we do the right thing when called
> with a kernel context. For kernel context, we have mm = NULL. W.r.t kernel
> address we can skip setting the mm cpumask.
> 
> Fixes: 0f4bc0932e ("powerpc/mm/cxl: Add the fault handling cpu to mm cpumask")
> Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/cxl/fault.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index ab507e4ed69b..f17f72ea0545 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -141,9 +141,19 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
>   	/*
>   	 * Add the fault handling cpu to task mm cpumask so that we
>   	 * can do a safe lockless page table walk when inserting the
> -	 * hash page table entry.
> +	 * hash page table entry. This function get called with a
> +	 * valid mm for user space addresses. Hence using the if (mm)
> +	 * check is sufficient here.
>   	 */
> -	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> +	if (mm && !cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
> +		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> +		/*
> +		 * We need to make sure we walk the table only after
> +		 * we update the cpumask. The other side of the barrier
> +		 * is explained in serialize_against_pte_lookup()
> +		 */
> +		smp_mb();
> +	}
>   	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
>   		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
>   		return result;
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
