Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xghwS211RzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 16:40:24 +1000 (AEST)
Message-ID: <1503902395.4850.0.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/cxl: Add barrier when setting mm cpumask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>
Date: Mon, 28 Aug 2017 16:39:55 +1000
In-Reply-To: <20170828062530.5789-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170828062530.5789-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 11:55 +0530, Aneesh Kumar K.V wrote:
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
> ---
>  drivers/misc/cxl/fault.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index ab507e4ed69b..caed2a523bee 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -141,9 +141,19 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
>  	/*
>  	 * Add the fault handling cpu to task mm cpumask so that we
>  	 * can do a safe lockless page table walk when inserting the
> -	 * hash page table entry.
> +	 * hash page table entry. This function get called with a
> +	 * valid mm for all user space applications. Hence using
> +	 * if (mm) check is sufficient here.
>  	 */
> -	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> +	if (mm) {
> +		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));

First test if it's already set as this should be quite common and the
cost of setting is a full atomic.

> +		/*
> +		 * We need to make sure we walk the table only after
> +		 * we update the cpumask. The other side of the barrier is
> +		 * explained * in serialize_against_pte_lookup()
> +		 */
> +		smp_mb();
> +	}
>  	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
>  		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
>  		return result;
