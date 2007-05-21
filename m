Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F419CDDE1D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 17:07:02 +1000 (EST)
Subject: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 21 May 2007 17:06:55 +1000
Message-Id: <1179731215.32247.659.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Folks !

I see that the fsl booke code has some #ifdef CONFIG_SMP bits here or
there, thus I suppose there are some SMP implementations of these
right ?

I'm having some serious issues trying to figure out how the TLB
management is made SMP safe however.

There are at least two main issues I've spotted at this point (there's
at least one more if there are HW threading, that is the TLB is shared
between logical processors, but I'll ignore that for now since I don't
think there is such a thing ... yet).

 - How do you guys shield PTE flushing vs. TLB misses on another CPU ?
That is, how do you prevent (if you do) the following scenario:

	cpu 0				cpu 1
	tlb miss			pte_clear (or similar)
	load PTE value
					write 0 to PTE (or replace)
					tlbviax (tlbie)
	tlbwe

That scenario, as you can see, will leave you with stale entries in the
TLB which will ultimately lead to all sort of unpleasant/random
behaviours.

If the answer is "oops ... we don't", then let's try to find out ways
out of that since I may have a similar issue in a not too distant
future :-) And I'm trying to find out a -fast- way to deal with that
without bloating the fast path. My main problem is that I want to avoid
taking a spin lock or equivalent atomic operation in the fast TLB reload
path (which would solve the problem) since lwarx/stwcx. are generally
real slow (hundreds of cycles on some processors).

 - I see that your TLB miss handle is using a non-atomic store to write
the _PAGE_ACCESSED bit back to the PTE. Don't you have a similar race
where something would do:

	cpu 0				cpu 1
	tlb miss			pte_clear (or similar)
	load PTE value
					write 0 to PTE (or replace)
	write back PTE with _PAGE_ACCESSED
	tlbwe

This is an extension of the previous race but it's a different problem
so I listed it separately. In that case, the problem is worse, since not
only you have a stale TLB entry, but you -also- have corrupted the linux
PTE by writing back the old value in it.

At this point, I'm afraid you may have no choice but going atomic, which
means paying the cost of lwarx/stwcx. on TLB misses, though if you have
a solution for the first problem, then you can avoid the atomic
operation in the second problem if _PAGE_ACCESSED is already set.

If not, you might have to use a _PAGE_BUSY bit similar to what 64 bits
uses as a per-PTE lock, or use mmu_hash_lock... Unless you come up with
a great idea or some HW black magic that makes the problem go away...

In any case, I'm curious about how you have or intend to solve that
since as I said above, I might be in a similar situation soon and am
trying to keep the TLB miss handler as fast as humanly possible.

Cheers,
Ben.
