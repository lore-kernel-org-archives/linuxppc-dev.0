Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy2Lc1Zg4zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 18:33:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v348ORgZ042435
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 04:33:36 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m51m96c3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 04:33:36 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 04:33:35 -0400
Subject: Re: [PATCH] powerpc/hugetlb: Add ABI defines for MAP_HUGE_16MB and
 MAP_HUGE_16GB
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170404060310.7588-1-khandual@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 4 Apr 2017 14:03:29 +0530
MIME-Version: 1.0
In-Reply-To: <20170404060310.7588-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <64a8341c-653f-ad59-009e-90cf49dcf551@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 April 2017 11:33 AM, Anshuman Khandual wrote:
> This just adds user space exported ABI definitions for both 16MB and
> 16GB non default huge page sizes to be used with mmap() system call.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> These defined values will be used along with MAP_HUGETLB while calling
> mmap() system call if the desired HugeTLB page size is not the default
> one. Follows similar definitions present in x86.
>
> arch/x86/include/uapi/asm/mman.h:#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
> arch/x86/include/uapi/asm/mman.h:#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
>
>  arch/powerpc/include/uapi/asm/mman.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index 03c06ba..e78980b 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -29,4 +29,7 @@
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
>
> +#define MAP_HUGE_16MB	(24 << MAP_HUGE_SHIFT)	/* 16MB HugeTLB Page */
> +#define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB HugeTLB Page */
> +
>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
>

I am doing a similar patch as part of 1G and hugetlb migration series. 
Can you add 2M and 1G #defines also so that i can drop the patch from my 
series and pick this ?

-aneesh
