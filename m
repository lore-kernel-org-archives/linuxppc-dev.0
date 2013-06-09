Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc/tm: Fix restoration of MSR on 32bit signal
 return
In-reply-to: <1370762860.14883.13.camel@pasglop>
References: <1370601390-29065-1-git-send-email-mikey@neuling.org>
 <1370601390-29065-3-git-send-email-mikey@neuling.org>
 <1370762860.14883.13.camel@pasglop>
Date: Sun, 09 Jun 2013 19:56:42 +1000
Message-ID: <13224.1370771802@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2013-06-07 at 20:36 +1000, Michael Neuling wrote:
> > Currently we clear out the MSR TM bits on signal return assuming that the
> > signal should never return to an active transaction.
> > 
> > This is bogus as the user may do this.  It's most likely the transaction will
> > be doomed due to a treclaim but that's a problem for the HW not the kernel.
> > 
> > This removes the stripping of these MSR TM bits.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> 
> > @@ -859,8 +860,10 @@ static long restore_tm_user_regs(struct pt_regs *regs,
> >  	tm_enable();
> >  	/* This loads the checkpointed FP/VEC state, if used */
> >  	tm_recheckpoint(&current->thread, msr);
> > -	/* The task has moved into TM state S, so ensure MSR reflects this */
> > -	regs->msr = (regs->msr & ~MSR_TS_MASK) | MSR_TS_S;
> > +	/* Retore the top half of the MSR */
> > +	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
> > +		return 1;
> > +	regs->msr = (regs->msr | (((unsigned long)msr_hi) << 32));
> 
> What kind of damage can I do by calling sigreturn with a cooked
> frame with random MSR bits set ? You should probably filter
> what bits you allow to come from the frame.

Lots of damage.. good, point.  

We do that in the 64 bit version of this.  I'll update to do the same.

> Additionally, I would also make sure I only do that if the CPU
> features say TM is supported in case that MSR bit means something else
> on a different/older CPU...

Ok, I'll add that also.

Mikey
