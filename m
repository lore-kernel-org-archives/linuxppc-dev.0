Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF9AFDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 08:34:07 +1000 (EST)
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <31580.1185948147@neuling.org>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 08:33:56 +1000
Message-Id: <1186007636.5495.536.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-01 at 16:02 +1000, Michael Neuling wrote:
> We sometimes change the vmalloc segment in slb_flush_and_rebolt but we
> never updated with slb shadow buffer.  This fixes it.  Thanks to paulus
> for finding this.
> 
> Also added some write barriers to ensure the shadow buffer is always
> valid.

The shadow is global or per-cpu ?

Because in the later case, I think you need more than that.

> Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_utils_64.c
> +++ linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
> @@ -629,6 +629,9 @@ int hash_page(unsigned long ea, unsigned
>  	cpumask_t tmp;
>  	int rc, user_region = 0, local = 0;
>  	int psize;
> +#ifdef CONFIG_PPC_64K_PAGES
> +	unsigned long vflags;
> +#endif
>  
>  	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
>  		ea, access, trap);
> @@ -759,6 +762,9 @@ int hash_page(unsigned long ea, unsigned
>  		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
>  		get_paca()->vmalloc_sllp =
>  			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> +		vflags = SLB_VSID_KERNEL |
> +			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> +		slb_shadow_update(VMALLOC_START, vflags, 1);
>  		slb_flush_and_rebolt();
>  	}

Later on:

        } else if (get_paca()->vmalloc_sllp !=
                   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
                get_paca()->vmalloc_sllp =
                        mmu_psize_defs[mmu_vmalloc_psize].sllp;
                slb_flush_and_rebolt();
        }

If your shadow is per-cpu, you need to fix that up too.

I'm tempted to think you should just expose an slb_vmalloc_update()
from slb.c that does the shadow update and calls flush_and_rebolt.
That would also get rid of your ifdef on vflags definition (which
wasn't necessary in the first place if you had put it inside the
if statement anyway).

Ben.
