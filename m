Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A3CA67BCE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 13:28:45 +1100 (EST)
In-Reply-To: <20061211223709.20169.93595.stgit@localhost.localdomain>
References: <20061212012641.5ef493f7@localhost.localdomain>
	<20061211223709.20169.93595.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9EC45741-28F3-49C7-9F0A-8EA3DA6A6290@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads.
Date: Mon, 11 Dec 2006 20:28:38 -0600
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


On Dec 11, 2006, at 4:37 PM, Vitaly Bordug wrote:

>
> Recent update of asm-powerpc/io.h caused cpm-related stuff to break  
> in the
> current kernel. Current patch fixes it, and includes other overhaul  
> and
> improvements (incomplete list is below). Required for proper  
> functioning of
> the 8xx stuff as well.
>
> - Updated dts with a chosen node with interrupt controller,
> - fixed messed device IDs among CPM2 SoC devices,
> - corrected odd header name and fixed type in defines,
> - Added 82xx subdir to the powerpc/platforms Makefile, new
>   solely-powerpc header for 8260 family (was using one from arch/ 
> ppc, this
>   one cleaned up from the extra stuff).
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
[snip]
>
> diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
> index 4c3af35..c624915 100644
> --- a/include/asm-powerpc/fs_pd.h
> +++ b/include/asm-powerpc/fs_pd.h
> @@ -17,6 +17,12 @@ #include <asm/time.h>
>  #ifdef CONFIG_CPM2
>  #include <asm/cpm2.h>
>
> +#if defined(CONFIG_8260)
> +#include <asm/mpc8260.h>
> +#elif defined(CONFIG_85xx)
> +#include <asm/mpc85xx.h>
> +#endif
> +

Why does this need to include these files?

>  #define cpm2_map(member)						\
>  ({									\
>  	u32 offset = offsetof(cpm2_map_t, member);			\
> @@ -37,6 +43,7 @@ #endif
>
>  #ifdef CONFIG_8xx
>  #include <asm/8xx_immap.h>
> +#include <asm/mpc8xx.h>
>
>  #define immr_map(member)						\
>  ({									\
>

> diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
> index 1cd5323..301c9bb 100644
> --- a/include/asm-powerpc/io.h
> +++ b/include/asm-powerpc/io.h
> @@ -732,6 +732,12 @@ #define page_to_bus(page)	(page_to_phys(
>
>  #endif /* CONFIG_PPC32 */
>
> +/* access ports */
> +#define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |   
> (_v))
> +#define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~ 
> (_v))
> +
> +#define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |   
> (_v))
> +#define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~ 
> (_v))
>
>  #endif /* __KERNEL__ */
>
> diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/ 
> mpc8260.h
> new file mode 100644
> index 0000000..c2adcb0
> --- /dev/null
> +++ b/include/asm-powerpc/mpc8260.h

Who needs this header?  Is this just for the board code under  
platforms/82xx?

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
