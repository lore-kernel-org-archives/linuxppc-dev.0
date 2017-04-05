Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vycCP57ZXzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 16:59:29 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 197so769623pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 23:59:29 -0700 (PDT)
Message-ID: <1491375562.28260.33.camel@gmail.com>
Subject: Re: [PATCH V2] powerpc/hugetlb: Add ABI defines for supported
 HugeTLB page sizes
From: Balbir Singh <bsingharora@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Wed, 05 Apr 2017 16:59:22 +1000
In-Reply-To: <20170405051907.18192-1-khandual@linux.vnet.ibm.com>
References: <f7208305-1aad-bc98-87e3-a8a46404c19e@linux.vnet.ibm.com>
 <20170405051907.18192-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-05 at 10:49 +0530, Anshuman Khandual wrote:
> This just adds user space exported ABI definitions for 2MB, 16MB, 1GB,
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
> Changes in V2:
> - Added definitions for 2MB and 1GB HugeTLB pages per Aneesh

I think it also helps if you mention these are used in bits 26:31 (6 bits)
to encode the size.

> 
>  arch/powerpc/include/uapi/asm/mman.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index 03c06ba..3eb788c 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -29,4 +29,9 @@
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
>  
> +#define MAP_HUGE_2MB	(21 << MAP_HUGE_SHIFT)	/* 2MB HugeTLB Page */
> +#define MAP_HUGE_16MB	(24 << MAP_HUGE_SHIFT)	/* 16MB HugeTLB Page */
> +#define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB HugeTLB Page */
> +#define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB HugeTLB Page */
> +
>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */

We may want to call out what MMU supports what size, so that an error can
be interpreted from the header file comments.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
