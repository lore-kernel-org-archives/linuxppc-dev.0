Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDC00DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 07:21:00 +1000 (EST)
In-Reply-To: <11790019223880-git-send-email-tnt@246tNt.com>
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019223299-git-send-email-tnt@246tNt.com>
	<11790019223880-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B66BE742-BFE4-48AC-89AC-48C35C1A1B69@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/9] powerpc: Changes the config mechanism for rheap
Date: Tue, 15 May 2007 16:20:00 -0500
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 12, 2007, at 3:31 PM, Sylvain Munaut wrote:

> Instead of having in the makefile all the option that
> requires rheap, we define a configuration symbol
> and when needed we make sure it's selected.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  arch/powerpc/Kconfig           |    2 ++
>  arch/powerpc/lib/Kconfig       |    3 +++
>  arch/powerpc/lib/Makefile      |    4 +---
>  arch/powerpc/platforms/Kconfig |    2 ++
>  4 files changed, 8 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/lib/Kconfig

You need to fixup arch/ppc as well since its now using rheap from  
arch/powerpc/lib.

- k

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 56d3c0d..094e5d2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -193,6 +193,7 @@ config PPC_8xx
>  	bool "Freescale 8xx"
>  	select FSL_SOC
>  	select 8xx
> +	select PPC_LIB_RHEAP
>
>  config 40x
>  	bool "AMCC 40x"
> @@ -885,6 +886,7 @@ source "fs/Kconfig"
>
>  source "arch/powerpc/sysdev/qe_lib/Kconfig"
>
> +source "arch/powerpc/lib/Kconfig"
>  source "lib/Kconfig"
>
>  menu "Instrumentation Support"
> diff --git a/arch/powerpc/lib/Kconfig b/arch/powerpc/lib/Kconfig
> new file mode 100644
> index 0000000..f383ad4
> --- /dev/null
> +++ b/arch/powerpc/lib/Kconfig
> @@ -0,0 +1,3 @@
> +config PPC_LIB_RHEAP
> +	bool
> +	default n
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 0a486d4..a6cf399 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -13,7 +13,6 @@ endif
>
>  obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o
> -obj-$(CONFIG_QUICC_ENGINE) += rheap.o
>  obj-$(CONFIG_XMON)	+= sstep.o
>  obj-$(CONFIG_KPROBES)	+= sstep.o
>  obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-noncoherent.o
> @@ -23,5 +22,4 @@ obj-$(CONFIG_SMP)	+= locks.o
>  endif
>
>  # Temporary hack until we have migrated to asm-powerpc
> -obj-$(CONFIG_8xx)	+= rheap.o
> -obj-$(CONFIG_CPM2)	+= rheap.o
> +obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/ 
> platforms/Kconfig
> index 361acfa..8432f56 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -242,6 +242,7 @@ config TAU_AVERAGE
>
>  config QUICC_ENGINE
>  	bool
> +	select PPC_LIB_RHEAP
>  	help
>  	  The QUICC Engine (QE) is a new generation of communications
>  	  coprocessors on Freescale embedded CPUs (akin to CPM in older  
> chips).
> @@ -251,6 +252,7 @@ config QUICC_ENGINE
>  config CPM2
>  	bool
>  	default n
> +	select PPC_LIB_RHEAP
>  	help
>  	  The CPM2 (Communications Processor Module) is a coprocessor on
>  	  embedded CPUs made by Freescale.  Selecting this option means that
> -- 
> 1.5.1.2
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
