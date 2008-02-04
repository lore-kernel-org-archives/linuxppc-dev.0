Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1980DDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 07:50:58 +1100 (EST)
Subject: Re: [RFC][PATCH] PowerPC: 4xx PCIe indirect DCR spinlock fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20080204182740.GA2898@ru.mvista.com>
References: <20080204182740.GA2898@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 07:50:39 +1100
Message-Id: <1202158239.7079.4.camel@pasglop>
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


On Mon, 2008-02-04 at 21:27 +0300, Valentine Barshak wrote:
> Since we have mfdcri() and mtdcri() as macros, we can't use constructions, such
> as "mtdcri(base, reg, mfdcri(base, reg) | val)". In this case the mfdcri() stuff
> is not evaluated first. It's evaluated inside the mtdcr() macro and we have
> the dcr_ind_lock spinlock acquired twice. To avoid this error, I've added
> set_dcri() and clr_dcri() macros which set/clear the specified bits.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

No, better is to fix the macros to use functions.

Make mfdcri/mtdcri call into __mfdcri/__mtdcri functions after fixing
up the macro register names, and have those be inlines that take the
lock.

Ben.

>  arch/powerpc/sysdev/ppc4xx_pci.c |   13 +++++--------
>  include/asm-powerpc/dcr-native.h |   22 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff -pruN linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c
> --- linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2008-02-04 20:05:37.000000000 +0300
> +++ linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c	2008-02-04 20:16:33.000000000 +0300
> @@ -645,7 +645,7 @@ static int __init ppc440spe_pciex_core_i
>  	int time_out = 20;
>  
>  	/* Set PLL clock receiver to LVPECL */
> -	mtdcri(SDR0, PESDR0_PLLLCT1, mfdcri(SDR0, PESDR0_PLLLCT1) | 1 << 28);
> +	set_dcri(SDR0, PESDR0_PLLLCT1, 1 << 28);
>  
>  	/* Shouldn't we do all the calibration stuff etc... here ? */
>  	if (ppc440spe_pciex_check_reset(np))
> @@ -659,8 +659,7 @@ static int __init ppc440spe_pciex_core_i
>  	}
>  
>  	/* De-assert reset of PCIe PLL, wait for lock */
> -	mtdcri(SDR0, PESDR0_PLLLCT1,
> -	       mfdcri(SDR0, PESDR0_PLLLCT1) & ~(1 << 24));
> +	clr_dcri(SDR0, PESDR0_PLLLCT1, 1 << 24);
>  	udelay(3);
>  
>  	while (time_out) {
> @@ -712,9 +711,8 @@ static int ppc440spe_pciex_init_port_hw(
>  		mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL7SET1,
>  		       0x35000000);
>  	}
> -	val = mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET);
> -	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
> -	       (val & ~(1 << 24 | 1 << 16)) | 1 << 12);
> +	clr_dcri(SDR0, port->sdr_base + PESDRn_RCSSET, 1 << 24 | 1 << 16)
> +	set_dcri(SDR0, port->sdr_base + PESDRn_RCSSET, 1 << 12);
>  
>  	return 0;
>  }
> @@ -1042,8 +1040,7 @@ static int __init ppc4xx_pciex_port_init
>  		port->link = 0;
>  	}
>  
> -	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
> -	       mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET) | 1 << 20);
> +	set_dcri(SDR0, port->sdr_base + PESDRn_RCSSET, 1 << 20);
>  	msleep(100);
>  
>  	return 0;
> diff -pruN linux-2.6.orig/include/asm-powerpc/dcr-native.h linux-2.6/include/asm-powerpc/dcr-native.h
> --- linux-2.6.orig/include/asm-powerpc/dcr-native.h	2008-02-04 20:06:34.000000000 +0300
> +++ linux-2.6/include/asm-powerpc/dcr-native.h	2008-02-04 20:16:33.000000000 +0300
> @@ -79,6 +79,28 @@ do {							\
>  	spin_unlock_irqrestore(&dcr_ind_lock, flags);	\
>  } while (0)
>  
> +#define set_dcri(base, reg, data)				\
> +do {								\
> +	unsigned long flags; 					\
> +	unsigned int val;					\
> +	spin_lock_irqsave(&dcr_ind_lock, flags);		\
> +	mtdcr(DCRN_ ## base ## _CONFIG_ADDR, reg);		\
> +	val = mfdcr(DCRN_ ## base ## _CONFIG_DATA);		\
> +	mtdcr(DCRN_ ## base ## _CONFIG_DATA, val | (data));	\
> +	spin_unlock_irqrestore(&dcr_ind_lock, flags);		\
> +} while (0)
> +
> +#define clr_dcri(base, reg, data)				\
> +do {								\
> +	unsigned long flags; 					\
> +	unsigned int val;					\
> +	spin_lock_irqsave(&dcr_ind_lock, flags);		\
> +	mtdcr(DCRN_ ## base ## _CONFIG_ADDR, reg);		\
> +	val = mfdcr(DCRN_ ## base ## _CONFIG_DATA);		\
> +	mtdcr(DCRN_ ## base ## _CONFIG_DATA, val & ~(data));	\
> +	spin_unlock_irqrestore(&dcr_ind_lock, flags);		\
> +} while (0)
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_DCR_NATIVE_H */
