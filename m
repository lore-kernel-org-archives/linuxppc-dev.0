Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F585DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 15:31:34 +1000 (EST)
In-Reply-To: <20070808170930.GB21487@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
	<20070808170930.GB21487@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8D1ADDCA-AA02-4108-87AD-529BF081AD52@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] [POWERPC] fsl_soc: add support for fsl_spi
Date: Thu, 9 Aug 2007 00:33:01 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 8, 2007, at 12:09 PM, Anton Vorontsov wrote:

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   88 ++++++++++++++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/sysdev/fsl_soc.h |   12 ++++++
>  2 files changed, 100 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index 727453d..0771700 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -23,6 +23,7 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
> +#include <linux/spi/spi.h>
>  #include <linux/fsl_devices.h>
>  #include <linux/fs_enet_pd.h>
>  #include <linux/fs_uart_pd.h>
> @@ -1186,3 +1187,90 @@ err:
>  arch_initcall(cpm_smc_uart_of_init);
>
>  #endif /* CONFIG_8xx */
> +
> +int fsl_spi_init(struct fsl_spi_board_info *binfo)

Do we really need a struct, can we not just pass the 4 params as args  
to the function?

May need to a typedef to linux/fsl_device.h for the chipselect call  
back.

- k
