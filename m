Return-Path: <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [POWERPC] minor paca optimisation 
In-reply-to: <20070316174707.8a5ae78c.sfr@canb.auug.org.au> 
References: <20070316174707.8a5ae78c.sfr@canb.auug.org.au>
Date: Fri, 16 Mar 2007 12:18:09 -0500
Message-ID: <12742.1174065489@neuling.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Move the slb_shadow_ptr field into the first cache line since it is
> (like evrything there) read only after boot.  It is in fact statically
> initialised and there after only read.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  include/asm-powerpc/paca.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
> index 0d3adc0..4de851d 100644
> --- a/include/asm-powerpc/paca.h
> +++ b/include/asm-powerpc/paca.h
> @@ -70,6 +70,7 @@ struct paca_struct {
>  	s16 hw_cpu_id;			/* Physical processor number */
>  	u8 cpu_start;			/* At startup, processor spins until */
>  					/* this becomes non-zero. */
> +	struct slb_shadow *slb_shadow_ptr;
>  
>  	/*
>  	 * Now, starting in cacheline 2, the exception save areas
> @@ -101,8 +102,6 @@ struct paca_struct {
>  	u64 user_time;			/* accumulated usermode TB ticks */
>  	u64 system_time;		/* accumulated system TB ticks */
>  	u64 startpurr;			/* PURR/TB value snapshot */
> -
> -	struct slb_shadow *slb_shadow_ptr;
>  };
>  
>  extern struct paca_struct paca[];
> -- 
> 1.5.0.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
