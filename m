Return-Path: <chombourger@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by ozlabs.org (Postfix) with ESMTP id 06DC4DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 18:28:28 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so611637mue
	for <linuxppc-dev@ozlabs.org>; Thu, 06 Dec 2007 23:28:27 -0800 (PST)
Message-ID: <4758F616.4050107@gmail.com>
Date: Fri, 07 Dec 2007 08:28:22 +0100
From: Cedric Hombourger <chombourger@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix swapper_pg_dir size when CONFIG_PTE_64BIT=y
	on FSL_BOOKE
References: <Pine.LNX.4.64.0712061312510.18193@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0712061312510.18193@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thanks Kumar for this much better patch!

Cedric

Kumar Gala wrote:
> The size of swapper_pg_dir is 8k instead of 4k when using 64-bit PTEs
> (CONFIG_PTE_64BIT).
>
> This was reported by Cedric Hombourger <chombourger@gmail.com>
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>
> This is in my git tree, branch for-2.6.24 and I'll forward on a pull
> request to Paul & Linus for it.
>
>  arch/powerpc/kernel/asm-offsets.c    |    3 +--
>  arch/powerpc/kernel/head_32.S        |    2 +-
>  arch/powerpc/kernel/head_40x.S       |    2 +-
>  arch/powerpc/kernel/head_44x.S       |    2 +-
>  arch/powerpc/kernel/head_fsl_booke.S |    2 +-
>  include/asm-powerpc/pgtable-ppc32.h  |    5 +++++
>  6 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index d67bcd8..ed083fe 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -326,8 +326,7 @@ int main(void)
>  	DEFINE(VMALLOC_START_VSID, KERNEL_VSID(VMALLOC_START));
>  #endif
>
> -#ifdef CONFIG_PPC64
>  	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
> -#endif
> +
>  	return 0;
>  }
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index a5b13ae..0f4fac5 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -1311,7 +1311,7 @@ empty_zero_page:
>
>  	.globl	swapper_pg_dir
>  swapper_pg_dir:
> -	.space	4096
> +	.space	PGD_TABLE_SIZE
>
>  	.globl intercept_table
>  intercept_table:
> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index cfefc2d..8552e67 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -994,7 +994,7 @@ empty_zero_page:
>  	.space	4096
>  	.globl	swapper_pg_dir
>  swapper_pg_dir:
> -	.space	4096
> +	.space	PGD_TABLE_SIZE
>
>
>  /* Stack for handling critical exceptions from kernel mode */
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index 409db61..56aba84 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -722,7 +722,7 @@ empty_zero_page:
>   */
>  	.globl	swapper_pg_dir
>  swapper_pg_dir:
> -	.space	8192
> +	.space	PGD_TABLE_SIZE
>
>  /* Reserved 4k for the critical exception stack & 4k for the machine
>   * check stack per CPU for kernel mode exceptions */
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index 4b98227..7aecb39 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -1035,7 +1035,7 @@ empty_zero_page:
>  	.space	4096
>  	.globl	swapper_pg_dir
>  swapper_pg_dir:
> -	.space	4096
> +	.space	PGD_TABLE_SIZE
>
>  /* Reserved 4k for the critical exception stack & 4k for the machine
>   * check stack per CPU for kernel mode exceptions */
> diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
> index fea2d8f..d1332bb 100644
> --- a/include/asm-powerpc/pgtable-ppc32.h
> +++ b/include/asm-powerpc/pgtable-ppc32.h
> @@ -86,6 +86,11 @@ extern int icache_44x_need_flush;
>   * entries per page directory level: our page-table tree is two-level, so
>   * we don't really have any PMD directory.
>   */
> +#ifndef __ASSEMBLY__
> +#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_SHIFT)
> +#define PGD_TABLE_SIZE	(sizeof(pgd_t) << (32 - PGDIR_SHIFT))
> +#endif	/* __ASSEMBLY__ */
> +
>  #define PTRS_PER_PTE	(1 << PTE_SHIFT)
>  #define PTRS_PER_PMD	1
>  #define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
>   
