Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 845CCDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:59:21 +1100 (EST)
Message-ID: <4769860D.9040401@freescale.com>
Date: Wed, 19 Dec 2007 14:58:53 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] [POWERPC][SPI] use brg-frequency for SPI in QE
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203805.GC20861@localhost.localdomain>
In-Reply-To: <20071219203805.GC20861@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 044dd7f..3cf84d0 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1227,15 +1227,19 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
>  
>  	/* SPI controller is either clocked from QE or SoC clock */
>  	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> -	if (!np)
> +	if (np) {
> +		sysclk = of_get_property(np, "brg-frequency", NULL);
> +		if (!sysclk)
> +			return -ENODEV;
> +	} else {

You should use get_brgfreq() instead (and fix the legacy match to find 
qe as well as soc nodes).

-Scott
