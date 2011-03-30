Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 062D6B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 08:07:37 +1100 (EST)
Message-ID: <4D939B88.5020707@goop.org>
Date: Wed, 30 Mar 2011 14:07:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm threatens ppc preemption again
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>	<1300665188.2402.64.camel@pasglop>	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>	<1300672207.2402.205.camel@pasglop>	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>	<1300674150.2402.207.camel@pasglop>
	<20110330135332.9c322e40.akpm@linux-foundation.org>
In-Reply-To: <20110330135332.9c322e40.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Hugh Dickins <hughd@google.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2011 01:53 PM, Andrew Morton wrote:
> On Mon, 21 Mar 2011 13:22:30 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Sun, 2011-03-20 at 19:20 -0700, Hugh Dickins wrote:
>>>> As long as the races to avoid are between map/unmap vs. access, yes, it
>>>> -should- be fine, and we used to not do demand faulting on kernel space
>>>> (but for how long ?). I'm wondering why we don't just stick a ptl in
>>>> there or is there a good reason why we can't ?
>>> We can - but we usually prefer to avoid unnecessary locking.
>>> An arch function which locks init_mm.page_table_lock on powerpc,
>>> but does nothing on others? 
>> That still means gratuitous differences between how the normal and
>> kernel page tables are handled. Maybe that's not worth bothering ...
> So what will we do here?  I still have
>
> mm-remove-unused-token-argument-from-apply_to_page_range-callback.patch
> mm-add-apply_to_page_range_batch.patch
> ioremap-use-apply_to_page_range_batch-for-ioremap_page_range.patch
> vmalloc-use-plain-pte_clear-for-unmaps.patch
> vmalloc-use-apply_to_page_range_batch-for-vunmap_page_range.patch
> vmalloc-use-apply_to_page_range_batch-for-vmap_page_range_noflush.patch
> vmalloc-use-apply_to_page_range_batch-in-alloc_vm_area.patch
> xen-mmu-use-apply_to_page_range_batch-in-xen_remap_domain_mfn_range.patch
> xen-grant-table-use-apply_to_page_range_batch.patch
>
> floating around and at some stage they may cause merge problems.

Well, my understanding of the situation is:

   1. There's a basic asymmetry between user and kernel pagetables, in
      that the former has a standard pte locking scheme, whereas the
      latter uses ad-hoc locking depending on what particular subsystem
      is doing the changes (presumably to its own private piece of
      kernel virtual address space)
   2. Power was assuming that all lazy mmu updates were done under
      spinlock, or are at least non-preemptable.  This is incompatible
      with 1), but it was moot because no kernel updates were done lazily
   3. These patches add the first instance of lazy mmu updates, which
      reveals the mismatch between Power's expectations and the actual
      locking rules.


So the options are:

   1. Change the locking rules for kernel updates to also require a pte lock
   2. Special-case batched kernel updates to include a pte lock
   3. Make Power deal with preemption during a batched kernel update
   4. Never do batched kernel updates on Power
   5. Never do batched kernel updates (the current state)


1 seems like a big change.
2 is pretty awkward, and has the side-effect of increasing preemption
latencies (since if you're doing enough updates to be worth batching,
you'll be disabling preemption for a longish time).
I don't know how complex 3 is; I guess it depends on the details of the
batched hashtable update thingy.
4 looks like it should be simple.
5 is the default do-nothing state, but it seems unfair on anyone who can
actually take advantage of batched updates.

Ben, how hard would something like 3 or 4 be to implement?

Thanks,
    J
