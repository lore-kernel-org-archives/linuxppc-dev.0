Message-ID: <3A64E1AA.7F955CCA@mvista.com>
Date: Tue, 16 Jan 2001 16:04:58 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: frowand@mvista.com, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com> <3A643283.A20200E8@raleigh.ibm.com> <3A647BC7.15F669F3@mvista.com> <3A64A751.8AA527CF@mvista.com> <3A64C78E.90633885@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Frank Rowand wrote:
>

I have only a small amount of performance instrumentation and measurements.
Some of what I have to say is based on observation, inference, and
conjecture...


> > I pinned some IO ranges as a convenience when I was first porting
> > to the 405gp but plan to remove those pins.
>
> Those are actually performace advantages, and I am doing that
> on some 8xx applications.  The difference now is we don't have
> to actually allocate specific "pinned" entries, the large mapping
> will just happen as part of the TLB reload.

The IO ranges that I pinned were all just a 4k page (except the 64k
"page" for PCI IO space, which shouldn't be accessed much except for
PCI device initialization).  So the only performance advantage I
gained was avoiding TLB misses, not from large pages.


> > I think that's a good idea.  If you do so, please provide a way to
> > force an entry to be locked in the tlb.
>
> Nope.  I don't want to do that.  Then you have to make processor
> specific trade offs, or incur high management overhead like the
> 405 does now.  For example, some of the processors allow a fixed
> number of locked entries, but you have to trade off what you will
> put there against losing TLB entries.  Or, you do like the 405
> does and create a "software" locking, losing the use of some
> very functional TLB management instructions.


The 405 core (and thus the many processors based on it) has a 64 entry
tlb.  While debugging via a JTAG debugger I have observed that the
tlb very quickly gets filled with entries for the current context.  It
is extremely rare to see entries for a different context left over.
>From this, I infer that the tlb is not large enough to hold a working
set.  (If I was still working as a performance geek, I would find this
an interesting area to instrument.)  Locking a few kernel entries in
the tlb means that the majority of the kernel's working set _is_ in
the tlb at all times.  Here is a simple measurement of tlb misses
(running a simple load of copying nfs mounted files around, etc):

  dtlb  misses:   34679326        <--- data tlb
  itlb  misses:   33075725        <--- instruction tlb
  d + i misses:   67755051
  ktlb  misses:     233683        <--- kernel addresses
  utlb  misses:   67521368        <--- user space addresses
  k + u misses:   67755051


If you want to repeat the measurement with other workloads, just
cat /proc/ppc_htab in my kernel to get the above data.

For the 405, the only tlb management instruction I sacrificed was
the tlbia (invalidate the entire tlb) that I would have used for
PPC4xx_tlb_flush_all(), which is used by flush_tlb_all(), which
is only called from:

  ppc_htab_write()
  mmu_context_overflow()
  vmfree_area_pages()
  vmalloc_area_pages()
  flush_all_zero_pkmaps()

Which doesn't seem to be much of a sacrifice for a large gain.


> By not locking entries and using large page table entries you don't
> need to have processor unique configurations that are cumbersome
> or unworkable on lesser featured processors.  You also let the
> system operation find the best distribution of TLB entries.  Yes,

The tlb is not large enough to accumulate a working set in the tlb,
so system operation never finds the best distribution of tlb entries.


> there is a clearly visible latency concern with loading TLBs, but
> considering the amount of context we are switching these days a
> single large page TLB miss is insignificant.

It will be nice to have large page TLB implemented.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
