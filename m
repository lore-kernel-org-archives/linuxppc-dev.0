Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c1285vK7zF2Tj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 13:33:20 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w433XC6f098444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 23:33:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hqn3ctnr6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 23:33:18 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 3 May 2018 04:33:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w433XDP136569114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 May 2018 03:33:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 134034C050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 04:25:22 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B06ED4C040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 04:25:21 +0100 (BST)
Received: from [9.124.35.178] (unknown [9.124.35.178])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 04:25:21 +0100 (BST)
Subject: Re: [PATCH 2/4] powerpc/perf: Replace the direct return with goto
 statement
To: linuxppc-dev@lists.ozlabs.org
References: <1523264425-19544-1-git-send-email-anju@linux.vnet.ibm.com>
 <1523264425-19544-3-git-send-email-anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 09:03:11 +0530
MIME-Version: 1.0
In-Reply-To: <1523264425-19544-3-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b0b9d12d-dd1b-bd58-454d-4e5846f3d0b5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 09 April 2018 02:30 PM, Anju T Sudhakar wrote:
> Replace the direct return statement in imc_mem_init() with goto,
> to adhere to the kernel coding style.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>   arch/powerpc/perf/imc-pmu.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 258b0f4..1b285cd 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1236,7 +1236,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   								int pmu_index)
>   {
>   	const char *s;
> -	int nr_cores, cpu, res;
> +	int nr_cores, cpu, res = -ENOMEM;
>
>   	if (of_property_read_string(parent, "name", &s))
>   		return -ENODEV;
> @@ -1246,7 +1246,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		/* Update the pmu name */
>   		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s_imc", "nest_", s);
>   		if (!pmu_ptr->pmu.name)
> -			return -ENOMEM;
> +			goto err;
>
>   		/* Needed for hotplug/migration */
>   		if (!per_nest_pmu_arr) {
> @@ -1254,7 +1254,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   						sizeof(struct imc_pmu *),
>   						GFP_KERNEL);
>   			if (!per_nest_pmu_arr)
> -				return -ENOMEM;
> +				goto err;
>   		}
>   		per_nest_pmu_arr[pmu_index] = pmu_ptr;
>   		break;
> @@ -1262,21 +1262,21 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		/* Update the pmu name */
>   		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
>   		if (!pmu_ptr->pmu.name)
> -			return -ENOMEM;
> +			goto err;
>
>   		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
>   		pmu_ptr->mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
>   								GFP_KERNEL);
>
>   		if (!pmu_ptr->mem_info)
> -			return -ENOMEM;
> +			goto err;
>
>   		core_imc_refc = kcalloc(nr_cores, sizeof(struct imc_pmu_ref),
>   								GFP_KERNEL);
>
>   		if (!core_imc_refc) {
>   			kfree(pmu_ptr->mem_info);
> -			return -ENOMEM;
> +			goto err;
>   		}
>
>   		core_imc_pmu = pmu_ptr;
> @@ -1285,14 +1285,14 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   		/* Update the pmu name */
>   		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
>   		if (!pmu_ptr->pmu.name)
> -			return -ENOMEM;
> +			goto err;
>
>   		thread_imc_mem_size = pmu_ptr->counter_mem_size;
>   		for_each_online_cpu(cpu) {
>   			res = thread_imc_mem_alloc(cpu, pmu_ptr->counter_mem_size);
>   			if (res) {
>   				cleanup_all_thread_imc_memory();
> -				return res;
> +				goto err;
>   			}
>   		}
>
> @@ -1302,6 +1302,8 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   	}
>
>   	return 0;
> +err:
> +	return res;
>   }
>
>   /*
