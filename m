From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14979.54261.375252.90841@gargle.gargle.HOWL>
Date: Fri, 9 Feb 2001 22:26:45 +1100 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: David Edelsohn <dje@watson.ibm.com>, Cort Dougan <cort@fsmlabs.com>,
        Dan Malek <dan@mvista.com>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: <Pine.HPX.4.10.10102091147560.16861-100000@gra-ux1.iram.es>
References: <14979.48995.833510.969973@gargle.gargle.HOWL>
	<Pine.HPX.4.10.10102091147560.16861-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> > - The hash table occupancy rates measured by Cort were very small,
> >   typically less than 10% IIRC.
>
> Then it means that the mm system is completely screwed up, even more than
> I thought. I have to study first how VSID are handled, but this smells
> definitively wrong.

Gabriel: one word: Measure.  Then criticize, if you like.

Cort's measurements were done with lmbench and kernel compiles IIRC.
Don't forget that not all pages of physical memory are used via HPTEs;
many pages are used for page-cache pages of files which are read and
written rather than being mmap'd.  For example, in the case of a
kernel compile you would hopefully have all of the relevant kernel
source and object files in the page cache but never mmap'd, and those
pages would be typically be accessed through the kernel BAT mapping.

And the other point is that the recommended hash table sizes are large
enough to map the whole of physical memory 4 times over.

> Yes, I was always worried by the added latency when a hash table clear
> comes in. But the question is why do we have to do it ? Actually the
> question is whether flush_tlb_all is even necessary.

As I have already said, flush_tlb_all can be avoided completely, but
the flush on MMU context overflow is necessary (but fortunately very
rare).

> I believe that this is a big mistake, faulting a PTE in the hash table is
> an exception and wil never be as fast as having the entry already in the
> PTE. And on SMP, you acquire hash_table_lock, an unnecessary variable BTW
> but let us leave it for a later discussion, which will be very contended
> and ping pong like mad between processors.

Measurements?

(David, perhaps you could comment on the need for hash_table_lock and
the possible hardware deadlocks if you do tlbie/tlbsync on different
CPUs at the same time?)

Like everything, the hash table size is a tradeoff.  A big hashtable
has disadvantages, one of which is that less of it will fit in L2
cache and thus TLB misses will take longer on average.

>  In short in all the previous discussion you had with Dan, I stand with
> him and against you in all and every single aspect, except for the TLB
> preloading thing.

I look forward to seeing your benchmark results for the different
alternatives.

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
