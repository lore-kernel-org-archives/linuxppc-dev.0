Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] Allocate the hash table under 1G on cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <f7985e5b32565961444283819eaeeda86f471fc8.1201257905.git.michael@ellerman.id.au>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<f7985e5b32565961444283819eaeeda86f471fc8.1201257905.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:23:00 +1100
Message-Id: <1202170980.7079.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 21:45 +1100, Michael Ellerman wrote:
> In order to support our IOMMU performance trick, we need the hash table to be
> inside the DMA window. This is usually 2G, but let's make sure the hash table
> is under 1G as that will satisfy the IOMMU requirements and also means the
> hash table will be on node 0.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/mm/hash_utils_64.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 9326a69..487c5e2 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -471,7 +471,7 @@ void __init htab_initialize(void)
>  	unsigned long table;
>  	unsigned long pteg_count;
>  	unsigned long mode_rw;
> -	unsigned long base = 0, size = 0;
> +	unsigned long base = 0, size = 0, limit;
>  	int i;
>  
>  	extern unsigned long tce_alloc_start, tce_alloc_end;
> @@ -505,9 +505,15 @@ void __init htab_initialize(void)
>  		_SDR1 = 0; 
>  	} else {
>  		/* Find storage for the HPT.  Must be contiguous in
> -		 * the absolute address space.
> +		 * the absolute address space. On cell we want it to be
> +		 * in the first 1 Gig.
>  		 */
> -		table = lmb_alloc(htab_size_bytes, htab_size_bytes);
> +		if (machine_is(cell))
> +			limit = 0x40000000;
> +		else
> +			limit = 0;
> +
> +		table = lmb_alloc_base(htab_size_bytes, htab_size_bytes, limit);
>  
>  		DBG("Hash table allocated at %lx, size: %lx\n", table,
>  		    htab_size_bytes);
