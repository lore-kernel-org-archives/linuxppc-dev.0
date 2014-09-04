Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CB081A0AED
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 08:47:12 +1000 (EST)
Message-ID: <1409870809.24184.163.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] QE: move qe code from arch/powerpc to drivers/soc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Thu, 4 Sep 2014 17:46:49 -0500
In-Reply-To: <1409807186-45816-1-git-send-email-B45475@freescale.com>
References: <1409807186-45816-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-04 at 13:06 +0800, Zhao Qiang wrote:
> LS1 is arm cpu and it has qe ip block.
> move qe code from platform directory to public directory.
> 
> QE is an IP block integrates several comunications peripheral
> controllers. It can implement a variety of applications, such
> as uart, usb and tdm and so on.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- mv code to drivers/soc

Who will be the maintainer of this code once it lives in drivers/soc,
especially once it is no longer used only by PPC?

>  44 files changed, 113 insertions(+), 113 deletions(-)
>  delete mode 100644 arch/powerpc/sysdev/qe_lib/Kconfig
>  create mode 100644 drivers/soc/qe/Kconfig
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/Makefile (100%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/gpio.c (99%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/qe.c (99%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/qe_ic.c (99%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/qe_ic.h (98%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/qe_io.c (99%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/ucc.c (98%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/ucc_fast.c (98%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/ucc_slow.c (98%)
>  rename {arch/powerpc/sysdev/qe_lib => drivers/soc/qe}/usb.c (96%)

drivers/soc/fsl-qe

> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 0f7c447..5da1a482 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,3 +3,5 @@
>  #
>  
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +
> +obj-$(CONFIG_QUICC_ENGINE)     += qe/

Please keep the file consistent regarding tabs versus spaces.

Plus, why do you need a newline between them?

> diff --git a/drivers/soc/qe/Kconfig b/drivers/soc/qe/Kconfig
> new file mode 100644
> index 0000000..8b03ca2
> --- /dev/null
> +++ b/drivers/soc/qe/Kconfig
> @@ -0,0 +1,45 @@
> +#
> +# QE Communication options
> +#
> +config QUICC_ENGINE
> +	bool "Freescale QUICC Engine (QE) Support"
> +	depends on FSL_SOC && PPC32
> +	select PPC_LIB_RHEAP
> +	select CRC32
> +	help
> +	  The QUICC Engine (QE) is a new generation of communications
> +	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
> +	  Selecting this option means that you wish to build a kernel
> +	  for a machine with a QE coprocessor.
> +
> +config QE_GPIO
> +	bool "QE GPIO support"
> +	depends on QUICC_ENGINE
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  Say Y here if you're going to use hardware that connects to the
> +	  QE GPIOs.
> +
> +config UCC_SLOW
> +	bool
> +	default y if SERIAL_QE
> +	help
> +	  This option provides qe_lib support to UCC slow
> +	  protocols: UART, BISYNC, QMC
> +
> +config UCC_FAST
> +	bool
> +	default y if UCC_GETH
> +	help
> +	  This option provides qe_lib support to UCC fast
> +	  protocols: HDLC, Ethernet, ATM, transparent
> +
> +config UCC
> +	bool
> +	default y if UCC_FAST || UCC_SLOW
> +
> +config QE_USB
> +	bool
> +	default y if USB_FSL_QE
> +	help
> +	  QE USB Controller support

First could we give these names better namespacing?

-Scott
