Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 941D8DDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:49:32 +1100 (EST)
Message-Id: <67AD9656-B287-46DD-B9E1-5F77B2EA4E47@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <11981624732110-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/4] sbc8560: add basic support for Wind River SBC8560 as
	powerpc
Date: Thu, 20 Dec 2007 17:49:26 -0600
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<11981624732110-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 20, 2007, at 8:54 AM, Paul Gortmaker wrote:

> This adds the basic support for the Wind River SBC8560 board,  
> implemented
> as powerpc.  It closely follows the implementation of the MPC8560ADS.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig   |   11 +-
> arch/powerpc/platforms/85xx/Makefile  |    1 +
> arch/powerpc/platforms/85xx/sbc8560.c |  302 ++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 312 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
> platforms/85xx/Kconfig
> index 7748a3a..0eb497b 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -38,6 +38,13 @@ config MPC85xx_DS
> 	help
> 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
>
> +config SBC8560
> +	bool "Wind River SBC8560"
> +	select DEFAULT_UIMAGE
> +	select PPC_CPM_NEW_BINDING
> +	help
> +	  This option enables support for the Wind River SBC8560 board
> +
> endchoice
>
> config MPC8540
> @@ -49,7 +56,7 @@ config MPC8540
> config MPC8560
> 	bool
> 	select CPM2
> -	default y if MPC8560_ADS
> +	default y if MPC8560_ADS || SBC8560
>
> config MPC85xx
> 	bool
> @@ -59,4 +66,4 @@ config MPC85xx
> 	select FSL_PCI if PCI
> 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
> 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
> -		|| MPC85xx_MDS || MPC85xx_DS
> +		|| MPC85xx_MDS || MPC85xx_DS || SBC8560
> diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/ 
> platforms/85xx/Makefile
> index 5eca920..c3f4d01 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
> obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
> obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
> obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
> +obj-$(CONFIG_SBC8560) += sbc8560.o
> diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/ 
> platforms/85xx/sbc8560.c
> new file mode 100644
> index 0000000..6aef38b
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/sbc8560.c
> @@ -0,0 +1,302 @@
> +/*
> + * Wind River SBC8560 setup and early boot code.
> + *
> + * Copyright 2007 Wind River Systems Inc.
> + *
> + * By Paul Gortmaker (see MAINTAINERS for contact information)
> + *
> + * Based largely on the MPC8560ADS support - Copyright 2005  
> Freescale Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpic.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/udbg.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +
> +#ifdef CONFIG_CPM2
> +#include <asm/cpm2.h>
> +#include <sysdev/cpm2_pic.h>
> +#endif
> +
> +#ifdef CONFIG_PCI
> +static int sbc8560_exclude_device(struct pci_controller *hose,
> +				   u_char bus, u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}

do you really need to exclude the PHB itself?  I've fixed this for FSL  
PHBs so I don't believe you need this anymore.

>
> +#endif /* CONFIG_PCI */
> +

- k
