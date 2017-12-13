Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxS8121ggzDrS0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:53:21 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBD6rG3V060120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:53:19 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etrs9esdg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:53:18 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 06:53:16 -0000
Subject: Re: [PATCH 2/3] powerpc/perf: IMC code cleanup with some code
 refactoring
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
 <1512971917-23851-3-git-send-email-anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 12:23:12 +0530
MIME-Version: 1.0
In-Reply-To: <1512971917-23851-3-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fb1d438c-4331-728e-95da-14a158af5803@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 11 December 2017 11:28 AM, Anju T Sudhakar wrote:
> Factor out memory freeing part for attribute elements from
> imc_common_cpuhp_mem_free().

Looks good to me.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>   arch/powerpc/perf/imc-pmu.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index ef7f9dd..71f425f 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1157,6 +1157,15 @@ static void cleanup_all_thread_imc_memory(void)
>   	}
>   }
>
> +/* Function to free the attr_groups which are dynamically allocated */
> +static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
> +{
> +	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
> +		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
> +	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
> +	kfree(pmu_ptr);
> +}
> +
>   /*
>    * Common function to unregister cpu hotplug callback and
>    * free the memory.
> @@ -1189,13 +1198,6 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
>   		cleanup_all_thread_imc_memory();
>   	}
> -
> -	/* Only free the attr_groups which are dynamically allocated  */
> -	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
> -		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
> -	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
> -	kfree(pmu_ptr);
> -	return;
>   }
>
>
> @@ -1244,8 +1246,10 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		core_imc_refc = kcalloc(nr_cores, sizeof(struct imc_pmu_ref),
>   								GFP_KERNEL);
>
> -		if (!core_imc_refc)
> +		if (!core_imc_refc) {
> +			kfree(pmu_ptr->mem_info);
>   			return -ENOMEM;
> +		}
>
>   		core_imc_pmu = pmu_ptr;
>   		break;
> @@ -1258,8 +1262,10 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		thread_imc_mem_size = pmu_ptr->counter_mem_size;
>   		for_each_online_cpu(cpu) {
>   			res = thread_imc_mem_alloc(cpu, pmu_ptr->counter_mem_size);
> -			if (res)
> +			if (res) {
> +				cleanup_all_thread_imc_memory();
>   				return res;
> +			}
>   		}
>
>   		break;
> @@ -1285,8 +1291,10 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   	int ret;
>
>   	ret = imc_mem_init(pmu_ptr, parent, pmu_idx);
> -	if (ret)
> -		goto err_free;
> +	if (ret) {
> +		imc_common_mem_free(pmu_ptr);
> +		return ret;
> +	}
>
>   	switch (pmu_ptr->domain) {
>   	case IMC_DOMAIN_NEST:
> @@ -1353,6 +1361,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   	return 0;
>
>   err_free:
> +	imc_common_mem_free(pmu_ptr);
>   	imc_common_cpuhp_mem_free(pmu_ptr);
>   	return ret;
>   }
