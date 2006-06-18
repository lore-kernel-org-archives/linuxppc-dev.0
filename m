Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFA7F67B29
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 00:12:37 +1000 (EST)
In-Reply-To: <E1Frjed-0004Of-T3@jdl.com>
References: <E1Frjed-0004Of-T3@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7056CA1B-ACE4-4FB7-BFE3-0A0631F83EAD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9 v3] Add the mpc8641 hpcn Kconfig and Makefiles.
Date: Sun, 18 Jun 2006 09:13:20 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2006, at 5:52 PM, Jon Loeliger wrote:

> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>
> ---
>
>  arch/powerpc/Kconfig                 |   15 ++++++++++++--
>  arch/powerpc/platforms/Makefile      |    1 +
>  arch/powerpc/platforms/86xx/Kconfig  |   36 +++++++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/86xx/Makefile |   10 +++++++++
>  4 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4ef2478..65f4cd1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -141,6 +141,15 @@ config PPC_85xx
>  	select FSL_SOC
>  	select 85xx
>
> +config PPC_86xx
> +	bool "Freescale 86xx"
> +	select 6xx
> +	select FSL_SOC
> +	select PPC_FPU
> +	select ALTIVEC
> +	help
> +	  The Freescale E600 SoCs have 74xx cores.
> +
>  config 40x
>  	bool "AMCC 40x"
>
> @@ -549,6 +558,7 @@ source arch/powerpc/platforms/embedded6x
>  source arch/powerpc/platforms/4xx/Kconfig
>  source arch/powerpc/platforms/83xx/Kconfig
>  source arch/powerpc/platforms/85xx/Kconfig
> +source arch/powerpc/platforms/86xx/Kconfig
>  source arch/powerpc/platforms/8xx/Kconfig
>  source arch/powerpc/platforms/cell/Kconfig
>
> @@ -780,6 +790,7 @@ config GENERIC_ISA_DMA
>
>  config PPC_I8259
>  	bool
> +	default y if MPC8641_HPCN
>  	default n

Can you change this into a select under the config MPC8641_HPCN menu?

>
>  config PPC_INDIRECT_PCI
> @@ -802,8 +813,8 @@ config MCA
>  	bool
>
>  config PCI
> -	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx ||  
> PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
> -	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && ! 
> PPC_85xx
> +	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx ||  
> PPC_86xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
> +	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && ! 
> PPC_85xx && !PPC_86xx
>  	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
>  	default PCI_QSPAN if !4xx && !CPM2 && 8xx
>  	help
> diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/ 
> platforms/Makefile
> index c4f6b0d..2928636 100644
> --- a/arch/powerpc/platforms/Makefile
> +++ b/arch/powerpc/platforms/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PPC_CHRP)		+= chrp/
>  obj-$(CONFIG_4xx)		+= 4xx/
>  obj-$(CONFIG_PPC_83xx)		+= 83xx/
>  obj-$(CONFIG_PPC_85xx)		+= 85xx/
> +obj-$(CONFIG_PPC_86xx)		+= 86xx/
>  obj-$(CONFIG_PPC_PSERIES)	+= pseries/
>  obj-$(CONFIG_PPC_ISERIES)	+= iseries/
>  obj-$(CONFIG_PPC_MAPLE)		+= maple/
> diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/ 
> platforms/86xx/Kconfig
> new file mode 100644
> index 0000000..3a87863
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/Kconfig
> @@ -0,0 +1,36 @@
> +menu "Platform Support"
> +	depends on PPC_86xx
> +
> +choice
> +	prompt "Machine Type"
> +	default MPC8641_HPCN
> +
> +config MPC8641_HPCN
> +	bool "Freescale MPC8641 HPCN"
> +	help
> +	  This option enables support for the MPC8641 HPCN board.
> +
> +endchoice
> +
> +
> +config MPC8641
> +	bool
> +	select PPC_INDIRECT_PCI
> +	select PPC_UDBG_16550
> +	default y if MPC8641_HPCN
> +
> +config MPIC
> +	bool
> +	default y
> +
> +config PPC_INDIRECT_PCI_BE
> +	bool
> +	depends on PPC_86xx
> +	default y
> +
> +config PPC_STD_MMU
> +	bool
> +	depends on PPC_86xx
> +	default y

this seems redundant, having 6xx should get this for you already.

> +
> +endmenu
> diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/ 
> platforms/86xx/Makefile
> new file mode 100644
> index 0000000..7be796c
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/Makefile
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for the PowerPC 86xx linux kernel.
> +#
> +
> +
> +ifeq ($(CONFIG_PPC_86xx),y)
> +obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
> +endif

isn't the ifeq redundant, we would only parse this Makefile if we  
were CONFIG_PPC_86xx

> +obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
> +obj-$(CONFIG_PCI)		+= pci.o mpc86xx_pcie.o
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
