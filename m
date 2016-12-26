Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tn6RY3pfwzDsyJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 16:06:49 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBQ53keW138814
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 00:06:47 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27jmnkvrjg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 00:06:46 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 26 Dec 2016 10:36:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2AD471258063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 10:38:01 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBQ56exL29163718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 10:36:40 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBQ56dGg001541
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 10:36:40 +0530
Subject: Re: [PATCH 2/2] powerpc/perf: support new BHRB filtering modes
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1482559353-22015-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482559353-22015-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 26 Dec 2016 10:36:34 +0530
MIME-Version: 1.0
In-Reply-To: <1482559353-22015-2-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5860A55A.2090205@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/24/2016 11:32 AM, Madhavan Srinivasan wrote:
> Add support for new BHRB filtering modes in
> power9. Patch updates the some of the branch types
> based on "Programming Note" information from
> PowerISA v3.0 "BHRB Filtering" section.

Please reformat, reword, align the commit paragraph and provide more details.

> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/power9-pmu.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
> index 56ad09801fff..7165f18934df 100644
> --- a/arch/powerpc/perf/power9-pmu.c
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -102,6 +102,11 @@ enum {
>  #define POWER9_MMCRA_IFM1		0x0000000040000000UL
>  #define POWER9_MMCRA_IFM2		0x0000000080000000UL
>  #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
> +#define POWER9_MMCRA_FJ			0x0000000100000000UL
> +#define POWER9_MMCRA_FR			0x0000000200000000UL
> +#define POWER9_MMCRA_FC			0x0000000400000000UL
> +#define POWER9_MMCRA_FU			0x0000000800000000UL
> +#define POWER9_MMCRA_FD			0x0000001000000000UL

This requires more explanation on what kind of filtering they do and how.
Also it will be a good idea to explain the existing IFM1, IFM2, IFM3
filters as well.

> 
>  /* PowerISA v2.07 format attribute structure*/
>  extern struct attribute_group isa207_pmu_format_group;
> @@ -240,14 +245,30 @@ static u64 power9_bhrb_filter_map(u64 branch_sample_type)
>  		return pmu_bhrb_filter;
> 
>  	/* Invalid branch filter options - HW does not support */
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
> -		return -1;
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN) {
> +		pmu_bhrb_filter = POWER9_MMCRA_FC | POWER9_MMCRA_FJ;
> +		return pmu_bhrb_filter;
> +	}
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL) {
> +		pmu_bhrb_filter = POWER9_MMCRA_FD | POWER9_MMCRA_FR | POWER9_MMCRA_FJ;
> +		return pmu_bhrb_filter;
> +	}
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
> +		pmu_bhrb_filter = POWER9_MMCRA_FU;
> +		return pmu_bhrb_filter;
> +	}
> 
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
> -		return -1;
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_JUMP) {
> +		pmu_bhrb_filter = POWER9_MMCRA_FD | POWER9_MMCRA_FC | POWER9_MMCRA_FR;
> +		return pmu_bhrb_filter;
> +	}
> 
> -	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
> -		return -1;
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL) {
> +		pmu_bhrb_filter = POWER9_MMCRA_FC;
> +		return pmu_bhrb_filter;
> +	}

May be we can define something like POWER9_BHRB_FILTER_BRANCH_IND_JUMP as
(POWER9_MMCRA_FD | POWER9_MMCRA_FC | POWER9_MMCRA_FR) for all the filters
and use it instead.
