Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2Sfc26YwzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:33:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v654T04K121224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:33:10 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j7cg14-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 00:33:09 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Jul 2017 22:33:09 -0600
Subject: Re: [PATCH] powerpc/mm: Check gigantic page range correctly inside
 memblock
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170703073130.27258-1-khandual@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 10:03:04 +0530
MIME-Version: 1.0
In-Reply-To: <20170703073130.27258-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <aa292524-c075-26ea-78ea-ce9e539e9ce9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 03 July 2017 01:01 PM, Anshuman Khandual wrote:
> The gigantic page range received from platform actually extends
> upto (block_size * expeted_pages) starting at any given address
> instead of just a single 16GB page.
> 
> Fixes: 4792adbac9eb ("powerpc: Don't use a 16G page if beyond mem= limits")
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Though in actual experiments never seen multiple gigantic pages (16GB)
> starting at the same address. But again its very much possible looking
> at the device tree property interfaces and depending upon what PowerVM
> provides.
> 
>   arch/powerpc/mm/hash_utils_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index f2095ce..a3f1e7d 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -507,7 +507,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
>   	printk(KERN_INFO "Huge page(16GB) memory: "
>   			"addr = 0x%lX size = 0x%lX pages = %d\n",
>   			phys_addr, block_size, expected_pages);
> -	if (phys_addr + (16 * GB) <= memblock_end_of_DRAM()) {
> +	if (phys_addr + block_size * expected_pages <= memblock_end_of_DRAM()) {
>   		memblock_reserve(phys_addr, block_size * expected_pages);
>   		add_gpage(phys_addr, block_size, expected_pages);
>   	}
> 

This was already posted by another person.

https://lkml.kernel.org/r/20170112090906.17864-1-rui.teng@linux.vnet.ibm.com


-aneesh
