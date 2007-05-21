Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C1B0DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:08:09 +1000 (EST)
Subject: Re: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Liu <r63238@freescale.com>
In-Reply-To: <1179747448.3660.22.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 May 2007 08:07:52 +1000
Message-Id: <1179785273.32247.742.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The tlb miss handler does:
> > 
> >  - tlbbusy = 1
> >  - barrier (make sure the following read is in order vs. the previous
> > store to tlbbusy)
> >  - read linux PTE value
> >  - write it to the HW TLB
> 
> and write the linux PTE with referenced bit?

I've kept the reference bit rewrite out of that pseudo-code because I
was approaching a different issue but yes. The idea i have there is to
do break down the linux PTE operation that way:

	 1 - rX = read PTE value (normal load)
	 2 - if (!_PAGE_PRESENT)) -> out
 	 3 - rY = rX | _PAGE_ACCESSED
	 4 - if (rX != rY)
	 5 -   rZ = lwarx PTE value
	 6 -   if (rZ != rX)
	 7 -	stdcx. PTE, rZ (rewrite just read value to clear reserv)
	 8 - 	goto 1 (try again)
	 9 -   stdcx. PTE, rY
	10 -   if failed -> goto 1 (try again)
	11 - that's it ! 

In addition, I suppose performance can be improved by also dealing with
dirty bit right in the TLB refill if the access is a write and the page
is writeable rather than taking a double fault.

> >  - appropriate sync
> >  - tlbbusy = 0
> > 
> > Now, the tlb invalidation code (which can use a batch to be even more
> > efficient, see how 64 bits or x86 use batching for TLB invalidations)
> > can then use the fact that the mm carries a cpu bitmask of all CPUs that
> > ever touched that mm and thus can do, after a PTE has changed and before
> > broadcasting an invalidation:
> 
> How to interlock this PTE change with the PTE change of tlb miss?

Look at pgtables-ppc32.h. PTE changes done by linux are atomic. If you
use the procedure I outlined above, you will also have PTE modifications
done by the TLB miss handler be atomic, though you also skip the atomic
bit when not necessary (when _PAGE_ACCESSED is already set for example).

Thus, the situation is basically that linux PTE changes need to

 - update the PTE
 - barrier
 - make sure that change is visible to all other CPUs and that
   they all have been out of a TLB miss handler at least once
   which is what my proposed algorithm does
 - broadcast invalidation

> >  - make a local copy "mask" of the mm->cpu_vm_mask
> >  - clear bit for the current cpu from the mask
> >  - while there is still a bit in the mask
> >  - for each bit in the mask, check if tlbbusy for that cpu is 0
> >    -> if 0, clear the bit in the mask
> >  - loop until there's nop more bit in the mask
> >  - perform the tlbivax
> 
> It looks like good idea, but what is the bad things with the batch
> invalidation?

Why bad ?

Batch invalidations allow you to do the whole operation of sync'ing with
other CPUs only once for a whole lot of invalidations:

	- clear lots of PTEs
	- sync once
	- send lots of tlbivax

You don't have to implement batch invalidates but it will improve
performances.

> > In addition, if you have a "local" version of tlbivax (no broadcast),
> > you can do a nice optimisation if after step 2 (clear bit for the
> > current cpu) the mask is already 0 (that means the mm only ever existed
> > on the local cpu), in which case you can do a local tlbivax and return.
> 
> The BookE has the "local" version of tlbivax with the tlbwe inst. Yes,
> It actually can reduce the bus traffic. 

And is probably faster too :-)

The above method need to also be looked at carefully for the TLB storage
interrupt (that is TLB present but with wrong permission).

Ben.
