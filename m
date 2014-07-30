Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE15D1A004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 10:19:39 +1000 (EST)
Date: Tue, 29 Jul 2014 19:19:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Subject: Re: qe: move qe from arch/powerpc to drivers
Message-ID: <20140730001923.GA4151@home.buserror.net>
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1403580712-30153-1-git-send-email-B45475@freescale.com>
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 11:31:52AM +0800, Zhao Qiang wrote:
> ls1 has qe and ls1 has arm cpu.
> move qe from arch/powerpc to drivers.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>

This is a very terse changelog.  Explain more about what QE is, and what
this patch accomplishes (it doesn't seem to get rid of the PPC
dependency, just moving code at this stage)

I don't see a MAINTAINERS update for the new path.  Who is going to
maintain it?

I don't think drivers/qe is the right place for it.  Directories directly
under drivers/ tend to be for classes of devices, not instances.  In any
case, LKML should be CCed when creating a new directory directly under
drivers/ or under a subdirectory of drivers/ that doesn't have its own
mailing list.

This came up before, without a resolution.  See:
http://www.spinics.net/lists/kernel/msg1621335.html

> diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
> index bf4c447..22c0d6d 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -37,8 +37,8 @@
>  #include <asm/udbg.h>
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/fsl_pci.h>
> -#include <asm/qe.h>
> -#include <asm/qe_ic.h>
> +#include <linux/qe.h>
> +#include <linux/qe_ic.h>

If you're moving it out of asm/ please give it an fsl prefix.

> diff --git a/drivers/qe/Kconfig b/drivers/qe/Kconfig
> new file mode 100644
> index 0000000..dc16e9a
> --- /dev/null
> +++ b/drivers/qe/Kconfig
> @@ -0,0 +1,35 @@
> +#
> +# QE Communication options
> +#
> +menuconfig QUICC_ENGINE
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
> +if QUICC_ENGINE
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
> +endif

These config options could use better namespacing.

-Scott
