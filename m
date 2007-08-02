Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] fixes for the SLB shadow buffer 
In-reply-to: <1186004885.22717.50.camel@farscape.rchland.ibm.com> 
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186004885.22717.50.camel@farscape.rchland.ibm.com>
Date: Thu, 02 Aug 2007 15:56:31 +1000
Message-ID: <24613.1186034191@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
> > +++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
> > @@ -389,7 +389,9 @@ BEGIN_FTR_SECTION
> >  	ld	r9,PACA_SLBSHADOWPTR(r13)
> >  	li	r12,0
> >  	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
> > +	eieio
> >  	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
> > +	eieio
> >  	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
> > 
> Hi Michael, 
> 
> I was going to ask if we really needed both of them, but think I
> convinced myself that we do.
>  
> Do we also want/need an eieio after the /* Save ESID */ statement, or is
> that somehow handled by the slbie following?

Actually, I think we can remove the barriers all together.

The ordering depends on how the buffer is accessed.

If each CPU only access it's own shadow buffer, then we are ok, but this
isn't the case when we take a checkpoint restart, like in POWER6, the
buffer must be read by a separate CPU.  

But even in the case of a checkpoint restart, the ordering will be
preserved as the NIA we get as part of the checkpoint will have all
previous instructions complete and none of the following instructions
started.

So I guess the questions is, does PHYP even need to access the shadow
buffer of another CPU, while that other CPU is in flight.  I'm not sure
that they can as they can't read the entire buffer atomically if the
target CPU is still active.  So PHYP must stop instructions on the
target CPU, before it reads it's shadow buffer.  Hence no ordering
problems.

I should probably talk to some PHYP guys to confirm, but i think we can
remove all the barriers when writing to the shadow buffer

Mikey
