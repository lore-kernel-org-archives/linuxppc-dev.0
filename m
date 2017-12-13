Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxS662C8QzDrX0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:51:42 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBD6p2c6080684
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:51:40 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etx7ttvnd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:51:39 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 06:51:37 -0000
Subject: Re: [PATCH 1/3] powerpc/perf: Remove thread_imc_pmu global variable
 from
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
 <1512971917-23851-2-git-send-email-anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 12:21:33 +0530
MIME-Version: 1.0
In-Reply-To: <1512971917-23851-2-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <413b2f46-c115-2b94-980c-502d4a5c8447@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 11 December 2017 11:28 AM, Anju T Sudhakar wrote:
> Remove the global variable 'thread_imc_pmu', since it is not used in the code.

Reviewed-by: madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Maddy

> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>   arch/powerpc/perf/imc-pmu.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 4eb9e2b..ef7f9dd 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -40,7 +40,6 @@ static struct imc_pmu *core_imc_pmu;
>   /* Thread IMC data structures and variables */
>
>   static DEFINE_PER_CPU(u64 *, thread_imc_mem);
> -static struct imc_pmu *thread_imc_pmu;
>   static int thread_imc_mem_size;
>
>   struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
> @@ -1263,7 +1262,6 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   				return res;
>   		}
>
> -		thread_imc_pmu = pmu_ptr;
>   		break;
>   	default:
>   		return -EINVAL;
