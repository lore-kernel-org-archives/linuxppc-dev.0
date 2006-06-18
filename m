Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B30167B32
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 00:31:07 +1000 (EST)
In-Reply-To: <E1Frjet-0004PA-J1@jdl.com>
References: <E1Frjet-0004PA-J1@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D9D3C577-D46A-47BA-A1E0-844B95061F57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 7/9 v3] Add 8641 Register space and IRQ definitions.
Date: Sun, 18 Jun 2006 09:31:53 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2006, at 5:52 PM, Jon Loeliger wrote:

[snip]

> diff --git a/include/asm-powerpc/mpc86xx.h b/include/asm-powerpc/ 
> mpc86xx.h
> new file mode 100644
> index 0000000..d0a6718
> --- /dev/null
> +++ b/include/asm-powerpc/mpc86xx.h
> @@ -0,0 +1,47 @@
> +/*
> + * MPC86xx definitions
> + *
> + * Author: Jeff Brown
> + *
> + * Copyright 2004 Freescale Semiconductor, Inc
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
> +#ifdef __KERNEL__
> +#ifndef __ASM_POWERPC_MPC86xx_H__
> +#define __ASM_POWERPC_MPC86xx_H__
> +
> +#include <linux/config.h>
> +#include <asm/mmu.h>
> +
> +#ifdef CONFIG_PPC_86xx
> +
> +#ifdef CONFIG_MPC8641_HPCN
> +#include <platforms/86xx/mpc8641_hpcn.h>
> +#endif
>

Is this really needed, its a hold over from arch/ppc.  I dont think  
you need anything defined in mpc8641_hpcn.h.  This always created  
funny dependancies and would be nice to get ride of.

> +
> +#define _IO_BASE        isa_io_base
> +#define _ISA_MEM_BASE   isa_mem_base
> +#ifdef CONFIG_PCI
> +#define PCI_DRAM_OFFSET pci_dram_offset
> +#else
> +#define PCI_DRAM_OFFSET 0
> +#endif
> +
> +#define CPU0_BOOT_RELEASE 0x01000000
> +#define CPU1_BOOT_RELEASE 0x02000000
> +#define CPU_ALL_RELEASED (CPU0_BOOT_RELEASE | CPU1_BOOT_RELEASE)
> +#define MCM_PORT_CONFIG_OFFSET 0x1010
> +
> +/* Offset from CCSRBAR */
> +#define MPC86xx_OPENPIC_OFFSET	(0x40000)
> +#define MPC86xx_MCM_OFFSET      (0x00000)
> +#define MPC86xx_MCM_SIZE        (0x02000)
> +
> +#endif /* CONFIG_PPC_86xx */
> +#endif /* __ASM_POWERPC_MPC86xx_H__ */
> +#endif /* __KERNEL__ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
