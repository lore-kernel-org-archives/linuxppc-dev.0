Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxS4K31ppzDqhM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:50:08 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBD6nkRn143004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:50:06 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etxpshkha-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:50:06 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 06:50:04 -0000
Subject: Re: [PATCH] powerpc/perf: Fix kfree memory allocated for nest pmus
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1512667407-30067-1-git-send-email-anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 12:19:59 +0530
MIME-Version: 1.0
In-Reply-To: <1512667407-30067-1-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e0b3dc1d-9a9d-83e5-7034-c7b4c0563a44@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 07 December 2017 10:53 PM, Anju T Sudhakar wrote:
> imc_common_cpuhp_mem_free() is the common function for all IMC (In-memory
> Collection counters) domains to unregister cpuhotplug callback and free memory.
> Since kfree of memory allocated for nest-imc (per_nest_pmu_arr) is in the common
> code, all domains (core/nest/thread) can do the kfree in the failure case.
>
> This could potentially create a call trace as shown below, where core(/thread/nest)
> imc pmu initialization fails and in the failure path imc_common_cpuhp_mem_free()
> free the memory(per_nest_pmu_arr), which is allocated by successfully registered
> nest units.
>
>
> The call trace is generated in a scenario where core-imc initialization is
> made to fail and a cpuhotplug is performed in a p9 system.
> During cpuhotplug ppc_nest_imc_cpu_offline() tries to access per_nest_pmu_arr,
> which is already freed by core-imc.
>
> [  136.563618] NIP [c000000000cb6a94] mutex_lock+0x34/0x90
> [  136.563653] LR [c000000000cb6a88] mutex_lock+0x28/0x90
> [  136.563687] Call Trace:
> [  136.563707] [c0000016b7a93b90] [c000000000cb6a88] mutex_lock+0x28/0x90 (unreliable)
> [  136.563762] [c0000016b7a93bc0] [c0000000002bc720] perf_pmu_migrate_context+0x90/0x3a0
> [  136.563814] [c0000016b7a93c60] [c0000000000f7a40] ppc_nest_imc_cpu_offline+0x190/0x1f0
> [  136.563867] [c0000016b7a93cb0] [c000000000108140] cpuhp_invoke_callback+0x160/0x820
> [  136.563918] [c0000016b7a93d30] [c00000000010939c] cpuhp_thread_fun+0x1bc/0x270
> [  136.563970] [c0000016b7a93d60] [c00000000013d2b0] smpboot_thread_fn+0x250/0x290
> [  136.564022] [c0000016b7a93dc0] [c000000000136f18] kthread+0x1a8/0x1b0
> [  136.564067] [c0000016b7a93e30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
>
> To address this scenario do the kfree(per_nest_pmu_arr) only in case of
> nest-imc initialization failure, and when there is no other nest units registered.

My bad. Broke it when fixing the IMC_MAX_PMU. Sorry about it.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>


>
> Fixes: 73ce9aec65b1 ("powerpc/perf: Fix IMC_MAX_PMU macro")
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>   arch/powerpc/perf/imc-pmu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 0ead3cd..4eb9e2b 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1171,6 +1171,7 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   		if (nest_pmus == 1) {
>   			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
>   			kfree(nest_imc_refc);
> +			kfree(per_nest_pmu_arr);
>   		}
>
>   		if (nest_pmus > 0)
> @@ -1195,7 +1196,6 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
>   	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
>   	kfree(pmu_ptr);
> -	kfree(per_nest_pmu_arr);
>   	return;
>   }
>
> @@ -1309,6 +1309,8 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   			ret = nest_pmu_cpumask_init();
>   			if (ret) {
>   				mutex_unlock(&nest_init_lock);
> +				kfree(nest_imc_refc);
> +				kfree(per_nest_pmu_arr);
>   				goto err_free;
>   			}
>   		}
