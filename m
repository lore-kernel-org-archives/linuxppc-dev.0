Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tn61k444KzDsxb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:47:54 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBQ4hcWH020033
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Dec 2016 23:47:51 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27jtnxkaeu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Dec 2016 23:47:51 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 26 Dec 2016 14:47:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5877C2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:47:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBQ4ljq857016462
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:47:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBQ4liis000421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:47:45 +1100
Subject: Re: [PATCH 1/2] powerpc/perf: Factor out bhrb functions
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1482559353-22015-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 26 Dec 2016 10:17:38 +0530
MIME-Version: 1.0
In-Reply-To: <1482559353-22015-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5860A0EA.7090108@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/24/2016 11:32 AM, Madhavan Srinivasan wrote:
> Factor out the bhrb functions to "isa207-common.c"
> to share with power9. Only code movement and no logic change

POWER9 is ISA 3.0, so dont you think the common code should not be in
a file named with "ISA 2.07" unless its going to be the same for both
POWER8 and POWER9 which is not the case here.

> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/isa207-common.c | 41 ++++++++++++++++++++++++++++++++
>  arch/powerpc/perf/isa207-common.h |  9 +++++++
>  arch/powerpc/perf/power8-pmu.c    | 49 ++-------------------------------------
>  arch/powerpc/perf/power9-pmu.c    |  4 ++--
>  4 files changed, 54 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index 50e598cf644b..ee4e3e89c04c 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -338,3 +338,44 @@ void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[])
>  	if (pmc <= 3)
>  		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
>  }
> +
> +u64 isa207_bhrb_filter_map(u64 branch_sample_type)
> +{
> +	u64 pmu_bhrb_filter = 0;
> +
> +	/* BHRB and regular PMU events share the same privilege state
> +	 * filter configuration. BHRB is always recorded along with a
> +	 * regular PMU event. As the privilege state filter is handled
> +	 * in the basic PMC configuration of the accompanying regular
> +	 * PMU event, we ignore any separate BHRB specific request.
> +	 */
> +
> +	/* No branch filter requested */
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> +		return pmu_bhrb_filter;
> +
> +	/* Invalid branch filter options - HW does not support */
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
> +		return -1;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
> +		return -1;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
> +		return -1;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
> +		pmu_bhrb_filter |= MMCRA_IFM1;
> +		return pmu_bhrb_filter;
> +	}
> +
> +	/* Every thing else is unsupported */
> +	return -1;
> +}
> +
> +void isa207_config_bhrb(u64 pmu_bhrb_filter)
> +{
> +	/* Enable BHRB filter in PMU */
> +	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
> +}
> +
> diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
> index 90495f1580c7..e5e4182731da 100644
> --- a/arch/powerpc/perf/isa207-common.h
> +++ b/arch/powerpc/perf/isa207-common.h
> @@ -244,6 +244,12 @@
>  #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
>  #define MMCRA_IFM_SHIFT			30
> 
> +/* MMCRA IFM bits */
> +#define MMCRA_IFM1		0x0000000040000000UL
> +#define MMCRA_IFM2		0x0000000080000000UL
> +#define MMCRA_IFM3		0x00000000C0000000UL
> +
> +
>  /* MMCR1 Threshold Compare bit constant for power9 */
>  #define p9_MMCRA_THR_CMP_SHIFT	45
> 
> @@ -261,4 +267,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
>  				struct perf_event *pevents[]);
>  void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
> 
> +u64 isa207_bhrb_filter_map(u64 branch_sample_type);
> +void isa207_config_bhrb(u64 pmu_bhrb_filter);
> +
>  #endif
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index d07186382f3a..91120bec4173 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -25,11 +25,6 @@ enum {
> 
>  #undef EVENT
> 
> -/* MMCRA IFM bits - POWER8 */
> -#define	POWER8_MMCRA_IFM1		0x0000000040000000UL
> -#define	POWER8_MMCRA_IFM2		0x0000000080000000UL
> -#define	POWER8_MMCRA_IFM3		0x00000000C0000000UL
> -
>  /* PowerISA v2.07 format attribute structure*/
>  extern struct attribute_group isa207_pmu_format_group;
> 
> @@ -195,46 +190,6 @@ static int power8_generic_events[] = {
>  	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1,
>  };
> 
> -static u64 power8_bhrb_filter_map(u64 branch_sample_type)
> -{
> -	u64 pmu_bhrb_filter = 0;
> -
> -	/* BHRB and regular PMU events share the same privilege state
> -	 * filter configuration. BHRB is always recorded along with a
> -	 * regular PMU event. As the privilege state filter is handled
> -	 * in the basic PMC configuration of the accompanying regular
> -	 * PMU event, we ignore any separate BHRB specific request.
> -	 */
> -
> -	/* No branch filter requested */
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> -		return pmu_bhrb_filter;
> -
> -	/* Invalid branch filter options - HW does not support */
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
> -		return -1;
> -
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
> -		return -1;
> -
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
> -		return -1;
> -
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
> -		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
> -		return pmu_bhrb_filter;
> -	}
> -
> -	/* Every thing else is unsupported */
> -	return -1;
> -}
> -
> -static void power8_config_bhrb(u64 pmu_bhrb_filter)
> -{
> -	/* Enable BHRB filter in PMU */
> -	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
> -}
> -
>  #define C(x)	PERF_COUNT_HW_CACHE_##x
> 
>  /*
> @@ -352,8 +307,8 @@ static struct power_pmu power8_pmu = {
>  	.add_fields		= ISA207_ADD_FIELDS,
>  	.test_adder		= ISA207_TEST_ADDER,
>  	.compute_mmcr		= isa207_compute_mmcr,
> -	.config_bhrb		= power8_config_bhrb,
> -	.bhrb_filter_map	= power8_bhrb_filter_map,
> +	.config_bhrb		= isa207_config_bhrb,
> +	.bhrb_filter_map	= isa207_bhrb_filter_map,

This is alright. But

>  	.get_constraint		= isa207_get_constraint,
>  	.get_alternatives	= power8_get_alternatives,
>  	.disable_pmc		= isa207_disable_pmc,
> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
> index 346010e8d463..56ad09801fff 100644
> --- a/arch/powerpc/perf/power9-pmu.c
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -380,8 +380,8 @@ static struct power_pmu power9_isa207_pmu = {
>  	.add_fields		= ISA207_ADD_FIELDS,
>  	.test_adder		= ISA207_TEST_ADDER,
>  	.compute_mmcr		= isa207_compute_mmcr,
> -	.config_bhrb		= power9_config_bhrb,
> -	.bhrb_filter_map	= power9_bhrb_filter_map,
> +	.config_bhrb		= isa207_config_bhrb,
> +	.bhrb_filter_map	= isa207_bhrb_filter_map,

this is not. We are going to change the BHRB filter map for POWER9 with
additional stuff and the common function here can not be used on both
the processors.
