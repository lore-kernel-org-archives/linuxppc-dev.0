Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id AF49B679FB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 11:17:38 +1000 (EST)
Date: Mon, 7 Aug 2006 20:15:53 -0500
From: Milton Miller <miltonm@bga.com>
To: mikey@neuling.org, linuxppc-dev@ozlabs.org,
Subject: Re: [PATCH] SLB shadow buffer
Message-Id: <11154999753625558ec1.596516649.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org, anton@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon Aug  7 2006 01:19:19 AM CDT, Michael Neuling wrote:

> Updated with comments from Milton.

Better

> +#define SHADOW_SLB_BOLTED_STACK_ESID \
> +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1))
> +#define SHADOW_SLB_BOLTED_STACK_VSID \
> +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1) + 8)
> +

Still a bit of magic size, but not likely to change.

Maybe an expicit define for the slot?


> +	/* Update the last bolted SLB */
> +	ld	r9,PACA_SLBSHADOWPTR(r13)
> + 	li	r12,0
> +  	std	r12,SHADOW_SLB_BOLTED_STACK_ESID(r9) /* Clear ESID */
> +	std	r7,SHADOW_SLB_BOLTED_STACK_VSID(r9)  /* Save VSID */
> + 	std	r0,SHADOW_SLB_BOLTED_STACK_ESID(r9)  /* Save ESID */
> +

 Still some leading spaces hiding

>  Index: linux-2.6-ozlabs/include/asm-powerpc/lppaca.h

> @@ -133,5 +135,22 @@ struct > > > lppaca {
>  
>  extern struct lppaca lppaca[];
>  
> +/*
> + * SLB shadow buffer structure as defined in the PAPR.  The save_area
> + * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
> + * ESID is stored in the lower 64bits, then the VSID.
> + */
> +struct slb_shadow {
> +	u32	persistent;		// Number of persistent SLBs	x00-x03
> +	u32	buffer_length;		// Total shadow buffer length	x04-x07
> +	u64	reserved;		// Alignment			x08-x0f
> +	struct	{
> +		u64     esid;
> +		u64	vsid;
> +	} save_area[SLB_NUM_BOLTED];	//				x10-x40
> +} ____cacheline_aligned;
> +

C comments ... or in the separate cleanup patch

> +extern struct slb_shadow slb_shadow[];
> +
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_LPPACA_H */
> Index: linux-2.6-ozlabs/include/asm-powerpc/paca.h
> ===================================================================
> 
>  	/* accumulated system TB ticks */
>  	u64 startpurr;			/* PURR/TB value snapshot */
> +
> +	struct slb_shadow *slb_shadow_ptr;
>  };
 
Do we need the extra line?  (I haven't looked at the result)

milton
