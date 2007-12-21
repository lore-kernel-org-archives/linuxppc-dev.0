Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE5E1DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 02:32:34 +1100 (EST)
Message-Id: <E22DFF32-E85B-4A58-89D4-E447BEB8BA28@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <11982194344016-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] sbc8548: Add basic support for Wind River SBC8548 as
	powerpc
Date: Fri, 21 Dec 2007 09:32:29 -0600
References: <11982194332672-git-send-email-paul.gortmaker@windriver.com>
	<11982194344016-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 21, 2007, at 12:43 AM, Paul Gortmaker wrote:

> This adds the basic support for the Wind River SBC8548 board,  
> implemented
> as powerpc.  It closely follows the implementation of the MPC8548CDS.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig   |   10 ++-
> arch/powerpc/platforms/85xx/Makefile  |    1 +
> arch/powerpc/platforms/85xx/sbc8548.c |  182 ++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 191 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
> platforms/85xx/Kconfig
> index 33d3bea..8407f43 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -39,6 +39,12 @@ config MPC85xx_DS
> 	help
> 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
>
> +config SBC8548
> +	bool "Wind River SBC8548"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the Wind River SBC8548 board
> +
> config SBC8560
> 	bool "Wind River SBC8560"
> 	select DEFAULT_UIMAGE
> @@ -52,7 +58,7 @@ config MPC8540
> 	bool
> 	select PPC_UDBG_16550
> 	select PPC_INDIRECT_PCI
> -	default y if MPC8540_ADS || MPC85xx_CDS
> +	default y if MPC8540_ADS || MPC85xx_CDS || SBC8548
>
> config MPC8560
> 	bool
> @@ -66,4 +72,4 @@ config MPC85xx
> 	select FSL_PCI if PCI
> 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
> 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
> -		|| MPC85xx_MDS || MPC85xx_DS || SBC8560
> +		|| MPC85xx_MDS || MPC85xx_DS || SBC8560 || SBC8548
> diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/ 
> platforms/85xx/Makefile
> index c3f4d01..3a47b7a 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
> obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
> obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
> obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
> +obj-$(CONFIG_SBC8548) += sbc8548.o
> obj-$(CONFIG_SBC8560) += sbc8560.o
> diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/ 
> platforms/85xx/sbc8548.c
> new file mode 100644
> index 0000000..f3ab271
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/sbc8548.c
> @@ -0,0 +1,182 @@
> +/*
> + * Wind River SBC8548 setup and early boot code.
> + *
> + * Copyright 2007 Wind River Systems Inc.
> + *
> + * By Paul Gortmaker (see MAINTAINERS for contact information)
> + *
> + * Based largely on the MPC8548CDS support - Copyright 2005  
> Freescale Inc.
> + *
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
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/initrd.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/irq.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +
> +#ifdef CONFIG_PCI
> +static int sbc8548_exclude_device(struct pci_controller *hose,
> +				  u_char bus, u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}
> +#endif

see comment on the 8560 support, but I don't think you need to exclude  
the PHBs anymore.  I've fixed this so we have a general quick for FSL  
PHBs.

>
- k
