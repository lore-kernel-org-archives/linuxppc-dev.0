Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D3002C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 23:56:19 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] powerpc/booke64: Use appropriate -mcpu
Date: Thu, 22 Aug 2013 15:56:11 +0200
Message-ID: <1753626.1M86qx3vEi@pcimr>
In-Reply-To: <1377051162-2588-4-git-send-email-scottwood@freescale.com>
References: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
 <1377051162-2588-4-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Scott Wood <scottwood@freescale.com>,
 Catalin Udma <catalin.udma@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just out of curiosity: What's the difference (if any) between -mcpu=e500mc64 
and -mcpu=e5500? AFAIK -mcpu=e500mc64 is supported by gcc since at least 
version 4.6 whereas -mcpu=e5500 is only supported since gcc 4.8. But is there 
actually any difference?

   Rojhalat


On Tuesday 20 August 2013 21:12:41 Scott Wood wrote:
> By default use -mcpu=powerpc64 rather than -mtune=power7
> 
> Add options for e5500/e6500, with fallbacks for older compilers.
> 
> Hide the POWER cpu options in booke configs.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/Makefile                  |  9 +++++++++
>  arch/powerpc/platforms/Kconfig.cputype | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 6930c93..32dfd5d 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -88,13 +88,22 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call
> cc-option,-mcmodel=medium,-mminimal-toc) CFLAGS-$(CONFIG_PPC64)	+= $(call
> cc-option,-mno-pointers-to-nested-functions) CFLAGS-$(CONFIG_PPC32)	:=
> -ffixed-r2 -mmultiple
> 
> +ifeq ($(CONFIG_PPC_BOOK3S_64),y)
>  CFLAGS-$(CONFIG_GENERIC_CPU) += $(call
> cc-option,-mtune=power7,-mtune=power4) +else
> +CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
> +endif
> +
>  CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
>  CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
>  CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
>  CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
>  CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
> 
> +E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
> +CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
> +CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))
> +
>  CFLAGS-$(CONFIG_TUNE_CELL) += $(call cc-option,-mtune=cell)
> 
>  KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype
> b/arch/powerpc/platforms/Kconfig.cputype index 47d9a03..6704e2e 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -96,18 +96,31 @@ config GENERIC_CPU
> 
>  config CELL_CPU
>  	bool "Cell Broadband Engine"
> +	depends on PPC_BOOK3S_64
> 
>  config POWER4_CPU
>  	bool "POWER4"
> +	depends on PPC_BOOK3S_64
> 
>  config POWER5_CPU
>  	bool "POWER5"
> +	depends on PPC_BOOK3S_64
> 
>  config POWER6_CPU
>  	bool "POWER6"
> +	depends on PPC_BOOK3S_64
> 
>  config POWER7_CPU
>  	bool "POWER7"
> +	depends on PPC_BOOK3S_64
> +
> +config E5500_CPU
> +	bool "Freescale e5500"
> +	depends on E500
> +
> +config E6500_CPU
> +	bool "Freescale e6500"
> +	depends on E500
> 
>  endchoice
