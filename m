Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2SWB0fTvzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:26:45 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v654NuXX117420
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:26:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bg9tq5pv0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 00:26:43 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Jul 2017 22:26:42 -0600
Subject: Re: [PATCH] powerpc/mm: Implemented default_hugepagesz verification
 for powerpc
To: Victor Aoqui <victora@br.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: victora@linux.vnet.ibm.com
References: <20170703200559.3743-1-victora@br.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 09:56:30 +0530
MIME-Version: 1.0
In-Reply-To: <20170703200559.3743-1-victora@br.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1f549637-773a-868c-effd-5614e85aa892@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 July 2017 01:35 AM, Victor Aoqui wrote:
> Implemented default hugepage size verification (default_hugepagesz=)
> in order to allow allocation of defined number of pages (hugepages=)
> only for supported hugepage sizes.
> 
> Signed-off-by: Victor Aoqui <victora@br.ibm.com>
> ---
>   arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a4f33de..464e72e 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -797,6 +797,21 @@ static int __init hugepage_setup_sz(char *str)
>   }
>   __setup("hugepagesz=", hugepage_setup_sz);
> 
> +static int __init default_hugepage_setup_sz(char *str)
> +{
> +        unsigned long long size;
> +
> +        size = memparse(str, &str);
> +
> +        if (add_huge_page_size(size) != 0) {
> +                hugetlb_bad_size();
> +                pr_err("Invalid default huge page size specified(%llu)\n", size);
> +        }
> +
> +        return 1;
> +}
> +__setup("default_hugepagesz=", default_hugepage_setup_sz);

isn't that a behavior change in what we have now ? . Right now if size 
specified is not supported, we fallback to HPAGE_SIZE.

mm/hugetlb.c

	if (!size_to_hstate(default_hstate_size)) {
		default_hstate_size = HPAGE_SIZE;
		if (!size_to_hstate(default_hstate_size))
			hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
	}


> +
>   struct kmem_cache *hugepte_cache;
>   static int __init hugetlbpage_init(void)
>   {
> 

Even if we want to do this, this should be done in generic code and 
should not be powerpc specific

-aneesh
