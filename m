Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 570FBDDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 20:56:10 +1100 (EST)
Subject: Possible ppc64 (and maybe others ?) mm problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 10:48:33 +0100
Message-Id: <1172569714.11949.73.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Memory Management <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have a lingering problem that I stumbled upon the other day just
before leaving for a rather long trip. I have a few minutes now and feel
like writing it all down before I forget :-)

So the main issue is that the ppc64 mmu hash table must not ever have a
duplicate entry. That is, there must never be two entries in a hash
group that can match the same virtual address. Ever.

I don't know wether other archs with things like software loaded TLBs
can have a similar problems ending up in trying to load two TLB entries
for the same address and what the consequences can be.

Thus it's very important when invalidating mappings, to always make sure
we cannot fault in a new entry before we have cleared any possible
previous entry from the hash table on powerpc (and possibly by
extension, from the TLB on some sw loaded platforms).

The powerpc kernel tracks the fact that a hash table entry may be
present for a given linux PTE via a bit in the PTE (_PAGE_HASHPTE)
along, on 64 bits, with some bits indicating which slot is used in a
given "group" so we don't have to perform a search when invalidating.

Now there is a race that I'm pretty sure we might hit, though I don't
know if it's always been there or only got there due to the recent
locking changes arund the vm, but basically, the problem is when we
batch invalidations.

When doing things like pte_clear, which are part of a batch, we
atomically replace the PTE with a non-present one, and store the old one
in the batch for further hash invalidations.

That means that we must -not- allow a new PTE to be re-faulted in for
that same page and thus potentially re-hashed in before we actually
flush the hash table (which we do when "completing" the hash, with
flush_tlb_*() called from tlb_finish_mmu() among others.

The possible scenario I found out however was when looking at this like
unmap_mapping_range(). It looks like this can call zap_page_range() and
thus do batched invalidations, without taking any useful locks
preventing new PTEs to be faulted in on the same range before we
invalidate the batch.

This can happen more specifically if the previously hashed PTE had
non-full permissions (for example, is read only). In this case, we would
hit do_page_fault() which wouldn't see any pte_present() and would
basically fault a new one in despite one being already present in the
hash table.

I think we used to be safe thanks to the PTL, but not anymore. We
sort-of assumed that insertions vs. removal races of that sort would
never happen because we would always either be protected by the mmap_sem
or the ptl while doing a batch.

The "quick fix" I can see would be for us to have a way to flush a
pending batch in zap_pte_range(), before we unlock the PTE page (that is
before pte_unmap_unlock()). That would prevent batches from spawning
accross PTE page locks (whatever the granularity of that lock is).

I suppose the above can be acheived by "hijacking" the
arch_leave_lazy_mmu_mode() hook that was added for paravirt ops and make
it flush any pending batch on powerpc, though I haven't had time to grep
around other call sites to see if that could be a performance issue in
other areas.

I also need to dbl check if there are other similar scenarios with other
code path.

I -think- sparc64's hash management is immune to that problem, though
I'm not 100% sure, I just had a quick look at the code and I'm not
entirely sure I grasp it all just yet.
