Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416611A0187
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 05:52:03 +1000 (EST)
Message-ID: <1412365908.13320.429.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 3 Oct 2014 14:51:48 -0500
In-Reply-To: <20141003164917.397871AB276@localhost.localdomain>
References: <20141003164917.397871AB276@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
> On CPM1, the SPI parameter RAM has a default location. In order to use SPI while
> using SCC2 with features like QMC or Ethernet, it is necessary to relocate SPI
> parameter RAM in a free location in the CPM dual port RAM.

Please explain in more detail why it's necessary.

>  With this patch,
> when "fsl,cpm1-spi-reloc" instead of "fsl,cpm1-spi" compatible is set in the
> device tree, the parameter RAM for SPI is dynamically allocated
> with cpm_muram_alloc().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> Changes from v1 to v2: using OF compatible instead of compile time option
> 
>  drivers/spi/spi-fsl-cpm.c   | 3 +++
>  drivers/spi/spi-fsl-lib.c   | 2 ++
>  include/linux/fsl_devices.h | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
> index 0f3a912..048ca5f 100644
> --- a/drivers/spi/spi-fsl-cpm.c
> +++ b/drivers/spi/spi-fsl-cpm.c
> @@ -261,6 +261,9 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
>  	if (mspi->flags & SPI_CPM2) {
>  		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>  		out_be16(spi_base, pram_ofs);
> +	} else if (mspi->flags & SPI_CPM1_RELOC) {
> +		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 32);
> +		out_be16(spi_base, pram_ofs);
>  	} else {
>  		u16 rpbase = in_be16(spi_base);
>  
> diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
> index c3f7802..e9db4c5 100644
> --- a/drivers/spi/spi-fsl-lib.c
> +++ b/drivers/spi/spi-fsl-lib.c
> @@ -227,6 +227,8 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
>  		pdata->flags = SPI_CPM_MODE | SPI_CPM2;
>  	else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
>  		pdata->flags = SPI_CPM_MODE | SPI_CPM1;
> +	else if (of_device_is_compatible(np, "fsl,cpm1-spi-reloc"))
> +		pdata->flags = SPI_CPM_MODE | SPI_CPM1 | SPI_CPM1_RELOC;

Where's the binding and device tree update for this?  What specific
aspect of hardware does it describe?

-Scott
