Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A21CDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 10:24:15 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8J0OBeW031502
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 20:24:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8J0OBfb269542
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 20:24:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8J0OBaZ005691
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 20:24:11 -0400
Date: Thu, 18 Sep 2008 20:01:39 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Victor Gallardo <vgallardo@amcc.com>
Subject: Re: [PATCH v2] Add AMCC Arches eval board support to platforms/44x
Message-ID: <20080918200139.493850fc@zod.rchland.ibm.com>
In-Reply-To: <1221778072-6336-1-git-send-email-vgallardo@amcc.com>
References: <1221778072-6336-1-git-send-email-vgallardo@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallardo@amcc.com>,
	fkan@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Sep 2008 15:47:52 -0700
Victor Gallardo <vgallardo@amcc.com> wrote:

> 
> Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
> ---
>  v2:
>  - remove arches.c and instead use canyonlands.c

That file doesn't exist anymore in my 'next' branch.  That is part of
the reason for the original delay.  See below.

>  - remove reference to IBM_NEW_EMAC_RGMII for ARCHES config
>  - remove reference to IBM_NEW_EMAC_ZMII for ARCHES config
>  - moved reference to IBM_NEW_EMAC_RGMII under CANYONLANDS config
>  - moved reference to IBM_NEW_EMAC_ZMII under CANYONLANDS config
> 
>  arch/powerpc/platforms/44x/Kconfig  |   18 ++++++++++++++----
>  arch/powerpc/platforms/44x/Makefile |    1 +
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 249ba01..be1bce7 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -83,9 +83,23 @@ config CANYONLANDS
>  	select 460EX
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select IBM_NEW_EMAC_EMAC4
> +	select IBM_NEW_EMAC_RGMII
> +	select IBM_NEW_EMAC_ZMII
> +	select IBM_NEW_EMAC_TAH
>  	help
>  	  This option enables support for the AMCC PPC460EX evaluation board.
> 
> +config ARCHES
> +	bool "Arches"
> +	depends on 44x
> +	default n
> +	select 460EX
> +	select IBM_NEW_EMAC_EMAC4
> +	select IBM_NEW_EMAC_TAH
> +	help
> +	  This option enables support for the AMCC PPC460GT evaluation board.

This seems fine.

> +
>  config YOSEMITE
>  	bool "Yosemite"
>  	depends on 44x
> @@ -169,10 +183,6 @@ config 440SPe
>  config 460EX
>  	bool
>  	select PPC_FPU
> -	select IBM_NEW_EMAC_EMAC4
> -	select IBM_NEW_EMAC_RGMII
> -	select IBM_NEW_EMAC_ZMII
> -	select IBM_NEW_EMAC_TAH
> 
>  # 44x errata/workaround config symbols, selected by the CPU models above
>  config IBM440EP_ERR42
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> index 8d0b1a1..3f83f73 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -9,5 +9,6 @@ obj-$(CONFIG_KATMAI)	+= katmai.o
>  obj-$(CONFIG_RAINIER)	+= rainier.o
>  obj-$(CONFIG_WARP)	+= warp.o
>  obj-$(CONFIG_WARP)	+= warp-nand.o
> +obj-$(CONFIG_ARCHES)	+= canyonlands.o
>  obj-$(CONFIG_CANYONLANDS) += canyonlands.o
>  obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o

Instead of modifying the Makefile, you should only have to add the
"amcc,arches" string to the "board" array in ppc44x_simple.c.

We switched to doing this as opposed to having a somewhat bogus "board
compatible" statement with other boards.  That is what was discussed at
OLS, and this is the result.

I can probably fix this patch up myself in a short amount of time, but
I have no way to test it.

josh
