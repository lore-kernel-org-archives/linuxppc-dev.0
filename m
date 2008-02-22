Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 615C8DDF54
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 08:37:45 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1203669132-9385-1-git-send-email-sr@denx.de>
References: <1203669132-9385-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Sat, 23 Feb 2008 08:27:35 +1100
Message-Id: <1203715656.6976.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-02-22 at 09:32 +0100, Stefan Roese wrote:
> 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> the internal loopback mode. Clear these bits so that both EMACs
> don't use loopback mode as default.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> I'm not sure if this should be done here in the board platform code,
> or in the newemac driver or perhaps in some code common for 405EX.
> 
> Any thoughts on this welcome.

This should be done in EMAC since we also need to force internal
loopback & clocking when probing the PHY or we might not probe
it properly (and fail reset) if there is no link.

I need to work on that.

Ben.


> Thanks.
> 
>  arch/powerpc/platforms/40x/kilauea.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
> index f9206a7..b5456cc 100644
> --- a/arch/powerpc/platforms/40x/kilauea.c
> +++ b/arch/powerpc/platforms/40x/kilauea.c
> @@ -1,7 +1,7 @@
>  /*
>   * Kilauea board specific routines
>   *
> - * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
> + * Copyright 2007-2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
>   *
>   * Based on the Walnut code by
>   * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> @@ -20,6 +20,8 @@
>  #include <asm/time.h>
>  #include <asm/uic.h>
>  #include <asm/pci-bridge.h>
> +#include <asm/dcr.h>
> +#include <asm/dcr-regs.h>
>  
>  static __initdata struct of_device_id kilauea_of_bus[] = {
>  	{ .compatible = "ibm,plb4", },
> @@ -45,6 +47,13 @@ static int __init kilauea_probe(void)
>  
>  	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
>  
> +	/*
> +	 * 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> +	 * the internal loopback mode. Clear these bits so that both EMACs
> +	 * don't use loopback mode as deafult.
> +	 */
> +	mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) & ~0x0c000000);
> +
>  	return 1;
>  }
>  
