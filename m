From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<linuxppc-commit@source.mvista.com>
Subject: Re: Page aging, _PAGE_ACESSED, & R/C bits
Date: Sun, 7 Oct 2001 17:34:01 +0200
Message-Id: <20011007153401.16899@smtp.wanadoo.fr>
In-Reply-To: <20011007130734.8038@smtp.wanadoo.fr>
References: <20011007130734.8038@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Paulus !
>
>According to people I discussed with on #kernel, the page aging of the
>linux VM will not work correctly if we don't set PAGE_ACCESSED when
>a page is... accessed.
>
>AFAIK, That bit is only test&cleared once in try_to_swap_out
>(except if I missed something).
>
>Do you think it would make sense (or it would suck perfs too badly)
>to do a hash lookup and copy the HPTE "R" bit to the linux PTE
>PAGE_ACCESSED from ptep_test_and_clear_youg() ?
>
>That would improve page aging behaviour, but I'm not sure I have
>an idea about the performance impact.

Ok, after discussing a bit more with "vm aware people", it appear
that:

 - ptep_test_and_clear_young() is not a critical code path, and
the overhead of doing the hash lookup to retreive the accessed bit
should be ok compared to the overall better VM behaviour (correct
page aging) if implementing that trick. I've done a test
implementation (with and without ktraps :), I still need to test it
a bit, I will post a patch here for comments. I had to slightly
modify the prototype of ptep_test_and_clear_young() to get the
MM context and the virtual address, but that shouldn't be a problem
to get accepted.

 - I also looked at the ptep_test_and_clear_dirty() case. It appear
that we rely on flush_tlb_page() beeing called just after it. That
works, but that also mean that we'll re-fault on the page as soon
as it's re-used. If implementing ptep_test_and_clear_dirty() the
same way as for the referenced bit (that is walking the hash),
we can avoid the flush and the fault (*), but that also mean we will
walk the hash table on each call, while the current code will walk
it (for flushing) only when the dirty bit was actually set.
I can't decide which one is the best here.

(*) That would also require some subtle change to the interaction
between the generic code of the arch, as in this case, we should
avoid the next flush_tlb_page(). An easy hack would be to have a
per-cpu flag telling us to ignore the next call to flush_tlb_page
and set it whenever we return 1 from ptep_test_and_clear_dirty.
Hackish but would work.

One issue here is that it's almost impossible to really bench the
VM. So you have to rely on user reports and imagination to figure
out what is best. According to people like Rik van Riel, the
ptep_test_and_clear_young() thing would really be a good thing
for us to implement. I don't know for the dirty bit one.

The case of CPUs with no hash table is different. For now, we can
survive by just setting PAGE_ACCESSED when faulting a TLB in. It's
not perfect, we could actually go look into the TLB for the referenced
bit the same way I go look into the hash table, but it may not be
work it. The point here is that ptep_test_and_clear_young() is
a rare and already slow code path, it's called when the system is
already swapping, possibly badly, and so adding a few overhead there
to make overall choice of which pages to swap out better is worth it.

Any comments ?

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
