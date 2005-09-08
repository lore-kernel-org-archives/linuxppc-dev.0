Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0509071354270.31849@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0509071354270.31849@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F2C8C7A1-55A5-4872-8C11-9C9957FB1AEA@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 15:32:40 -0500
To: "Gala Kumar K.-galak" <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc: Moved ASM_CONST macro into ppc_asm.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, this patch breaks thinks since ppc_asm.h really needs a hugh  
__ASSEMBLY__ protection for most of it.

I'll send an updated patch that also moves ppc_asm.h into include/asm- 
powerpc once we close on the non-volatile issue with r13 between  
ppc32/64.

- kumar

On Sep 7, 2005, at 1:55 PM, Gala Kumar K.-galak wrote:

> Moved the ASM_CONST macro into ppc_asm for ppc32 and ppc64 since that
> seems like a much better place for it long term.  Also, by adding the
> macro to ppc32 it will ease some future merging of code into
> arch/powerpc.
>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
> commit f56255eddd631902e3835bf7cdd8d94e69799097
> tree 82c222d64fdccbaed25e302816fd4cf6237e8d56
> parent 71c22e7cc4bf30119761b60b26c498d7b9d33e36
> author Kumar K. Gala <kumar.gala@freescale.com> Wed, 07 Sep 2005
> 13:53:35 -0500
> committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 07 Sep 2005
> 13:53:35 -0500
>
>  include/asm-ppc/ppc_asm.h    |   12 ++++++++++++
>  include/asm-ppc64/cputable.h |    2 +-
>  include/asm-ppc64/mmu.h      |    1 +
>  include/asm-ppc64/page.h     |    8 +-------
>  include/asm-ppc64/ppc_asm.h  |    7 +++++++
>  5 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/include/asm-ppc/ppc_asm.h b/include/asm-ppc/ppc_asm.h
> --- a/include/asm-ppc/ppc_asm.h
> +++ b/include/asm-ppc/ppc_asm.h
> @@ -11,6 +11,9 @@
>   *  2 of the License, or (at your option) any later version.
>   */
>
> +#ifndef __PPC_ASM_H
> +#define __PPC_ASM_H
> +
>  #include <linux/config.h>
>
>  /*
> @@ -348,3 +351,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
>  #define N_RSYM    64
>  #define N_SLINE    68
>  #define N_SO    100
> +
> +#ifdef __ASSEMBLY__
> +  #define ASM_CONST(x) x
> +#else
> +  #define __ASM_CONST(x) x##UL
> +  #define ASM_CONST(x) __ASM_CONST(x)
> +#endif
> +
> +#endif /* __PPC_ASM_H */
> diff --git a/include/asm-ppc64/cputable.h b/include/asm-ppc64/ 
> cputable.h
> --- a/include/asm-ppc64/cputable.h
> +++ b/include/asm-ppc64/cputable.h
> @@ -16,7 +16,7 @@
>  #define __ASM_PPC_CPUTABLE_H
>
>  #include <linux/config.h>
> -#include <asm/page.h> /* for ASM_CONST */
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
>
>  /* Exposed to userland CPU features - Must match ppc32 definitions */
>  #define PPC_FEATURE_32            0x80000000
> diff --git a/include/asm-ppc64/mmu.h b/include/asm-ppc64/mmu.h
> --- a/include/asm-ppc64/mmu.h
> +++ b/include/asm-ppc64/mmu.h
> @@ -14,6 +14,7 @@
>  #define _PPC64_MMU_H_
>
>  #include <linux/config.h>
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
>  #include <asm/page.h>
>
>  /*
> diff --git a/include/asm-ppc64/page.h b/include/asm-ppc64/page.h
> --- a/include/asm-ppc64/page.h
> +++ b/include/asm-ppc64/page.h
> @@ -11,13 +11,7 @@
>   */
>
>  #include <linux/config.h>
> -
> -#ifdef __ASSEMBLY__
> -  #define ASM_CONST(x) x
> -#else
> -  #define __ASM_CONST(x) x##UL
> -  #define ASM_CONST(x) __ASM_CONST(x)
> -#endif
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
>
>  /* PAGE_SHIFT determines the page size */
>  #define PAGE_SHIFT    12
> diff --git a/include/asm-ppc64/ppc_asm.h b/include/asm-ppc64/ppc_asm.h
> --- a/include/asm-ppc64/ppc_asm.h
> +++ b/include/asm-ppc64/ppc_asm.h
> @@ -239,4 +239,11 @@
>  #define    vr30    30
>  #define    vr31    31
>
> +#ifdef __ASSEMBLY__
> +  #define ASM_CONST(x) x
> +#else
> +  #define __ASM_CONST(x) x##UL
> +  #define ASM_CONST(x) __ASM_CONST(x)
> +#endif
> +
>  #endif /* _PPC64_PPC_ASM_H */
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev
>
