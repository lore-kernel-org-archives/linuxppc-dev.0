Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D2E7DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 04:03:44 +1100 (EST)
In-Reply-To: <20070110011124.20342.38130.stgit@localhost.localdomain>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1664D59-5C48-45DF-8C53-5E1AE6AEDAF4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: Updates for CPM2 pic
Date: Wed, 10 Jan 2007 11:02:52 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2007, at 7:11 PM, Vitaly Bordug wrote:

>
> This contains important fixes for the CPM2 PIC code. Eliminated
> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the  
> interrupt
> mapping. Updated devicetree files to reflect that. Changed direct
> IC-related IO accesses to the IO accessors.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---

[snip]

> diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/ 
> mpc8260.h
> new file mode 100644
> index 0000000..c2adcb0
> --- /dev/null
> +++ b/include/asm-powerpc/mpc8260.h
> @@ -0,0 +1,32 @@
> +/*
> + * Since there are many different boards and no standard  
> configuration,
> + * we have a unique include file for each.  Rather than change every
> + * file that has to include MPC8260 configuration, they all include
> + * this one and the configuration switching is done here.
> + */
> +#ifdef __KERNEL__
> +#ifndef __ASM_PPC_MPC8260_H__
> +#define __ASM_PPC_MPC8260_H__
> +
> +
> +#ifdef CONFIG_8260
> +
> +#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
> +#include <platforms/82xx/pq2ads.h>
> +#endif

What's defined in pq2ads.h that is needed by other code?

> +
> +#ifdef CONFIG_PCI_8260
> +#include <platforms/82xx/m82xx_pci.h>
> +#endif
> +
> +#ifndef _ISA_MEM_BASE
> +#define _ISA_MEM_BASE   0
> +#endif
> +
> +#ifndef PCI_DRAM_OFFSET
> +#define PCI_DRAM_OFFSET 0
> +#endif
> +
> +#endif /* CONFIG_8260 */
> +#endif /* !__ASM_PPC_MPC8260_H__ */
> +#endif /* __KERNEL__ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
