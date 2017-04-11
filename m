Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2NVZ63yfzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:25:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 6/7] powerpc/hugetlb: Add code to support to follow
 huge page directory entries
In-Reply-To: <1491314675-15787-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1491314675-15787-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 20:25:41 +1000
Message-ID: <87shlfutp6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Add follow_huge_pd implementation for ppc64.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 80f6d2ed551a..9d66d4f810aa 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -17,6 +17,8 @@
>  #include <linux/memblock.h>
>  #include <linux/bootmem.h>
>  #include <linux/moduleparam.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
> @@ -618,6 +620,10 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  }
>  
>  /*
> + * 64 bit book3s use generic follow_page_mask
> + */
> +#ifndef CONFIG_PPC_BOOK3S_64

I think it's always easier to follow if you use:

  #ifdef x
  ...
  #else /* !x */
  ...
  #endif

ie. in this case put the Book3S 64 case first and the existing code in the
#else.

cheers
