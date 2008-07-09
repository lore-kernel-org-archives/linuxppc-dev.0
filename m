Return-Path: <benh@au1.ibm.com>
Subject: Re: [patch 5/5] powerpc: Dont clear _PAGE_COHERENT when _PAGE_SAO
	is set
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <20080707143011.729373219@linux.vnet.ibm.com>
References: <20080707142850.034542257@linux.vnet.ibm.com>
	<20080707143011.729373219@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 13:46:17 +1000
Message-Id: <1215575177.8970.311.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 09:28 -0500, Dave Kleikamp wrote:
> plain text document attachment (dont_clobber_M.patch)
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

The old code looks bogus.. why clear M when G is set ? Only
I should have mattered.

I'll apply anyway as you aren't changing the existing behaviour here but
maybe you can shoot me a fixup patch that removes the _PAGE_GUARDED
condition completely here ?

It's legal to have G=1 M=1 pages and can even be useful under some
circumstances.

Cheers,
Ben.

>  arch/powerpc/platforms/pseries/lpar.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: b/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -305,7 +305,8 @@
>  	flags = 0;
>  
>  	/* Make pHyp happy */
> -	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
> +	if ((rflags & _PAGE_GUARDED) ||
> +	    ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU)))
>  		hpte_r &= ~_PAGE_COHERENT;
>  
>  	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
> 
