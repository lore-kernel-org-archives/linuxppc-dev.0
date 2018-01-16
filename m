Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLZvw0fgGzF0WN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:11:07 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0GG9UNF106911
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:11:05 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhku9b66y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:11:04 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 16:11:02 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps
 with slice
In-Reply-To: <20180109101810.2471D6C6CF@localhost.localdomain>
References: <20180109101810.2471D6C6CF@localhost.localdomain>
Date: Tue, 16 Jan 2018 21:33:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp0haizf.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> An application running with libhugetlbfs fails to allocate
> additional pages to HEAP due to the hugemap being done
> inconditionally as topdown mapping:
>
> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
> [...]
> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
> munmap(0x73d80000, 1048576)             = 0
> [...]
> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
> munmap(0x73d00000, 1572864)             = 0
> [...]
> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
> munmap(0x73d00000, 1572864)             = 0
> [...]
>

Can you explain the failure details above. I am not sure I understand
what to read from the above output.

> As one can see from the above strace log, mmap() allocates further
> pages below the initial one.
>
> This patch fixes it by taking into account MAP_GROWSDOWN flag.

Rest of the kernel don't depend on that flag to select a topdown search
or not. So what is special with hugetlb? IF we select legacy mmap that
is when we select a bottomup search. Hugetlb on ppc64 always did a
topdown search.

>
> Fixes: d0f13e3c20b6f ("[POWERPC] Introduce address space "slices" ")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Added missing include
>
>  arch/powerpc/mm/hugetlbpage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 79e1378ee303..0eadf9f199de 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -19,6 +19,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> +#include <linux/mman.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
> @@ -558,7 +559,8 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  		return radix__hugetlb_get_unmapped_area(file, addr, len,
>  						       pgoff, flags);
>  #endif
> -	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
> +	return slice_get_unmapped_area(addr, len, flags, mmu_psize,
> +				       flags & MAP_GROWSDOWN);
>  }
>  #endif
>  
> -- 
> 2.13.3
