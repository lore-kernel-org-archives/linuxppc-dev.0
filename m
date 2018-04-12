Return-Path: <srs0=ptyn=hb=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40M7NV3pXqzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 14:34:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40M7NV39NCz8sw1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 14:34:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40M7NT5zX6z9s1B
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2018 14:34:33 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3C4YPiV050344
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2018 00:34:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h9t60vja8-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2018 00:34:29 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 12 Apr 2018 05:34:27 +0100
Subject: Re: [PATCH v2 2/2] powerpc/fadump: Do not use hugepages when fadump
 is active
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <152336766167.8374.13811759102783227353.stgit@hbathini.in.ibm.com>
 <152336768322.8374.8580280567534579046.stgit@hbathini.in.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2018 10:04:22 +0530
MIME-Version: 1.0
In-Reply-To: <152336768322.8374.8580280567534579046.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <ddd03136-a8c6-6610-7007-b5d05d0ff0b9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2018 07:11 PM, Hari Bathini wrote:
> FADump capture kernel boots in restricted memory environment preserving
> the context of previous kernel to save vmcore. Supporting hugepages in
> such environment makes things unnecessarily complicated, as hugepages
> need memory set aside for them. This means most of the capture kernel's
> memory is used in supporting hugepages. In most cases, this results in
> out-of-memory issues while booting FADump capture kernel. But hugepages
> are not of much use in capture kernel whose only job is to save vmcore.
> So, disabling hugepages support, when fadump is active, is a reliable
> solution for the out of memory issues. Introducing a flag variable to
> disable HugeTLB support when fadump is active.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
> 
> Changes in v2:
> * Introduce a hugetlb_disabled flag to enable/disable hugepage support &
>   use that flag to disable hugepage support when fadump is active.

Looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> 
> 
>  arch/powerpc/include/asm/page.h |    1 +
>  arch/powerpc/kernel/fadump.c    |    8 ++++++++
>  arch/powerpc/mm/hash_utils_64.c |    6 ++++--
>  arch/powerpc/mm/hugetlbpage.c   |    7 +++++++
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 8da5d4c..40aee93 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -39,6 +39,7 @@
> 
>  #ifndef __ASSEMBLY__
>  #ifdef CONFIG_HUGETLB_PAGE
> +extern bool hugetlb_disabled;
>  extern unsigned int HPAGE_SHIFT;
>  #else
>  #define HPAGE_SHIFT PAGE_SHIFT
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index bea8d5f..8ceabef4 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -402,6 +402,14 @@ int __init fadump_reserve_mem(void)
>  	if (fw_dump.dump_active) {
>  		pr_info("Firmware-assisted dump is active.\n");
> 
> +#ifdef CONFIG_HUGETLB_PAGE
> +		/*
> +		 * FADump capture kernel doesn't care much about hugepages.
> +		 * In fact, handling hugepages in capture kernel is asking for
> +		 * trouble. So, disable HugeTLB support when fadump is active.
> +		 */
> +		hugetlb_disabled = true;
> +#endif
>  		/*
>  		 * If last boot has crashed then reserve all the memory
>  		 * above boot_memory_size so that we don't touch it until
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index cf290d41..eab8f1d 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -571,8 +571,10 @@ static void __init htab_scan_page_sizes(void)
>  	}
> 
>  #ifdef CONFIG_HUGETLB_PAGE
> -	/* Reserve 16G huge page memory sections for huge pages */
> -	of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
> +	if (!hugetlb_disabled) {
> +		/* Reserve 16G huge page memory sections for huge pages */
> +		of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
> +	}
>  #endif /* CONFIG_HUGETLB_PAGE */
>  }
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 876da2b..18c080a 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -35,6 +35,8 @@
>  #define PAGE_SHIFT_16M	24
>  #define PAGE_SHIFT_16G	34
> 
> +bool hugetlb_disabled = false;
> +
>  unsigned int HPAGE_SHIFT;
>  EXPORT_SYMBOL(HPAGE_SHIFT);
> 
> @@ -653,6 +655,11 @@ static int __init hugetlbpage_init(void)
>  {
>  	int psize;
> 
> +	if (hugetlb_disabled) {
> +		pr_info("HugeTLB support is disabled!\n");
> +		return 0;
> +	}
> +
>  #if !defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_PPC_8xx)
>  	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
>  		return -ENODEV;
> 
