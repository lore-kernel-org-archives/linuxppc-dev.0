Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 687D4DDFC0
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 23:28:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7SDSOXj007389
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 09:28:24 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7SDSNGd163186
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 09:28:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7SDSNb8032100
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 09:28:23 -0400
Date: Thu, 28 Aug 2008 09:28:20 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ilya Yanok <yanok@emcraft.com>, benh@kernel.crashing.org
Subject: Re: [PATCH] ppc4xx_pci: necessary fixes for 4GB RAM size
Message-ID: <20080828092820.2cacaba7@zod.rchland.ibm.com>
In-Reply-To: <1219391015-6317-1-git-send-email-yanok@emcraft.com>
References: <1219391015-6317-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Aug 2008 11:43:35 +0400
Ilya Yanok <yanok@emcraft.com> wrote:

> 1. total_memory should be phys_addr_t not unsigned long
> 2. is_power_of_2() works with u32 so I just inlined (size & (size-1)) != 0
> instead.
> Also this patch fixes default initialization: res->end should be 0x7fffffff
> not 0x80000000.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Ben, any comments here?  Looks right to me.

josh

> ---
>  arch/powerpc/sysdev/ppc4xx_pci.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index e1c7df9..645b2c9 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -36,7 +36,7 @@
>  static int dma_offset_set;
> 
>  /* Move that to a useable header */
> -extern unsigned long total_memory;
> +extern phys_addr_t total_memory;
> 
>  #define U64_TO_U32_LOW(val)	((u32)((val) & 0x00000000ffffffffULL))
>  #define U64_TO_U32_HIGH(val)	((u32)((val) >> 32))
> @@ -105,7 +105,8 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
> 
>  	/* Default */
>  	res->start = 0;
> -	res->end = size = 0x80000000;
> +	size = 0x80000000;
> +	res->end = size - 1;
>  	res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
> 
>  	/* Get dma-ranges property */
> @@ -167,13 +168,13 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
>  	 */
>  	if (size < total_memory) {
>  		printk(KERN_ERR "%s: dma-ranges too small "
> -		       "(size=%llx total_memory=%lx)\n",
> -		       hose->dn->full_name, size, total_memory);
> +		       "(size=%llx total_memory=%llx)\n",
> +		       hose->dn->full_name, size, (u64)total_memory);
>  		return -ENXIO;
>  	}
> 
>  	/* Check we are a power of 2 size and that base is a multiple of size*/
> -	if (!is_power_of_2(size) ||
> +	if ((size & (size - 1)) != 0  ||
>  	    (res->start & (size - 1)) != 0) {
>  		printk(KERN_ERR "%s: dma-ranges unaligned\n",
>  		       hose->dn->full_name);
