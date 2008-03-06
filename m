Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CD1FCDE1EA
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 01:10:22 +1100 (EST)
Message-ID: <47CFFAD0.9060609@ru.mvista.com>
Date: Thu, 06 Mar 2008 17:08:16 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PowerPC 4xx: Use dcri_clrset() for PCIe indirect dcr
	read/modify/write access
References: <20080306133751.GA31690@ru.mvista.com>
In-Reply-To: <20080306133751.GA31690@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, sorry, please discard this one.
There's a typo in it. The fixed patch is coming right away.
Thanks.
Valentine.

Valentine Barshak wrote:
> Use dcri_clrset() for PCIe SDR0 read/modify/write access.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/ppc4xx_pci.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff -pruN linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c
> --- linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2008-03-06 14:39:46.000000000 +0300
> +++ linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c	2008-03-06 14:52:02.000000000 +0300
> @@ -645,7 +645,7 @@ static int __init ppc440spe_pciex_core_i
>  	int time_out = 20;
>  
>  	/* Set PLL clock receiver to LVPECL */
> -	mtdcri(SDR0, PESDR0_PLLLCT1, mfdcri(SDR0, PESDR0_PLLLCT1) | 1 << 28);
> +	dcri_clrset(SDR0, PESDR0_PLLLCT1, 0, 1 << 28);
>  
>  	/* Shouldn't we do all the calibration stuff etc... here ? */
>  	if (ppc440spe_pciex_check_reset(np))
> @@ -659,8 +659,7 @@ static int __init ppc440spe_pciex_core_i
>  	}
>  
>  	/* De-assert reset of PCIe PLL, wait for lock */
> -	mtdcri(SDR0, PESDR0_PLLLCT1,
> -	       mfdcri(SDR0, PESDR0_PLLLCT1) & ~(1 << 24));
> +	dcri_clrset(SDR0, PESDR0_PLLLCT1, 1 << 24, 0);
>  	udelay(3);
>  
>  	while (time_out) {
> @@ -712,9 +711,8 @@ static int ppc440spe_pciex_init_port_hw(
>  		mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL7SET1,
>  		       0x35000000);
>  	}
> -	val = mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET);
>  	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
> -	       (val & ~(1 << 24 | 1 << 16)) | 1 << 12);
> +		(1 << 24) | (1 << 16), 1 << 12);
>  
>  	return 0;
>  }
> @@ -1042,8 +1040,7 @@ static int __init ppc4xx_pciex_port_init
>  		port->link = 0;
>  	}
>  
> -	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
> -	       mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET) | 1 << 20);
> +	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET, 0, 1 << 20);
>  	msleep(100);
>  
>  	return 0;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
