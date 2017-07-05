Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2Scx1rbdzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:31:45 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v654ShjF107328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:31:42 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bgapu9es9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 00:31:42 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 14:31:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v654VYHx4784616
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 14:31:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v654VXW2017561
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 14:31:33 +1000
Subject: Re: [PATCH] powerpc/mm: Implemented default_hugepagesz verification
 for powerpc
To: Victor Aoqui <victora@br.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 mpe@ellerman.id.au
References: <20170703200559.3743-1-victora@br.ibm.com>
Cc: victora@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 10:01:26 +0530
MIME-Version: 1.0
In-Reply-To: <20170703200559.3743-1-victora@br.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4d5950e6-d208-b8d1-ffee-6e54c741c8e0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2017 01:35 AM, Victor Aoqui wrote:
> Implemented default hugepage size verification (default_hugepagesz=)
> in order to allow allocation of defined number of pages (hugepages=)
> only for supported hugepage sizes.
> 
> Signed-off-by: Victor Aoqui <victora@br.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a4f33de..464e72e 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -797,6 +797,21 @@ static int __init hugepage_setup_sz(char *str)
>  }
>  __setup("hugepagesz=", hugepage_setup_sz);
> 
> +static int __init default_hugepage_setup_sz(char *str)

The function name should be hugetlb_default_size_setup in
sync with the generic function hugetlb_default_setup for the
same parameter default_hugepagesz.

> +{
> +        unsigned long long size;
> +
> +        size = memparse(str, &str);
> +
> +        if (add_huge_page_size(size) != 0) {

I am little bit confused here. Do we always follow another
'hugepages=' element after 'default_hugepagesz' ? If not,
then we dont have to do 'add_huge_page_size'. But then
that function checks for valid huge page sizes and skips
adding hstate if its already added. So I guess it okay.

> +                hugetlb_bad_size();
> +                pr_err("Invalid default huge page size specified(%llu)\n", size);

Error message should have 'ppc' some where to indicate that
the arch rejected the size not core MM.
