Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57F96DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:04:58 +1100 (EST)
Message-ID: <47698773.1010004@freescale.com>
Date: Wed, 19 Dec 2007 15:04:51 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
In-Reply-To: <20071219203817.GD20861@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
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
> index 3cf84d0..91bac51 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1242,7 +1242,7 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
>  	}
>  
>  	for (np = NULL, i = 1;
> -	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
> +	     (np = of_find_compatible_node(np, NULL, "fsl,spi")) != NULL;

Can you keep the original code around to look for older device trees that are 
wrong?  Backwards compatibility is important.  I don't want to have to update 
the device tree just because I update the kernel.

-- 
Timur Tabi
Linux kernel developer at Freescale
