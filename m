Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D452CB6F80
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2011 04:20:17 +1000 (EST)
Date: Tue, 26 Jul 2011 13:20:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: <MichaelHench@gmail.com>
Subject: Re: [PATCH] mtd: eLBC NAND: update ecc_stats.corrected when lteccr
	available
Message-ID: <20110726132009.1fdaf1b7@schlenkerla.am.freescale.net>
In-Reply-To: <CAHyXW61fOhuDcxCVQQ6inO_Uoz6m+hN_eB0pQ-rW0c=miJC=3w@mail.gmail.com>
References: <CAHyXW61fOhuDcxCVQQ6inO_Uoz6m+hN_eB0pQ-rW0c=miJC=3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, mlcreech@gmail.com,
	mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2011 08:45:42 -0500
Michael Hench <michaelhench@gmail.com> wrote:

> update ecc_stats.corrected if LTECCR register is available.
> 
> Signed-off-by: Michael Hench <MichaelHench@gmail.com>
> ---
> diff -purN orig/drivers/mtd/nand/fsl_elbc_nand.c
> linux-3.0/drivers/mtd/nand/fsl_elbc_nand.c
> --- orig/drivers/mtd/nand/fsl_elbc_nand.c	2011-07-25 14:50:56.838326055 -0500
> +++ linux-3.0/drivers/mtd/nand/fsl_elbc_nand.c	2011-07-25
> 14:48:35.680940052 -0500
> @@ -256,6 +256,25 @@ static int fsl_elbc_run_command(struct m
>  		return -EIO;
>  	}
> 
> +	if(chip->ecc.mode != NAND_ECC_HW)
> +		return(0);
> +
> +	if(elbc_fcm_ctrl->read_bytes == mtd->writesize + mtd->oobsize) {
> +		uint32_t lteccr = in_be32(&lbc->lteccr);
> +		/*
> +		 * if command was a full page read and the ELBC
> +		 * has the LTECCR register, then bits 12-15 (ppc order) of
> +		 * LTECCR indicate which 512 byte sub-pages had corrected errors.
> +		 * bits 28-31 are uncorrectable errors, marked elsewhere.
> +		 * for small page nand only 1 bit is used.
> +		 * if the ELBC doesn't have the lteccr register it reads 0
> +		 */
> +		if(lteccr & 0x000F000F)
> +			out_be32(&lbc->lteccr, 0x000F000F); /* clear lteccr */
> +		if(lteccr & 0x000F0000)
> +			mtd->ecc_stats.corrected++;
> +	}

Add a space after "if" and remove the parentheses in "return(0)", but
otherwise ACK.

-Scott
