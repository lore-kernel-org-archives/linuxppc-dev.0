Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6FC0DDE26
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 21:37:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4LBbWDm023251
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 04:37:33 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4LBbVq8026224
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 06:37:32 -0500 (CDT)
Subject: Re: fsl booke MM vs. SMP questions
From: Dave Liu <r63238@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1179742083.32247.689.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 21 May 2007 19:37:28 +0800
Message-Id: <1179747448.3660.22.camel@localhost.localdomain>
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

On Mon, 2007-05-21 at 20:08 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-05-21 at 17:57 +0800, Dave Liu wrote:
> 
> > > If not, you might have to use a _PAGE_BUSY bit similar to what 64 bits
> > > uses as a per-PTE lock, or use mmu_hash_lock... Unless you come up with
> > > a great idea or some HW black magic that makes the problem go away...
> > 
> > I would like the _PAGE_BUSY bit for a per-PTE lock, it will have better
> > performance benifit than global lock. The BookE architecutre doesn't use
> > the hardware hash table, so can not use the mmu_hash_lock, which is
> > global lock for hashtable.
> 
> (BTW. Did you remove the list CC on purpose ? If not, then please add it
> back on your reply and make sure my reply is fully visible :-)

Sorry for that, It is wrong to click the mouse.

> Still.. having to use a lwarx/stwcx. loop in the TLB refill handler is a
> sad story don't you think ? I don't know for you guys but on the cpus I
> know, those take hundres of cycles....

It is true, I know that.

> I've come up with an idea (thanks wli for tipping me off) that's
> inspired from RCU instead:
> 
> We have a per-cpu flag called tlbbusy
> 
> The tlb miss handler does:
> 
>  - tlbbusy = 1
>  - barrier (make sure the following read is in order vs. the previous
> store to tlbbusy)
>  - read linux PTE value
>  - write it to the HW TLB

and write the linux PTE with referenced bit?

>  - appropriate sync
>  - tlbbusy = 0
> 
> Now, the tlb invalidation code (which can use a batch to be even more
> efficient, see how 64 bits or x86 use batching for TLB invalidations)
> can then use the fact that the mm carries a cpu bitmask of all CPUs that
> ever touched that mm and thus can do, after a PTE has changed and before
> broadcasting an invalidation:

How to interlock this PTE change with the PTE change of tlb miss?

>  - make a local copy "mask" of the mm->cpu_vm_mask
>  - clear bit for the current cpu from the mask
>  - while there is still a bit in the mask
>  - for each bit in the mask, check if tlbbusy for that cpu is 0
>    -> if 0, clear the bit in the mask
>  - loop until there's nop more bit in the mask
>  - perform the tlbivax

It looks like good idea, but what is the bad things with the batch
invalidation?

> In addition, if you have a "local" version of tlbivax (no broadcast),
> you can do a nice optimisation if after step 2 (clear bit for the
> current cpu) the mask is already 0 (that means the mm only ever existed
> on the local cpu), in which case you can do a local tlbivax and return.

The BookE has the "local" version of tlbivax with the tlbwe inst. Yes,
It actually can reduce the bus traffic. 
