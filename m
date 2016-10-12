Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sv5Hh5cc2zDsrf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 18:35:27 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r16so2159910pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 00:35:27 -0700 (PDT)
Received: from balbir.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id z123sm9264910pfz.60.2016.10.12.00.35.24
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Oct 2016 00:35:25 -0700 (PDT)
Subject: Re: [PATCH] powerpc/64: option to force run-at-load to test relocation
To: linuxppc-dev@lists.ozlabs.org
References: <20161012065719.29833-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <ad8e59d1-57fb-56c9-c2cf-d284835d9288@gmail.com>
Date: Wed, 12 Oct 2016 18:35:21 +1100
MIME-Version: 1.0
In-Reply-To: <20161012065719.29833-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/10/16 17:57, Nicholas Piggin wrote:
> This adds a config option that can help exercise the case when
> the kernel is not running at PAGE_OFFSET.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Kconfig               | 9 +++++++++
>  arch/powerpc/kernel/head_64.S      | 4 ++++
>  arch/powerpc/kernel/setup-common.c | 3 +++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 65fba4c..5d43cb8 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -478,6 +478,15 @@ config RELOCATABLE
>  	  setting can still be useful to bootwrappers that need to know the
>  	  load address of the kernel (eg. u-boot/mkimage).
>  
> +config RELOCATABLE_TEST
> +	bool "Test relocatable kernel"
> +	depends on (PPC64 && RELOCATABLE)
> +	default n
> +	help
> +	  This runs the relocatable kernel at the address it was initially
> +	  loaded at, which tends to be non-zero and therefore test the
> +	  relocation code.
> +
>  config CRASH_DUMP
>  	bool "Build a kdump crash kernel"
>  	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 79da0641..bc9ceac 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -111,8 +111,12 @@ __secondary_hold_acknowledge:
>  	.globl	__run_at_load
>  __run_at_load:
>  DEFINE_FIXED_SYMBOL(__run_at_load)
> +#ifdef CONFIG_RELOCATABLE_TEST
> +	.long	0x1		/* Test relocation, do not relocate to 0 */
> +#else
>  	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
>  #endif
> +#endif

Could we do something like

config RELOCATION_VALUE
	default 0x72756e30
	default	1  if CONFIG_RELOCTABLE_TEST

and then get

	.long CONFIG_RELOCATION_VALUE


	

>  
>  	. = 0x60
>  /*
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index dba265c..18e0f19 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -795,6 +795,9 @@ static __init void print_system_info(void)
>  	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
>  #ifdef CONFIG_PPC64
>  	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
> +
> +	if (get_paca()->kernelbase != PAGE_OFFSET)
> +		pr_info("kernelbase        = 0x%llx\n", get_paca()->kernelbase);
>  #endif
>  

Do we need this? We get physical_offset if we are relocated.

>  #ifdef CONFIG_PPC_STD_MMU_64
> 

Balbir Singh.
