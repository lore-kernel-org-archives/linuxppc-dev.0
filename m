Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDMGm173ZzDqqN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 17:05:19 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6L73rKI065113
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 03:05:17 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu84ms90h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 03:05:17 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 17:05:15 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6L75BS726869856
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 17:05:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6L759tc002214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 17:05:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Victor Aoqui <victora@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com
Cc: victora@br.ibm.com, victora@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc/mm: Implemented default_hugepagesz
 verification for powerpc
In-Reply-To: <20170720165838.3549-1-victora@linux.vnet.ibm.com>
References: <20170720165838.3549-1-victora@linux.vnet.ibm.com>
Date: Fri, 21 Jul 2017 12:35:08 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8y6p8wr.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Victor Aoqui <victora@linux.vnet.ibm.com> writes:

> Implemented default hugepage size verification (default_hugepagesz=)
> in order to allow allocation of defined number of pages (hugepages=)
> only for supported hugepage sizes.
>
> Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
> ---
> v2:
>
> - Renamed default_hugepage_setup_sz function to hugetlb_default_size_setup;
>
> - Added powerpc string to error message.
>
>  arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index e1bf5ca..3a142fe 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -780,6 +780,21 @@ static int __init hugepage_setup_sz(char *str)
>  }
>  __setup("hugepagesz=", hugepage_setup_sz);
>
> +static int __init hugetlb_default_size_setup(char *str)
> +{
> +	unsigned long long size;
> +
> +	size = memparse(str, &str);
> +
> +	if (add_huge_page_size(size) != 0) {
> +		hugetlb_bad_size();
> +		pr_err("Invalid powerpc default huge page size specified(%llu)\n", size);
> +	}
> +
> +	return 1;
> +}
> +__setup("default_hugepagesz=", hugetlb_default_size_setup);
> +

this means we don't core the core function hugetlb_default_setup().
Hence the value default_hstate_size = 0  which means different value
for default_hstate_idx. We use that for hugetlbfs mount. 

>  struct kmem_cache *hugepte_cache;
>  static int __init hugetlbpage_init(void)
>  {
> -- 
> 1.8.3.1
