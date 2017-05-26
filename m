Return-Path: <shriyak@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ3bs1vWczDqTM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 21:21:13 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4QBInD8076098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 07:21:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2apc2e0nub-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 07:21:06 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shriyak@linux.vnet.ibm.com>;
 Fri, 26 May 2017 07:21:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 26 May 2017 16:52:09 +0530
From: shriyak <shriyak@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linuxppc-dev
 <linuxppc-dev-bounces+shriyak=linux.vnet.ibm.com@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/perf: Fix Power9 test_adder field
In-Reply-To: <1495786107-341-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1495786107-341-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <5438126c297f5125fd8713f9c104bbcc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-05-26 13:38, Madhavan Srinivasan wrote:
> Commit 8d911904f3ce4 ('powerpc/perf: Add restrictions to PMC5 in power9 
> DD1')
> was added to restrict the use of PMC5 in Power9 DD1. Intend is to 
> diable
> the use of PMC5 using raw event code. Commit instead of updating
> "power9_isa207_pmu"
> structure, updated "power9_pmu" structure. Patch to fix the same.
> 
> Fixes: 8d911904f3ce4 ('powerpc/perf: Add restrictions to PMC5 in power9 
> DD1')
> Reported-by: Shriya <shriyak@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/power9-pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/perf/power9-pmu.c 
> b/arch/powerpc/perf/power9-pmu.c
> index 018f8e90ac35..bb28e1a41257 100644
> --- a/arch/powerpc/perf/power9-pmu.c
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -402,7 +402,7 @@ static struct power_pmu power9_isa207_pmu = {
>  	.name			= "POWER9",
>  	.n_counter		= MAX_PMU_COUNTERS,
>  	.add_fields		= ISA207_ADD_FIELDS,
> -	.test_adder		= ISA207_TEST_ADDER,
> +	.test_adder		= P9_DD1_TEST_ADDER,
>  	.compute_mmcr		= isa207_compute_mmcr,
>  	.config_bhrb		= power9_config_bhrb,
>  	.bhrb_filter_map	= power9_bhrb_filter_map,
> @@ -421,7 +421,7 @@ static struct power_pmu power9_pmu = {
>  	.name			= "POWER9",
>  	.n_counter		= MAX_PMU_COUNTERS,
>  	.add_fields		= ISA207_ADD_FIELDS,
> -	.test_adder		= P9_DD1_TEST_ADDER,
> +	.test_adder		= ISA207_TEST_ADDER,
>  	.compute_mmcr		= isa207_compute_mmcr,
>  	.config_bhrb		= power9_config_bhrb,
>  	.bhrb_filter_map	= power9_bhrb_filter_map,

Tested-by: Shriya <shriyak@linux.vnet.ibm.com>
