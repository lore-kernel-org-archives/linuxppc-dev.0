Date: Fri, 15 Jan 1999 12:57:32 +1100
Message-Id: <199901150157.MAA01789@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: alan@cymru.net, jskov@cygnus.co.uk, cort@persephone.cs.nmt.edu,
        linuxppc-dev@lists.linuxppc.org, Jes.Sorensen@cern.ch,
        linux-apus@sunsite.auc.dk
In-reply-to: <199901142052.UAA24588@snowcrash.cymru.net> (message from Alan
	Cox on Thu, 14 Jan 1999 20:52:51 +0000 (GMT))
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199901142052.UAA24588@snowcrash.cymru.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Cox <alan@cymru.net> wrote:

> >  eieio: prevent CPU from reordering/collapsing reads/writes to memory.
> >         (but otherwise run at full steam!)
> 
> Thats what mb() does - its a memory-barrier hence the name - it imposes
> strong store ordering properties across it. 

My understanding of the original mb() (and correct me if I'm wrong)
was that it basically said "an interrupt or another processor might
have changed memory, so don't keep values from memory cached in
registers".  With wmb() on SMP, this seems to be extended to include
"make sure other cpus can see the values we just wrote".  I don't know
exactly how rmb() differs from mb().

I just read in the Programming Environments Manual (the doc that
defines the PPC architecture) that eieio is supposed to provide
ordering for two sets of accesses:

- loads and stores to cache-inhibited, guarded addresses, and stores
  to write-through cached addresses (i.e. I/O accesses),

- stores to cached, coherent addresses (i.e. addresses where the
  corresponding PTE has WIM == 001).

The two sets are ordered separately.  The eieio instruction doesn't
wait for previous accesses to complete, it just inserts a barrier into
the stream of memory accesses.

I guess eieio probably is strong enough for wmb(), since all ordinary
memory is marked coherent in PPC SMP.

The sync instruction is stronger than eieio, it says "wait until all
outstanding loads and stores (and instructions) have completed before
starting any new instructions".  AFAICS, it subsumes eieio so there
would be no point in doing an eieio immediately after a sync.

I put a sync in for mb, rmb and wmb, which may be overkill.  Certainly
I think the eieio that Cort added after the sync for these things is
unnecessary.

> x86 and most other processors dont have the notion of a store barrier and
> an i/o barrier beign different

On x86, i/o accesses are strongly ordered already.  On PPC the eieio
instruction provides this sort of ordering (if you do it after each
access).  So I think eieio is right for iobarrier_*.  Whether eieio
would be sufficient for *mb(), or whether sync is needed, I'm not
sure.  Certainly sync should be sufficient.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
