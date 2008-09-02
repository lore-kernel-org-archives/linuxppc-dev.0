Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AAC84DE031
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:25:03 +1000 (EST)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support
	36-bit physical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <44677536-2308-40AF-8844-7192489664B9@freescale.com>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<1220246399.13010.25.camel@pasglop>
	<44677536-2308-40AF-8844-7192489664B9@freescale.com>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 07:21:18 +1000
Message-Id: <1220390478.13010.163.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The reason I did that was to distinguish between the size of a  
> software PTE entry, and the actual size of the hardware entry.  In the  
> case of 36b physical, the hardware PTE size is the same as it always  
> is; but we've grown the Linux PTE.  We can call it something else, or  
> I can change as you suggest; I was worried that the next person to  
> come along might get confused.  I suppose there aren't too many of us  
> that are crazy enough to muck around in this code, so maybe it's not  
> that big of a deal.

We already called "PTE" the linux entry everywhere so hopefully there
should be no confusion. We call "HPTE" the hash table ones.

> That's from Kumar's tree of changes for BookE.... he'll need to answer  
> that.  I think he put out a patchset with that work; not sure if it  
> was correct in this particular or not.

Well, unless he did some changes in the area of hash flushing, linux
code must -never- clear _PAGE_HASHPTE on 32 bits. Only the assembly hash
flushing code will do it while also flushing the hash table.

> IIRC, we discussed this at some point, months ago, and decided this  
> was the case. If it *can* be valid, and it's possible to have a reader  
> on another cpu, I think we end up having to go through a very gross  
> sequence where we have to mark it invalid before we start mucking  
> around with it; otherwise a reader can get half-and-half.  Perhaps I'm  
> missing a key restriction here?

No that's correct. You can go out of line with something like

	if (unlikely(pte_valid(*ptep)) {
		pte_clear(ptep);
		eieio(); /* make sure above is visible before
		          * further stw to high word is */
	}
	if (pte_val(*ptep) & _PAGE_HASHPTE)
		flush_hash_entry(ptep, addr) /* or whatever proto */

I'd rather be safe than sorry in that area. ppc64 does something akin
to the above.

> If the pte is invalid, and we're SMP, we need the store to the high  
> word to occur before the stwcx that sets the valid bit, unless you're  
> certain we can't have a reader on another cpu.  If we're not SMP, then  
> I agree, let's move that store.

Yes, the stores must occur in order, but none of them need to be a
stwcx. if your PTE cannot be modified from underneath you and in any
case, the high word which isn't atomic doesn't have to be in the loop,
it should just be before the loop.

> I thought we discussed at some point the possibility that there might  
> be an updater on another CPU?  Is this not possible?  If not, I'll  
> change it.  The existing code is also lwarx/stwcxing via pte_update();  
> is there no reason for that?  We should probably change that as well,  
> if that's the case.

You are holding the PTE lock, so the only code path that might
eventually perform an update are the hash miss and the hash flush. The
former will never happen if your PTE is invalid. The later will never
happen if your PTE has _PAGE_HASHPTE clear which it should have if you
do the sequence above properly and if I didn't miss anything (which is
always possible :-)

There is indeed the chance that your PTE -will- be concurrently modified
without a lock by an invalidation if you have _PAGE_HASHPTE set and you
don't first ensure the hash has been flushed. In that case, you do need
an atomic operation. Just move the stw to the top word to be before the
loop then (and still keep the pte_clear bit).

Cheers,
Ben.
