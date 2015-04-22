Return-Path: <jogo@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [78.24.191.176])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F25B51A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 06:51:46 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by arrakis.dune.hu (Postfix) with ESMTP id 460E828B43A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:50:41 +0200 (CEST)
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com
 [209.85.220.173])
 by arrakis.dune.hu (Postfix) with ESMTPSA id F18A62801B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:50:19 +0200 (CEST)
Received: by qkhg7 with SMTP id g7so238406656qkh.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 13:51:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150422141721.D3F8C1A242E@localhost.localdomain>
References: <20150422141721.D3F8C1A242E@localhost.localdomain>
From: Jonas Gorski <jogo@openwrt.org>
Date: Wed, 22 Apr 2015 22:50:56 +0200
Message-ID: <CAOiHx==UgFEfvoeF+YrSsS-=i4gKX-hRY3ssB35=5_HsBDXt2A@mail.gmail.com>
Subject: Re: [PATCH v2] spi: fsl-spi: use of_iomap() to map parameter ram on
 CPM1
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi (again),

as usual you only see issues *after* sending the email ...

On Wed, Apr 22, 2015 at 4:17 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the
> dualport RAM whereas in CPM1, it is statically allocated to a default
> address with capability to relocate it somewhere else via the use of
> CPM micropatch. The address of the parameter RAM is given by the boot
> loader and expected to be mapped via of_iomap()
>
> In the current implementation, in function fsl_spi_cpm_get_pram()
> there is a confusion between the SPI_BASE register and the base of the
> SPI parameter RAM. Fortunatly, it is working properly with MPC866 and
> MPC885 because they do set SPI_BASE, but on MPC860 and other old
> MPC8xx that doesn't set SPI_BASE, pram_ofs is not properly set.
> Also, the parameter RAM is not properly mapped with of_iomap() as it
> should but still gets accessible by chance through the full RAM which
> is mapped from somewhere else.
>
> This patch applies to the SPI driver the same principle as for the
> CPM UART: when the CPM is of type CPM1, we simply do an of_iomap() of
> the area provided via the device tree.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> ---
>  v2: Use devm_ioremap_resource() instead of_iomap()
>
>  drivers/spi/spi-fsl-cpm.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
> index e85ab1c..4e5c945 100644
> --- a/drivers/spi/spi-fsl-cpm.c
> +++ b/drivers/spi/spi-fsl-cpm.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_address.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
> +#include <linux/platform_device.h>
>
>  #include "spi-fsl-cpm.h"
>  #include "spi-fsl-lib.h"
> @@ -264,17 +265,6 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
>         if (mspi->flags & SPI_CPM2) {
>                 pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>                 out_be16(spi_base, pram_ofs);
> -       } else {
> -               struct spi_pram __iomem *pram = spi_base;
> -               u16 rpbase = in_be16(&pram->rpbase);
> -
> -               /* Microcode relocation patch applied? */
> -               if (rpbase) {
> -                       pram_ofs = rpbase;
> -               } else {
> -                       pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
> -                       out_be16(spi_base, pram_ofs);
> -               }
>         }
>
>         iounmap(spi_base);
> @@ -287,7 +277,6 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
>         struct device_node *np = dev->of_node;
>         const u32 *iprop;
>         int size;
> -       unsigned long pram_ofs;
>         unsigned long bds_ofs;
>
>         if (!(mspi->flags & SPI_CPM_MODE))
> @@ -314,8 +303,21 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
>                 }
>         }
>
> -       pram_ofs = fsl_spi_cpm_get_pram(mspi);
> -       if (IS_ERR_VALUE(pram_ofs)) {
> +       if (mspi->flags & SPI_CPM1) {
> +               struct resource *res;
> +
> +               res = platform_get_resource(to_platform_device(dev),
> +                                           IORESOURCE_MEM, 1);
> +               mspi->pram = devm_ioremap_resource(dev, res);
> +       } else {
> +               unsigned long pram_ofs = fsl_spi_cpm_get_pram(mspi);
> +
> +               if (IS_ERR_VALUE(pram_ofs))
> +                       mspi->pram = NULL;
> +               else
> +                       mspi->pram = cpm_muram_addr(pram_ofs);
> +       }
> +       if (mspi->pram == NULL) {

devm_ioremap_resource will never return NULL; you either need to check
with IS_ERR(), or do that after calling devm_ioremap_resource and setg
pram to NULL in that case.

>                 dev_err(dev, "can't allocate spi parameter ram\n");
>                 goto err_pram;
>         }
> @@ -341,8 +343,6 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
>                 goto err_dummy_rx;
>         }
>
> -       mspi->pram = cpm_muram_addr(pram_ofs);
> -
>         mspi->tx_bd = cpm_muram_addr(bds_ofs);
>         mspi->rx_bd = cpm_muram_addr(bds_ofs + sizeof(*mspi->tx_bd));
>
> @@ -370,7 +370,8 @@ err_dummy_rx:
>  err_dummy_tx:
>         cpm_muram_free(bds_ofs);
>  err_bds:
> -       cpm_muram_free(pram_ofs);
> +       if (!(mspi->flags & SPI_CPM1))
> +               cpm_muram_free(cpm_muram_offset(mspi->pram));
>  err_pram:
>         fsl_spi_free_dummy_rx();
>         return -ENOMEM;


Regards
Jonas
