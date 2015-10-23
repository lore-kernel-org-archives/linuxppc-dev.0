Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0106.outbound.protection.outlook.com [157.56.110.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25A611A0A7C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:20:09 +1100 (AEDT)
Date: Thu, 22 Oct 2015 22:19:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Subject: Re: [PATCH v12 6/6] QE: Move QE from arch/powerpc to drivers/soc
Message-ID: <20151023031952.GA31843@home.buserror.net>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-6-git-send-email-qiang.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1444806968-4627-6-git-send-email-qiang.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 03:16:08PM +0800, Zhao Qiang wrote:
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 01626be7..c9541a5 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -272,25 +272,6 @@ config TAU_AVERAGE
>  
>  	  If in doubt, say N here.
>  
> -config QUICC_ENGINE
> -	bool "Freescale QUICC Engine (QE) Support"
> -	depends on FSL_SOC && PPC32
> -	select GENERIC_ALLOCATOR
> -	select CRC32
> -	help
> -	  The QUICC Engine (QE) is a new generation of communications
> -	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
> -	  Selecting this option means that you wish to build a kernel
> -	  for a machine with a QE coprocessor.
> -
> -config QE_GPIO
> -	bool "QE GPIO support"
> -	depends on QUICC_ENGINE
> -	select ARCH_REQUIRE_GPIOLIB
> -	help
> -	  Say Y here if you're going to use hardware that connects to the
> -	  QE GPIOs.

Why was QE_GPIO moved as part of this patch?


> diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/drivers/soc/fsl/qe/Kconfig
> similarity index 50%
> copy from arch/powerpc/sysdev/qe_lib/Kconfig
> copy to drivers/soc/fsl/qe/Kconfig
> index 3c25199..283fe0d 100644
> --- a/arch/powerpc/sysdev/qe_lib/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -2,6 +2,17 @@
>  # QE Communication options
>  #
>  
> +config QUICC_ENGINE
> +	bool "Freescale QUICC Engine (QE) Support"
> +	depends on FSL_SOC && PPC32
> +	select GENERIC_ALLOCATOR
> +	select CRC32
> +	help
> +	  The QUICC Engine (QE) is a new generation of communications
> +	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
> +	  Selecting this option means that you wish to build a kernel
> +	  for a machine with a QE coprocessor.
> +
>  config UCC_SLOW
>  	bool
>  	default y if SERIAL_QE
> @@ -19,9 +30,3 @@ config UCC_FAST
>  config UCC
>  	bool
>  	default y if UCC_FAST || UCC_SLOW
> -
> -config QE_USB
> -	bool
> -	default y if USB_FSL_QE
> -	help
> -	  QE USB Controller support

Why did some config symbols get moved and others not?

> diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
> new file mode 100644
> index 0000000..51c9dce
> --- /dev/null
> +++ b/drivers/soc/fsl/qe/Makefile
> @@ -0,0 +1,9 @@
> +#
> +#Makefile for the Linux fsl parts of QE
> +#

"fsl parts of QE"?  Are there non-fsl parts of QE?

-Scott
