Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY7KN6C9czDr1y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 00:05:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HE3m4O127068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 10:05:42 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cd9x1aax8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 10:05:42 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 18 Aug 2017 00:05:40 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7HE5UVj38076628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 00:05:38 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7HE56cc008481
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 00:05:06 +1000
Received: from [9.79.203.91] ([9.79.203.91])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v7HE55qa008019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 00:05:06 +1000
Subject: Re: [PATCH] powerpc: powernv: Fix build error on const discarding
To: linuxppc-dev@lists.ozlabs.org
References: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 17 Aug 2017 19:34:49 +0530
MIME-Version: 1.0
In-Reply-To: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e3c580e1-6081-d89e-8324-0e98c2440151@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 16 August 2017 06:04 PM, Corentin Labbe wrote:
> When building a random powerpc kernel I hit this build error:
>    CC      arch/powerpc/platforms/powernv/opal-imc.o
> arch/powerpc/platforms/powernv/opal-imc.c: In function « disable_nest_pmu_counters »:
> arch/powerpc/platforms/powernv/opal-imc.c:130:13: error : assignment discards « const » qualifier from pointer target type [-Werror=discarded-qualifiers]
>     l_cpumask = cpumask_of_node(nid);
>               ^
> This patch simply add const to l_cpumask to fix this issue.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>   arch/powerpc/platforms/powernv/opal-imc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index b903bf5e6006..21f6531fae20 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -123,7 +123,7 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
>   static void disable_nest_pmu_counters(void)
>   {
>   	int nid, cpu;
> -	struct cpumask *l_cpumask;
> +	const struct cpumask *l_cpumask;
>
>   	get_online_cpus();
>   	for_each_online_node(nid) {
