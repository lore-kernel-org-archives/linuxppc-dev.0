Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7B982C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 08:41:42 +1000 (EST)
Message-ID: <1380062492.24959.123.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 3/3] powerpc/85xx: use one kernel option for all the
 CoreNet_Generic boards
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Tue, 24 Sep 2013 17:41:32 -0500
In-Reply-To: <1379991797-29222-4-git-send-email-haokexin@gmail.com>
References: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
 <1379991797-29222-4-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-24 at 11:03 +0800, Kevin Hao wrote:
> Currently all these boards use the same machine struct and also select
> the same kernel options, so it seems a bit of redundant to keep one
> separate kernel option for each board. Also update the defconfigs
> according to this change.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> A new patch in v3.
> 
>  arch/powerpc/configs/corenet32_smp_defconfig |  6 +-
>  arch/powerpc/configs/corenet64_smp_defconfig |  5 +-
>  arch/powerpc/configs/ppc64e_defconfig        |  2 +-
>  arch/powerpc/platforms/85xx/Kconfig          | 97 +++-------------------------
>  4 files changed, 12 insertions(+), 98 deletions(-)
> 
> diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
> index 3dfab4c..1d9cb29 100644
> --- a/arch/powerpc/configs/corenet32_smp_defconfig
> +++ b/arch/powerpc/configs/corenet32_smp_defconfig
> @@ -23,11 +23,7 @@ CONFIG_MODVERSIONS=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_MAC_PARTITION=y
> -CONFIG_P2041_RDB=y
> -CONFIG_P3041_DS=y
> -CONFIG_P4080_DS=y
> -CONFIG_P5020_DS=y
> -CONFIG_P5040_DS=y
> +CONFIG_CORENET_GENERIC=y
>  CONFIG_HIGHMEM=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_BINFMT_MISC=m
> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
> index fa94fb3..63508dd 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> @@ -21,10 +21,7 @@ CONFIG_MODVERSIONS=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_MAC_PARTITION=y
> -CONFIG_B4_QDS=y
> -CONFIG_P5020_DS=y
> -CONFIG_P5040_DS=y
> -CONFIG_T4240_QDS=y
> +CONFIG_CORENET_GENERIC=y
>  # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
>  CONFIG_BINFMT_MISC=m
>  CONFIG_MATH_EMULATION=y
> diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
> index 0085dc4..0a6be6d 100644
> --- a/arch/powerpc/configs/ppc64e_defconfig
> +++ b/arch/powerpc/configs/ppc64e_defconfig
> @@ -23,7 +23,7 @@ CONFIG_MODULE_SRCVERSION_ALL=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_MAC_PARTITION=y
>  CONFIG_EFI_PARTITION=y
> -CONFIG_P5020_DS=y
> +CONFIG_CORENET_GENERIC=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>  CONFIG_CPU_FREQ_GOV_USERSPACE=y
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index 3bee943..04456fb 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -218,36 +218,8 @@ config GE_IMP3A
>  	  This board is a 3U CompactPCI Single Board Computer with a Freescale
>  	  P2020 processor.
>  
> -config P2041_RDB
> -	bool "Freescale P2041 RDB"
> -	select DEFAULT_UIMAGE
> -	select PPC_E500MC
> -	select PHYS_64BIT
> -	select SWIOTLB
> -	select ARCH_REQUIRE_GPIOLIB
> -	select GPIO_MPC8XXX
> -	select HAS_RAPIDIO
> -	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
> -	help
> -	  This option enables support for the P2041 RDB board
> -
> -config P3041_DS
> -	bool "Freescale P3041 DS"
> -	select DEFAULT_UIMAGE
> -	select PPC_E500MC
> -	select PHYS_64BIT
> -	select SWIOTLB
> -	select ARCH_REQUIRE_GPIOLIB
> -	select GPIO_MPC8XXX
> -	select HAS_RAPIDIO
> -	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
> -	help
> -	  This option enables support for the P3041 DS board
> -
> -config P4080_DS
> -	bool "Freescale P4080 DS"
> +config CORENET_GENERIC
> +	bool "Freescale CoreNet Generic"
>  	select DEFAULT_UIMAGE
>  	select PPC_E500MC
>  	select PHYS_64BIT
> @@ -256,50 +228,20 @@ config P4080_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
>  	help
> -	  This option enables support for the P4080 DS board
> +	  This option enables support for the P2041 RDB, P3041 DS, P4080 DS, P5020 DS
> +	  and P5040 DS boards
>  
>  config SGY_CTS1000
>  	tristate "Servergy CTS-1000 support"
>  	select GPIOLIB
>  	select OF_GPIO
> -	depends on P4080_DS
> +	depends on CORENET_GENERIC
>  	help
>  	  Enable this to support functionality in Servergy's CTS-1000 systems.
>  
>  endif # PPC32
>  
> -config P5020_DS
> -	bool "Freescale P5020 DS"
> -	select DEFAULT_UIMAGE
> -	select E500
> -	select PPC_E500MC
> -	select PHYS_64BIT
> -	select SWIOTLB
> -	select ARCH_REQUIRE_GPIOLIB
> -	select GPIO_MPC8XXX
> -	select HAS_RAPIDIO
> -	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
> -	help
> -	  This option enables support for the P5020 DS board
> -
> -config P5040_DS
> -	bool "Freescale P5040 DS"
> -	select DEFAULT_UIMAGE
> -	select E500
> -	select PPC_E500MC
> -	select PHYS_64BIT
> -	select SWIOTLB
> -	select ARCH_REQUIRE_GPIOLIB
> -	select GPIO_MPC8XXX
> -	select HAS_RAPIDIO
> -	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
> -	help
> -	  This option enables support for the P5040 DS board
> -
>  config PPC_QEMU_E500
>  	bool "QEMU generic e500 platform"
>  	select DEFAULT_UIMAGE
> @@ -317,8 +259,8 @@ config PPC_QEMU_E500
>  
>  if PPC64
>  
> -config T4240_QDS
> -	bool "Freescale T4240 QDS"
> +config CORENET_GENERIC
> +	bool "Freescale CoreNet Generic"
>  	select DEFAULT_UIMAGE
>  	select E500
>  	select PPC_E500MC
> @@ -328,33 +270,12 @@ config T4240_QDS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
>  	help
> -	  This option enables support for the T4240 QDS board
> -
> -config B4_QDS
> -	bool "Freescale B4 QDS"
> -	select DEFAULT_UIMAGE
> -	select E500
> -	select PPC_E500MC
> -	select PHYS_64BIT
> -	select SWIOTLB
> -	select GPIOLIB
> -	select ARCH_REQUIRE_GPIOLIB
> -	select HAS_RAPIDIO
> -	select PPC_EPAPR_HV_PIC
> -	select CORENET_GENERIC
> -	help
> -	  This option enables support for the B4 QDS board
> -	  The B4 application development system B4 QDS is a complete
> -	  debugging environment intended for engineers developing
> -	  applications for the B4.
> +	  This option enables support for the P5020 DS, P5040 DS, T4240 QDS
> +	  and B4 QDS boards

Is there any difference between the 32-bit and 64-bit versions of this
config symbol, other than the help text?

-Scott
