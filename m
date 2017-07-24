Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGHdV5dQFzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:28:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Disable registering 16G hugepage size for
 powernv platform
In-Reply-To: <1500881167-9389-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1500881167-9389-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 24 Jul 2017 20:28:13 +1000
Message-ID: <87wp6yjfia.fsf@concordia.ellerman.id.au>
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

> We don't support allocating them runtime. Only supported mechanism as of now is
> HMC based hypervisor interface. So disable 16G hugetlb on powernv platform
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>
> May be this should go to -stable ?. To show the 16G pagesize in
> /sys/kernel/mm/hugepages/ confuse users

It's a bit of a hack :/

16G also shows up on pseries, when there are no pages pre-allocated,
which is also confusing.

Ideally we'd only show sizes that can be allocated at runtime, OR were
preallocated, regardless of platform.

Is there an easy way to do that?

cheers

>  arch/powerpc/mm/hugetlbpage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index e1bf5ca397fe..28ea94da0707 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -24,6 +24,7 @@
>  #include <asm/tlb.h>
>  #include <asm/setup.h>
>  #include <asm/hugetlb.h>
> +#include <asm/machdep.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  
> @@ -749,7 +750,8 @@ static int __init add_huge_page_size(unsigned long long size)
>  				return -EINVAL;
>  		}
>  	} else {
> -		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
> +		if ((mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
> +		    || (mmu_psize == MMU_PAGE_16G && machine_is(powernv)))
>  			return -EINVAL;
>  	}
>  #endif
> -- 
> 2.7.4
