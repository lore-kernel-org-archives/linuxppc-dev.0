From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15296.58245.196742.987118@cargo.ozlabs.ibm.com>
Date: Mon, 8 Oct 2001 09:21:41 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<linuxppc-commit@source.mvista.com>
Subject: Re: Page aging, _PAGE_ACESSED, & R/C bits
In-Reply-To: <20011007153401.16899@smtp.wanadoo.fr>
References: <20011007130734.8038@smtp.wanadoo.fr>
	<20011007153401.16899@smtp.wanadoo.fr>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> >According to people I discussed with on #kernel, the page aging of the
> >linux VM will not work correctly if we don't set PAGE_ACCESSED when
> >a page is... accessed.

We do, we set it in the linux PTE in hash_page, when we create the
hash PTE from the linux PTE.  Of course we need to do a TLB flush
after clearing the accessed bit, but that is the same on other
architectures as well.

We have a bug, I have just noticed, in update_mmu_cache.  It should
either refuse to preload a PTE that doesn't have the accessed bit set,
or else it should set the accessed bit (probably refusing to preload
the PTE would be better).  (I believe that most callers of
update_mmu_cache would have just set the accessed bit in the linux PTE
anyway.)

We should never have the situation where we have a HPTE in the hash
table, and the corresponding linux PTE has the accessed bit clear
(well not for any significant length of time, anyway).

> >Do you think it would make sense (or it would suck perfs too badly)
> >to do a hash lookup and copy the HPTE "R" bit to the linux PTE
> >PAGE_ACCESSED from ptep_test_and_clear_youg() ?

The problem is in getting from the linux PTE to the hash PTE at the
point where the accessed bit is tested.  I'm not sure that we would
have the necessary information (the MM context and the virtual
address) available to us at that point.

>  - ptep_test_and_clear_young() is not a critical code path, and
> the overhead of doing the hash lookup to retreive the accessed bit
> should be ok compared to the overall better VM behaviour (correct
> page aging) if implementing that trick. I've done a test
> implementation (with and without ktraps :), I still need to test it
> a bit, I will post a patch here for comments. I had to slightly
> modify the prototype of ptep_test_and_clear_young() to get the
> MM context and the virtual address, but that shouldn't be a problem
> to get accepted.

Well I still like the idea of doing software accessed bit management,
just as we do software dirty bit management.  As I said, it looks like
update_mmu_cache isn't doing the right thing and that is what we
should fix first.

>  - I also looked at the ptep_test_and_clear_dirty() case. It appear
> that we rely on flush_tlb_page() beeing called just after it. That
> works, but that also mean that we'll re-fault on the page as soon
> as it's re-used. If implementing ptep_test_and_clear_dirty() the
> same way as for the referenced bit (that is walking the hash),
> we can avoid the flush and the fault (*), but that also mean we will

You would at least have to do a tlbie.  It is apparently legal for a
PPC to keep the dirty (and accessed) bits in the TLB and not write
them back to the hash table until the TLB entry gets flushed.

> walk the hash table on each call, while the current code will walk
> it (for flushing) only when the dirty bit was actually set.
> I can't decide which one is the best here.
>
> (*) That would also require some subtle change to the interaction
> between the generic code of the arch, as in this case, we should
> avoid the next flush_tlb_page(). An easy hack would be to have a
> per-cpu flag telling us to ignore the next call to flush_tlb_page
> and set it whenever we return 1 from ptep_test_and_clear_dirty.
> Hackish but would work.
>
> One issue here is that it's almost impossible to really bench the
> VM. So you have to rely on user reports and imagination to figure
> out what is best. According to people like Rik van Riel, the
> ptep_test_and_clear_young() thing would really be a good thing
> for us to implement. I don't know for the dirty bit one.

Well, ptep_test_and_clear_young should work already, except for the
update_mmu_cache bug.

I have done measurements of the number of flushes and reloads in the
hash table, as well as the number of times that we update an existing
HPTE (changing the protection or whatever).  These numbers are
available in /proc/ppc_htab.  We could extend the set of counters and
also use the TB to work out how long we are spending doing different
sorts of things.

I have already done some measurements of how long we are spending in
hash_page in total.  For a kernel compile which took 450s user time
and 30s system time, we spent a total of 2.1s in hash_page.  So there
isn't a great deal to be gained there.

> The case of CPUs with no hash table is different. For now, we can
> survive by just setting PAGE_ACCESSED when faulting a TLB in. It's
> not perfect, we could actually go look into the TLB for the referenced
> bit the same way I go look into the hash table, but it may not be

Why would that be better?  Doesn't a TLB miss fault imply that we are
accessing the page?

> work it. The point here is that ptep_test_and_clear_young() is
> a rare and already slow code path, it's called when the system is
> already swapping, possibly badly, and so adding a few overhead there
> to make overall choice of which pages to swap out better is worth it.

Equally that says that have the accessed bit clear is going to be
quite rare and so taking an extra hash-table miss fault is not going
to be a noticeable overhead (particularly since hash_page is quite
fast already).

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
