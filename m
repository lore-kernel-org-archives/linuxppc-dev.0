Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzXDq0M1qzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 05:03:54 +1000 (AEST)
Date: Thu, 06 Apr 2017 21:03:49 +0200
Message-ID: <20170406210349.Horde.IjWAXy6PGr_tNkSos87TqQ3@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3] powerpc/hugetlb: Add ABI defines for supported
 HugeTLB page sizes
References: <87pogrtjns.fsf@concordia.ellerman.id.au>
 <20170405112007.17390-1-khandual@linux.vnet.ibm.com>
In-Reply-To: <20170405112007.17390-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

Anshuman Khandual <khandual@linux.vnet.ibm.com> a =C3=A9crit=C2=A0:

> This just adds user space exported ABI definitions for 2MB, 16MB, 1GB,
> 16GB non default huge page sizes to be used with mmap() system call.

Why not add all possible huge page sizes ?
For instance the 8xx (only) supports 512k and 8M hugepages

Christophe

>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> These defined values will be used along with MAP_HUGETLB while calling
> mmap() system call if the desired HugeTLB page size is not the default
> one. Follows similar definitions present in x86.
>
> arch/x86/include/uapi/asm/mman.h:#define MAP_HUGE_2MB    (21 <<=20=20
>=20MAP_HUGE_SHIFT)
> arch/x86/include/uapi/asm/mman.h:#define MAP_HUGE_1GB    (30 <<=20=20
>=20MAP_HUGE_SHIFT)
>
> Changes in V3:
> - Added comment about how these defines will help create 'flags'
>   argument for mmap() system call per Balbir
>
> Changes in V2:
> - Added definitions for 2MB and 1GB HugeTLB pages per Aneesh
>
>  arch/powerpc/include/uapi/asm/mman.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/include/uapi/asm/mman.h=20=20
>=20b/arch/powerpc/include/uapi/asm/mman.h
> index 03c06ba..0c84e14 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -29,4 +29,14 @@
>  #define MAP_STACK	0x20000		/* give out an address that is best=20=20
>=20suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
>
> +/*
> + * These defines should be used for creating 'flags' argument
> + * (26:31 bits) for the mmap() system call should the caller
> + * decide to use non default HugeTLB page size.
> + */
> +#define MAP_HUGE_2MB	(21 << MAP_HUGE_SHIFT)	/* 2MB HugeTLB Page */
> +#define MAP_HUGE_16MB	(24 << MAP_HUGE_SHIFT)	/* 16MB HugeTLB Page */
> +#define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB HugeTLB Page */
> +#define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB HugeTLB Page */
> +
>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
> --
> 1.8.5.2
