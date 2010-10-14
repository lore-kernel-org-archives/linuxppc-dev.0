Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id DCFD9B70EB
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 01:12:48 +1100 (EST)
Received: by pzk4 with SMTP id 4so439144pzk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 07:12:47 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 14 Oct 2010 08:12:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] spi/fsl_spi: Fix compile errors when building on ppc64
Message-ID: <20101014141244.GA4312@angua.secretlab.ca>
References: <1287064547-8876-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287064547-8876-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2010 at 08:55:47AM -0500, Kumar Gala wrote:
> We get the following when building on ppc64 due to lack of include of
> <asm/io.h>:

Is this an immediate problem (merge for .36), or is it a linux-next thing?

g.

> 
> In file included from drivers/spi/spi_fsl_espi.c:25:0:
> drivers/spi/spi_fsl_lib.h: In function 'mpc8xxx_spi_write_reg':
> drivers/spi/spi_fsl_lib.h:88:2: error: implicit declaration of function 'out_be32'
> drivers/spi/spi_fsl_lib.h: In function 'mpc8xxx_spi_read_reg':
> drivers/spi/spi_fsl_lib.h:93:2: error: implicit declaration of function 'in_be32'
> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_remove':
> drivers/spi/spi_fsl_espi.c:571:2: error: implicit declaration of function 'iounmap'
> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_probe':
> drivers/spi/spi_fsl_espi.c:602:2: error: implicit declaration of function 'ioremap'
> drivers/spi/spi_fsl_espi.c:602:24: warning: assignment makes pointer from integer without a cast
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  drivers/spi/spi_fsl_lib.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> index 15aa6c2..281e060 100644
> --- a/drivers/spi/spi_fsl_lib.h
> +++ b/drivers/spi/spi_fsl_lib.h
> @@ -18,6 +18,8 @@
>  #ifndef __SPI_FSL_LIB_H__
>  #define __SPI_FSL_LIB_H__
>  
> +#include <asm/io.h>
> +
>  /* SPI/eSPI Controller driver's private data. */
>  struct mpc8xxx_spi {
>  	struct device *dev;
> -- 
> 1.7.2.3
> 
