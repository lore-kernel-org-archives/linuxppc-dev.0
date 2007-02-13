Return-Path: <mikey@neuling.org>
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 4/16] powerpc: Allow duplicate lmb_reserve() calls 
In-reply-to: <20070213061024.82D45DDD0D@ozlabs.org> 
References: <20070213061024.82D45DDD0D@ozlabs.org>
Date: Tue, 13 Feb 2007 18:05:20 +1100
Message-ID: <21160.1171350320@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> At present calling lmb_reserve() (and hence lmb_add_region()) twice
> for exactly the same memory region will cause strange behaviour.
> 
> This makes life difficult when booting from a flat device tree with
> memory reserve map.  Which regions are automatically reserved by the
> kernel has changed over time, so it's quite possible a newer kernel
> could attempt to auto-reserve a region which is also explicitly listed
> in the device tree's reserve map, leading to trouble.
> 
> This patch avoids the problem by making lmb_reserve() ignore a call to
> reserve a previously reserved region.  It also removes a now redundant
> test designed to avoid one specific case of the problem noted above.
> 
> At present, this patch deals only with duplicate reservations of an
> identical region.  Attempting to reserve two different, but
> overlapping regions will still cause problems.  I might post another
> patch later dealing with this case, but I'm avoiding it now since it
> is substantially more complicated to deal with, less likely to occur
> and more likely to indicate a genuine bug elsewhere if it does occur.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---
> 
> 
>  arch/powerpc/kernel/prom.c |    3 ---
>  arch/powerpc/mm/lmb.c      |    4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> Index: working-2.6/arch/powerpc/mm/lmb.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/mm/lmb.c	2007-02-06 16:21:02.000000000 +
1100
> +++ working-2.6/arch/powerpc/mm/lmb.c	2007-02-06 16:22:32.000000000 +1100
> @@ -146,6 +146,10 @@ static long __init lmb_add_region(struct
>  		unsigned long rgnbase = rgn->region[i].base;
>  		unsigned long rgnsize = rgn->region[i].size;
>  
> +		if ((rgnbase == base) && (rgnsize == size))
> +			/* Already have this region, so we're done */
> +			return 0;

This might indicate that two things actually want to use the same memory
region.  How about we print a warning?

Mikey
