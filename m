Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPPZC6d79zDqc6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 19:19:47 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4C9Egpu046749
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:19:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2acwgr15rp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:19:39 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 12 May 2017 03:19:38 -0600
Date: Fri, 12 May 2017 14:49:33 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/powernv: Fix CPU_HOTPLUG=n idle.c compile
 error
Reply-To: ego@linux.vnet.ibm.com
References: <20170511151522.4772-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170511151522.4772-1-npiggin@gmail.com>
Message-Id: <20170512091933.GA13320@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,
On Fri, May 12, 2017 at 01:15:20AM +1000, Nicholas Piggin wrote:
> Fixes: a7cd88da97 ("powerpc/powernv: Move CPU-Offline idle state invocation from smp.c to idle.c")
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 445f30a2c5ef..0c21747ed7e0 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -261,6 +261,7 @@ static u64 pnv_deepest_stop_psscr_val;
>  static u64 pnv_deepest_stop_psscr_mask;
>  static bool deepest_stop_found;
> 
> +#ifdef CONFIG_HOTPLUG_CPU
>  /*
>   * pnv_cpu_offline: A function that puts the CPU into the deepest
>   * available platform idle state on a CPU-Offline.
> @@ -293,6 +294,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
> 
>  	return srr1;
>  }
> +#endif

Looks like the updated verison of "powerpc/powernv: Move CPU-Offline
idle state invocation from smp.c to idle.c"
(https://lkml.org/lkml/2017/3/30/235) wasn't picked.

Thanks for catching this!
Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> 
>  /*
>   * Power ISA 3.0 idle initialization.
> -- 
> 2.11.0
> 

--
Thanks and Regards
gautham.
