Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C47F2B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 04:00:41 +1000 (EST)
Received: by iyn35 with SMTP id 35so6014871iyn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Jul 2011 11:00:37 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 5 Jul 2011 12:00:10 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Holger Brunck <holger.brunck@keymile.com>
Subject: Re: [PATCH] spi/fsl_spi: fix CPM spi driver
Message-ID: <20110705180010.GA7393@ponder.secretlab.ca>
References: <1308587517-20640-1-git-send-email-holger.brunck@keymile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308587517-20640-1-git-send-email-holger.brunck@keymile.com>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 20, 2011 at 06:31:57PM +0200, Holger Brunck wrote:
> This patch fixes the freescale spi driver for CPM. Without this
> patch SPI on CPM failed because cpm_muram_alloc_fixed tries to
> allocate muram in an preserved area. The error reported was:
> 
> mpc8xxx_spi f0011a80.spi: can't allocate spi parameter ram
> mpc8xxx_spi: probe of f0011a80.spi failed with error -12
> 
> Now the driver uses of_iomap to get access to this area
> similar to i2c driver driver in the i2c-cpm.c which has a
> similar device tree node. This is tested on a MPC8247 with CPM2.
> 
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: spi-devel-general@lists.sourceforge.net

Applied, thanks.

g.

> ---
> This was the same problem reported and discussed on ppc-dev for CPM1:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-September/085739.html
> 
>  drivers/spi/spi_fsl_spi.c |   28 +++++++++++-----------------
>  1 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/spi/spi_fsl_spi.c b/drivers/spi/spi_fsl_spi.c
> index 7963c9b..ca57edf 100644
> --- a/drivers/spi/spi_fsl_spi.c
> +++ b/drivers/spi/spi_fsl_spi.c
> @@ -684,7 +684,7 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
>  	struct device_node *np = dev->of_node;
>  	const u32 *iprop;
>  	int size;
> -	unsigned long spi_base_ofs;
> +	void __iomem *spi_base;
>  	unsigned long pram_ofs = -ENOMEM;
>  
>  	/* Can't use of_address_to_resource(), QE muram isn't at 0. */
> @@ -702,33 +702,27 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
>  		return pram_ofs;
>  	}
>  
> -	/* CPM1 and CPM2 pram must be at a fixed addr. */
> -	if (!iprop || size != sizeof(*iprop) * 4)
> -		return -ENOMEM;
> -
> -	spi_base_ofs = cpm_muram_alloc_fixed(iprop[2], 2);
> -	if (IS_ERR_VALUE(spi_base_ofs))
> -		return -ENOMEM;
> +	spi_base = of_iomap(np, 1);
> +	if (spi_base == NULL)
> +		return -EINVAL;
>  
>  	if (mspi->flags & SPI_CPM2) {
>  		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
> -		if (!IS_ERR_VALUE(pram_ofs)) {
> -			u16 __iomem *spi_base = cpm_muram_addr(spi_base_ofs);
> -
> -			out_be16(spi_base, pram_ofs);
> -		}
> +		out_be16(spi_base, pram_ofs);
>  	} else {
> -		struct spi_pram __iomem *pram = cpm_muram_addr(spi_base_ofs);
> +		struct spi_pram __iomem *pram = spi_base;
>  		u16 rpbase = in_be16(&pram->rpbase);
>  
>  		/* Microcode relocation patch applied? */
>  		if (rpbase)
>  			pram_ofs = rpbase;
> -		else
> -			return spi_base_ofs;
> +		else {
> +			pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
> +			out_be16(spi_base, pram_ofs);
> +		}
>  	}
>  
> -	cpm_muram_free(spi_base_ofs);
> +	iounmap(spi_base);
>  	return pram_ofs;
>  }
>  
> -- 
> 1.7.1
> 
