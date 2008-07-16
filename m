Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 564DDDDF15
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 13:05:45 +1000 (EST)
Subject: Re: SW TLB MMU rework and SMP issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BF59BFC7-736B-4D3F-9227-97DC90CE4739@kernel.crashing.org>
References: <BF59BFC7-736B-4D3F-9227-97DC90CE4739@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 12:07:25 +1000
Message-Id: <1216174045.7740.152.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 16:58 -0500, Kumar Gala wrote:
> Ben,
> 
> I've been giving some thought to the new software managed TLBs and SMP  
> issues.  I was wondering if you had any insights on how we should deal  
> with the following issues:

As discussed on IRC (might interest others...)

> * tlb invalidates -- need to ensure we don't have multiple tlbsync's  
> on the bus.  I'm thinking for e500/fsl we will move to IPI based  
> invalidate broadcast and do invalidates locally
> (http://patchwork.ozlabs.org/linuxppc/patch?id=19657 )

Well, you can just have all your invalidations wrapped in a spinlock.

The "trick" of course is for full-mm invalidates such as page tables
teardown or fork, to avoid doing a lock/unlock & IPI for every PTE of
course. A way to do it is to do some batching, though it isn't trivial. 

Without support for TLB invalidate all or by PID, what you can do maybe
is to manually do an invalidate by PID with a tlbre/tlbwe loop. Check
the worst case scenario of walking your entire TLB vs. small processes
that carry only a handful of PTEs....

You can use the batch interface to 'count' things on page table teardown
and decide based on a threshold of invalidated PTEs what approach is
more likely to be useful, but can't really use the batch interface for
fork. 

> * 64-bit PTEs and reader vs writer hazards.  How do we ensure that the  
> TLB miss handler samples a consistent view of the pte.  pte_updates  
> seem ok since we only update the flag word.  However set_pte_at seems  
> like it could be problematic.

eieio on the writer and a data dependency on the reader. segher
suggested a nice way to do it on the reader side, by doing a subf of the
value from the pointer and then a lwxz using that value as an offset.

ie. something like that, with r3 containing the PTE pointer:

	lwz	r10,4(r3)
	subf	r4,r10,r3  <-- you can use r3,r10,r3 if clobber is safe
	lwzx	r11,r10,r4 <-- in which case you use r3 here too

That ensures that the top half is loaded after the bottom half, which
is what you want if you do the set_pte_at() that way:

	stw	r11,0(r3)  <-- write top half first
	eieio	           <-- maitain order to coherency domain
        stw	r10,4(r3)  <-- write bottom half last

In fact, in the reader case, while at it, you can interleave that with
the testing of the present bit. Assuming _PAGE_PRESENT is in the low
bits and you can clobber r3, you get something like:

	lwz	r10,4(r3)
	<-- can't do much here unless you can do unrelated things -->
	andi.	r0,r10,_PAGE_PRESENT
	subf	r3,r10,r3
	beq	page_fault
	lwzx	r11,r10,r3

Cheers,
Ben.
