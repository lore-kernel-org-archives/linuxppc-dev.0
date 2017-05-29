Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcBHm23tBzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 08:29:40 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n23so13660309pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 15:29:40 -0700 (PDT)
Message-ID: <1496096943.21894.13.camel@gmail.com>
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 30 May 2017 08:29:03 +1000
In-Reply-To: <20170511112441.30287-1-npiggin@gmail.com>
References: <20170511112441.30287-1-npiggin@gmail.com>
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

On Thu, 2017-05-11 at 21:24 +1000, Nicholas Piggin wrote:
> Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
> feature discovery, and fall back to the "cputable" based version.
> 
> Also allow control of advertising unknown features to userspace and
> with this parameter, and remove the clunky CONFIG option.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++++
>  arch/powerpc/Kconfig                            |  5 ---
>  arch/powerpc/kernel/dt_cpu_ftrs.c               | 41 +++++++++++++++++++------
>  3 files changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index facc20a3f962..7a7c1cc80f9f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -867,6 +867,16 @@
>  
>  	dscc4.setup=	[NET]
>  
> +	dt_cpu_ftrs=	[PPC]
> +			Format: {"off" | "known"}
> +			Control how the dt_cpu_ftrs device-tree binding is
> +			used for CPU feature discovery and setup (if it
> +			exists).
> +			off: Do not use it, fall back to legacy cpu table.
> +			known: Do not pass through unknown features to guests
> +			or userspace, only those that the kernel is not aware
> +			of.
> +
>  	dump_apple_properties	[X86]
>  			Dump name and content of EFI device properties on
>  			x86 Macs.  Useful for driver authors to determine
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5bd868f2e813..c924710e5bc7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -391,11 +391,6 @@ config PPC_DT_CPU_FTRS
>  	  firmware provides this binding.
>  	  If you're not sure say Y.
>  
> -config PPC_CPUFEATURES_ENABLE_UNKNOWN
> -	bool "cpufeatures pass through unknown features to guest/userspace"
> -	depends on PPC_DT_CPU_FTRS
> -	default y
> -
>  config HIGHMEM
>  	bool "High memory support"
>  	depends on PPC32
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index fcc7588a96d6..050925b5b451 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -671,12 +671,24 @@ static struct dt_cpu_feature_match __initdata
>  	{"wait-v3", feat_enable, 0},
>  };
>  
> -/* XXX: how to configure this? Default + boot time? */
> -#ifdef CONFIG_PPC_CPUFEATURES_ENABLE_UNKNOWN
> -#define CPU_FEATURE_ENABLE_UNKNOWN 1
> -#else
> -#define CPU_FEATURE_ENABLE_UNKNOWN 0
> -#endif
> +static bool __initdata using_dt_cpu_ftrs = true;
> +static bool __initdata dt_cpu_ftrs_enable_unknown = true;
> +
> +static int __init dt_cpu_ftrs_parse(char *str)
> +{
> +	if (!str)
> +		return 0;
> +
> +	if (!strcmp(str, "off"))
> +		using_dt_cpu_ftrs = false;
> +	else if (!strcmp(str, "known"))
> +		dt_cpu_ftrs_enable_unknown = false;
> +	else
> +		return 1;
> +
> +	return 0;
> +}
> +early_param("dt_cpu_ftrs", dt_cpu_ftrs_parse);

I wouldn't use strcmp with user passed parameters.

Balbir Singh.
