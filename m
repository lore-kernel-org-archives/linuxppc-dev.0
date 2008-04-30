Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4845BDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:01:49 +1000 (EST)
Subject: Re: [patch 1/5] POWERPC: Fix slb.c compile warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4818F1BA.80408@am.sony.com>
References: <20080430215644.655638516@am.sony.com> <4818F1BA.80408@am.sony.com>
Content-Type: text/plain
Date: Thu, 01 May 2008 09:01:41 +1000
Message-Id: <1209596501.18023.260.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-30 at 15:24 -0700, Geoff Levand wrote:
> Arrange for a syntax check to always be done on the powerpc/mm/slb.c
> DBG() macro by defining it to pr_debug() for non-debug builds. 
> 
> Also, fix these related compile warnings:
> 
>   slb.c:273: warning: format '%04x' expects type 'unsigned int', but argument 2 has type 'long unsigned int
>   slb.c:274: warning: format '%04x' expects type 'unsigned int', but argument 2 has type 'long unsigned int'
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/mm/slb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -30,7 +30,7 @@
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
>  #else
> -#define DBG(fmt...)
> +#define DBG pr_debug
>  #endif
>  
>  extern void slb_allocate_realmode(unsigned long ea);
> @@ -279,8 +279,8 @@ void slb_initialize(void)
>  		patch_slb_encoding(slb_compare_rr_to_size,
>  				   mmu_slb_size);
>  
> -		DBG("SLB: linear  LLP = %04x\n", linear_llp);
> -		DBG("SLB: io      LLP = %04x\n", io_llp);
> +		DBG("SLB: linear  LLP = %04lx\n", linear_llp);
> +		DBG("SLB: io      LLP = %04lx\n", io_llp);
>  	}
>  
>  	get_paca()->stab_rr = SLB_NUM_BOLTED;
> 
