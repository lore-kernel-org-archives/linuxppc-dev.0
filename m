Return-Path: <mikey@ozlabs.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] SLB shadow buffer 
In-reply-to: <111547573996b8b45671.846930886.miltonm@bga.com> 
References: <111547573996b8b45671.846930886.miltonm@bga.com>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 07 Aug 2006 15:55:37 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060807055538.A5386679E7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +#define SHADOW_SLB_BOLTED_LAST_ESID \
> > +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1))
> > +#define SHADOW_SLB_BOLTED_LAST_VSID \
> > +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1) + 8)
> 
> It's not because it's the last one but that it's the one with the stack.

Yep changed to SHADOW_SLB_BOLTED_STACK_<blah>

> > +  	std     r12,SHADOW_SLB_BOLTED_LAST_ESID(r9) /* Clear ESID */
> > +	std     r7,SHADOW_SLB_BOLTED_LAST_VSID(r9)  /* Save VSID */
> > + 	std     r0,SHADOW_SLB_BOLTED_LAST_ESID(r9)  /* Save ESID */
> > +
> 
> Tabs not spaces please

Oops.. done

> > +/*
> > + * 3 persistent SLBs are registered here.  The buffer will be zero
> > + * initially, hence will all be invaild until we actually write them.
> > + */
> > +struct slb_shadow_buffer slb_shadow_buffer[] = {
> > +	[0 ... (NR_CPUS-1)] = {
> > +		.persistent = SLB_NUM_BOLTED,
> > +		.buffer_length = sizeof(struct slb_shadow_buffer),
> > +	},
> > +};
> 
> How about making this per-cpu and setting the paca pointer at runtime?
> It would save NR_CPUS-1 cachelines of data.   Otherwise, put  in
> cacheline_aligned will potentially save some space.

The PAPR requirement is that it's cache aligned so I've added the
necessary  __cacheline_aligned foo.

I did some experiments and without the alignment.  Alignment costs
around 8KB when NR_CPUS=128 so there is some space to be saved if we
play around.

I also tried putting the structure directly in the PACA but I couldn't
get any savings.  I tired in a few different locations in the paca
struct, but it didn't make any difference.  I may have been doing
something stupid though :-)

> 
> > +
> >  /* The Paca is an array with one entry per processor.  Each contains an
> >   * lppaca, which contains the information shared between the
> >   * hypervisor and Linux.
> > @@ -59,7 +71,8 @@ struct lppaca lppaca[] = {
> >  	.lock_token = 0x8000,						    \
> >  	.paca_index = (number),		/* Paca Index */		    \
> >  	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
> > -	.hw_cpu_id = 0xffff,
> > +	.hw_cpu_id = 0xffff,						    \
> > +	.slb_shadow_buffer_ptr = &slb_shadow_buffer[number]
> 
> Trailing , (yeah, still have to add the \ )

Oops.. done

> 
> >  
> >  #ifdef CONFIG_PPC_ISERIES
> >  #define PACA_INIT_ISERIES(number)					    \
> > Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
> > +++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
> > @@ -22,6 +22,8 @@
> >  #include <asm/paca.h>
> >  #include <asm/cputable.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/smp.h>
> > +#include <linux/compiler.h>
> >  
> >  #ifdef DEBUG
> >  #define DBG(fmt...) udbg_printf(fmt)
> > @@ -50,9 +52,29 @@ static inline unsigned long mk_vsid_data
> >  	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
> >  }
> >  
> > +static inline void slb_shadow_update(unsigned long esid, unsigned long vsi
d,
> > +				     unsigned long entry)
> > +{
> > +	/* Clear the ESID first so the entry is not valid while we are
> > +	 * updating it.  Then write the VSID before the real ESID. */
> 
> Multi-line comments get the  */ on it's own line

Ok... (most comments in that file are like this though)

> > +	get_slb_shadow_buffer()->save_area[2*entry] = 0;
> > +	barrier();
> > +	get_slb_shadow_buffer()->save_area[2*entry+1] =	vsid;
> > +	barrier();
> > +	get_slb_shadow_buffer()->save_area[2*entry] = esid;
> > +
> > +}
> 
> This 2* seems magic.  How about an array of structs?

OK, that's two people I've confused.  Changed.

> 
> > +
> >  static inline void create_slbe(unsigned long ea, unsigned long flags,
> >  			       unsigned long entry)
> 
> Should we rename to create_shadowed_slbe?

Good point. Changed


> > +	slb_shadow_update(mk_esid_data(ea, entry),
> > +			  mk_vsid_data(ea, flags),
> > +			  entry);
> 
> Do we need the third line?

Nope.

> 
> > +
> >  	asm volatile("slbmte  %0,%1" :
> >  		     : "r" (mk_vsid_data(ea, flags)),
> >  		       "r" (mk_esid_data(ea, entry))
> 
> Hopefully the compiler only calculates these once.

I've been keeping all my fingers and toes crossed...

> > @@ -77,6 +99,11 @@ void slb_flush_and_rebolt(void)
> >  	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET)
> >  		ksp_esid_data &= ~SLB_ESID_V;
> >  
> > +	/* Only second entry may change here so only resave that */
> > +	slb_shadow_update(ksp_esid_data,
> > +			  mk_vsid_data(ksp_esid_data, lflags),
> > +			  2);
> > +
> 
> 1) it's the third entry 2) it's the stack slot

Yep.  Updated comment.

> 
> >  	asm volatile("isync\n"
> > Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/lpar.c
> > +++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
> > @@ -254,18 +254,32 @@ out:
> >  void vpa_init(int cpu)
> >  {
> >  	int hwcpu = get_hard_smp_processor_id(cpu);
> > -	unsigned long vpa = __pa(&lppaca[cpu]);
> > +	unsigned long vpa;
> 
> This is used for something  other than vpa, rename.

Another complaint about this, I'll changed.

BTW It's called vpa in the PAPR for both calls.

> > +/* SLB shadow buffer structure as defined in the PAPR.  The save_area
> > + * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
> > + * ESID is stored in the lower 64bits, then the VSID.  NOTE: This
> > + * structure is 0x40 bytes long (with 3 bolted SLBs), but PHYP
> > + * complaints if we're not 0x80 (cache line?) aligned.  */
> 
> Own line
> 
> Less explaination needed with array of structs.

Yep and yep.

> 
> > +struct slb_shadow_buffer {
> > +	u32	persistent;		// Number of persistent SLBs	x00-x03
> > +	u32	buffer_length;		// Total shadow buffer length	x04-x07
> > +	u64	reserved;		// Alignment			x08-x0f
> > +	u64     save_area[SLB_NUM_BOLTED * 2];	//			x10-x40
> > +} __attribute__((__aligned__(0x80)));
> > +
> > +extern struct slb_shadow_buffer slb_shadow_buffer[];
> > +
> 
> Remove buffer from these names? They seem quite long for linux.

Ok.  Changed.

> >  	u64 user_time;			/* accumulated usermode TB ticks */
> >  	u64 system_time;		/* accumulated system TB ticks */
> >  	u64 startpurr;			/* PURR/TB value snapshot */
> > +
> > +	/* Pointer to SLB shadow buffer */
> > +	struct slb_shadow_buffer *slb_shadow_buffer_ptr;
> >  };
> 
> With the long name the comment doesn't add much.

True.  The comment was only there since most other items in that struct
were documented.

Thanks for the review.  I'll repost the updated patch.

Mikey
