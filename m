Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 051FF2C009A
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2012 10:17:17 +1100 (EST)
Message-ID: <1355435328.19932.102.camel@pasglop>
Subject: Re: Understanding how kernel updates MMU hash table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pegasus <aijazbaig1.new@gmail.com>
Date: Fri, 14 Dec 2012 08:48:48 +1100
In-Reply-To: <1355388520814-67313.post@n7.nabble.com>
References: <1355388520814-59509.post@n7.nabble.com>
 <1354695642.2351.8.camel@pasglop> <1355388520815-59512.post@n7.nabble.com>
 <1354766337.2351.41.camel@pasglop> <1355388520815-59514.post@n7.nabble.com>
 <1354794967.28585.16.camel@pasglop>
 <1355388520816-59516.post@n7.nabble.com>
 <1355087457.28585.61.camel@pasglop>
 <1355388520814-67313.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-12-13 at 00:48 -0800, pegasus wrote:

> 1. Linux page table structure (PGD, PUD, PMD and PTE) is directly used in
> case of architecture that lend themselves to such a tree structure for
> maintaining virtual memory information. Otherwise Linux needs to maintain
> two seperate constructs like it does in case of PowerPC. Right? 

Linux always maintains a tree structure, it can be 2, 3 or 4 levels, and
there's some flexibility on the actual details of the structure and PTE
format. If that can be made to match a HW construct, then it's used
directly (x86, ARM), else, there's some other mechanism to load the HW
construct.

I believe some sparcs have some kind of hash table as well (though a
different one).

> 2. PowerPC's hash table as you said is pretty large. However isn't it still
> smaller than Linux's VM infrastructure such that the chances of it being
> 'FULL' are a lot more. It is also possible that there could be two entries
> in the table that points to the same Real address. Like a page being shared
> by two processes? 

Yes and yes.

> My main concern here is to understand if having such an inverted page table
> aka the hash table helps us in any way when doing TLB flushes. You mentioned
> and I also read  in a paper by Paul Mackerras that every Linux PTE (LPTE) in
> case of ppc64 contains 4 extra bits that help us to get to the very slot in
> the hash table that houses the corresponding hashtable PTE (HPTE). Now this
> (at least to me) is smartness on the part of the kernel and I do not think
> the architecture per se is doing us any favor by having that hash table
> right? Or am I missing something here? 

Right.

> His paper is (or rather was) on how one can optimize the Linux ppc kernel
> and time and again he mentions the fact that one can first record the LPTEs
> being invalidated and then remove the corresponding HPTEs in a batched
> format. In his own words "Alternatively, it would be possible to make a list
> of virtual addresses when LPTEs are changed and then use that list in the
> TLB flush routines to avoid the search through the Linux page tables". So do
> we skip looking for the corresponding LPTEs or perhaps we've already
> invalidated them and we remove the corresponding HPTEs in a batch as you
> mentioned earlier?? Could you shed some light on how this optimization
> actually developed over time?

Currently we batch within arch_lazy_mmu sections. We do that because we
require a batch to be fully contained within a page table spinlock
section, ie, we must guarantee that we have performed the hash
invalidations before there's a chance that a new PTE for that same VA
gets faulted in (or we would run the risk of creating duplicates in the
hash which is fatal).

For the details, I'd say look at the code (and not 2.6.10, that's quite
uninteresting).

>  He had results for an "immediate update"
> kernel 
> and "batched update" kernel for both ppc32 and ppc64. For ppc32 the batched
> update is actually a bit worse than immediate update however for ppc64, the
> batched update performs better than immediate update. What exactly is
> helping ppc64 perform better with the so called "batched update"? Is it the
> encoding of the HPTE address in the LPTE as mentioned above? Or some aspect
> of ppc64 that I am unaware of? 

Possibly the fact that we know which slot which means we don't search.

> Also on a generic note, how come we have 4 spare bits in the PTE for 64bit
> address space? Large pages perhaps? 

We don't exploit the entire 64-bit address space. Up until recently we
only gave 16T to processes though we just bumped that a bit.

Cheers,
Ben.
> 
> 
> --
> View this message in context: http://linuxppc.10917.n7.nabble.com/Understanding-how-kernel-updates-MMU-hash-table-tp59509p67313.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
