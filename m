Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 922AD67BAE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 14:44:20 +1000 (EST)
In-Reply-To: <1149719645.23938.184.camel@cashmere.sps.mot.com>
References: <1149719645.23938.184.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0EC9507F-27EE-46E4-A92A-E4150A2FA312@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/10] Add the mpc8641 hpcn Kconfig and Makefiles.
Date: Wed, 7 Jun 2006 23:44:36 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 7, 2006, at 5:34 PM, Jon Loeliger wrote:

>
> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>
> ---
>
>  arch/powerpc/Kconfig                 |   15 ++++++++++-
>  arch/powerpc/platforms/Makefile      |    1 +
>  arch/powerpc/platforms/86xx/Makefile |    7 +++++
>  arch/powerpc/platforms/86xx/Kconfig  |   46 +++++++++++++++++++++++ 
> +++++++++++
>  drivers/i2c/busses/Kconfig           |    4 +--
>  5 files changed, 69 insertions(+), 4 deletions(-)
>
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 75ba0ec..e708401 100644
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
> +	default y if PPC_86xx
>  	default n

This dependancy seems too generic, shouldn't it be based on some  
board (its not like 86xx actually has an i8259 in it).

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
> diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/ 
> platforms/86xx/Makefile
> new file mode 100644
> index 0000000..8a237a1
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the PowerPC 86xx linux kernel.
> +#
> +
> +obj-$(CONFIG_PPC_86xx)		+= mpc86xx_hpcn.o misc.o

Seems like mpc86xx_hpcn.o is board specific code and should move down  
one line.

> +obj-$(CONFIG_MPC8641_HPCN)	+= mpc8641_hpcn.o
> +obj-$(CONFIG_PCI)		+= pci.o pex.o
> diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/ 
> platforms/86xx/Kconfig
> new file mode 100644
> index 0000000..b8924e7
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/Kconfig
> @@ -0,0 +1,46 @@
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
> +config PEX
> +	bool "PCI Express support"
> +	depends on PCI && PPC_86xx
> +	default y
> +
> +config I8259_LEVEL_TRIGGER
> +	bool
> +	depends on MPC8641
> +	default y

again, seems like it should depend on a board & not MPC8641

> +
> +config PPC_STD_MMU
> +	bool
> +	depends on PPC_86xx
> +	default y
> +
> +endmenu
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d6d4494..fbeae82 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -252,12 +252,12 @@ config I2C_POWERMAC
>  	  will be called i2c-powermac.
>
>  config I2C_MPC
> -	tristate "MPC107/824x/85xx/52xx"
> +	tristate "MPC107/824x/85xx/52xx/86xx"
>  	depends on I2C && PPC32
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
> -	  MPC85xx family processors. The driver may also work on 52xx
> +	  MPC85xx/MPC8641 family processors. The driver may also work on  
> 52xx
>  	  family processors, though interrupts are known not to work.
>
>  	  This driver can also be built as a module.  If so, the module

should probably separate this out into its own patch for the I2C  
maintainer.

- k
