Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c12l13qfzF2VC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 13:33:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w433Swms070121
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 23:33:48 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hqs32b1wt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 23:33:48 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 3 May 2018 04:33:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w433XjYO6881714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 May 2018 03:33:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F0534C044
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 04:25:54 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C32B74C052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 04:25:53 +0100 (BST)
Received: from [9.124.35.178] (unknown [9.124.35.178])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 04:25:53 +0100 (BST)
Subject: Re: [PATCH 1/4] powerpc/perf: Rearrange memory freeing in imc init
To: linuxppc-dev@lists.ozlabs.org
References: <1523264425-19544-1-git-send-email-anju@linux.vnet.ibm.com>
 <1523264425-19544-2-git-send-email-anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 09:03:43 +0530
MIME-Version: 1.0
In-Reply-To: <1523264425-19544-2-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <638684a1-f75e-3dc9-553d-b04037f2d555@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 09 April 2018 02:30 PM, Anju T Sudhakar wrote:
> When any of the IMC (In-Memory Collection counter) devices fail
> to initialize, imc_common_mem_free() frees set of memory. In doing so,
> pmu_ptr pointer is also freed. But pmu_ptr pointer is used in subsequent
> function (imc_common_cpuhp_mem_free()) which is wrong. Patch here reorders
> the code to avoid such access.
>
> Also free the memory which is dynamically allocated during imc initialization,
> wherever required.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
> test matrix and static checker run details are updated in the cover letter
> patch is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git (branch: merge)
>
>   arch/powerpc/perf/imc-pmu.c               | 32 ++++++++++++++++---------------
>   arch/powerpc/platforms/powernv/opal-imc.c | 13 ++++++++++---
>   2 files changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index d7532e7..258b0f4 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1153,7 +1153,7 @@ static void cleanup_all_core_imc_memory(void)
>   	/* mem_info will never be NULL */
>   	for (i = 0; i < nr_cores; i++) {
>   		if (ptr[i].vbase)
> -			free_pages((u64)ptr->vbase, get_order(size));
> +			free_pages((u64)ptr[i].vbase, get_order(size));
>   	}
>
>   	kfree(ptr);
> @@ -1191,7 +1191,6 @@ static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
>   	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
>   		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
>   	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
> -	kfree(pmu_ptr);
>   }
>
>   /*
> @@ -1208,6 +1207,7 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
>   			kfree(nest_imc_refc);
>   			kfree(per_nest_pmu_arr);
> +			per_nest_pmu_arr = NULL;
>   		}
>
>   		if (nest_pmus > 0)
> @@ -1319,10 +1319,8 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   	int ret;
>
>   	ret = imc_mem_init(pmu_ptr, parent, pmu_idx);
> -	if (ret) {
> -		imc_common_mem_free(pmu_ptr);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_free_mem;
>
>   	switch (pmu_ptr->domain) {
>   	case IMC_DOMAIN_NEST:
> @@ -1337,7 +1335,9 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   			ret = init_nest_pmu_ref();
>   			if (ret) {
>   				mutex_unlock(&nest_init_lock);
> -				goto err_free;
> +				kfree(per_nest_pmu_arr);
> +				per_nest_pmu_arr = NULL;
> +				goto err_free_mem;
>   			}
>   			/* Register for cpu hotplug notification. */
>   			ret = nest_pmu_cpumask_init();
> @@ -1345,7 +1345,8 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   				mutex_unlock(&nest_init_lock);
>   				kfree(nest_imc_refc);
>   				kfree(per_nest_pmu_arr);
> -				goto err_free;
> +				per_nest_pmu_arr = NULL;
> +				goto err_free_mem;
>   			}
>   		}
>   		nest_pmus++;
> @@ -1355,7 +1356,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   		ret = core_imc_pmu_cpumask_init();
>   		if (ret) {
>   			cleanup_all_core_imc_memory();
> -			return ret;
> +			goto err_free_mem;
>   		}
>
>   		break;
> @@ -1363,7 +1364,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   		ret = thread_imc_cpu_init();
>   		if (ret) {
>   			cleanup_all_thread_imc_memory();
> -			return ret;
> +			goto err_free_mem;
>   		}
>
>   		break;
> @@ -1373,23 +1374,24 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>
>   	ret = update_events_in_group(parent, pmu_ptr);
>   	if (ret)
> -		goto err_free;
> +		goto err_free_cpuhp_mem;
>
>   	ret = update_pmu_ops(pmu_ptr);
>   	if (ret)
> -		goto err_free;
> +		goto err_free_cpuhp_mem;
>
>   	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
>   	if (ret)
> -		goto err_free;
> +		goto err_free_cpuhp_mem;
>
>   	pr_info("%s performance monitor hardware support registered\n",
>   							pmu_ptr->pmu.name);
>
>   	return 0;
>
> -err_free:
> -	imc_common_mem_free(pmu_ptr);
> +err_free_cpuhp_mem:
>   	imc_common_cpuhp_mem_free(pmu_ptr);
> +err_free_mem:
> +	imc_common_mem_free(pmu_ptr);
>   	return ret;
>   }
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index 2a14fda..490bb72 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -115,8 +115,10 @@ static int imc_get_mem_addr_nest(struct device_node *node,
>   		return -ENOMEM;
>
>   	chipid_arr = kcalloc(nr_chips, sizeof(*chipid_arr), GFP_KERNEL);
> -	if (!chipid_arr)
> +	if (!chipid_arr) {
> +		kfree(base_addr_arr);
>   		return -ENOMEM;
> +	}
>
>   	if (of_property_read_u32_array(node, "chip-id", chipid_arr, nr_chips))
>   		goto error;
> @@ -143,7 +145,6 @@ static int imc_get_mem_addr_nest(struct device_node *node,
>   	return 0;
>
>   error:
> -	kfree(pmu_ptr->mem_info);
>   	kfree(base_addr_arr);
>   	kfree(chipid_arr);
>   	return -1;
> @@ -183,8 +184,14 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
>
>   	/* Function to register IMC pmu */
>   	ret = init_imc_pmu(parent, pmu_ptr, pmu_index);
> -	if (ret)
> +	if (ret) {
>   		pr_err("IMC PMU %s Register failed\n", pmu_ptr->pmu.name);
> +		kfree(pmu_ptr->pmu.name);
> +		if (pmu_ptr->domain == IMC_DOMAIN_NEST)
> +			kfree(pmu_ptr->mem_info);
> +		kfree(pmu_ptr);
> +		return ret;
> +	}
>
>   	return 0;
>
