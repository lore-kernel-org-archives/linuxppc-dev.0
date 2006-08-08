Return-Path: <mikey@ozlabs.org>
To: Milton Miller <miltonm@bga.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] SLB shadow buffer 
In-reply-to: <11154999753625558ec1.596516649.miltonm@bga.com> 
References: <11154999753625558ec1.596516649.miltonm@bga.com>
Date: Tue, 08 Aug 2006 14:21:05 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060808042106.4379E679FD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +#define SHADOW_SLB_BOLTED_STACK_ESID \
> > +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1))
> > +#define SHADOW_SLB_BOLTED_STACK_VSID \
> > +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1) + 8)
> > +
> Still a bit of magic size, but not likely to change.
> 
> Maybe an expicit define for the slot?

Arrh nice, I can do this all in asm-offsets.  Much less magic.

> > +	/* Update the last bolted SLB */
> > +	ld	r9,PACA_SLBSHADOWPTR(r13)
> > + 	li	r12,0
> > +  	std	r12,SHADOW_SLB_BOLTED_STACK_ESID(r9) /* Clear ESID */
> > +	std	r7,SHADOW_SLB_BOLTED_STACK_VSID(r9)  /* Save VSID */
> > + 	std	r0,SHADOW_SLB_BOLTED_STACK_ESID(r9)  /* Save ESID */
> > +
> 
>  Still some leading spaces hiding

Yep... oops.  

> 
> >  Index: linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
> 
> > @@ -133,5 +135,22 @@ struct > > > lppaca {
> >  
> >  extern struct lppaca lppaca[];
> >  
> > +/*
> > + * SLB shadow buffer structure as defined in the PAPR.  The save_area
> > + * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
> > + * ESID is stored in the lower 64bits, then the VSID.
> > + */
> > +struct slb_shadow {
> > +	u32	persistent;		// Number of persistent SLBs	x00-x03
> > +	u32	buffer_length;		// Total shadow buffer length	x04-x07
> > +	u64	reserved;		// Alignment			x08-x0f
> > +	struct	{
> > +		u64     esid;
> > +		u64	vsid;
> > +	} save_area[SLB_NUM_BOLTED];	//				x10-x40
> > +} ____cacheline_aligned;
> > +
> 
> C comments ... or in the separate cleanup patch

I think I'll post a full lppaca cleanup patch in a bit.  

> > +extern struct slb_shadow slb_shadow[];
> > +
> >  #endif /* __KERNEL__ */
> >  #endif /* _ASM_POWERPC_LPPACA_H */
> > Index: linux-2.6-ozlabs/include/asm-powerpc/paca.h
> > ===================================================================
> > 
> >  	/* accumulated system TB ticks */
> >  	u64 startpurr;			/* PURR/TB value snapshot */
> > +
> > +	struct slb_shadow *slb_shadow_ptr;
> >  };
>  
> Do we need the extra line?  (I haven't looked at the result)

They are broken into logical groups, so no.

Updated patch to come.

Michael
