From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<linuxppc-commit@source.mvista.com>
Subject: Re: Page aging, _PAGE_ACESSED, & R/C bits
Date: Sun, 7 Oct 2001 17:45:04 +0200
Message-Id: <20011007154504.25319@smtp.wanadoo.fr>
In-Reply-To: <20011007153401.16899@smtp.wanadoo.fr>
References: <20011007153401.16899@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> - I also looked at the ptep_test_and_clear_dirty() case. It appear
>that we rely on flush_tlb_page() beeing called just after it. That
>works, but that also mean that we'll re-fault on the page as soon
>as it's re-used. If implementing ptep_test_and_clear_dirty() the
>same way as for the referenced bit (that is walking the hash),
>we can avoid the flush and the fault (*), but that also mean we will
>walk the hash table on each call, while the current code will walk
>it (for flushing) only when the dirty bit was actually set.
>I can't decide which one is the best here.
>
>(*) That would also require some subtle change to the interaction
>between the generic code of the arch, as in this case, we should
>avoid the next flush_tlb_page(). An easy hack would be to have a
>per-cpu flag telling us to ignore the next call to flush_tlb_page
>and set it whenever we return 1 from ptep_test_and_clear_dirty.
>Hackish but would work.

Well, the whole issue of the dirty bit is more complex than that,
as we would have to change page_dirty() accessor as well. It's
probably not worth the trouble. My comment about page accessed
is still valid however.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
