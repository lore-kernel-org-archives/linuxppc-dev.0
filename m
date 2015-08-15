Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC7351A0567
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 12:44:45 +1000 (AEST)
Message-ID: <1439606668.15601.15.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/e6500: hw tablewalk: optimize a bit for tcd
 lock acquiring codes
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 14 Aug 2015 21:44:28 -0500
In-Reply-To: <20150814071309.GH30310@pek-khao-d1.corp.ad.wrs.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-2-git-send-email-haokexin@gmail.com>
 <1439491483.4099.101.camel@freescale.com>
 <20150814071309.GH30310@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-14 at 15:13 +0800, Kevin Hao wrote:
> On Thu, Aug 13, 2015 at 01:44:43PM -0500, Scott Wood wrote:
> > On Thu, 2015-08-13 at 19:51 +0800, Kevin Hao wrote:
> > > It makes no sense to put the instructions for calculating the lock
> > > value (cpu number + 1) and the clearing of eq bit of cr1 in lbarx/stbcx
> > > loop. And when the lock is acquired by the other thread, the current
> > > lock value has no chance to equal with the lock value used by current
> > > cpu. So we can skip the comparing for these two lock values in the
> > > lbz/bne loop.
> > > 
> > > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > > ---
> > >  arch/powerpc/mm/tlb_low_64e.S | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/mm/tlb_low_64e.S 
> > > b/arch/powerpc/mm/tlb_low_64e.S
> > > index 765b419883f2..e4185581c5a7 100644
> > > --- a/arch/powerpc/mm/tlb_low_64e.S
> > > +++ b/arch/powerpc/mm/tlb_low_64e.S
> > > @@ -308,11 +308,11 @@ BEGIN_FTR_SECTION               /* CPU_FTR_SMT */
> > >        *
> > >        * MAS6:IND should be already set based on MAS4
> > >        */
> > > -1:   lbarx   r15,0,r11
> > >       lhz     r10,PACAPACAINDEX(r13)
> > > -     cmpdi   r15,0
> > > -     cmpdi   cr1,r15,1       /* set cr1.eq = 0 for non-recursive */
> > >       addi    r10,r10,1
> > > +     crclr   cr1*4+eq        /* set cr1.eq = 0 for non-recursive */
> > > +1:   lbarx   r15,0,r11
> > > +     cmpdi   r15,0
> > >       bne     2f
> > 
> > You're optimizing the contended case at the expense of introducing stalls 
> > in 
> > the uncontended case.
> 
> Before the patch, the uncontended case code sequence are:
> 1:    lbarx   r15,0,r11
>       lhz     r10,PACAPACAINDEX(r13)
>       cmpdi   r15,0
>       cmpdi   cr1,r15,1       /* set cr1.eq = 0 for non-recursive */
>       addi    r10,r10,1
>       bne     2f
>       stbcx.  r10,0,r11
>       bne     1b
> 
> 
> After the patch:
>       lhz     r10,PACAPACAINDEX(r13)
>       addi    r10,r10,1
>       crclr   cr1*4+eq        /* set cr1.eq = 0 for non-recursive */
> 1:    lbarx   r15,0,r11
>       cmpdi   r15,0
>       bne     2f
>       stbcx.  r10,0,r11
>       bne     1b
> 
> As you know, the lbarx is a Presync instruction and stbcx is a Presync and
> Postsync instruction.

Yes, so don't we want to move instructions after the lbarx if possible, so 
that the presync condition is achieved sooner?

>  Putting the unnecessary instructions in the lbarx/stbcx
> loop also serialize these instructions execution.

Again, the common case should be that the loop executes only once.  The two 
cmpdi instructions should pair, the addi should pair with the bne, and the 
lhz should happen while waiting for the lbarx result.  My understanding of 
how to model this stuff is certainly imperfect/incomplete, so I generally try 
to confirm by testing, but I think both loops take the same number of cycles 
per iteration.

>  The execution latency of
> lbarx is only 3 cycles and there are still two instructions after it.
> Considering the out of order execution optimization after this patch, do you
> really think that new uncontended path will become slower due to this
> additional stall?

The (theoretical) additional time is before the loop, not during it.

> >  Does it really matter if there are more instructions 
> > in the loop?
> 
> I really think we should minimize the window of lbarx/stbcx, for following 
> two
> reasons:
>   - The bigger of this window, the more possible conflicts between the two
>      threads run into this loop simultaneously.

That's more true of the total time the lock is held, not the lbarx/stbcx 
section.

>   - The reservation used by lbarx may be cleared by another thread due to
>      store to the same reservation granule. The smaller the window of
>      lbarx/stbcx, the less possibility to be affected by this.

There's only one other thread that should be touching that reservation 
granule, and it's the one we're waiting for.

In any case, if there is a difference in loop iteration execution time, it's 
small.

> > This change just means that you'll spin in the loop for more 
> > iterations (if it even does that -- I think the cycles per loop iteration 
> > might be the same before and after, due to load latency and pairing) 
> > while 
> > waiting for the other thread to release the lock.
> 
> Besides the optimization for the contended case, it also make the code more
> readable with these changes:
>   - It always seem a bit weird to calculate the lock value for the current
>     cpu in the lbarx/stbcx loop.
>   - The "cmpdi   cr1,r15,1" seems pretty confusion. It doesn't always do 
> what
>     the comment said (set cr1.eq = 0). In some cases, it does set the
>     crq.eq = 1, such as when running on cpu 1 with lock is acquired by cpu0.
>     All we need to do just clear the cr1.eq unconditionally.

We only care about cr1.eq when we break out of the loop, in which case r15 
will have been zero.  But yes, crclr is better.

> > 
> > Do you have any benchmark results for this patch?
> 
> I doubt it will get any visible difference. Anyway I will gave it a try.

I tried a couple different benchmarks and didn't find a significant 
difference, relative to the variability of the results running on the same 
kernel.  A patch that claims to "optimize a bit" as its main purpose ought to 
show some results. :-)

-Scott
