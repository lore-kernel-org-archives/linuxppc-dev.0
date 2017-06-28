Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyJDf078bzDr3h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:59:45 +1000 (AEST)
Date: Wed, 28 Jun 2017 11:52:32 +0200
From: Torsten Duwe <duwe@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Hannes Reinecke <hare@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: conditionally compile platform-specific
 serial drivers
Message-ID: <20170628095232.GA27785@lst.de>
References: <1498573791-6781-1-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498573791-6781-1-git-send-email-hare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 27, 2017 at 04:29:51PM +0200, Hannes Reinecke wrote:
> mpsc.c and mpc52xx-psc.c are platform-specific serial drivers, and
> should be compiled for the respective platforms only.

Yes, this is really dead code that gets compiled and copied needlessly,
on all PPCs apart from those embedded platforms.

> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Torsten Duwe <duwe@suse.de>

> ---
>  arch/powerpc/boot/Makefile | 7 ++++---
>  arch/powerpc/boot/serial.c | 4 ++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index e82f333..1a4609c 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -99,14 +99,15 @@ src-wlib-y := string.S crt0.S crtsavres.S stdio.c decompress.c main.c \
>  		$(libfdt) libfdt-wrapper.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>  		elf_util.c $(zlib-y) devtree.c stdlib.c \
> -		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
> -		uartlite.c mpc52xx-psc.c opal.c
> +		oflib.c ofconsole.c cuboot.c cpm-serial.c \
> +		uartlite.c opal.c
> +src-wlib-$(CONFIG_PPC_MPC52XX) += mpc52xx-psc.c
>  src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) +=  opal-calls.S
>  src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
>  src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
>  src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
>  src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
> -src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
> +src-wlib-$(CONFIG_EMBEDDED6xx) += mpsc.c mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
>  
>  src-plat-y := of.c epapr.c
>  src-plat-$(CONFIG_40x) += fixed-head.S ep405.c cuboot-hotfoot.c \
> diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> index e04c1e4..7b5c02b 100644
> --- a/arch/powerpc/boot/serial.c
> +++ b/arch/powerpc/boot/serial.c
> @@ -120,15 +120,19 @@ int serial_console_init(void)
>  	if (dt_is_compatible(devp, "ns16550") ||
>  	    dt_is_compatible(devp, "pnpPNP,501"))
>  		rc = ns16550_console_init(devp, &serial_cd);
> +#ifdef CONFIG_EMBEDDED6xx
>  	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
>  		rc = mpsc_console_init(devp, &serial_cd);
> +#endif
>  	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
>  	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
>  	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
>  	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
>  		rc = cpm_console_init(devp, &serial_cd);
> +#ifdef CONFIG_PPC_MPC52XX
>  	else if (dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
>  		rc = mpc5200_psc_console_init(devp, &serial_cd);
> +#endif
>  	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
>  		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
>  		rc = uartlite_console_init(devp, &serial_cd);
> -- 
> 1.8.5.6
> 
