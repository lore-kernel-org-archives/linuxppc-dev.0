Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4E51A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 20:48:43 +1100 (AEDT)
In-Reply-To: <1443796428-11517-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc: Fix _ALIGN_* errors due to type difference.
Message-Id: <20151006094843.C8ECF140D71@ozlabs.org>
Date: Tue,  6 Oct 2015 20:48:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-10 at 14:33:48 UTC, "Aneesh Kumar K.V" wrote:
> This avoid errors like
> 
>         unsigned int usize = 1 << 30;
>         int size = 1 << 30;
>         unsigned long addr = 64UL << 30 ;
> 
>         value = _ALIGN_DOWN(addr, usize); -> 0
>         value = _ALIGN_DOWN(addr, size);  -> 0x1000000000

Are you actually seeing that anywhere? I assume not.

> diff --git a/arch/powerpc/boot/page.h b/arch/powerpc/boot/page.h
> index 14eca30fef64..87c42d7d283d 100644
> --- a/arch/powerpc/boot/page.h
> +++ b/arch/powerpc/boot/page.h
> @@ -22,8 +22,8 @@
>  #define PAGE_MASK	(~(PAGE_SIZE-1))
>  
>  /* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
> -#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
> +#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
> +#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
>  
>  /* align addr on a size boundary - adjust address up if needed */
>  #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 71294a6e976e..1dd69774a31c 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -240,8 +240,8 @@ extern long long virt_phys_offset;
>  #endif
>  
>  /* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
> -#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
> +#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
> +#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))


It looks like ALIGN() in kernel.h already does this right, so can we just use
that instead for _ALIGN_UP() at least.

cheers
